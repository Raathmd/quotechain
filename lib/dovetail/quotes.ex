defmodule Dovetail.Quotes do
    use Ash.Domain
  
    resources do
      resource Dovetail.Quotes.Quote
    end
  end