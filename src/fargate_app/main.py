"""Small FastAPI app designed to run on ECS Fargate behind an ALB."""

from __future__ import annotations

import os
import socket

from fastapi import FastAPI
from fastapi.responses import JSONResponse

from fargate_app import __version__

SERVICE_NAME = os.getenv("SERVICE_NAME", "aws-ecs-fargate-app")
ENVIRONMENT = os.getenv("ENVIRONMENT", "dev")

app = FastAPI(
    title=SERVICE_NAME,
    version=__version__,
    description="Portfolio demo: FastAPI on ECS Fargate",
)


@app.get("/health")
def health() -> dict[str, str]:
    """ALB / ECS health check endpoint."""
    return {"status": "ok"}


@app.get("/")
def root() -> dict[str, str]:
    """Welcome payload with service identity."""
    return {
        "message": "Welcome to the ECS Fargate portfolio demo",
        "service": SERVICE_NAME,
        "version": __version__,
        "environment": ENVIRONMENT,
    }


@app.get("/info")
def info() -> JSONResponse:
    """Runtime metadata useful for verifying rolling deploys."""
    return JSONResponse(
        {
            "service": SERVICE_NAME,
            "version": __version__,
            "environment": ENVIRONMENT,
            "hostname": socket.gethostname(),
            "python": os.getenv("PYTHON_VERSION", "3.12"),
            "aws_region": os.getenv("AWS_REGION", os.getenv("AWS_DEFAULT_REGION", "unknown")),
        }
    )
