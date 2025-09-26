# -----------------------------
# Stage 1: Build the Go binary
# -----------------------------
FROM golang:1.23-alpine AS builder

# Set working directory inside container
WORKDIR /app

# Copy go.mod and go.sum first (if any) for caching dependencies
COPY go.mod ./


# Download dependencies (if any)
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go binary
RUN go build -o nix_it_lab ./cmd/server

# -----------------------------
# Stage 2: Create a minimal image
# -----------------------------
FROM alpine:latest

# Set working directory
WORKDIR /root/

# Copy binary from builder stage
COPY --from=builder /app/healthapp .

# Expose port 8080
EXPOSE 8080

# Run the binary
CMD ["./nix_it_lab"]
