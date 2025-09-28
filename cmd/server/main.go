package main

import (
	"log"
	"net/http"

	"healthapp/internal/handlers" // importing from your module
)

func main() {
	http.HandleFunc("/health", handlers.HealthHandler)

	log.Println("Server is running on http://localhost:9000")
	if err := http.ListenAndServe(":9000", nil); err != nil {
		log.Fatalf("server failed: %v", err)
	}
}
