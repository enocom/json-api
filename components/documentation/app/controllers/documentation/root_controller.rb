module Documentation
  class RootController < ActionController::Base
    def index
      render layout: "documentation/application"
    end
  end
end
