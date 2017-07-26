package models

import "encoding/json"

// Code represents the message that will be hidden in the QR Code
type Code struct {
	Data     Data   `json:"data"`
	Checksum string `json:"checksum"`
}

// JSON returns the current Code struct in JSON
func (c *Code) JSON() string {
	jsn, err := json.Marshal(c)
	if err != nil {
		panic(err.Error())
	}
	return string(jsn)
}
