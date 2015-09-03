# Github Releases

[![Gem Version](https://badge.fury.io/rb/github_releases.svg)](http://badge.fury.io/rb/github_releases)
[![Build Status](https://travis-ci.org/G5/github_releases.svg?branch=master)](https://travis-ci.org/G5/github_releases)

Github Releases creates an endpoint that exposes an app's releases for use in
displaying a current version.

## Requirements

An app that utilizes Github's release feature

## Installation

1. Add this line to your application's Gemfile:

   ```ruby
   gem 'github_releases'
   ```

2. And then execute:

   ```console
   bundle
   ```


3. Configure your app in a config/initializers/github_releases.rb initializer

   ```ruby
   GithubReleases.setup do |config|
      # configure your app's Github username
      config.username = 'g5search'
      # configure your app's Github repo name
      config.repo = 'g5-cxm'
   end

   ```
   
4. Set your GitHub API token in a GITHUB_API_TOKEN environment variable.

5. Install

   ```ruby
   rails g github_releases:install
   ```

   This mounts the engine at `/releases`.
   
   If you're using a pure Rails app, and want to use the current_version view helper, add     GithubReleases::ApplicationHelper to your ApplicationController.

   ```ruby
   class ApplicationController < ActionController::Base
      helper GithubRelease::ApplicationHelper
   end
   ```

## Usage

The engine exposes an endpoint at '/releases' that will list all of the app's
releases in json. '/releases/latest' will expose the latest release to use in
displaying your apps current version. You may also access any single release
by id '/releases/:id'.

For pure Rails apps, you may access the current_version of your app with a view helper...

```Ruby
<%= current_version %>
```

**IMPORTANT** All calls to the GitHub API are cached. It's up to you to refresh the cache when releases should be updated. There are two ways to do this. Via the rake task...

```
rake github_releases:refresh_cache
```

Or via a Ruby class method...

```Ruby
GithubReleases.refresh_cache
```

One strategy is to run the rake task in a post deploy hook.

## Authors

* Brian Bauer / [@bbauer](https://github.com/bbauer)

## Contributing

1. [Fork it](https://github.com/g5search/github_releases/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write your code and **specs**
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/github_releases/issues).

## Specs

### Running the specs

Run specs via `rspec` with:

```bash
$ rspec spec
```

## License

Copyright (c) 2015 G5

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

