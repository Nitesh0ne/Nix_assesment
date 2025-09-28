# nix_it_lab

## Project Overview

`nix_it_lab` is a tiny Go application exposing a single endpoint:

```
GET /health
```

Returns:

```json
{
  "status": "ok",
  "language": "Go"
}
```

It demonstrates a simple Go web server, Dockerization, and deployment to Kubernetes (GKE).

---

## Folder Structure

```
nix_it_lab/
├── cmd/
│   └── server/
│       └── main.go          # Entry point
├── internal/
│   └── handlers/
│       └── health.go        # Health endpoint logic
├── k8s/
│   ├── nix_it_lab-deployment.yaml
│   └── nix_it_lab-service.yaml
├── go.mod
├── Dockerfile
├── .gitignore
└── README.md
```

---

## Prerequisites

* Go 1.25+
* Docker
* Kubernetes cluster (e.g., GKE)
* `kubectl` configured for your cluster
* (Optional) Docker Hub account for pushing images

---

## Running Locally

1. Clone the repository:

```bash
git clone <repo_url>
cd nix_it_lab
```

2. Run the application:

```bash
go run ./cmd/server
```

3. Test the endpoint:

```bash
curl http://localhost:8080/health
```

Expected response:

```json
{"status":"ok","language":"Go"}
```

---

## Docker Setup

### Build the Docker image:

```bash
docker build -t nix_it_lab .
```

### Run the container:

```bash
docker run -p 8080:8080 nix_it_lab
```

Test the endpoint:

```bash
curl http://localhost:8080/health
```

---

## GitHub Actions (CI/CD)

* Workflow automatically builds and pushes Docker images to Docker Hub on push to `main`.
* Secrets required in GitHub:

  * `DOCKER_USERNAME`
  * `DOCKER_PASSWORD`

---

## Kubernetes Deployment (GKE)

### Apply Deployment

```bash
kubectl apply -f k8s/nix_it_lab-deployment.yaml
```

### Apply Service

```bash
kubectl apply -f k8s/nix_it_lab-service.yaml
```

### Verify

```bash
kubectl get pods
kubectl get svc
```

* `EXTERNAL-IP` column shows the public IP.
* Test:

```bash
curl http://<EXTERNAL-IP>/health
```
```
http://a25d67d4e5ce74ad8827e2b2e0656e6b-317484364.us-east-1.elb.amazonaws.com/health
```

---



## Notes

* Project uses **Go standard library only**, no external dependencies.
* Dockerfile uses **multi-stage build** for small final image.
* Designed to be a **learning project for Go, Docker, and GKE**.
