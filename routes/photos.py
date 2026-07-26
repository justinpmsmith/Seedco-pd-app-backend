import os
from uuid import uuid4
from flask import Blueprint, request, jsonify

photos_bp = Blueprint("photos", __name__)

ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "webp"}
UPLOAD_DIR = os.getenv("UPLOAD_PATH", os.path.join(os.path.dirname(__file__), "..", "uploads"))


@photos_bp.route("/upload_photo", methods=["POST"])
def upload_photo():
    try:
        if "photo" not in request.files:
            return jsonify({"success": False, "error": "No photo field in request"}), 400

        file = request.files["photo"]

        if file.filename == "":
            return jsonify({"success": False, "error": "No file selected"}), 400

        ext = file.filename.rsplit(".", 1)[-1].lower() if "." in file.filename else ""
        if ext not in ALLOWED_EXTENSIONS:
            return jsonify({"success": False, "error": "Invalid file type. Allowed: jpg, jpeg, png, webp"}), 400

        filename = f"{uuid4()}.{ext}"
        os.makedirs(UPLOAD_DIR, exist_ok=True)
        file.save(os.path.join(UPLOAD_DIR, filename))

        return jsonify({"success": True, "filename": filename}), 200

    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500
