# frozen_string_literal: true

source "https://rubygems.org"

gem "jekyll-theme-chirpy", "~> 7.1", ">= 7.1.1"

gem "html-proofer", "~> 5.0", group: :test

platforms :windows do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# wdm gem 在 Ruby 3.4+ 上编译失败，已注释
# Jekyll 在没有 wdm 的情况下也能正常工作，只是文件监控性能稍差
# gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
