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

func listFiles(fileType string) ([]string, error) {
	lsCmd := fmt.Sprintf("ls %s", fileType)
	output, err := exec.Command("bash", "-c", lsCmd).Output()
	if err != nil {
		return nil, err
	}

	files := string(output)
	files = strings.Trim(files, "\n")
	myFiles := strings.Split(files, "\n")

	return myFiles, nil
}

func main() {

	myZipFiles, err := listFiles("*.zip")
	checkError(err)

	// unzip files
	for _, v := range myZipFiles {
		unZipCmd := fmt.Sprintf("unzip %s", v)
		_ = exec.Command("bash", "-c", unZipCmd).Run()
	}

	err = exec.Command("bash", "-c", "rm -f *.zip *.html").Run()
	checkError(err)

	myFiles, err := listFiles("*.csv")
	checkError(err)

	// removes header from files
	for _, v := range myFiles {
		if v != myFiles[0] {
			cmd := fmt.Sprintf("sed -i -e 1d %s", v)
			err := exec.Command("bash", "-c", cmd).Run()
			checkError(err)
		}
	}

	// appending into one file
	for _, v := range myFiles {
		if v != myFiles[0] {
			cmd := fmt.Sprintf("cat %s >> %s", v, myFiles[0])
			err := exec.Command("bash", "-c", cmd).Run()
			checkError(err)
		}
	}

	err = exec.Command("bash", "-c", "rm -f *-e").Run()
	checkError(err)
}
