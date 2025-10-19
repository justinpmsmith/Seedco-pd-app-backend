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


@trials_bp.route("/get_trial/<int:trial_id>", methods=["GET"])
def get_trial(trial_id):
    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute(
            """
            SELECT 
                id, start_date, end_date, category_name, variety, location, region,
                plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
                fruit_setting, fruit_shape, plant_notes,
                fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness,
                fruit_calyx_quality, fruit_blotchy_ripening, fruit_macro_cracking,
                fruit_micro_cracking, fruit_notes, diseases
            FROM trials
            WHERE id = %s
            """,
            (trial_id,)
        )

        trial = cur.fetchone()

        if not trial:
            return jsonify({"error": "Trial not found"}), 404

        # Convert to dictionary
        trial_data = {
            "id": trial[0],
            "start_date": trial[1].isoformat() if trial[1] else None,
            "end_date": trial[2].isoformat() if trial[2] else None,
            "category_name": trial[3],
            "variety": trial[4],
            "location": trial[5],
            "region": trial[6],
            "plant_vigour": trial[7],
            "plant_earliness": trial[8],
            "plant_cold_tolerence": trial[9],
            "plant_heat_tolerence": trial[10],
            "fruit_setting": trial[11],
            "fruit_shape": trial[12],
            "plant_notes": trial[13],
            "fruit_quantity": trial[14],
            "fruit_uniformity": trial[15],
            "fruit_weight": float(trial[16]) if trial[16] else None,
            "fruit_firmness": trial[17],
            "fruit_calyx_quality": trial[18],
            "fruit_blotchy_ripening": trial[19],
            "fruit_macro_cracking": trial[20],
            "fruit_micro_cracking": trial[21],
            "fruit_notes": trial[22],
            "diseases": trial[23]
        }

        return jsonify(trial_data), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cur.close()
        conn.close()
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

    # Helper function to round and convert to float
    def round_value(val):
        if val is None:
            return None
        return round(float(val), 2)

    # Map results into a JSON object with rounded values
    averages = {
        "plant_vigour": round_value(row[0]),
        "plant_earliness": round_value(row[1]),
        "plant_cold_tolerence": round_value(row[2]),
        "plant_heat_tolerence": round_value(row[3]),
        "fruit_setting": round_value(row[4]),
        "fruit_quantity": round_value(row[5]),
        "fruit_uniformity": round_value(row[6]),
        "fruit_weight": round_value(row[7]),
        "fruit_firmness": round_value(row[8]),
        "fruit_calyx_quality": round_value(row[9]),
        "fruit_blotchy_ripening": round_value(row[10]),
        "fruit_macro_cracking": round_value(row[11]),
        "fruit_micro_cracking": round_value(row[12])
    }

    return jsonify(averages)
@trials_bp.route("/add_trial", methods=["POST"])
@trials_bp.route("/add_trial", methods=["POST"])
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
        # Prepare diseases as JSONB if provided
        diseases_json = None
        if "diseases" in data:
            import json
            diseases_json = json.dumps(data["diseases"])

        # Insert trial record with all fields
        cur.execute(
            """
            INSERT INTO trials (
                start_date, end_date, category_name, variety, location, region,
                plant_vigour, plant_earliness, plant_cold_tolerence, plant_heat_tolerence,
                fruit_setting, fruit_shape, plant_notes,
                fruit_quantity, fruit_uniformity, fruit_weight, fruit_firmness, 
                fruit_calyx_quality, fruit_blotchy_ripening, fruit_macro_cracking, 
                fruit_micro_cracking, fruit_notes, diseases
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING id
            """,
            (
                data["start_date"],
                data["end_date"],
                data["category"],  # This maps to category_name column
                data["variety"],
                data["location"],
                data["region"],
                data.get("plant_vigour"),
                data.get("plant_earliness"),
                data.get("plant_cold_tolerence"),
                data.get("plant_heat_tolerence"),
                data.get("fruit_setting"),
                data.get("fruit_shape"),
                data.get("plant_notes"),
                data.get("fruit_quantity"),
                data.get("fruit_uniformity"),
                data.get("fruit_weight"),
                data.get("fruit_firmness"),
                data.get("fruit_calyx_quality"),
                data.get("fruit_blotchy_ripening"),
                data.get("fruit_macro_cracking"),
                data.get("fruit_micro_cracking"),
                data.get("fruit_notes"),
                diseases_json
            ),
        )
        trial_id = cur.fetchone()[0]

        conn.commit()
        return jsonify({"success": True, "trial_id": trial_id}), 201

    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cur.close()
        conn.close()