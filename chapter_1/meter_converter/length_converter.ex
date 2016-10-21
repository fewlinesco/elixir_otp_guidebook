defmodule MeterToLengthConverter do
  def convert(:feet, m) when is_number(m) and m >= 0, do: m * 3.28084
  def convert(:inch, m) when is_number(m) and m >= 0, do: m * 39.3701
  def convert(:yard, m) when is_number(m) and m >= 0, do: m * 1.09361
end
