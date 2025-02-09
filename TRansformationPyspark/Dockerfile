# Use a lightweight base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install Java and system dependencies
RUN apt-get update && \
    apt-get install -y python3-pip default-jdk && \
    apt-get clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH=$JAVA_HOME/bin:$PATH


# Copy and install Python dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt



COPY main.py .

# Set the default command
CMD ["python", "main.py"]


