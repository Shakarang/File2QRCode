package main

import (
	"QRcodeTest/models"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	qrcode "github.com/skip2/go-qrcode"
	"github.com/urfave/cli"
)

const limit = 1400

func main() {

	var filePath string
	var destination string

	app := cli.NewApp()
	app.Name = "File2QRCode"
	app.Usage = "Split a file into multiple QR Codes"
	app.Version = "0.0.1"

	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:        "split",
			Usage:       "Split the given file into multiple QR Codes",
			Destination: &filePath,
		},
		cli.StringFlag{
			Name:        "output",
			Usage:       "Specify a different output (default is current directory)",
			Destination: &destination,
		},
	}

	app.Action = func(c *cli.Context) error {
		if c.String("split") == filePath {
			data := getFileData(filePath)
			subs := splitIntoSubstrings(data)
			createCodesFromStrings(subs, &destination)
		}
		return nil
	}

	app.Run(os.Args)
}

func getFileData(filename string) *[]byte {

	fileData, err := ioutil.ReadFile(filename)
	if err != nil {
		panic("The file given cannot be opened.")
	}
	return &fileData
}

func splitIntoSubstrings(data *[]byte) *[]string {

	var content []string
	var tmpString string

	splitted := strings.Split(string(*data), "\n")

	for _, s := range splitted {
		if (len(tmpString) + len(s)) < limit {
			tmpString += s
			continue
		}
		content = append(content, tmpString)
		tmpString = ""
	}

	return &content
}

func createCodesFromStrings(data *[]string, destination *string) {

	for index, element := range *data {
		data := models.Data{ID: index, Content: element}
		code := models.Code{
			Data:     data,
			Checksum: data.Checksum(),
		}
		pngData, err := qrcode.Encode(code.Json(), qrcode.Medium, 1024)
		if err != nil {
			panic(err.Error())
		}
		if *destination != "" {
			fmt.Println("Destination", *destination)
			if err := ioutil.WriteFile(fmt.Sprintf("%v/%v.png", *destination, index+1), pngData, 0644); err != nil {
				panic(err)
			}
		} else {
			fmt.Println("Destination NIL")
			if err := ioutil.WriteFile(fmt.Sprintf("%v.png", index+1), pngData, 0644); err != nil {
				panic(err)
			}
		}
	}
}
