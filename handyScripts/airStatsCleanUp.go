package main

import (
	"fmt"
	"log"
	"os/exec"
	"strings"
)

func checkError(e error) {
	if e != nil {
		log.Fatalf(e.Error())
	}
}

func main() {
	lsCmd := exec.Command("bash", "-c", "ls *.csv")
	output, err := lsCmd.Output()
	checkError(err)

	files := string(output)
	files = strings.Trim(files, "\n")
	myFiles := strings.Split(files, "\n")

	// removes header from files
	for _, v := range myFiles {
		if v != myFiles[0] {
			cmd := fmt.Sprintf("sed -i -e 1d %s", v)
			sedCmd := exec.Command("bash", "-c", cmd)
			err := sedCmd.Run()
			checkError(err)
		}
	}

	// appending into one file
	for _, v := range myFiles {
		if v != myFiles[0] {
			cmd := fmt.Sprintf("cat %s >> %s", v, myFiles[0])
			appendCmd := exec.Command("bash", "-c", cmd)
			err := appendCmd.Run()
			checkError(err)
		}
	}
}
