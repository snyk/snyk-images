#!/usr/bin/env ruby

# Generate a GitHub Action with separate builds for every image
# based on the  contents of the two target files

require "date"
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

# Generate the dev.yml
templatename = File.join("_templates", "dev.yml.erb")
renderer = ERB.new(File.read(templatename))
File.open(".github/workflows/dev.yml", "w") { |file| file.puts renderer.result() }

# We need to write a file to trigger the image build action, as just changing the
# contents of workflow doesn't trigger it
File.open(".generated", "w") { |file| file.puts DateTime.now.iso8601 }


# Available distributions of snyk
# https://docs.snyk.io/snyk-cli/releases-and-channels-for-the-snyk-cli
distribution_map = {
  "stable" => "",
  "preview" => "-preview",
  "rc" => "-rc"
}


# Generate workflows for each distribution channel
distribution_map.each do |distribution, post_fix|
  @distribution_channel = distribution
  @post_fix = post_fix
  
  # Generate the workflow .yml
  templatename = File.join("_templates", "distribution-channel.yml.erb")
  renderer = ERB.new(File.read(templatename))

  File.open(".github/workflows/" + distribution + ".yml", "w") { |file| file.puts renderer.result() }
end

# We need to write a file to trigger the image build action, as just changing the
# contents of workflow doesn't trigger it
File.open(".generated", "w") { |file| file.puts DateTime.now.iso8601 }
