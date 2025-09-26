package handlers

import (
	"encoding/json"
	"net/http"
)

func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	response := map[string]string{
		"status":   "ok",
		"language": "Go",
	}

	json.NewEncoder(w).Encode(response)
}
