from flask import Blueprint, jsonify, request
from db import get_db_connection

trials_bp = Blueprint("trials", __name__)

@trials_bp.route("/get_variety_trials/<string:variety_name>", methods=["GET"])
def get_variety_trials(variety_name):
    conn = get_db_connection()
    cur = conn.cursor()

    query = """
        SELECT *
        FROM trials t
        JOIN categories c ON t.category_name = c.category_name
        WHERE t.variety = %s
    """
    cur.execute(query, (variety_name,))
    rows = cur.fetchall()

    cur.close()
    conn.close()

    # Convert to JSON-friendly list of dicts
    trials = []
    for row in rows:
        trials.append({
            "id": row[0],
            "start_date": row[1].isoformat() if row[1] else None,
            "end_date": row[2].isoformat() if row[2] else None,
            "category": row[3],
            "variety": row[4],
            "location": row[5],
            "region": row[6]
        })

    return jsonify(trials)

@trials_bp.route("/get_variety_average_trials/<string:variety_name>", methods=["GET"])
def get_variety_average_trials(variety_name):
    conn = get_db_connection()
    cur = conn.cursor()

    query = """
        SELECT 
            AVG(plant_vigour) AS plant_vigour,
            AVG(plant_earliness) AS plant_earliness,
            AVG(plant_cold_tolerence) AS plant_cold_tolerence,
            AVG(plant_heat_tolerence) AS plant_heat_tolerence,
            AVG(fruit_setting) AS fruit_setting,
            AVG(fruit_quantity) AS fruit_quantity,
            AVG(fruit_uniformity) AS fruit_uniformity,
            AVG(fruit_weight) AS fruit_weight,
            AVG(fruit_firmness) AS fruit_firmness,
            AVG(fruit_calyx_quality) AS fruit_calyx_quality,
            AVG(fruit_blotchy_ripening) AS fruit_blotchy_ripening,
            AVG(fruit_macro_cracking) AS fruit_macro_cracking,
            AVG(fruit_micro_cracking) AS fruit_micro_cracking
        FROM trials
        WHERE variety = %s
    """
    cur.execute(query, (variety_name,))
    row = cur.fetchone()

    cur.close()
    conn.close()

    # Map results into a JSON object
    averages = {
        "plant_vigour": row[0],
        "plant_earliness": row[1],
        "plant_cold_tolerence": row[2],
        "plant_heat_tolerence": row[3],
        "fruit_setting": row[4],
        "fruit_quantity": row[5],
        "fruit_uniformity": row[6],
        "fruit_weight": row[7],
        "fruit_firmness": row[8],
        "fruit_calyx_quality": row[9],
        "fruit_blotchy_ripening": row[10],
        "fruit_macro_cracking": row[11],
        "fruit_micro_cracking": row[12]
    }

    return jsonify(averages)

def add_trial():
    data = request.get_json()

    # Validate required fields
    required_fields = ["start_date", "end_date", "category", "variety", "location", "region"]
    missing = [field for field in required_fields if field not in data]
    if missing:
        return jsonify({"error": f"Missing required fields: {', '.join(missing)}"}), 400

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        # Insert trial record
        cur.execute(
            """
            INSERT INTO trials (start_date, end_date, catergory, variety, location, region)
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING id
            """,
            (data["start_date"], data["end_date"], data["category"], data["variety"], data["location"], data["region"]),
        )
        trial_id = cur.fetchone()[0]

        # Optional: insert plants data if provided
        if "plants" in data:
            plants = data["plants"]
            cur.execute(
                """
                INSERT INTO plants (plant_vigour, plant_earliness, plant_cold_tolerence, 
                                    plant_heat_tolerence, fruit_setting, fruit_shape, plant_notes, trial_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    plants.get("plant_vigour"),
                    plants.get("plant_earliness"),
                    plants.get("plant_cold_tolerence"),
                    plants.get("plant_heat_tolerence"),
                    plants.get("fruit_setting"),
                    plants.get("fruit_shape"),
                    plants.get("plant_notes"),
                    trial_id,
                ),
            )

        # Optional: insert fruits data if provided
        if "fruits" in data:
            fruits = data["fruits"]
            cur.execute(
                """
                INSERT INTO fruits (fruit_quantity, fruit_uniformity, fruit_weight,
                                    fruit_firmness, fruit_calyx_quality, fruit_blotchy_ripening,
                                    fruit_macro_cracking, fruit_micro_cracking, fruit_notes, trial_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    fruits.get("fruit_quantity"),
                    fruits.get("fruit_uniformity"),
                    fruits.get("fruit_weight"),
                    fruits.get("fruit_firmness"),
                    fruits.get("fruit_calyx_quality"),
                    fruits.get("fruit_blotchy_ripening"),
                    fruits.get("fruit_macro_cracking"),
                    fruits.get("fruit_micro_cracking"),
                    fruits.get("fruit_notes"),
                    trial_id,
                ),
            )

        # Optional: insert diseases data if provided
        if "diseases" in data:
            for disease_note in data["diseases"]:
                cur.execute(
                    """
                    INSERT INTO diseases (trial_id, notes)
                    VALUES (%s, %s)
                    """,
                    (trial_id, disease_note),
                )

        conn.commit()
        return jsonify({"success": True, "trial_id": trial_id}), 201

    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cur.close()
        conn.close()

