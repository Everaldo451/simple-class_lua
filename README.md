# Lua Simple Class

The idea of this project is to create a simple way to simulate Lua classes with a syntax closer to other languages. It also supports private attributes and methods, and ensures that the instance itself is not affected by methods like `rawget` and `rawset`. However, the proxy table used can still be interfered with by these methods.

At the moment, there is only a single property common to all classes: the `new` method. Properties like `name` in JavaScript have not been added yet.

**Note**: This project is currently in the introductory phase.

## Use example

```lua
require 'class' --require the class module

local Animal = Class() --create a new class

function Animal:new(type) --create the constructor method

  self._type = type

  self:Say("oi")

  return self
end

function Animal:Say(value) --create a new class method
    print(self._type, value)
end

local Dog = Class(Animal)

function Dog:new()

  self:super().new(self, "dog") --this line is a example of super use for access the parent class methods.

  return self
end

local dog = Dog:new()

dog:Say("ola")

print(dog._type) --it is a private attribute. An error will be raised.
```

## Contributing

<ol>
  <li>Fork this repository</li>
  <li>Create a new branch</li>
  <li>Commit your changes</li>
  <li>Push to the branch</li>
  <li>Create a new pull request</li>
</ol>
