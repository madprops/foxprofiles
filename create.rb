#!/usr/bin/env ruby
require "fileutils"

if ARGV.empty?
	puts "Usage: create.rb <profile_name>"
	exit
end

name = ARGV[0]
firefox = "firefox-developer-edition"
base = File.dirname(File.expand_path(__FILE__))
profiles = File.join(Dir.home, "foxprofiles")
path = File.join(profiles, name)

unless File.directory?(profiles)
	FileUtils.mkdir_p(profiles)
	puts "Created: #{profiles}"
end

puts "Creating profile..."
`#{firefox} -CreateProfile "#{name} #{path}"`

puts "Copying files..."
FileUtils.cp_r(File.join(base, "chrome"), File.join(path, "chrome"))
FileUtils.cp_r(File.join(base, "extensions"), File.join(path, "extensions"))
FileUtils.cp(File.join(base, "user.js"), File.join(path, "user.js"))

puts "Launching Firefox..."
`#{firefox} -P "#{name}"`