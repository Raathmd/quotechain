defmodule Dovetail.Quote do
  use Ash.Resource,
    domain: Dovetail.Quotes,
    data_layer: AshPostgres.DataLayer

  alias Dovetail.Item
  alias Dovetail.Sundry

  postgres do
    table "quotes"
    repo Quotechain.Repo
  end

  actions do
    # Use the default implementation of the :read action
    defaults [:read]

    # and a create action for a request before submitting create action to Freigfhtware
    create :request do
      accept [
        :quote_number,
        :quote_obj,
        :quote_date,
        :account_reference,
        :shipper_reference,
        :service_type,
        :rate_type,
        :consignor_site,
        :consignor_name,
        :consignor_street,
        :consignor_suburb,
        :consignor_city,
        :consignor_postal_code,
        :consignee_site,
        :consignee_name,
        :consignee_street,
        :consignee_suburb,
        :consignee_city,
        :consignee_postal_code
      ]
    end

    create :quick_quote do
      accept [
        :quote_number,
        :quote_obj,
        :quote_date,
        :account_reference,
        :shipper_reference,
        :service_type,
        :rate_type,
        :consignor_site,
        :consignor_name,
        :consignor_street,
        :consignor_suburb,
        :consignor_city,
        :consignor_postal_code,
        :consignee_site,
        :consignee_name,
        :consignee_street,
        :consignee_suburb,
        :consignee_city,
        :consignee_postal_code
      ]
    end

    create :create_quote do
      accept [
        :quote_number,
        :quote_obj,
        :quote_date,
        :account_reference,
        :shipper_reference,
        :service_type,
        :rate_type,
        :consignor_site,
        :consignor_name,
        :consignor_street,
        :consignor_suburb,
        :consignor_city,
        :consignor_postal_code,
        :consignee_site,
        :consignee_name,
        :consignee_street,
        :consignee_suburb,
        :consignee_city,
        :consignee_postal_code
      ]
    end
  end

  attributes do
    uuid_primary_key :id
    # System-generated, primary key
    attribute :quote_number, :string, allow_nil?: false
    # Required on update, system-generated on create
    attribute :quote_obj, :decimal, allow_nil?: true
    # System-generated
    attribute :quote_date, :date, allow_nil?: true
    # Derived from user security if not supplied
    attribute :account_reference, :string, allow_nil?: true
    # Required if set for account
    attribute :shipper_reference, :string, allow_nil?: true
    # System default if not supplied
    attribute :service_type, :string, allow_nil?: true
    # For display, retrieve only
    attribute :service_type_description, :string, allow_nil?: true
    # Optional
    attribute :consignment_type, :string, allow_nil?: true
    # Populated on query
    attribute :consignment_type_desc, :string, allow_nil?: true
    # Retrieve only
    attribute :status_code, :string, allow_nil?: true
    # Retrieve only
    attribute :status_description, :string, allow_nil?: true
    attribute :collection_instructions, :string, allow_nil?: true
    attribute :delivery_instructions, :string, allow_nil?: true
    # Historical only
    attribute :estimated_kilometres, :integer, allow_nil?: true
    # Use case dependent
    attribute :billable_units, :integer, allow_nil?: true
    # Derived from account
    attribute :rate_type, :string, allow_nil?: true
    # Retrieve only
    attribute :rate_type_description, :string, allow_nil?: true
    # Calculated on save
    attribute :total_quantity, :integer, allow_nil?: true
    # Calculated on save
    attribute :total_weight, :decimal, allow_nil?: true
    attribute :consignor_site, :string, allow_nil?: true
    attribute :consignor_name, :string, allow_nil?: false
    attribute :consignor_building, :string, allow_nil?: false
    attribute :consignor_street, :string, allow_nil?: false
    attribute :consignor_suburb, :string, allow_nil?: false
    attribute :consignor_city, :string, allow_nil?: false
    attribute :consignor_postal_code, :string, allow_nil?: false
    attribute :consignor_contact_name, :string, allow_nil?: false
    attribute :consignor_contact_tel, :string, allow_nil?: false
    attribute :consignee_site, :string, allow_nil?: true
    attribute :consignee_name, :string, allow_nil?: false
    attribute :consignee_building, :string, allow_nil?: false
    attribute :consignee_street, :string, allow_nil?: false
    attribute :consignee_suburb, :string, allow_nil?: false
    attribute :consignee_city, :string, allow_nil?: false
    attribute :consignee_postal_code, :string, allow_nil?: false
    attribute :consignee_contact_name, :string, allow_nil?: false
    attribute :consignee_contact_tel, :string, allow_nil?: false
    # Information only
    attribute :waybill_number, :string, allow_nil?: true
    # Information only
    attribute :collection_reference, :string, allow_nil?: true
    # Defaults to logged-in user if blank
    attribute :accepted_by, :string, allow_nil?: true
    # Required if rejecting
    attribute :reject_reason, :string, allow_nil?: true
    attribute :order_number, :string, allow_nil?: true
    # Used for invoice charge percentage
    attribute :value_declared, :decimal, allow_nil?: true
    # Retrieve only, calculated on save
    attribute :charged_amount, :decimal, allow_nil?: true
    # Retrieve only
    attribute :cash_account_type, :string, allow_nil?: true
    # Default sender, not user-updateable
    attribute :paying_party, :string, allow_nil?: true
    # Required if mandatory
    attribute :vehicle_category, :string, allow_nil?: true

    attribute :item, Item, public?: true
    attribute :sundry, Sundry, public?: true
  end
end
