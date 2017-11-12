package tools

import (
	"fmt"
	"io/ioutil"
	"os"

	"github.com/Shakarang/File2QRCode/cli/models"

	qrcode "github.com/skip2/go-qrcode"
)

const limit = 600

// CreateCodes creates QR codes with given data
func CreateCodes(data *[]byte, destination *string) {

	subs := splitIntoSubstrings(data)
	createCodesFromStrings(subs, destination)

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
			os.MkdirAll(*destination, os.ModePerm)
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
