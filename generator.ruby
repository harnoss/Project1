#Random pickup-line generator

#User-stories
#I want to send an SMS to a phone number
#by using the console typing "generator.ruby send number person"
#The SMS includes
# - a random pickup pickup-line
# - the name of the person
# - some other intro text


#Object-design
class Controller
	def self.run(input)
		$command, $number, $name = input[0], input[1.to_i], input[2]

		case $command 
			when "send"
				p "send to #{$name}, number #{$number}"
				p "the following message"
				Message.generate
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
	def self.generate
	end
end

class Parser
	def self.run
	end
end

class Messenger
	def self.send_SMS
	end
end

#Run program
Controller.run(ARGV)
p $command == "send"

#Driver code

