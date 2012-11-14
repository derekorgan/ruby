#worker.rb
require 'uri'
require 'net/http'
require 'stalker'
include Stalker

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


job 'hello' do |args|
  puts "hi" + args['id'].to_s +  "    " + Time.now.to_s
  sleep 1
  puts "bye" + args['id'].to_s +  "    " + Time.now.to_s
end

job 'post' do |args|
	puts "hi" + args['id'].to_s +  "    " + Time.now.to_s
	uri = URI.parse(web_url)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	request = Net::HTTP::Post.new(uri.request_uri)
	request.set_form_data(transmit_options)
	response = http.request(request)

	puts response.body.size
	puts "bye" + args['id'].to_s +  "    " + Time.now.to_s
end