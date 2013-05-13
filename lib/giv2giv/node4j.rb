require 'net/http'
require 'uri'
require 'json'

def getData()
  url  = 'http://localhost:7474/db/data/'
  resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
  data = resp.body
end


#puts getData()
load 'lib/functions.rb'


class NeoRest
	attr_accessor :data
	@http = Net::HTTP.new("localhost", "7474")

	def self.put(id, key= "josh", value = "good")
		request = Net::HTTP::Put.new("/db/data/node/"+id.to_s+"/properties/"+key)
		request.set_form_data({key=>value})
		puts request
		response = @http.request(request)
		puts response.body.inspect
		create_instance(response)
	end

	def self.post(key = "id", value = generate_unique_id())
		request = Net::HTTP::Post.new("/db/data/node/")
		request.set_form_data({key=>value})
		response = @http.request(request)
		puts response.body.inspect
		create_instance(response)
	end

	def self.get(id)
		request = Net::HTTP::Get.new("/db/data/node/"+id.to_s)
		response = @http.request(request)
		create_instance(response)
	end #get

	def self.delete(id)
		request = Net::HTTP::Delete.new("/db/data/node/"+id.to_s)
		response = @http.request(request)
	end #get

	def self.find_by_email(email)
		request = Net::HTTP::Delete.new("/db/data/index/node/my_nodes/DONOR_EMAIL_INDEX/"+email)
		response=@http.request(request)
		create_instance(response)
	end

	def self.find_by_id(unique_id)
		request = Net::HTTP::Delete.new("/db/data/index/node/my_nodes/DONOR_ID_INDEX/"+unique_id.to_s)
		response=@http.request(request)
		create_instance(response)
	end

	def self.create_instance(response)
		puts response.body
		decode=JSON.parse(response.body)
		instance = self.new 
		instance.data=decode["data"]
		puts "created following instance"
		puts decode["data"]
		puts decode["self"]
		instance
	end

	def self.add_to_index(node, index)
		"y"
	end





end #class


#testrest()

#puts "SHOULD POST STUFF"
#bob=NeoRest.post()
#puts bob.class


#puts "SHOULD PUT/EDIT SOMETHING"
# 	bob=NeoRest.put(11081, "email", "joshemail")


puts "SHOULD GET STUFF"
josh=NeoRest.get(11081)
puts josh.class



puts "SHOULD DELETE STUFF"
joshdel=NeoRest.delete(11051)
puts joshdel





