#!/usr/bin/env ruby
require "fileutils"

if ARGV.empty?
	puts "Usage: create.rb <profile_name>"
	exit
end

name = ARGV[0]
firefox = "firefox-developer-edition"
profiles = File.join(Dir.home, "foxprofiles")
$base = File.dirname(File.expand_path(__FILE__))
$path = File.join(profiles, name)

unless File.directory?(profiles)
	FileUtils.mkdir_p(profiles)
	puts "Created: #{profiles}"
end

def dirbase(d)
	File.join($base, d)
end

def dirpath(d)
	File.join($path, d)
end

puts "Creating profile..."
`#{firefox} -CreateProfile "#{name} #{$path}"`

puts "Copying files..."
FileUtils.cp_r(dirbase("chrome"), dirpath("chrome"))
FileUtils.cp_r(dirbase("extensions"), dirpath("extensions"))
FileUtils.cp(dirbase("user.js"), dirpath("user.js"))

puts "Launching Firefox..."
`#{firefox} -P "#{name}"`