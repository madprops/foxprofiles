#!/usr/bin/env ruby
require "fileutils"

if ARGV.empty?
	puts "Usage: create.rb <profile_name>"
	exit
end

name = ARGV[0]
base = File.dirname(File.expand_path(__FILE__))
profiles = File.join(Dir.home, "foxprofiles")
firefox = "firefox-developer-edition"

unless File.directory?(profiles)
	FileUtils.mkdir_p(profiles)
	puts "Created: #{profiles}"
end

path = File.join(profiles, name)

puts "Creating profile..."
`#{firefox} -CreateProfile "#{name} #{path}"`

puts "Copying files..."
`cp -R #{base}/chrome #{path}/.`
`cp -R #{base}/extensions #{path}/.`
`cp #{base}/user.js #{path}/user.js`

puts "Launching Firefox..."
`#{firefox} -P "#{name}"`