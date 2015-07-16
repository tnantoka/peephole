module Peephole
  class Config
    include ActiveSupport::Configurable

    config_accessor :paginates_per do
      200 
    end

    DEFAULT_PEEPER = proc { !Rails.env.production? }
    def peeper?(&block)
      @peeper = block if block_given?
      @peeper.presence || DEFAULT_PEEPER
    end 
  end
end
