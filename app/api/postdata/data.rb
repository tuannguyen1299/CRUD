module Postdata
  class Data < Grape::API

    resource :postdata do
      desc "List all post"
      get do
        Post.all
      end
    end
  end
end
