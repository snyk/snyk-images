#!/usr/bin/env ruby

require "erb"
require "fileutils"


@images = []

["linux", "alpine"].each do |target|
  File.open(target).each do |line|
    base,tag = line.split
    @images.append [base, tag ? tag : base, target]
  end
end

# Matrix builds require a least one item in the matrix to be valid
# so we grab the first entry to populate the matrix.
# Everything else is used as explicitly included jobs.
@seed = @images.shift

templatename = File.join("_templates", "build.yml.erb")
renderer = ERB.new(File.read(templatename))
File.open(".github/workflows/build.yml", "w") { |file| file.puts renderer.result() }
