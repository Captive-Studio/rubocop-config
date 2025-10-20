# Captive Rubocop config

[![License][license-image]][license-url]
[![Gem Version](https://img.shields.io/gem/v/rubocop-config-captive.svg)](https://rubygems.org/gems/rubocop-config-captive)

> Rubocop shared configurations for projects

## Install

add the follow line into your `Gemfile`

```ruby
group :test, :development do
  gem 'rubocop-config-captive', '~> 2.0'
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

## Common Errors

<details>
  <summary>
    <strong>😩 My project has too many errors</strong>
  </summary>
  
## Explanation

the configuration is very strict, it is normal to have many errors

## Solution

### Solution 1 : Auto-correct all errors

```shell
bundle exec rubocop -a
```

### Solution 2 : Ignore errors and progressively fix them

```shell
bundle exec rubocop --auto-gen-config
```

Will create `.rubocop_todo.yml` will all non passing rules. It is advised to fix them later, rule by rule.
</details>

<details>
  <summary>
    <strong>📍 <code>Gemfile</code> has lots of <code>Bundler/GemVersion</code> errors </strong>
  </summary>

## Explanation

Each dependency should be explicitly set in the `Gemfile` and `bundle update` is strongly discouraged.

## Solution

### Solution 1 : Use bundle-locker

1. Install bundle-locker globally

  ```shell
  gem install bundle-locker
  ```

2. Pin Gemfile using `Gemfile.lock`

  ```shell
  bundle-locker ./Gemfile
  ```

3. Manually edit `Gemfile` and adjust constraints `"x.x.x"`, `"~> x.x.x"`,  etc

4. Update `Gemfile.lock`

  ```shell
  bundle install
  ```

</details>

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

About Captive
-------------

![captive](https://raw.githubusercontent.com/Captive-Studio/assets/main/logo_captive_blue_avec_fond.webp)

rubocop-config-captive is maintained and funded by Captive.
The names and logos for captive are trademarks of captive-studio.

We love open source software!
See [our other projects][community] or
[hire us][hire] to design, develop, and grow your product.

[community]: https://github.com/Captive-Studio
[hire]: https://www.captive.fr/contact?utm_source=github
