defmodule TextToBinaryWeb.ConversionControllerTest do
  use TextToBinaryWeb.ConnCase

  import TextToBinary.ConversionsFixtures

  @create_attrs %{input_text: "some input_text", output_binary: "some output_binary"}
  @update_attrs %{input_text: "some updated input_text", output_binary: "some updated output_binary"}
  @invalid_attrs %{input_text: nil, output_binary: nil}

  describe "index" do
    test "lists all conversions", %{conn: conn} do
      conn = get(conn, ~p"/conversions")
      assert html_response(conn, 200) =~ "Listing Conversions"
    end
  end

  describe "new conversion" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/conversions/new")
      assert html_response(conn, 200) =~ "New Conversion"
    end
  end

  describe "create conversion" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/conversions", conversion: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/conversions/#{id}"

      conn = get(conn, ~p"/conversions/#{id}")
      assert html_response(conn, 200) =~ "Conversion #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/conversions", conversion: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Conversion"
    end
  end

  describe "edit conversion" do
    setup [:create_conversion]

    test "renders form for editing chosen conversion", %{conn: conn, conversion: conversion} do
      conn = get(conn, ~p"/conversions/#{conversion}/edit")
      assert html_response(conn, 200) =~ "Edit Conversion"
    end
  end

  describe "update conversion" do
    setup [:create_conversion]

    test "redirects when data is valid", %{conn: conn, conversion: conversion} do
      conn = put(conn, ~p"/conversions/#{conversion}", conversion: @update_attrs)
      assert redirected_to(conn) == ~p"/conversions/#{conversion}"

      conn = get(conn, ~p"/conversions/#{conversion}")
      assert html_response(conn, 200) =~ "some updated input_text"
    end

    test "renders errors when data is invalid", %{conn: conn, conversion: conversion} do
      conn = put(conn, ~p"/conversions/#{conversion}", conversion: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Conversion"
    end
  end

  describe "delete conversion" do
    setup [:create_conversion]

    test "deletes chosen conversion", %{conn: conn, conversion: conversion} do
      conn = delete(conn, ~p"/conversions/#{conversion}")
      assert redirected_to(conn) == ~p"/conversions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/conversions/#{conversion}")
      end
    end
  end

  defp create_conversion(_) do
    conversion = conversion_fixture()
    %{conversion: conversion}
  end
end
