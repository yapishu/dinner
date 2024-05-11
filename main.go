package main

import (
	"embed"
	"fmt"
	"io/fs"
	"net/http"
)

var (
	//go:embed dist/*
	content       embed.FS
	webContent, _ = fs.Sub(content, "dist")
	fileServer    = http.FileServer(http.FS(webContent))
)

func main() {
	http.Handle("/", fileServer)
	fmt.Println("Running on 8080")
	http.ListenAndServe(":8080", nil)
}
