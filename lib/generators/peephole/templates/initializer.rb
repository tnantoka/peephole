Peephole.configure do |config|
  config.lines_per = 200
  config.bytes_per = 5000
  config.peeper? do
    !Rails.env.production?
  end
end
