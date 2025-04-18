defmodule Dovetail.Quotes do
    use Ash.Domain
  
    resources do
      resource Quotechain.Dovetail.Quotes.Quote
      resource Quotechain.Dovetail.Items.Item
      resource Quotechain.Dovetail.Sundries.Sundry
    end
  end