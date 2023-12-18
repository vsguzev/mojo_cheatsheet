# This is a comment explaining the code below
def main():
    # Using a 'def' function for dynamic behavior
    greet("World")

    # Working with variables and mutability
    var mutableValue = 5
    let immutableValue: Int = 10
    print(add_one(mutableValue))

    # Using a struct
    let pair = MyPair(1, 2)
    pair.dump()

    # Demonstrating traits
    var structInstance = SomeStruct()
    fun_with_traits(structInstance)

    # Parameterized function
    repeat[3]("Hello")

    # Using Python integration
    from python import Python
    let np = Python.import_module("numpy")
    let array = np.arange(6).reshape(2, 3)
    print(array)

		# Value semantics
    var a = 1
    var b = a
    b += 1
    print(a)  # Outputs 1
    print(b)  # Outputs 2

    # Function demonstrating value semantics in 'def'
    var x = 1
    add_one(x) # takes ownership and fully copies value
    print(x)  # Outputs 1

    # Function demonstrating value semantics in 'fn'
    var y = 1
    add_two(y) # takes ownership as immutable reference
    print(y)  # Outputs 1

# Function with 'def' showing value semantics
def add_one_to(y: Int):
    y += 1
    print(y)  # Outputs 2

# Function with 'fn' showing value semantics
fn add_two_to(y: Int):
    var z = y
    z += 2
    print(z)  # Outputs 3

# Simple function to greet
# - Defining Functions with Specific Argument and Return Types
def greet(name: String) -> String:
    return "Hello, " + name + "!"

# Using Optional Arguments
fn pow(base: Int, exp: Int = 2) -> Int:
    return base ** exp

# Keyword Arguments
fn use_keywords():
    let z = pow(exp=3, base=2)
    print(z)

# Function overloading
fn add(x: Int, y: Int) -> Int:
    return x + y

fn add(x: String, y: String) -> String:
    return x + y

# Function with variable type declaration
def add_one(x):
    let y: Int = 1
    return x + y

# Undeclared Variables
def example_undeclared_variable():
    simple_var = 10
    print(simple_var)

# Mutable and Immutable Variables
def mutable_immutable_example():
    var mutable_var = "mutable"
    let immutable_var = "immutable"
    mutable_var = "changed"
    # immutable_var = "cannot change" # This would cause a compiler error
    print(mutable_var, immutable_var)

# Type Annotations
def type_annotation_example():
    var name: String = "Mojo"
    print(name)

# Late Initialization
fn late_initialization_example(x: Int):
    let late_var: Float32
    if x != 0:
        late_var = 1.0
    else:
        late_var = 3.14
    print(late_var)

# Implicit Type Conversion
def implicit_conversion_example():
    var number: String = 1
    print(number)

# Variable Scopes
def lexical_scope_example():
    let outer_var = 10
    if True:
        let inner_var = 20
        print("Inner:", inner_var)  # Inner scope
    # print(inner_var) # This would cause an error as inner_var is not visible here
    print("Outer:", outer_var)      # Outer scope

# Struct Definition with Constructor and Methods
# Special Methods (Dunder Methods) __init__
struct MyPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second

    fn dump(self):
        print(self.first, self.second)

    fn get_sum(self) -> Int:
        return self.first + self.second

# Trait definition
trait SomeTrait:
    fn required_method(self, x: Int): ...

# Struct implementing a trait
struct SomeStruct(SomeTrait):
    fn required_method(self, x: Int):
        print("hello traits", x)

# Generic function using traits
fn fun_with_traits[T: SomeTrait](x: T):
    x.required_method(42)

# Parameterized function
fn repeat[count: Int](msg: String):
    for i in range(count):
        print(msg)

# @value Decorator
@value
struct MyPet:
    var name: String
    var age: Int

    fn speak(self):
        print("My name is", self.name, "and I am", self.age, "years old")

# Defining and Using Traits
trait Quackable:
    fn quack(self): ...

struct AnotherStruct(Quackable):
    fn required_method(self, x: Int):
        print("hello traits", x)
    fn quack(self):
        print("Quack from SomeStruct")

fn fun_with_quackable[T: Quackable](x: T):
    x.quack()

# Traits with Static Methods
trait HasStaticMethod:
    @staticmethod
    fn do_stuff(): ...

fn fun_with_static_method[T: HasStaticMethod]():
    T.do_stuff()

# Trait Inheritance
trait Animal:
    fn make_sound(self): ...

trait Bird(Animal):
    fn fly(self): ...

# Traits and Lifecycle Methods
trait DefaultConstructible:
    fn __init__(inout self): ...

trait Movable:
    fn __moveinit__(inout self, owned existing: Self): ...

trait MassProducible(DefaultConstructible, Movable):
    pass

struct Thing(MassProducible):
    var id: Int
    fn __init__(inout self):
        self.id = 0
    fn __moveinit__(inout self, owned existing: Self):
        self.id = existing.id


