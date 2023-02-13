# Captive Rubocop config

[![License][license-image]][license-url]

> Rubocop shared configurations for projects

## Install

add the follow line into your `Gemfile`

```ruby
gem "captive-rubocop", github: 'Captive-Studio/rubocop-config'
```

And then in a terminal

```console
$ bundle
[...]
```

## Usage

```yml
# /.rubocop.yml
inherit_gem:
  captive-rubocop:
  - .rubocop.yml
  # - .rubocop_rails.yml # Uncomment this for Ruby on Rails

# Some files define `Exclude` for same cops. To merge the `Exclude` rules, add:
inherit_mode:
  merge:
    - Exclude
```

## License
<!-- AUTO-GENERATED-CONTENT:START (PKG_JSON:template=[${license}][license-url] © ${author}) -->
[MIT][license-url] © Captive Studio <julien.polo@captive.fr>

<!-- AUTO-GENERATED-CONTENT:START (PKG_JSON:template=[license-image]: https://img.shields.io/badge/license-${license}-green.svg?style=flat-square) -->
[license-image]: https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
<!-- AUTO-GENERATED-CONTENT:END -->
[license-url]: ./LICENSE
