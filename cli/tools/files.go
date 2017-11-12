package tools

import (
	"io/ioutil"
)

// GetFileData opens a file and returns its content
func GetFileData(filename string) (*[]byte, error) {
	fileData, err := ioutil.ReadFile(filename)
	return &fileData, err
}
