FROM python:3.9-slim

WORKDIR /app

# Copiar el archivo de configuración
COPY config.json ./data/

# Copiar el código
COPY app.py .

CMD ["python", "app.py"]