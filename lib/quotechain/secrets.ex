defmodule Quotechain.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        Quotechain.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:quotechain, :token_signing_secret)
  end
end
