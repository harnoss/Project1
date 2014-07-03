#Random pickup-line generator

#User-stories
#I want to send an SMS to a phone number
#by using the console typing "generator.ruby send number person"
#The SMS includes
# - a random pickup pickup-line
# - the name of the person
# - some other intro text

#require 'rubygems'
#require 'twilio-ruby'

#Object-design
class Controller
	def self.run(input)
		# Embrace destructured assignment and the "splat" operator
		quote_type, command, number, name = *input
		file_name = quote_type + ".txt"
		raise "File does not exist" unless File.exists?(file_name)
		raise "you must pass the `send` command" unless command
		print_status(name, number)
		message = Message.generate(name, Parser.run(file_name), quote_type)
		Messenger.send_SMS(number, message)
	end

	def self.print_status(name, number)
		p "send to #{$name}, number #{$number}"
		p "the following message"
	end
end

class Viewer
	def render(text)
	end
end

class Message
	def self.generate(name, all_messages, type)
		line = all_messages.sample.join(" ")
		if type == "sherif"
			return "#{name}, #{line.downcase} Best wishes, Sherif"
		else
			return "#{name}, #{line}"
		end
	end
end

class Parser
	attr_reader :messages

	@all_messages = []

	def self.run(file)
		File.open(file).each do |line|
			@all_messages << line.split
		end
		return @all_messages
	end

	def self.show
		@all_messages.each do |message|
			p message
		end
		p @all_messages.size
	end



end

class Messenger
	def self.send_SMS(number, message)
		`curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/AC7a19ff5f4ab5fe7d93e722f8fff9bc3f/Messages.json' \
		--data-urlencode 'To=#{number}'  \
		--data-urlencode 'From=+16504092678'  \
		--data-urlencode 'Body="#{message}"' \
		-u AC7a19ff5f4ab5fe7d93e722f8fff9bc3f:7d19dc48b3fad97e4b1a001541cb9a5e`
		p "message sent"
		p message
	end
end

#Run program
Controller.new().run(ARGV)
#p $command == "send"

#Driver code
#p Message.generate("Justin", Parser.run('pickups.txt'))
#Parser.show

#p $messages.count != 0



