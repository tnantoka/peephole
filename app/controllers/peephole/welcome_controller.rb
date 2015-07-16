require_dependency "peephole/application_controller"

module Peephole
  class WelcomeController < ApplicationController
    def index
      @logfiles = Logfile.all
    end
  end
end
