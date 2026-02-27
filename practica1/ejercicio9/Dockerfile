FROM python:3.9-slim

RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

RUN mkdir -p /app/logs && chown -R appuser:appgroup /app

COPY writer_app.py .

RUN chown appuser:appgroup writer_app.py

USER appuser

CMD ["python", "writer_app.py"]