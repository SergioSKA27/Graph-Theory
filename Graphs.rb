require 'ruby2d'

set title: 'Graph Theory'
set background: 'white'
set resizable: true
set width: 1280, height: 720


COLORS = ['navy', 'blue','aqua', 'teal', 'olive','green','lime',
        'yellow', 'orange','red', 'brown','fuchsia', 'purple', 'maroon',
        'white', 'silver','gray','black']


# Nodo para graficas no dirigidas 
class Node_S
    attr_accessor :id, :degree, :color # atributos del nodo
    attr_accessor :adjacent # hash con los id de los nodos adyacentes
    attr_accessor :x_pos , :y_pos, :node_fig, :size, :text_shape

    def initialize(hash) # permite definir arbitriamente los atributos 

        if hash.has_key?(:id) then # revisamos si la clave existe
            self.id = hash[:id] 
        else 
            self.id = nil # si la clave no existe asignamos nil como valor 
        end

        if hash.has_key?(:color) then
            raise 'Invalid Id' unless hash[:color].respond_to?('to_s') 
            self.color = hash[:color] 
        else 
            self.color = 'random' # si la clave no existe asignamos un color al azar
        end

        if hash.has_key?(:adjacent) then # de igual forma podemos pasar los vertices adyacentes 
            self.adjacent = hash[:adjacent]
            #  Debemos pasar un hash con las claves siendo los id de vertice y el id de la linea que los une
            # adjacent = {id_1 => line1,..., id_N => lineN}
        else 
            self.adjacent = Hash.new
        end

        if hash.has_key?(:x_pos) then # revisamos si la clave existe
            self.x_pos = hash[:x_pos] 
        else 
            self.x_pos = rand(1200) + 80 # asignamos una posicion aleatoria 
        end


        if hash.has_key?(:y_pos) then # revisamos si la clave existe
            self.y_pos = hash[:y_pos] 
        else 
            self.y_pos = rand(700) + 20 # asignamos una posicion aleatoria 
        end

        if hash.has_key?(:size) then # revisamos si la clave existe
            self.size = hash[:size] 
        else 
            self.size = 5 
        end

        self.node_fig = Circle.new(
            x: self.x_pos, y: self.y_pos,
            color: self.color, radius: self.size,
            sectors: 300, z: 10 
        )

        self.text_shape = Text.new(
            self.id , x: self.node_fig.x-5, y: self.node_fig.y-5,
            size: (self.size/2).to_i, z: 20
        )


    end

    def x 
        self.node_fig.x
    end

    def y 
        self.node_fig.y
    end
end


# Linea no dirigida 
class LineN 
    attr_accessor :id, :color , :terminal_vertex, :width
    attr_accessor :line_shape
    def initialize(hash)

        if hash.has_key?(:id) then # revisamos si la clave existe
            self.id = hash[:id] 
        else 
            self.id = nil  
        end

        if hash.has_key?(:color) then # revisamos si la clave existe
            self.color = hash[:color] 
        else 
            self.color = 'random'  
        end

        if hash.has_key?(:terminal_vertex) then # revisamos si la clave existe
            #los vertices deben pasarse como el objeto Node , dentro de un hash con las claves 1 y 2(int) y los nodos respectivos 
            raise 'two terminal vertices are needed' if hash[:terminal_vertex].length != 2 or hash[:terminal_vertex] == nil
            self.terminal_vertex = hash[:terminal_vertex]
        else 
            raise 'two terminal vertices are needed' 
            self.terminal_vertex = Hash.new  
        end

        if hash.has_key?(:width) then # revisamos si la clave existe
            self.width = hash[:width] 
        else 
            self.width = 1  
        end

        self.line_shape = Line.new(
            x1: self.terminal_vertex[1].x, y1: self.terminal_vertex[1].y,
            x2:self.terminal_vertex[2].x, y2: self.terminal_vertex[2].y, 
            color: self.color, width: self.width, z: 1
        )

    end
    
end


