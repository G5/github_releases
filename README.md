# Github Releases

Github Releases creates an endpoint that exposes an app's releases for use in
displaying a current version.

## Current Version

0.0.0

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

4. Install

   ```ruby
   rails g github_releases:install
   ```

   This mounts the engine at `/releases`.

## Usage

The engine exposes an endpoint at '/releases' that will list all of the app's
releases in json. '/releases/latest' will expose the latest release to use in
displaying your apps current version. You may also access any single release
by id '/releases/:id'.

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

