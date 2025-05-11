defmodule Dovetail.Quotes do
    use Ash.Domain, extensions: [AshPhoenix]
  
    resources do
      resource Dovetail.Quote do
        define :create_request, action: :request
        define :search_quotes, action: :search
        define :get_quote_by_number, action: :read, get_by: :quote_number
      end

    end
  end