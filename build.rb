#!/usr/bin/env ruby

require "erb"
require "fileutils"

@images = [
  ["node",  "node"],
  ["node:10", "node-10"]
]
templatename = File.join("_templates", "build.yml.erb")
renderer = ERB.new(File.read(templatename))
File.open(".github/workflows/build.yml", "w") { |file| file.puts renderer.result() }
