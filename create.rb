#!/usr/bin/env ruby
require "open3"

def get_input(prompt, data = "")
	cmd = "rofi -dmenu -p '#{prompt}' -i"
	stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
	stdin.puts(data)
	stdin.close
	return stdout.read.strip
end

name = get_input("Enter profile name")

`firefox-developer-edition -CreateProfile "#{name} /home/yo/foxprofiles/#{name}"`
`cp -R /home/yo/foxprofiles/base/chrome /home/yo/foxprofiles/#{name}/.`
`cp -R /home/yo/foxprofiles/base/extensions /home/yo/foxprofiles/#{name}/.`
`cp /home/yo/foxprofiles/base/user.js /home/yo/foxprofiles/#{name}/user.js`