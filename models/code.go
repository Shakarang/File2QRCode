package models

import "encoding/json"

// Code represents the message that will be hidden in the QR Code
type Code struct {
	Data     Data   `json:"data"`
	Checksum string `json:"checksum"`
}

func (c *Code) Json() string {
	jsn, err := json.Marshal(c)
	if err != nil {
		panic(err.Error())
	}
	return string(jsn)
}
