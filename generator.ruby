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
		type, command, number, name = input[0], input[1], input[2], input[3]

		case type
			when "pickup"
				file = 'pickups.txt'
			when "sherif"
				file = 'sherif.txt'
			else
				p "this file does not exist"
		end

		case command 
			when "send"
				p "send to #{$name}, number #{$number}"
				p "the following message"
				message = Message.generate(name, Parser.run(file))
				Messenger.send_SMS(number, message)
			else
				p "this command does not exist"
		end
	end
end

class Viewer
	def render(text)
	end
end

class Message
	def self.generate(name, all_messages)
		line = all_messages.sample.join(" ") 
		return "#{name}, #{line}"
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
	

#	def self.clean
#		$messages.map! do |message|
#			#some cleaning here with REGEX
#		end
#	end
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
Controller.run(ARGV)
#p $command == "send"

#Driver code
#p Message.generate("Justin", Parser.run('pickups.txt'))
#Parser.show

#p $messages.count != 0



