import json
import pytest
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test the root endpoint"""
    res = client.get('/')
    assert res.status_code == 200
    data = json.loads(res.data)
    assert "Welcome" in data["message"]

def test_hello_name(client):
    """Test the /hello/<name> endpoint"""
    name = "Mukti"
    res = client.get(f'/hello/{name}')
    assert res.status_code == 200
    data = json.loads(res.data)
    assert data["message"] == f"Hello, {name}!"

def test_add_numbers(client):
    """Test /add endpoint with valid numbers"""
    payload = {"num1": 10, "num2": 20}
    res = client.post('/add', json=payload)
    assert res.status_code == 200
    data = json.loads(res.data)
    assert data["result"] == 30

def test_add_numbers_invalid(client):
    """Test /add endpoint with invalid input"""
    payload = {"num1": "abc", "num2": 5}
    res = client.post('/add', json=payload)
    assert res.status_code == 400
    data = json.loads(res.data)
    assert "error" in data
