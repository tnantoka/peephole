Peephole.configure do |config|
  config.paginates_per = 200
  config.peeper? do
    #admin_user?
    authenticate_or_request_with_http_basic do |user, pass|
      user == 'user' && pass == 'pass'
    end
  end
end
