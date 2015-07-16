require_dependency "peephole/application_controller"

module Peephole
  class LogfilesController < ApplicationController
    before_action :set_logfile

    def show
      @page = params[:page].to_i.nonzero? || 1
      @loglines, @eof = @logfile.loglines(@page)
    end

    def download
      send_file @logfile.path
    end

    private
      def set_logfile
        @logfile = Logfile.find(params[:id])       
      end
  end
end
