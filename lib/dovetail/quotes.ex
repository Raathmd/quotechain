defmodule Dovetail.Quotes do
    use Ash.Domain
  
    resources do
      resource Quotechain.Dovetail.Quote
      resource Quotechain.Dovetail.Item
      resource Quotechain.Dovetail.Sundry
    end
  end