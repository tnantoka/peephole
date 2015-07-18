Peephole.configure do |config|
  config.lines_per = 500
  config.bytes_per = 10000
  #config.peeper? do
  #  admin_user?
  #  authenticate_or_request_with_http_basic do |user, pass|
  #    user == 'user' && pass == 'pass'
  #  end
  #end
end
