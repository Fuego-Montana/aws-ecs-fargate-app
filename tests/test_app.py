"""Offline tests for the FastAPI demo app (no AWS required)."""

from fastapi.testclient import TestClient

from fargate_app import __version__
from fargate_app.main import app

client = TestClient(app)


def test_health_returns_ok() -> None:
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}


def test_root_welcome_payload() -> None:
    response = client.get("/")
    assert response.status_code == 200
    body = response.json()
    assert body["service"] == "aws-ecs-fargate-app"
    assert body["version"] == __version__
    assert "Welcome" in body["message"]
    assert "environment" in body


def test_info_includes_hostname() -> None:
    response = client.get("/info")
    assert response.status_code == 200
    body = response.json()
    assert body["service"] == "aws-ecs-fargate-app"
    assert body["version"] == __version__
    assert isinstance(body["hostname"], str)
    assert len(body["hostname"]) > 0
