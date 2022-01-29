
<div align="center">


<img src="https://user-images.githubusercontent.com/194400/151025711-574482bb-918d-499f-b7cd-32bf224403c8.png"
alt="envar rainbow logo">

A collection of functions for checking/getting/setting **environment variables** in **`Elixir`**.

<!-- Better LOGO #HelpWanted -->

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dwyl/envar/Elixir%20CI?label=build&style=flat-square)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/envar/main.svg?style=flat-square)](http://codecov.io/github/dwyl/envar?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/envar?color=brightgreen&style=flat-square)](https://hex.pm/packages/envar)
[![Dependencies: None](https://img.shields.io/badge/dependencies-none-brightgreen.svg?style=flat-square)](https://libraries.io/hex/envar "Zero Dependencies")
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/envar/issues)
[![HitCount](http://hits.dwyl.com/dwyl/envar.svg)](http://hits.dwyl.com/dwyl/envar)


</div><br />

## Why?

We needed a way of checking that environment variables were defined
and improving the developer experience when they are not.
## What?

**`envar`** is our solution to a very specific problem:
the developer experience when a required environment variable is undefined.


<br />


## How?

### Installation

Install the package
by adding `envar` to your list of dependencies in your `mix.exs` file:

```elixir
def deps do
  [
    {:envar, "~> 1.0.4"}
  ]
end
```

## Usage

Load an `.env` file
containing a line-separated list of environment variables
on your `localhost`:

```elixir
Envar.load(".env")
```

That will locate the `.env` file in your project
and set each environment variable in it.

<br />


When you need to retrieve a specific environment variable,
use the following:

```elixir
DATABASE_URL = Envar.get("DATABASE_URL")
```

<br />

If you need to check that a variable is set,
use `is_set?/1`

```elixir
if Envar.is_set?("Heroku") do
  # do stuff on Heroku
end
```

To check if _any_ of the variables in a `List` are set,
invoke `Envar.is_set_any?/1`:

```elixir
if Envar.is_set_any?(~w/HEROKU FLYIO/) do
  # Do something on non-prod environment
end
```

Conversely, to confirm that _all_ the environment variables
in a list are set, invoke `Envar.is_set_all?/1`:

```elixir
if Envar.is_set_all?(~w/ADMIN_EMAIL AUTH_API_KEY/) do
  # Do something with the required environment variables
end
```

For more detail, please see docs:
https://hexdocs.pm/envar/Envar.html#functions

<br />

## Context

We created this module after doing
a search of the `Elixir` (Hex.pm)
ecosystem, <br />
see:
[dwyl/learn-environment-variables/issues/18](https://github.com/dwyl/learn-environment-variables/issues/18)

There are several modules available,
we wanted something very basic/specific to our needs. <br />
We don't expect anyone else to use this;
it's Open Source
because that's just what we do: <br />
[/manifesto.md#open-source-always](https://github.com/dwyl/start-here/blob/master/manifesto.md#open-source-always)
