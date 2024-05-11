# Use a Python base image
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app

# Expose port 5000
EXPOSE 5000

# Set the command to run the Flask application
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
