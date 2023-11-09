defmodule TextToBinaryWeb.ConversionController do
  use TextToBinaryWeb, :controller

  alias TextToBinary.Conversions
  alias TextToBinary.Conversions.Conversion

  def index(conn, _params) do
    conversions = Conversions.list_conversions()
    render(conn, :index, conversions: conversions)
  end

  # def new(conn, _params) do
  #   changeset = Conversions.change_conversion(%Conversion{})
  #   render(conn, :new, changeset: changeset)
  # end

  def new(conn, _params) do
    changeset = Conversions.change_conversion(%Conversion{})
    render(conn, :new, changeset: changeset, conversion: nil)
  end

  def create(conn, %{"conversion" => conversion_params}) do
    input_text = conversion_params["input_text"]
    output_binary = TextToBinary.Conversions.Conversion.text_to_utf8_binary(input_text)

    # Combine the original conversion_params with the new output_binary
    conversion_params_with_binary = Map.put(conversion_params, "output_binary", output_binary)

    # Create the conversion using the new parameters (this may differ based on your existing code)
    case Conversions.create_conversion(conversion_params_with_binary) do
      # {:ok, _conversion} ->
      #   conn
      #   |> put_flash(:info, "Conversion created successfully.")
      #   |> redirect(to: "/conversions")

      # {:ok, conversion} ->
      #     conn
      #     |> put_flash(:info, "Conversion created successfully.")
      #     |> render("new.html", changeset: conversion)

      {:ok, conversion} ->
        changeset = Conversions.change_conversion(conversion)
        conn
        |> put_flash(:info, "Conversion created successfully.")
        |> render("new.html", changeset: changeset, conversion: conversion)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    conversion = Conversions.get_conversion!(id)
    render(conn, :show, conversion: conversion)
  end

  def edit(conn, %{"id" => id}) do
    conversion = Conversions.get_conversion!(id)
    changeset = Conversions.change_conversion(conversion)
    render(conn, :edit, conversion: conversion, changeset: changeset)
  end

  def update(conn, %{"id" => id, "conversion" => conversion_params}) do
    conversion = Conversions.get_conversion!(id)

    case Conversions.update_conversion(conversion, conversion_params) do
      {:ok, conversion} ->
        conn
        |> put_flash(:info, "Conversion updated successfully.")
        |> redirect(to: ~p"/conversions/#{conversion}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, conversion: conversion, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    conversion = Conversions.get_conversion!(id)
    {:ok, _conversion} = Conversions.delete_conversion(conversion)

    conn
    |> put_flash(:info, "Conversion deleted successfully.")
    |> redirect(to: ~p"/conversions")
  end
end
