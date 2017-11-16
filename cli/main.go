package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/Shakarang/File2QRCode/cli/tools"

	"github.com/urfave/cli"
)

func main() {

	var filePath string
	var destination string
	var decryptFilePath string

	// Get current directory
	ex, err := os.Executable()
	if err != nil {
		panic(err)
	}
	exPath := filepath.Dir(ex)
	destination = exPath

	app := cli.NewApp()
	app.Name = "File2QRCode"
	app.Usage = "Split a file into multiple QR Codes"
	app.Version = "1.0.0"

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
		cli.StringFlag{
			Name:        "decrypt",
			Usage:       "Decrypt a file ciphered using mobile application File2QRCode",
			Destination: &decryptFilePath,
		},
	}

	app.Action = func(c *cli.Context) error {

		if c.String("split") == filePath && len(filePath) > 0 {
			data, err := tools.GetFileData(filePath)

			if err != nil {
				fmt.Println("Error opening the file", err)
				return err
			}
			tools.CreateCodes(data, &destination)
		} else if c.String("decrypt") == decryptFilePath && len(decryptFilePath) > 0 {
			tools.StartDecrypt(&decryptFilePath)
		} else {
			cli.ShowAppHelp(c)
		}
		return nil
	}

	app.Run(os.Args)
}
