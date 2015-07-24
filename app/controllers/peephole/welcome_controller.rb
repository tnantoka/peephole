require_dependency "peephole/application_controller"

module Peephole
  class WelcomeController < ApplicationController
    def index
      @logfiles = Logfile.all.sort { |a, b| b.updated_at <=> a.updated_at }
    end
  end
end
