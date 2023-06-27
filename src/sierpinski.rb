require 'ruby2d'
require './lib/point.rb'
require './lib/triangle.rb'

set title: "Sierpinski Triangle Demo", width: 1200, height: 1200

triangles = [TriangleContainer.new(Point.new(50, 1150), 1100)]
rendering = []
tick = 0
iterations = 0

update do
  if tick % 60 == 0
    iterations += 1
    #unrender last batch of triangles + build child triangles
    rendering.each do |shape|
      shape.unrender_self
      triangles += shape.build_children
    end
    #remove references to last batch of triangles
    until rendering.length == 0
      rendering.pop
    end
    #add all child triangles to the render queue
    until triangles.length == 0
      rendering << triangles.pop
      rendering[-1].render_self
    end
  end
  #adjust as necessary, but it gets remarkably slow past 10 iterations when there are 3^9 triangles being rendered
  close if iterations == 10
  tick += 1
end

show
