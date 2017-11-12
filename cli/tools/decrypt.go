package tools

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/md5"
	"crypto/sha256"
	"fmt"
	"io/ioutil"

	"encoding/base64"

	"github.com/miquella/ask"

	"golang.org/x/crypto/pbkdf2"
)

const salt = "File2QRCodeSalt"
const pbkdf2Iterations = 4096

// StartDecrypt first asks user to type password and then starts decrypting process
func StartDecrypt(filePath *string) {

	password, err := getPassword()

	if err != nil {
		panic(err)
	}

	// Get file data
	base64CipheredData := getData(filePath)

	decrypt(base64CipheredData, &password)
}

func decrypt(base64CipheredData *[]byte, password *string) {

	// Decode base 64 data to get ciphered data
	cipheredData := make([]byte, base64.StdEncoding.DecodedLen(len(*base64CipheredData)))
	nbr, _ := base64.StdEncoding.Decode(cipheredData, *base64CipheredData)
	cipheredData = cipheredData[:nbr]

	// Start AES Decryption
	aesDecrypt(&cipheredData, password)
}

func aesDecrypt(data *[]byte, password *string) {

	// Generate the PBKDF2 key derivation for password and initialisation vector
	initialisationVector := pbkdf2.Key([]byte(*password), []byte(salt), pbkdf2Iterations, 16, md5.New)
	key := pbkdf2.Key([]byte(*password), []byte(salt), pbkdf2Iterations, 32, sha256.New)

	block, err := aes.NewCipher(key)
	if err != nil {
		panic(err.Error())
	}

	// Init AES with CBC mode
	aescbc := cipher.NewCBCDecrypter(block, initialisationVector)
	aescbc.CryptBlocks(*data, *data)

	// Print recovered data
	fmt.Printf("Your recovered data :\n%v\n", string(*data))
}

func getData(filePath *string) *[]byte {

	fileData, err := ioutil.ReadFile(*filePath)

	if err != nil {
		panic(err)
	}
	return &fileData
}

func getPassword() (string, error) {
	ask.Print("Please enter the password you've used to encrypt the file in the application.\n")
	return ask.HiddenAsk("Password: ")
}
