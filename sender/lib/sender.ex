defmodule Sender do
  @moduledoc """
  Documentation for `Sender`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sender.hello()
      :world

  """
  def hello do
    :world
  end

  # def send_email("konnichiwa@world.com" = email) do
  #   # raise "OOps, couldn't send email to #{email}!"
  #   {:error, "OOps, couldn't send email to #{email}!"}
  # end
  def send_email("konnichiwa@world.com" = _email), do: :error

  def send_email(email) do
    # Send email
    Process.sleep(3000)
    IO.puts("Email sto #{email} sent")
    {:ok, "email_sent"}
  end

  def notify_all(emails) do
    # emails
    # |> Enum.map( fn email ->
    #   Task.async(fn ->
    #     send_email(email)
    #   end)
    # end)
    # |> Enum.map(&Task.await/1)

    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1)
    |> Enum.to_list()
  end
end
