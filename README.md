# Psycopg2 AWS Lambda Layer

This project builds an **AWS Lambda Layer** for `psycopg2`, allowing seamless PostgreSQL connections in AWS Lambda.

## 🛠 Build Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-repo/psycopg2-lambda-layer.git
   cd psycopg2-lambda-layer
   ```

2. **Build the Docker image:**
   ```bash
   docker build -t psycopg2-layer .
   ```

3. **Generate the AWS Lambda Layer zip file:**
   ```bash
   docker run --rm -v "$PWD":/output psycopg2-layer /bin/bash -c "cp /app/psycopg2-layer-*.zip /output"
   ```

The generated `.zip` file is ready for deployment as an AWS Lambda Layer.