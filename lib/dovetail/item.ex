defmodule Dovetail.Item do
    use Ash.Resource, 
    data_layer: :embedded,
    embed_nil_values?: false
  
    attributes do
      uuid_primary_key :id
      # Links to Quote
      attribute :quote_number, :string, allow_nil?: false
      # System-calculated
      attribute :line_number, :integer, allow_nil?: true
      # Default 1 if not supplied
      attribute :quantity, :integer, allow_nil?: false, default: 1
      # Must be valid if entered
      attribute :product_code, :string, allow_nil?: true
      attribute :description, :string, allow_nil?: true
      # Default 0.1 if not supplied
      attribute :total_weight, :decimal, allow_nil?: false, default: 0.1
      # Default if blank
      attribute :length, :decimal, allow_nil?: false
      # Default if blank
      attribute :width, :decimal, allow_nil?: false
      # Default if blank
      attribute :height, :decimal, allow_nil?: false
      # System-calculated
      attribute :volumetric_weight, :decimal, allow_nil?: true
      # System default if not supplied
      attribute :rate_type, :string, allow_nil?: true
    end

    validations do
      validate present([:quote_number, :line_number,
      :description], at_least: 1),,
      validate numbericality(:quantity, greater_than: 0)
    end

  end