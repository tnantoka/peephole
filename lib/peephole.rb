require "peephole/engine"
require "peephole/config"
require "peephole/version"

module Peephole
  class << self
    def configure(&block)
      yield config
    end

    def config
      @config ||= Config.new
    end
  end
end
