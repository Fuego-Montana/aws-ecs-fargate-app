# syntax=docker/dockerfile:1
# Multi-stage build: slim runtime, non-root user, Python 3.12

FROM python:3.12-slim AS builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/home/appuser/.local/bin:$PATH" \
    SERVICE_NAME=aws-ecs-fargate-app \
    ENVIRONMENT=dev

RUN groupadd --system appgroup \
    && useradd --system --gid appgroup --create-home --home-dir /home/appuser appuser

WORKDIR /app

COPY --from=builder /install /usr/local
COPY src/ ./src/

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/health')" || exit 1

CMD ["uvicorn", "fargate_app.main:app", "--host", "0.0.0.0", "--port", "8080", "--app-dir", "src"]
