defmodule Quotechain.Accounts do
  use Ash.Domain, otp_app: :quotechain, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Quotechain.Accounts.Token
    resource Quotechain.Accounts.User
  end
end
