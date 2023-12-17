# Mojo Programming Language
Mojo is a high-performance, memory-safe language designed for AI, supporting both Python interoperability and complex compile-time metaprogramming through parameters and decorators.

## Features
- Value Ownership: Single variable ownership of values with immediate destruction policy.
- Memory Management: No garbage collector/manual memory management, types manage their lifecycle via constructors and destructors.
- Python Compatibility: Import and use Python modules, Mojo is progressing towards full Python compatibility.
- Modules and Packages: Organize code in modules (.mojo files) and packages (directories with `__init__.mojo`). Packages can be compiled into `.mojopkg` or `.📦` files.
- Decorators: Higher-order functions that modify code at compile-time (e.g., `@always_inline`, `@value`).
- Parameters: Compile-time variables for metaprogramming and creating generic code structures.

## Getting Started
Define functions in `.mojo` files and use the `import` statement to use them or package them into distributable `.mojopkg` or `.📦` files. An `__init__.mojo` file is required in directories treated as packages.

```mojo
struct MyPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second
```

## Importing Modules
```mojo
import mymodule
```
Import classes and functions into your main `.mojo` file from modules.

## Creating Packages
Organize modules in a directory with an `__init__.mojo` file and run `mojo package mypackage -o mypack.mojopkg`.

## Language Constructs
- Standard behaviors for Copy (`__copyinit__()`) and Move (`__moveinit__()`, `__takeinit__()`) constructors.
- Value types (`@value`) to generate lifecycle methods automatically.
- Lifecycles (`@register_passable`, `@register_passable("trivial")`) for passing types in CPU registers efficiently.
- Automatic compilation optimization (`@unroll`).
- Metaprogramming with parameters (`@parameter`).
- Python object integration with special handling of Python dictionaries and on-demand type conversion.

## Devices and Runners
- Device-based execution (`Device` class) to choose the best performing device.
- Runners (`JITRunner`, `CompiledASTRunner`) for executing compiled code.
- Buffer management (`_BufferCopy`, `Allocator`, `LRUAllocator`, `MallocAllocator`) for memory operations.

## Python Integration
Within Mojo, utilize and interact with Python objects, dictionaries, and modules, with full Type integration and runtime conversion to Mojo types (`Int`, `String`, `Bool`, `Float64`). Python objects get encapsulated in `PythonObject` for seamless operation within Mojo code.

For further details and the latest updates, refer to the [official Mojo documentation](https://docs.modular.com/mojo/).
```


# Mojo Examples

The following examples showcase various features of the Mojo programming language, illustrating how to use struct definitions, value ownership, import modules, decorators, and Python integration.

### Struct Definitions and Usage

```mojo
// Define a struct with an initializer and dump method
struct MyPair:
  var first: Int
  var second: Int

  fn __init__(inout self, first: Int, second: Int):
    self.first = first
    self.second = second

  fn dump(self):
    print(self.first, self.second)

// Use the struct in main
fn main():
  let pair = MyPair(2, 4)
  pair.dump()  // Output: 2 4
```

### Importing Modules

```mojo
// Import the entire module
import mymodule

// Import a specific struct with an alias
from mymodule import MyPair as Pair

// Use the imported struct
fn main():
  let pair = Pair(3, 6)
  pair.dump()  // Output: 3 6
```

### Packaging

```sh
# Compile a package into a distributable file
mojo package mypackage -o mypack.mojopkg
```

### Decorators

```mojo
@value  // Auto-generate constructors and destructors
struct SimpleStruct:
  var data: String

@always_inline  // Force inlining of this function
fn add(a: Int, b: Int) -> Int:
  return a + b
```

### Value Ownership

```mojo
fn main():
  let x = SimpleStruct("data")
  let y = x^  // 'x' is moved to 'y', 'x' becomes invalid
  // ... 'y' is used ...
  // 'y' is automatically destroyed when no longer in use
```

### Parameters and Metaprogramming

```mojo
fn compute[TYPE: DType, SIZE: Int](data: SIMD[TYPE, SIZE]) -> Float64:
  // Perform compute operations...
  return result

// Call with literals as compile-time parameters
let result = compute[FLOAT32, 128](myData)
```

### Python Integration

```mojo
fn main() raises:
  let np = Python.import_module("numpy")
  let array = np.array([1, 2, 3])
  print(array)  // Output: [1 2 3]

  // Use a Python dictionary in Mojo
  let pyDict = Python.dict()
  pyDict["key"] = "value"
  print(pyDict["key"])  // Output: value
```

Each of these examples demonstrates a different area of Mojo's functionality, helping programmers write efficient and memory-safe AI-oriented applications with seamless Python compatibility and robust metaprogramming capabilities.
