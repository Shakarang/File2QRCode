package main

import (
	"QRcodeTest/models"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	qrcode "github.com/skip2/go-qrcode"
)

const limit = 1400

func main() {
	data := getFileData(os.Args[1])
	subs := splitIntoSubstrings(data)
	createCodesFromStrings(subs)
}

func getFileData(filename string) []byte {

	fileData, err := ioutil.ReadFile(filename)
	if err != nil {
		panic("The file given cannot be opened.")
	}
	return fileData
}

func splitIntoSubstrings(data []byte) []string {

	var content []string
	var tmpString string

	splitted := strings.Split(string(data), "\n")

	for _, s := range splitted {
		if (len(tmpString) + len(s)) < limit {
			tmpString += s
			continue
		}
		content = append(content, tmpString)
		tmpString = ""
	}

	return content
}

func createCodesFromStrings(data []string) {

	for index, element := range data {
		data := models.Data{ID: index, Content: element}
		code := models.Code{
			Data:     data,
			Checksum: data.Checksum(),
		}
		pngData, err := qrcode.Encode(code.Json(), qrcode.Medium, 1024)
		if err != nil {
			panic(err.Error())
		}
		ioutil.WriteFile(fmt.Sprintf("%v.png", index+1), pngData, 0644)
	}
}
