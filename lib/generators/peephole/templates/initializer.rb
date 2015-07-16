Peephole.configure do |config|
  config.paginates_per = 200
  config.peeper? do
    !Rails.env.production?
  end
end
