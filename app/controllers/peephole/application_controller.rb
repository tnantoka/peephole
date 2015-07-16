module Peephole
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!

    private
      def authenticate_user!
        redirect_to main_app.root_url unless instance_eval(&Peephole.config.peeper?)
      end
  end
end
