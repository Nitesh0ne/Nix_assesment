# Stage 1: Build the Go binary
FROM golang:1.25-alpine AS builder

# Set working directory
WORKDIR /app

# Copy module files first (for caching)
COPY go.mod ./


# Download dependencies (none in this project, but good practice)
RUN go mod download

# Copy source code
COPY . .

# Build the Go application
RUN go build -o nix_it_lab ./cmd/server

# Stage 2: Minimal image
FROM alpine:latest

WORKDIR /root/

# Copy the compiled binary
COPY --from=builder /app/nix_it_lab .

# Expose port 8080
EXPOSE 9000

# Run the app
CMD ["./nix_it_lab"]
