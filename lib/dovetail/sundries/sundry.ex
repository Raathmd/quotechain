defmodule Dovetail.Sundry do
    use Ash.Resource, domain: Dovetail.Quotes,
    data_layer: :embedded,
    embed_nil_values?: false
  
    attributes do
      uuid_primary_key :id
      # Links to Quote
      attribute :quote_number, :string, allow_nil?: false
      attribute :service_type, :string, allow_nil?: false
      attribute :sundry_code, :string, allow_nil?: false
      attribute :sundry_description, :string, allow_nil?: true
      # Collection or Delivery leg
      attribute :sundry_direction, :string, allow_nil?: false
      # Non-amendable by external users
      attribute :sundry_charge, :decimal, allow_nil?: false
      attribute :sundry_included, :boolean, allow_nil?: false
      # Indicates if override is allowed
      attribute :sundry_can_override, :boolean, allow_nil?: true
    end
  end
  