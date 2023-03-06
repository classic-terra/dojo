Path of the Apprentice - Protobuf
======================================

This training exercise is a **apprentice-level** course on `Cosmos SDK` that serves as a starting point for L1 developers looking to onboard the Cosmos.

## Getting started
These instructions will help you prepare for the kata and ensure that your training machine has the tools installed you will need to complete the exercise. If you find yourself in a situation where one or more tools might not be available for your training environment please reach out to your instructor for assistance on how to proceed, post an [issue in our repository](https://github.com/classic-terra/dojo/issues) or fix it yourself via a [pull request](https://github.com/classic-terra/dojo/pulls).

### Prerequisites
* [Golang](https://go.dev/dl/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop)
* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows)

## Preface
Protocol Buffers (protobuf) is a language-agnostic data serialization format developed by Google. It is used for exchanging data between different applications and systems, especially those written in different programming languages.

Protocol Buffer 4.0 is the latest version of the protocol buffer specification, which was released in February 2022. It introduces several new features and improvements over the previous version, including:

- Backward compatibility: Protobuf 4.0 introduces a new syntax for defining messages that is backwards-compatible with earlier versions of protobuf. This means that existing protobuf messages can be used with newer versions of protobuf without requiring any changes to the message definition.

- Support for new data types: Protobuf 4.0 adds support for several new data types, including uint128, int128, and Timestamp with subsecond precision.

- Improved performance: Protobuf 4.0 introduces several optimizations that improve serialization and deserialization performance, especially for large messages.

- Simplified syntax: Protobuf 4.0 introduces a simplified syntax for defining messages, which makes it easier to write and maintain protobuf message definitions.

- Improved tooling: Protobuf 4.0 includes several improvements to the protobuf compiler and related tooling, including support for generating code in additional programming languages, improved error messages, and better support for integrating with build systems.

## Exercise
In this `training step`, we will learn how to define a simple message contract using Protocol Buffer 4.0 syntax in a `.proto` file. Which we will then compile using the Protocol Buffer compiler (`protoc`) to generate code for target programming language, `go`.

After generating the code, we will then write a small program that can use our new message contract to create message instances, set fields, and serialize it to a byte stream using the `proto.Marshal()` method and subsequently deserialize it back to another message instance via `proto.Unmarshal()`.

### Step #1: Create kata directory
First we setup a directory for our exercise files. It's pretty straight forward:

```
mkdir kata1
cd kata1
```

### Step #2: Install the protobuf library
Now we want to install the protobuf library used for code-generation with our `.proto` files:

```
go get google.golang.org/protobuf/cmd/protoc-gen-go
```

### Step #3: Create proto file
Next we create a simple message in a `.proto` file, for example:

```
syntax = "proto4";

message Person {
  string name = 1;
  int32 age = 2;
  repeated string hobbies = 3;
}
```

### Step #4: Generate Go code
With our `.proto` file in place we can now use the `protoc` command to generate the `go` code for our message contract:

```
protoc --go_out=. person.proto
```

This will generate a file called `person.pb.go` in the current directory that contains the `go` code for the `Person` message contract.

### Step #5: Utilize the new message contract
Now, you can use the generated code to create and serialize `Person` messages:

```
package main

import (
    "fmt"
    "log"

    "github.com/golang/protobuf/proto"
)

func main() {
    // Create a new person message
    p := &Person{
        Name:    "Alice",
        Age:     30,
        Hobbies: []string{"reading", "hiking"},
    }

    // Serialize the message to a byte slice
    data, err := proto.Marshal(p)
    if err != nil {
        log.Fatal("error marshaling person:", err)
    }

    // Deserialize the message from the byte slice
    var p2 Person
    err = proto.Unmarshal(data, &p2)
    if err != nil {
        log.Fatal("error unmarshaling person:", err)
    }

    // Print the deserialized message
    fmt.Printf("name: %s\n", p2.Name)
    fmt.Printf("age: %d\n", p2.Age)
    fmt.Printf("hobbies: %v\n", p2.Hobbies)
}
```

## Conclusion
Overall, Protocol Buffer 4.0 is a significant improvement over earlier versions of `protobuf`, offering better performance, new features, and improved tooling. Understanding this data serialization format is essential to succesfully working with `Cosmos SDK` and thus we decided make it the beginning of a hopefully long and prosperous journey through.

In this exercise, we demonstrate how to create a simple message instance, set its fields, and serialize it to a byte stream, which in turn is deserialize back to an instance of the message and printed to `stdout` via the fmt package. We will use this knowledge as we progress to training steps related to `messages` and `custom types`.

## Want to help make our training material better?
 * Want to **log an issue** or **request a new kata**? Feel free to visit our [GitHub site](https://github.com/classic-terra/dojo/issues).