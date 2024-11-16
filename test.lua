require 'class'

local Animal = Class()

function Animal:new(type)

    self._type = type

    self:Say("oi")

    return self
end

function Animal:Say(value)
    print(self._type, value)
end

local Dog = Class(Animal)

function Dog:new()

    self:super().new(self, "dog")

    print(getmetatable(self), self:super())

    return self
end

local dog = Dog:new()

dog:Say("ola")



