require_dependency "peephole/application_controller"

module Peephole
  class LogfilesController < ApplicationController
    before_action :set_logfile
    before_action :set_page, only: %i(show raw)

    def show
      @loglines, @eof = @logfile.lines(@page)
    end

    def download
      send_file @logfile.path
    end

    def raw
      @raw, @eof = @logfile.bytes(@page)
    end

    private
      def set_logfile
        @logfile = Logfile.find(params[:id])       
      end

      def set_page
        @page = params[:page].to_i.nonzero? || 1
      end
  end
end
