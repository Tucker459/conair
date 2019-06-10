package main

import (
	"encoding/csv"
	"io"
	"log"
	"os"
)

func main() {

	if len(os.Args[1:]) != 2 {
		log.Fatal("Must specify input and output file!")
	}
	filename := os.Args[1]
	dataFile, err := os.Open(filename)
	if err != nil {
		log.Fatal(err.Error())
	}

	outputFile, err := os.Create(os.Args[2])
	if err != nil {
		log.Fatalln("unable to create outputfile: ", err.Error())
	}
	defer outputFile.Close()

	r := csv.NewReader(dataFile)
	// controls whether call to Read return a slice shring the backing array
	// of the previous call's returned slice increasing the performance
	r.ReuseRecord = true
	r.FieldsPerRecord = -1 // If negative, allows varing number of fields per record

	//row, err := r.Read() // handle header
	var row []string
	for {
		row, err = r.Read()
		if err != nil {
			if err == io.EOF {
				break
			}
			log.Fatal(err.Error())
		}
		//Filter by necessary columns
		newRow := row[0:6]
		newRow = append(newRow, row[8])
		newRow = append(newRow, row[10:12]...)
		newRow = append(newRow, row[13])
		newRow = append(newRow, row[17])
		newRow = append(newRow, row[19])
		newRow = append(newRow, row[24:28]...)
		newRow = append(newRow, row[35:39]...)
		newRow = append(newRow, row[41])
		newRow = append(newRow, row[45:47]...)

		w := csv.NewWriter(outputFile)
		if err := w.Write(newRow); err != nil {
			log.Fatalln("error writing record to csv: ", err.Error())
		}

		w.Flush()

		if err := w.Error(); err != nil {
			log.Fatal(err)
		}
	}
	dataFile.Close()
}
