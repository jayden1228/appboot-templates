package main

import (
	"log"

	"{{.GitHost}}/{{.GitGroup}}/{{.Name}}/cmd"
)

func main() {
	log.SetFlags(0)
	cmd.Execute()
}
