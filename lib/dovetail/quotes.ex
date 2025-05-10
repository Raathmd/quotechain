defmodule Dovetail.Quotes do
    use Ash.Domain, extensions: [AshPhoenix]
  
    resources do
      resource Dovetail.Quote do
        define :create_request, action: :request
      end

    end
  end