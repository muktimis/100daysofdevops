# Use lightweight Python image
FROM python:3.9-slim

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy app code
COPY . .

# Expose port and run Flask
EXPOSE 5000
CMD ["python", "app.py"]
