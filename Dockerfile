# Use an official Python base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY app.py .

# Expose the Flask port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
