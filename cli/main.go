package main

import (
	"fmt"
	"io/ioutil"
	"os"
	// "strings"

	"github.com/Shakarang/File2QRCode/cli/models"

	qrcode "github.com/skip2/go-qrcode"
	"github.com/urfave/cli"
)

const limit = 100

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
		panic(err)
	}
	return &fileData
}

func splitIntoSubstrings(data *[]byte) *[]string {

	var content []string
	var tmpArray = string(*data)
	var tmpLimit = limit

	if len(tmpArray) < tmpLimit {
		tmpLimit = len(tmpArray)
	}

	for index := 0; index < len(tmpArray); index += tmpLimit {
		if len(tmpArray) < (index + tmpLimit) {
			tmpLimit = len(tmpArray) - index
		}
		content = append(content, tmpArray[index:index+tmpLimit])
	}

	return &content
}

func createCodesFromStrings(data *[]string, destination *string) {
	for index, element := range *data {
		data := models.Data{ID: index, Content: element, Elements: len(*data)}
		code := models.Code{
			Data:     data,
			Checksum: data.Checksum(),
		}
		pngData, err := qrcode.Encode(code.JSON(), qrcode.Medium, 1024)
		if err != nil {
			panic(err.Error())
		}
		if *destination != "" {
			if err := ioutil.WriteFile(fmt.Sprintf("%v/%v.png", *destination, index+1), pngData, 0644); err != nil {
				panic(err)
			}
		} else {
			if err := ioutil.WriteFile(fmt.Sprintf("%v.png", index+1), pngData, 0644); err != nil {
				panic(err)
			}
		}
	}
}
