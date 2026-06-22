source "https://rubygems.org"

# Use the github-pages gem so local builds match GitHub Pages exactly.
# This pins Jekyll and bundles the allowed plugins (including jekyll-feed).
gem "github-pages", group: :jekyll_plugins

# Faster watching on macOS
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Stdlib gems unbundled from Ruby 3.4+ that the pinned Jekyll (3.9.x) still requires.
# Needed only for local builds on modern Ruby; harmless on GitHub Pages.
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
gem "ostruct"
