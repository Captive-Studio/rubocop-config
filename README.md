# Captive Rubocop config

[![License][license-image]][license-url]

> Rubocop shared configurations for projects

## Install

add the follow line into your `Gemfile`

```ruby
group :test, :development do
  gem "rubocop-config-captive", github: 'Captive-Studio/rubocop-config'
end
```

And then in a terminal

```console
$ bundle install
[...]
```

## Usage

```yml
# /.rubocop.yml
inherit_gem:
  rubocop-config-captive:
  - config/default.yml
  # -OR-
  # - config/rubocop-XXX.yml
```

## Contributing

To contribute, here are some inspirations for good configurations :

- [Airbnb](https://github.com/airbnb/ruby/tree/main/rubocop-airbnb)

## License
<!-- AUTO-GENERATED-CONTENT:START (PKG_JSON:template=[${license}][license-url] © ${author}) -->
[MIT][license-url] © Captive Studio <julien.polo@captive.fr>

<!-- AUTO-GENERATED-CONTENT:START (PKG_JSON:template=[license-image]: https://img.shields.io/badge/license-${license}-green.svg?style=flat-square) -->
[license-image]: https://img.shields.io/badge/license-MIT-green.svg?style=flat-square
<!-- AUTO-GENERATED-CONTENT:END -->
[license-url]: ./LICENSE
