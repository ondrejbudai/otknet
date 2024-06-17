package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path"

	"github.com/google/go-jsonnet"
	"github.com/google/go-jsonnet/ast"
)

func main() {
	vm := jsonnet.MakeVM()

	vm.TLACode("target", `"osbuild"`)

	vm.NativeFunction(&jsonnet.NativeFunction{
		Name: "external",
		Func: func(args []interface{}) (interface{}, error) {
			// TODO: Check len(args)
			name, valid := args[0].(string)
			if !valid {
				return nil, errors.New("name must be string")
			}
			stdin, err := json.Marshal(args[1])
			if err != nil {
				return nil, fmt.Errorf("cannot encode json for external (%s): %w", name, err)
			}

			// TODO: add a sane way of checking that the external exist
			executable := path.Join("./externals", name)
			cmd := exec.Command(executable)
			cmd.Stdin = bytes.NewReader(stdin)

			output, err := cmd.CombinedOutput()
			if err != nil {
				return nil, fmt.Errorf("running external (%s) failed: %w\noutput:\n%s", name, err, output)
			}

			var result interface{}
			if err := json.Unmarshal(output, &result); err != nil {
				return nil, fmt.Errorf("cannot parse the result of external (%s): %w\nraw output:\n%s", name, err, output)
			}

			return result, nil
		},
		Params: ast.Identifiers{"name", "stdin"},
	})

	// TODO: check argv len
	output, err := vm.EvaluateFile(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "%v", err)
		os.Exit(1)
	}

	fmt.Printf("%s", output)
}
