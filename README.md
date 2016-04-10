# Rails Components

A guide to implementing component-based architecture in Rails implemented using:

* Postgresql
* ERB
* Rspec
* Rubocop

### Table of Contents
**[Engines](#engines)**
**[Gems](#gems)**

## Engines

Rails Engines are useful for components that use database models and views.

**[Generating a new engine](#generating-a-new-engine)**
**[Add Rspec and related dependencies](#add-rspec-and-related-dependencies)**
**[Host application configuration](#host-application-configuration)**

### Generating a new engine

New engine: `ui_core`

```bash
$ rails plugin new components/ui_core --mountable -dummy-path=spec/dummy -T
```

### Add Rspec and related dependencies

Add the following lines to `components/ui_core/ui_core.gemspec`

```rb
spec.add_dependency 'pg'

spec.add_development_dependency 'rspec-rails'
```

Component test database to use the main app database:

```bash
$ cd <rails_root>/components/ui_core/spec/dummy/config
$ rm database.yml
$ ln –s ../../../../../config/database.yml
```

Install Rspec:

```bash
$ cd <rails_root>/components/ui_core
$ rails generate rspec:install
```

Update line of generated rails helper:

From:
```rb
require File.expand_path('../../config/environment', __FILE__)
```

To:
```rb
require File.expand_path('../dummy/config/environment', __FILE__)
```

### Host application configuration

Add these lines to the main app's Gemfile (`<rails_root>/Gemfile`):

```rb
path 'components/' do
  gem 'ui_core'
end
```

Mount the engine by adding these lines to the main app's routes (`<rails_root>/config/routes.rb`):

```rb
Rails.application.routes.draw do
  mount UiCore::Engine => ‘/’
end
```

## Gems

Gems are best for extracting functionality that does not depend on reading/writing to the database and has no view layer

**[Generating a new gem](#generating-a-new-gem)**
**[Plug into host application](#plug-into-host-application)**

### Generating a new gem

New gem: `parser`

```bash
$ bundle gem parser
```

### Plug into host application

Add these lines to the main app's Gemfile (`<rails_root>/Gemfile`):

```rb
path 'components/' do
  # ...
  gem 'parser'
end
```
