require "Win32API" 
require "win32/clipboard"
include Win32
require "highline/system_extensions"
include HighLine::SystemExtensions
require "auto_click"

module PasteProject

@@file_names = []

def self.paste_key_press()
	key_down(0x11)
	key_stroke("v")
	key_up(0x11)
	key_stroke("tab")
end

def self.get_file_names(current_dir)

	dir = Dir.entries(current_dir)
	
	dir.each do |file|
		file_name = file.split(".")
		@@file_names << file_name[0]
	end
	@@file_names.delete_at(0)
	@@file_names.delete_at(0)
	return @@file_names
end

def self.print_menu(files)
	count = 1
	puts "----------------------------"
	puts "CURRENT PASTE FILES"
	puts "----------------------------"
	files.each do |file|
		puts "#{count}: #{file}"
		count = count + 1
	end
	puts ""
end

def self.get_user_input
	puts "(To exit type 'quit')"
	puts ""
	print "Select file to auto paste: "
	choice = STDIN.gets.chomp()
	if  choice == "quit"
		Process.exit(1)
	else
		return Integer(choice)
	end
end

def self.load_file(file_name)
	file = File.new("paste_project/data/#{file_name}.txt", "r")
	paste_file = []
	count = 1
	while (line = file.gets)
		paste_file << line
		count = count + 1
	end
	file.close
	return paste_file
end

def self.paste_lines(file)
	
	puts ""
	count = 1
	
	sleep 1.5
	
	file.each do |line|
		Clipboard.set_data(line)
		paste_key_press
		puts "#{count}: #{line}"
		count = count + 1
		sleep 0.2
	end
	
	puts ""
end

def self.run

	get_file_names("paste_project/data")
	
	while true
		Clipboard.empty
		print_menu(@@file_names)
		file_name = @@file_names[get_user_input-1]
		file = load_file(file_name)
		paste_lines(file)
	end
end

run


end
