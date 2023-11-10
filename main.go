package main

import (
	"log"

	"github.com/StarNGK/XrayR/cmd"
)

func main() {
	if err := cmd.Execute(); err != nil {
		log.Fatal(err)
	}
}
