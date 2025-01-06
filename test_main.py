from fastapi.testclient import TestClient

from main import app

client = TestClient(app)

def test_upload():
    with open("/sample.json", "rb") as f:
        response = client.post("/upload", files={"file": ("sample.json", f, "text/json")})
    assert response.status_code == 200
    assert response.json() == {"written": "sample.json"}

def test_list():
    response = client.get("/list")
    assert response.status_code == 200