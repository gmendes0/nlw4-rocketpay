defmodule Rocketpay.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:receiver, :sender]

  def build(%Account{} = sender, %Account{} = receiver) do
    %__MODULE__{
      receiver: receiver,
      sender: sender
    }
  end
end
