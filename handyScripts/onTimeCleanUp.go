package main

import (
	"fmt"
	"log"
	"os/exec"
	"strings"
)

func main() {

	lsCmd := exec.Command("ls")
	output, err := lsCmd.Output()
	if err != nil {
		log.Fatalf(err.Error())
	}

	files := string(output)
	files = strings.Trim(files, "\n")
	myFiles := strings.Split(files, "\n")

	fmt.Println(len(myFiles))
	fmt.Println(myFiles[1])

}
