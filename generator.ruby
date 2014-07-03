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
		$command, $number, $name = input[0], input[1], input[2]

		case $command 
			when "send"
				p "send to #{$name}, number #{$number}"
				p "the following message"
				Parser.run('pickups.txt')
				Message.generate($name)
				Messenger.send_SMS($number, $message)
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
	def self.generate(name)
		line = $messages.sample.join(" ") 
		$message = "#{name}, #{line}"
	end
end

class Parser
	attr_reader :messages

	$messages = []

	def self.run(file)
		File.open(file).each do |line|
			$messages << line.split
		end
	end

#	def self.clean
#		$messages.map! do |message|
#			#some cleaning here with REGEX
#		end
#	end
end

class Messenger
	def self.send_SMS(number, message)
		#{}`curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/{AC7a19ff5f4ab5fe7d93e722f8fff9bc3f}/Messages' \
		#{}-d "To=+15105081935"  \
		#{}-d "From=+16504092678" \ 
		#{}-d "Body=Hello world!" \
		#{}-d "MediaUrl=http://www.images.com/flower.png" \
		#{}-u '{AC7a19ff5f4ab5fe7d93e722f8fff9bc3f}:{7d19dc48b3fad97e4b1a001541cb9a5e}'` 

		`curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/AC7a19ff5f4ab5fe7d93e722f8fff9bc3f/Messages.json' \
		--data-urlencode 'To=#{number}'  \
		--data-urlencode 'From=+16504092678'  \
		--data-urlencode 'Body="#{message}"' \
		-u AC7a19ff5f4ab5fe7d93e722f8fff9bc3f:7d19dc48b3fad97e4b1a001541cb9a5e`
		p "message sent"
		p $message

		# account_sid = "AC7a19ff5f4ab5fe7d93e722f8fff9bc3f"
		# auth_token = "7d19dc48b3fad97e4b1a001541cb9a5e"
		# client = Twilio::REST::Client.new account_sid, auth_token
 
		# from = "+16504092678" # Your Twilio number
		 
		# friends = {
		# number.to_s => name,
		# }

		# friends.each do |key, value|
		#   client.account.messages.create(
		#     :from => from,
		#     :to => key,
		#     :body => "Hey #{value}, Monkey party at 6PM. Bring Bananas!"
		#   ) 
		#   puts "Sent message to #{value}

	end
end

#Run program
Controller.run(ARGV)
#p $command == "send"

#Driver code
#Parser.run('pickups.txt')
#p $messages.count != 0



