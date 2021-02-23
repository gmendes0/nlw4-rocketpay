defmodule Rocktpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when given a valid file name, it should return a number" do
      result = Numbers.sum_from_file("numbers")
      expected_result = {:ok, %{result: 37}}

      assert result === expected_result
    end

    test "when given an invalid file name, it should return an error" do
      result = Numbers.sum_from_file("invalid")
      expected_result = {:error, %{message: "invalid file"}}

      assert result === expected_result
    end
  end
end
