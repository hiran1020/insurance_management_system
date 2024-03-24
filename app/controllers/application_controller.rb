class ApplicationController < ActionController::API

def index
    render path: "users/index.html.erb"
end
end

