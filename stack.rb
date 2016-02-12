require 'pry'

class Stack
  attr_reader :backing_array

  def initialize(array = [1, 2, 3])
    @backing_array = array
  end

  def size
    @backing_array.size
  end

  # the jerk "Ruby already does this answer":
  # @backing_array.push(input)
  def push(input)
    raise ArgumentError if input.nil?
    new_arr = [input]
    @backing_array.each { |element| new_arr << element }
    @backing_array = new_arr
    self
  end

  def peek
    raise StandardError if @backing_array.empty?
    @backing_array[0]
  end

  # the jerk "Ruby already does this answer":
  # @backing_array.pop
  def pop
    raise StandardError if @backing_array.empty?
    popped = @backing_array[0]
    new_arr = []
    @backing_array.each_with_index do |element, index|
      next if index == 0
      new_arr << element
    end
    @backing_array = new_arr
    popped
  end

  def has_value?(input)
    raise ArgumentError if input.nil?
    # This is Ruby enumerable magic
    # detect returns either the first element to match the condition,
    # or nil if not found
    @backing_array.detect { |e| e == input }.nil? ? false : true
  end
end
