require 'rubygems'
require 'eventmachine'
require 'em-http'


def time
  start = Time.now
  yield
  puts Time.now - start
end

time do

	LIVE_SERVER_ENDPOINT = "https://www.bfgeek.com/api/v1/"

	web_url = LIVE_SERVER_ENDPOINT + "node_history_items.json"


	secondary_params = { :title => "1xx",
	                         :url => "http://xxxx.xx.xx",
	                         :time_on_site => "20",
	                         :description => "This is a description	",
	                         :host_name => "xxx.x.x",
	                         :host_key => "xxxxxxxxdsafdsfasdxxxfadsfasd",
	                         :version => "17",
	                         :source => "console",
	                         :ip_address => "111.11.11.11"}

	pre_processed_params = {:time_to_parse_sentences => "128937491827349812734987123",
	                            :digest => "asdkjfjklasdjflkasdjfl;kasjdflkasjdflkajsdflkajsdl;fkjasdlkfjasdl;kfja;sldkfja;lsdkjfal;skdjfa;lskdjf;alskdjf;lkasdjf;lkasdflkjadsklfjasl;djfal;sdkjfalksdjfalksdjflaksjdfl;aksjdflkasjdflkasjdflkasjdflkjasdfkljasdlkfjasdlkfja;sdlkjfa;lskdjflak;jdsfoqieuroiquewroiqewurqpoiweurqoiweurqpoiweurqopiewurqopiewurqopieur1983741298374192837498123749081723498127348917234nasdfjkhasdkjfhasdkfjhakjsdhfalksdjhfkjasndfm,ands,fmnadsfhlkajsdhfkjahsdf,mnasd,fnaskjdhfjashdf",
	                            :pass_poem => "pass_poem",
	                            :auth_token => "$Dfasdfasdfasdfasdfasdf",
  								:sentences => 'x' * 500_000 }
	details = secondary_params.merge(pre_processed_params)

	transmit_options = {:body => details,
	                        :ssl_verifypeer => 1,
	                        :ssl_verifyhost => 0,
	                        }.merge(:method => :post)


	#10.times do 
	EventMachine.run do
	 
		multi = EventMachine::MultiRequest.new


		100.times do |i|
			http = EventMachine::HttpRequest.new(web_url) 
			req = http.post :body => transmit_options
			multi.add i, req
		end

		#multi.callback  do
		#    p multi.responses[:callback].size
		#    p multi.responses[:errback].size
		    EventMachine.stop
 		#end
	 end
	#end
end

# 100 requests using multi 27 seconds
