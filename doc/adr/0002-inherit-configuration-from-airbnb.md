# 2. Inherit configuration from Airbnb

Date: 2023-02-15

## Status

Accepted

## Context

Airbnb are tech leaders in many web technologies. They open-sourced their rubocop configuration at [github](https://github.com/airbnb/ruby), with people maintaining it.
Like ESLint configuration, their configuration is the result of problem solving and discussion on concrete industry cases.

Compared to Airbnb, Captive is a small team. We do not have the human resources to maintain such kind of project on short term.

## Decision

Julien Polo decided to :

- Use Airbnb as a solid base of work for Captive configuration
- Not depend on Airbnb as a Gem, because we would have had no control over `rubocop` and plugin versions
  - A script `script/pull` simply copy Airbnb rules to `config/__private__` folder

## Consequences

- Some developers did not understand the `Airbnb` references in the configuration
  - The configuration must be de-branded from `Airbnb` to avoid confusion, yet explaining the clear dependency
  - Some additional documentation (such as this document) were added
