#Lua Simple Class

The idea of this project is to create a simple way to simulate Lua classes with a syntax closer to other languages. It also supports private attributes and methods, and ensures that the instance itself is not affected by methods like `rawget` and `rawset`. However, the proxy table used can still be interfered with by these methods.

At the moment, there is only a single property common to all classes: the `new` method. Properties like `name` in JavaScript have not been added yet.

**Note**: This project is currently in the introductory phase.

##Contributing

<ol>
  <li>Fork this repository</li>
  <li>Create a new branch</li>
  <li>Commit your changes</li>
  <li>Push to the branch</li>
  <li>Create a new pull request</li>
</ol>
