FROM python:3.9

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Retry pip install with increased timeout and use a PyPI mirror
RUN PIP_DEFAULT_TIMEOUT=120 pip install --no-cache-dir -r requirements.txt --index-url=https://pypi.org/simple

# Copy the application code into the container
COPY . .

# Expose port 8501 to the outside world (assuming your application uses this port)
EXPOSE 8501

# Set the command to run your Python application
CMD ["streamlit", "run", "app.py"]
