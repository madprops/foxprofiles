#!/usr/bin/env ruby
if ARGV.empty?
	puts "Usage: create.rb <profile_name>"
	exit
end

name = ARGV[0]
base = "/home/yo/foxprofiles/base"
path = "/home/yo/foxprofiles/#{name}"

`firefox-developer-edition -CreateProfile "#{name} #{path}"`
`cp -R #{base}/chrome #{path}/.`
`cp -R #{base}/extensions #{path}/.`
`cp #{base}/user.js #{path}/user.js`
`firefox-developer-edition -P "#{name}"`