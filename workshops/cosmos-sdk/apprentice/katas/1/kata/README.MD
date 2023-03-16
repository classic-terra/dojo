# Path of the Apprentice - Protocol Buffers

This training exercise is a **apprentice-level** course on Cosmos SDK that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started

These instructions will help you prepare for the `training step` and ensure that your training machine has the tools installed you will need to complete the exercise. If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites

* [Golang](https://go.dev/dl/)
* [Protocol Buffer Compiler](https://grpc.io/docs/protoc-installation/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface

Protocol Buffers (`protobuf`) is a language-agnostic data serialization format developed by Google. It is used for exchanging data between different applications and systems, especially those written in different programming languages.

Protocol Buffer 4.0 is the latest version of the protocol buffer specification, which was released in February 2022. It introduces several new features and improvements over the previous version, including:

* `Backward compatibility`: `protobuf` 4.0 introduces a new syntax for defining messages that is backwards-compatible with earlier versions of `protobuf`. This means that existing `protobuf` messages can be used with newer versions of `protobuf` without requiring any changes to the message definition.

* `Support for new data types`: `protobuf` 4.0 adds support for several new data types, including uint128, int128, and Timestamp with subsecond precision.

* `Improved performance`: `protobuf` 4.0 introduces several optimizations that improve serialization and deserialization performance, especially for large messages.

* `Simplified syntax`: `protobuf` 4.0 introduces a simplified syntax for defining messages, which makes it easier to write and maintain `protobuf` message definitions.

* `Improved tooling`: `protobuf` 4.0 includes several improvements to the `protobuf` compiler and related tooling, including support for generating code in additional programming languages, improved error messages, and better support for integrating with build systems.

## Exercise

In this `training step`, we will learn how to define a simple message contract using Protocol Buffer 3.0 syntax in a `.proto` file. Which we will then compile using the Protocol Buffer compiler (`protoc`) to generate code for our target programming language, `Go`.

After generating the code, we will write a small program that can use our new message contract to create message a instance, set its fields, and serialize it to a byte stream using the `proto.Marshal()` method and subsequently deserialize it back to another message instance via `proto.Unmarshal()`.

### Step #1: Create kata directory

First we setup a directory for our exercise files. It's pretty straight forward:

```bash
mkdir kata1
cd kata1
```

### Step #2: Initialize `Go` module

Now we want to initialize a new `Go` module and install the packages needed for code-generation with our `.proto` files:

```bash
go mod init proto
go get google.golang.org/`protobuf`/proto@latest
go get google.golang.org/`protobuf`/cmd/protoc-gen-go@latest
go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

The above CLI commands are used to setup up our `Go` module for working with protocol buffers and gRPC. Here's what each command does:

- `go mod init proto`: Initializes a new Go module named `proto` in the current directory. This command creates a `go.mod` file, which is used to manage dependencies for the module.

- `go get google.golang.org/`protobuf`/proto@latest`: Downloads the latest version of the `proto` package from the `google.golang.org/`protobuf`` module and adds it as a dependency to the current module. The proto package provides support for working with protocol buffers in Go.

- `go get google.golang.org/`protobuf`/cmd/protoc-gen-go@latest`: Downloads the latest version of the `protoc-gen-go` CLI from the `google.golang.org/`protobuf`` module and installs it in the bin directory of your `$GOPATH`. This tool is used to generate Go code from protocol buffer definitions.

- `go get google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest`: Downloads the latest version of the `protoc-gen-go-grpc` cLI from the `google.golang.org/grpc` module and installs it in the bin directory of your `$GOPATH`. This tool is used to generate Go code for gRPC servers and clients from protocol buffer definitions.

### Step #3: Create `protobuf` message contract

To create a simple message contract, we can create a file named `person.proto` and add the following content:

```bash
PROTO_MSG="syntax = \"proto3\";
option go_package = \"proto/main\";

message Person {
  string name = 1;
  int32 age = 2;
  repeated string hobbies = 3;
}"

echo "$PROTO_MSG" > person.proto
```

Our new `message contract` defines a Protocol Buffer message named `Person` with three fields: `name`, `age`, and `hobbies`. The `option go_package = "proto/main";` statement specifies the `Go` package name for the generated code. In this case, the generated `Go` code will be placed in the `proto` directory under the `main` package.

### Step #4: Generate Go code

With our `person.proto` file in place we can now use the `protoc` CLI to generate the `Go` code for our message contract:

```bash
protoc --go_out=. person.proto --go_opt=paths=source_relative
```

This will generate a file called `person.pb.go` in the current directory that contains the `Go` code for our message contract.

### Step #5: Utilize the new message contract

After generating the `Go` code from the `person.proto` file, you can use it to create and serialize `Person` messages. Here is an example `Go` program that creates a `Person` message, marshals it into a binary format, and then unmarshals the binary data back into a new `Person` object:

```go
package main

import (
    "fmt"
    "log"

    "github.com/golang/`protobuf`/proto"
)

func main() {
    p := &Person{
        Name:    "Alice",
        Age:     30,
        Hobbies: []string{"reading", "hiking"},
    }

    data, err := proto.Marshal(p)
    if err != nil {
        log.Fatal("error marshaling person:", err)
    }

    var p2 Person
    err = proto.Unmarshal(data, &p2)
    if err != nil {
        log.Fatal("error unmarshaling person:", err)
    }

    fmt.Printf("name: %s\n", p2.Name)
    fmt.Printf("age: %d\n", p2.Age)
    fmt.Printf("hobbies: %v\n", p2.Hobbies)
}
```

Once you are satisfied with the implementation, you can save the code to a file named `main.go`.

### Step #6: Build executable

Build a new `Go` binary based on our module:

```bash
go build
```

### Step #7: Run executable

Lastly we can run our new `Go` binary with the following command to verify that everything works as intended:

```bash
./proto
```

## Conclusion

Overall, Protocol Buffer 4.0 is a significant improvement over earlier versions of `protobuf`, offering better performance, new features, and improved tooling. Understanding this data serialization format is essential to succesfully working with Cosmos SDK and thus we decided make it the beginning of a hopefully long and prosperous journey through the K1 dojo.

The architectural pattern of Protocol Buffers is based on a client-server model, where the client and server use Protocol Buffers to communicate with each other. The server defines the `.proto` file that defines the data structure, and the client uses the generated code to serialize and deserialize the data that is transmitted over the network. This makes it a powerful tool for efficient inter-process communication and data storage.

Cosmos SDK currently targets a modified version of Protocol Buffer 3.0 however we expect support for Protocol Buffer 4.0 to become available in the near future and thus we decided it made more sense to target the newest version in this `training step` and in the process demonstrate that the latest version of `protoc` works with older schemas such as the one targeted in our code kata.

## Want to help make our training material better?

Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).
