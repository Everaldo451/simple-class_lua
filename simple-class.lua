--[[
	This function creates a proxy to the instance and return this. Of course, 
the instance is acessed using a proxy, and this allows the use of private attributes and
methods

	Verify function is used to allow methods access the instance itself
]]

local function proxyInstance(self, Class)

	local function verify(tab, key)

		if type(tab[key]) == "function" then
			--print("é function")
			
			local instance = self
			
			return function(self, ...)
				return tab[key](instance, ...)
			end
		end

		return tab[key]

	end

	local mt = {}
	mt.__index = function(t, k)

		assert(string.sub(k, 1, 1) ~= "_", "Error: private Value")

		--print("é publico")

		if self[k] then
			--print("Tem em Instance")
			return verify(self, k)
		elseif Class[k] then
			--print("Tem em Class")
			return verify(Class, k)
		else return nil
		end

	end

	mt.__newindex = function(t, k, v)
		
		assert(string.sub(k, 1, 1) ~= "_", "Error: private Value")
		self[k] = v

	end
	
	mt.__metatable = true

	local proxy = {}
	setmetatable(proxy, mt)

	return proxy
end

--[[
	This function modify the newindex of anyone class, specially the "new" method, to allow
the inheritance and generate a proxied instance.
]]

local newIndex = function (class, parent)

    return function (t, k, v)

        if k == "new" and type(v) == "function" then
            
            local function n(self, ...)

				if self ~= class then

					local super = self.super
					local mt = getmetatable(self)

					if parent then
						self.super = function(self)
							return parent
						end
					end

					setmetatable(self, class)
					local self = v(self, ...)

					self.super = super
					setmetatable(self, mt)

					return
				end

				local instance = {}

				setmetatable(instance, class)
				if parent then
					instance.super = function(self)
						return parent
					end
				end

                instance = v(instance, ...)
                return proxyInstance(instance, class)
            end

            rawset(t, k, n)
        else 
            rawset(t, k, v)
        end
        
    end

end


--[[
	This function creates the class.
]]
Class = function (parent)
   
    local newClass = {}
    
    newClass.__index = newClass

    if parent then
        setmetatable(newClass, {__index = parent.__index, __newindex = newIndex(newClass, parent), __metatable = true})
    else
        setmetatable(newClass, {__newindex = newIndex(newClass), __metatable = true})
    end

    return newClass
end


return Class
