# File2QRCode

File2QRCode is a project allowing you to print different files (e.g. SSH key, GPG key, ..) to QR Codes and lets you store them physically at any place you want. Your files are split in multiple codes and, are NOT encrypted, so you can recover them whenever you want by scanning the codes.

To make it more conveniant and also more secure, the project comes with an iOS application. It allows you to recover your entire file by scanning it and also, it lets you share your file the way you want (Mail, Airdrop, ..).
As sending clear data is definitly not secure, the application allows you to encrypt your data using AES-256. You only have to set a password. To decrypt the data, you can use the File2QRCode desktop application.

The desktop application and the iOS application are open source so that you can install them yourself and make sure your data will not leak through the process.

## Installation

### Command line application

Downloading binary (Recommended):

// TODO

Cloning :

```
> git clone git@github.com:Shakarang/File2QRCode.git
> cd File2QRCode/cli
> go run main.go
```

### iOS application

The iOS application uses [Carthage](https://github.com/Carthage/Carthage) as a dependency manager.

```
> git clone git@github.com:Shakarang/File2QRCode.git
> cd File2QRCode/iOS
> carthage bootstrap
```

## Usage

### Command line application

```
NAME:
   File2QRCode - Split a file into multiple QR Codes

USAGE:
   cli [global options] command [command options] [arguments...]

VERSION:
   1.0.0

COMMANDS:
     help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --split value    Split the given file into multiple QR Codes
   --output value   Specify a different output (default is current directory)
   --decrypt value  Decrypt a file ciphered using mobile application File2QRCode
   --help, -h       show help
   --version, -v    print the version
```

|Option|Parameter|
|---|---|
|`--split`|Give the filepath of the file you want to split into QR Codes|
|`--output`|Select a specific output for the codes (only for split option)|
|`--decrypt`|Filepath of the file encrypted with the iOS application|

### iOS application

[![http://www.youtube.com/watch?v=_XMYY7ZbT0g](https://img.youtube.com/vi/_XMYY7ZbT0g/0.jpg)](http://www.youtube.com/watch?v=_XMYY7ZbT0g)

## Licenses

### Command line application

- [github.com/urfave/cli](https://github.com/urfave/cli)
- [github.com/skip2/go-qrcode](https://github.com/skip2/go-qrcode)

### iOS application

- [github.com/krzyzanowskim/CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)

### Design

- [https://www.flaticon.com/packs/security-2](https://www.flaticon.com/packs/security-2)
