from flask import Blueprint, jsonify
from db import get_db_connection

diseases_bp = Blueprint("diseases", __name__)

@diseases_bp.route("/get_diseases_for_variety/<string:variety_name>", methods=["GET"])
def get_diseases_for_variety(variety_name):
    conn = get_db_connection()
    cur = conn.cursor()

    query = """
        SELECT diseases
        FROM trials
        WHERE variety = %s
          AND diseases IS NOT NULL
    """
    cur.execute(query, (variety_name,))
    rows = cur.fetchall()

    cur.close()
    conn.close()

    # Aggregate all diseases into a single flat list
    all_diseases = []
    for row in rows:
        # Each row is a JSONB object/array → convert to Python dict/list
        if row[0]:
            if isinstance(row[0], list):
                all_diseases.extend(row[0])
            else:
                # if stored as JSON object with keys
                all_diseases.append(row[0])

    return jsonify(all_diseases)
