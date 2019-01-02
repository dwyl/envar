
<div align="center">

# `envar`

<!-- LOGO Goes Here -->

</div>

## Why?

We needed a way of checking that environment variables were defined 
and improving the developer experience when they are not.
## What?

**`envar`** is our solution to a very specific problem:
the developer experience when a required environment variable is undefined. 


## How?

### Installation

Install the package
by adding `envar` to your list of dependencies in your `mix.exs` file:

```elixir
def deps do
  [
    {:envar, "~> 0.1.0"}
  ]
end
```



## Research

We created this module after doing
a comprehensive search of the `Elixir` (Hex.pm)
ecosystem, see:
[dwyl/learn-environment-variables/issues/18](https://github.com/dwyl/learn-environment-variables/issues/18)

