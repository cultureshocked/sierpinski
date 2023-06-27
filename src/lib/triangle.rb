require_relative './point.rb'
require 'ruby2d'

class TriangleContainer
  attr_reader :render
  def initialize(left_corner, side_length)
    @side_length = side_length
    @left = left_corner
    @right = Point.new left_corner.x + side_length, left_corner.y
    @top = Point.new (@left.x + side_length / 2), @left.y - get_height(side_length)
  end

  def get_coords
    [@top, @right, @left]
  end

  def build_children
    midpoints = get_midpoints
    [
      TriangleContainer.new(@left, @side_length / 2),
      TriangleContainer.new(midpoints[1], @side_length / 2),
      TriangleContainer.new(midpoints[2], @side_length / 2)
    ]
  end

  def render_self
    @render = Triangle.new(
        x1: @top.x, y1: @top.y,
        x2: @right.x, y2: @right.y,
        x3: @left.x, y3: @left.y,
        color: ['red','green','blue']
    )
  end

  def unrender_self
    @render.remove
    @render = nil
  end

  private

  def get_midpoints
    [
      Point.new((@top.x + (@right.x - @top.x) / 2), (@top.y + (@right.y - @top.y) / 2)), #top/right
      Point.new((@left.x + (@right.x - @left.x) / 2), (@left.y + (@right.y - @left.y) / 2)), #right/left
      Point.new((@left.x + (@top.x - @left.x) / 2), (@left.y + (@top.y - @left.y) / 2)) #left/top
    ]
  end

  def get_height(side_length)
    (side_length * Math.sqrt(3)) / 2
  end
end