# Nodo para graficas dirigidas 
class Node_D
    attr_accessor :id, :degree_i, :degree_e, :color
    attr_accessor :adjacent_i, :adjacent_e # hash con los id de los nodos adyacentes
    attr_accessor :x_pos , :y_pos, :node_fig, :size, :text_shape

    def initialize(hash)

        if hash.has_key?(:id) then # revisamos si la clave existe
            self.id = hash[:id] 
        else 
            self.id = nil # si la clave no existe asignamos nil como valor 
        end
        if hash.has_key?(:color) then # revisamos si la clave existe
            self.color = hash[:color] 
        else 
            self.color = 'random' # si la clave no existe asignamos nil como valor 
        end
        if hash.has_key?(:adjacent_i) then # revisamos si la clave existe
            self.adjacent_i = hash[:adjacent_i] 
        else 
            self.adjacent_i = Hash.new 
        end

        if hash.has_key?(:adjacent_e) then # revisamos si la clave existe
            self.adjacent_e = hash[:adjacent_e] 
        else 
            self.adjacent_e = Hash.new 
        end

        if hash.has_key?(:x_pos) then # revisamos si la clave existe
            self.x_pos = hash[:x_pos] 
        else 
            self.x_pos = rand(1200) + 80 # asignamos una posicion aleatoria 
        end


        if hash.has_key?(:y_pos) then # revisamos si la clave existe
            self.y_pos = hash[:y_pos] 
        else 
            self.y_pos = rand(700) + 20 # asignamos una posicion aleatoria 
        end
        
        if hash.has_key?(:size) then # revisamos si la clave existe
            self.size = hash[:size] 
        else 
            self.size = 5 
        end

        self.node_fig = Circle.new(
            x: self.x_pos, y: self.y_pos,
            color: self.color, radius: self.size,
            sectors: 300, z: 10 
        )

        self.text_shape = Text.new(
            self.id , x: self.node_fig.x-5, y: self.node_fig.y-5,
            size: (self.size/2).to_i, z: 20

        )

    end



    def x 
        self.node_fig.x
    end

    def y 
        self.node_fig.y
    end

end


# Linea dirigida

class LineD
    attr_accessor :id,:color , :input_vertex,:output_vertex, :width 
    attr_accessor :line_shape, :arrow1,:arrow2

    def initialize(hash)
        if hash.has_key?(:id) then # revisamos si la clave existe
            self.id = hash[:id] 
        else 
            self.id = nil  
        end

        if hash.has_key?(:color) then # revisamos si la clave existe
            self.color = hash[:color] 
        else 
            self.color = 'random'  
        end

        if hash.has_key?(:width) then # revisamos si la clave existe
            self.width = hash[:width] 
        else 
            self.width = 1  
        end

        if hash.has_key?(:input_vertex) then # revisamos si la clave existe
            self.input_vertex = hash[:input_vertex] #vertice de donde llega la arista
        else 
            raise 'No input vertex!'  
        end

        if hash.has_key?(:output_vertex) then # revisamos si la clave existe
            self.output_vertex = hash[:output_vertex]  #vertice de donde sale la arista
        else 
            raise 'No output vertex!'  
        end

        self.line_shape = Line.new(
            x1: self.input_vertex.x+(self.input_vertex.node_fig.radius).to_i+3, y1: self.input_vertex.y,
            x2:self.output_vertex.x, y2: self.output_vertex.y, 
            color: self.color, width: self.width, z: 1
        )
        #self.arrow1 = Circle.new(
        #    x:self.line_shape.x1,y: self.line_shape.y1, 
        #    sectors: 3,radius: 10,z:100,color: self.color
        #)

        
    end
end


#Clase para imprimir la informacion de cada vertice en la grafica 
class NodesInfo
    attr_accessor :x_pos, :y_pos, :node,:info_size
    attr_accessor :shape1, :shape2, :nodeid ,:nodetype
    attr_accessor :adjacent

    def initialize(hash)
        if hash.has_key?(:x_pos) then # revisamos si la clave existe
            self.x_pos = hash[:x_pos] 
        else 
            self.x_pos = 10 
        end

        if hash.has_key?(:y_pos) then # revisamos si la clave existe
            self.y_pos = hash[:y_pos] 
        else 
            self.y_pos = 25 
        end

        if hash.has_key?(:node) then # revisamos si la clave existe
            self.node = hash[:node] 
        else 
            raise 'No target node!'
        end

        if hash.has_key?(:info_size) then # revisamos si la clave existe
            self.info_size = hash[:info_size] 
        else 
            self.info_size = 80
        end
        
        self.shape1 = Square.new(
            x: self.x_pos, y: self.y_pos,
            size: self.info_size, color: 'black',
            z: 100
        )
        self.shape2 = Square.new(
            x: self.x_pos+5, y: self.y_pos+5,
            size: self.info_size-10, color: 'white',
            z: 101
        )
        self.nodeid = Text.new(
            'Vertex ID: '+(self.node.id).to_s, x: self.x_pos+7,
            y: self.y_pos+5 , color: 'black', size: 10, z:102
        )
        
    end
end



n = Node_D.new(id: 'hi' , x_pos: 100 , y_pos: 55, size: 20, color: 'blue')
n1 = Node_D.new(id: 'hi' , x_pos: 300 , y_pos: 100, size: 20)

#ns = LineN.new(id: 'di', terminal_vertex: {1 => n, 2 => n1 })

nk = LineD.new(id: 'in', input_vertex: n, output_vertex: n1,)

inf = NodesInfo.new(node: n1,x_pos: 300, y_pos: 400, info_size: 100)
show
