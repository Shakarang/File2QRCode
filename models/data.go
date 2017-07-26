package models

import (
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"hash"
)

// Data represents the position of the data inside the original file and the content
type Data struct {
	ID      int    `json:"id"`
	Content string `json:"content"`
}

var hasher hash.Hash

func init() {
	hasher = sha256.New()
}

func (d *Data) Checksum() string {
	jsn, err := json.Marshal(d)
	if err != nil {
		panic(err.Error())
	}
	hasher.Reset()
	_, err = hasher.Write(jsn)
	if err != nil {
		panic(err.Error())
	}
	return fmt.Sprintf("%x", hasher.Sum(nil))
}
