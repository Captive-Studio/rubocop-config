# 3. Enable String/StringLiterals

Date: 2023-07-31

## Status

Accepted

## Context

### Our code

We lack consistency in the quoting standard of string literal. It is not clearly defined which should be used.
The best example is a Gemfile, where we can often find both single quotes and double quotes, without any particular reason (probably the source of the copy paste).

### Tradeoff Analysis

- `Enabled: false` :
  - BAD : no style = consider that the developer knows what he/she is doing, which is not always true
  - BAD : no consistency in code = bad practise propagation
- `'single_quotes'` :
  - GOOD : secure because string interpolation cannot be done unintentionnally
  - BAD : when adding an interpolation, developer must change the quoting character
  - BAD : double quotes are still necessary when interpolation is needed
- `'double_quotes'` :
  - GOOD : developer does not have to change quote character when adding/removing interpolation
  - GOOD : only double quotes can be used for string literals, single quote is obsolete
  - BAD : could be unsecure (but should almost never happen)

### Reference to other libraries

- [Rubocop](https://docs.rubocop.org/rubocop/cops_style.html) : `'single_quotes'`
- [RubyGems](https://rubygems.org/gems/rails) `'single_quotes'` (snippets to install a gem)
- [Rails](https://github.com/rails/rails/blob/main/.rubocop.yml) : `'double_quotes'`
- [StandardRB](https://github.com/standardrb/standard/blob/1214481276c5e5dd4ce4e84b10042476bd82bd8f/config/base.yml#L1677) : `'double_quotes'`
- [AirBnB] : `Enabled: false`

## Decision

## Consequences
