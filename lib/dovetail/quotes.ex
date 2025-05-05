defmodule Dovetail.Quotes do
    use Ash.Domain, extensions: [AshPhoenix]
  
    resources do
      resource Dovetail.Quote

    end
  end