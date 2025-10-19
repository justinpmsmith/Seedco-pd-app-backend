from flask import Blueprint, request, jsonify
from db import get_db_connection
import psycopg2.extras

categories_bp = Blueprint("categories", __name__)

@categories_bp.route("/get_all_categories", methods=["GET"])
def get_all_categories():
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    cur.execute("SELECT category_name FROM categories;")
    rows = cur.fetchall()

    cur.close()
    conn.close()

    categories = [row["category_name"] for row in rows]
    return jsonify(categories)

@categories_bp.route("/get_varieties_in_category/<string:category_name>", methods=["GET"])
def get_varieties_in_category(category_name):
    conn = get_db_connection()
    cur = conn.cursor()

    query = """
        SELECT t.variety
        FROM trials t
        JOIN categories c ON t.category_name = c.category_name
        WHERE c.category_name = %s
    """
    cur.execute(query, (category_name,))
    rows = cur.fetchall()

    cur.close()
    conn.close()

    varieties = [row[0] for row in rows]
    return jsonify(varieties)

@categories_bp.route("/add_category", methods=["POST"])
def add_category():
    data = request.get_json()

    # Validate input
    if not data or "name" not in data:
        return jsonify({"error": "Missing required field: name"}), 400

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute(
            """
            INSERT INTO categories (category_name)
            VALUES (%s)
            RETURNING id
            """,
            (data["name"],)
        )
        category_id = cur.fetchone()[0]
        conn.commit()
        return jsonify({"success": True, "category_id": category_id}), 201

    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500

    finally:
        cur.close()
        conn.close()