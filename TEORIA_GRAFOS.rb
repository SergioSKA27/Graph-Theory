require 'ruby2d'

#:) it's fine 
set title: 'TEORIA DE GRAFOS'
set resizable: true 
set width: 1920
set height: 1080 

#set background: '#99B899'
set background: 'white'

set diagnostics: true
def make_Squre(_x,_y,_z,_size, _color)
    Square.new(
        x: _x, y: _y,
        size: _size,
        color: _color.to_s,
        z: _z)
end


def make_Circle(_x,_y,_z,_radius, _sectors,_color)
    Circle.new(
        x: _x, y: _y,
        radius: _radius,
        sectors: _sectors,
        color: _color.to_s,
        z: _z )
end


def make_Triangle(_x1,_y1,_x2,_y2,_x3,_y3,_z,_color)
    Triangle.new(
        x1: _x1,  y1: _y1,
        x2: _x2, y2: _y2,
        x3: _x3,   y3: _y3,
        color: _color.to_s,
        z: _z
    )
end

def make_Quad(_x1,_y1,_x2,_y2,_x3,_y3,_x4,_y4,_z,_color)
    Quad.new(
        x1: _x1, y1: _y1,
        x2: _x2, y2: _y2,
        x3: _x3, y3: _y3,
        x4: _x4, y4: _y4,
        color: _color.to_s,
        z: _z)
end


class Vertex
    attr_accessor :vertex_name, :vertex_pos #vertex_pos = [x,y]
    attr_accessor :vertex_color, :vertex_shape #vertex shape can be any kind of shape
    attr_accessor :vshape, :nameshape


    #We initialize the object passing the vertex name as a string, the vertex position
    #is passed as an array where the first position is the x cordinate and the second is
    #the y cordinate, then we select the kind of shape we want to use(this shapes need 
    #to be included in the ruby2d libary, or select an specific image to representate the
    #vertex), finaly we select the color of the selected shape(the color need to be included
    #in ruby2d or use a color in hex expression '#fffff').



    def initialize(vname, vertexpos, kshape, color, size)
        self.vertex_name = vname.to_s
        self.vertex_pos = vertexpos
        self.vertex_shape = kshape.to_s
        self.vertex_color = color.to_s


        

        case kshape.downcase
        when 'triangle' then
            #in progress :)
            @vshape = Triangle.new(
                x1: vertexpos[0],  y1: vertexpos[1]-((vertexpos[1]/2).to_i),
                x2: vertexpos[0]+ ((vertexpos[0]/2).to_i),  y2: vertexpos[1]+((vertexpos[1]/2).to_i),
                x3: vertexpos[1]- ((vertexpos[0]/2).to_i),  y3: vertexpos[1]+((vertexpos[1]/2).to_i),
                color: self.vertex_color, z: 10)
            
        when 'circle' then
            @vshape = Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 32,
                color: color.to_s,z: 10)
        when 'square' then
            @vshape= Square.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                size: size.to_i, color: color.to_s,z: 10)
        when 'rectangle' then
            @vshape = Rectangle.new(
                x: vertexpos[0].to_i, y:vertexpos[1].to_i,
                width: (size*2).to_i, height: size.to_i,
                color: color.to_s,z: 10)
        when 'quad' then
            nil
        else
            #Selecciona  una imagen
        end
    end
end


#this class help us to create a vertex or edit any of this 
#and at the same way this can help us to conect any pair of 
#vertex this create an edge with an specific identifier and 
#we can edit this edges at the same form


class Editor
    attr_accessor :shape1, :shape2,:shape3, :shape4

    attr_accessor :shape5, :shape6,:shape7, :shape8

    attr_accessor :shape9 , :shape10,:shape11

    attr_accessor :shapeTs, :shapeT,:shapeSs, :shapeS
    
    attr_accessor :shapeCs, :shapeC,:shapePs, :shapeP, :shapeHs, :shapeH
    
    attr_accessor :text1, :text2, :text3, :text_box1

    attr_accessor :vertex_button , :edge_button, :name_box1

    def initialize
        #edge and vertex buttons variables are used to specify if the button y selected
        @vertex_button = false
        @edge_button = false
        @name_box1 = false


        #shapes 1 and 2 are the first square 
        @shape1 = Square.new(
            x: 1300, y: 10,
            size: 580,
            color: '#2A363B', z: 10 )

        @shape2 = Square.new(
            x: 1300, y: 10,
            size: 550,
            color: '#FF847C',z: 11)
        #shapes 3 and 4 are the square that contains the visualitation of the vertex or the edge
        @shape3 = Square.new(
            x: 1310, y: 15,
            size: 250,
            color: 'white',z: 14)

        @shape4 = Square.new(
            x: 1310, y: 15,
            size: 270,
            color: '#2A363B',z: 12)

        #button to create a vertex 
        @shape5 = Quad.new(
            x1: 1590, y1: 15,
            x2: 1690, y2: 15,
            x3: 1690, y3: 60,
            x4: 1590, y4: 60,
            color: '#99B899',
            z: 20)
        
        @shape6 = Quad.new(
            x1: 1590, y1: 15,
            x2: 1700, y2: 15,
            x3: 1700, y3: 65,
            x4: 1590, y4: 65,
            color: '#2A363B',
            z: 19)

        @text1 = Text.new(
            'Vertice',
            x: 1600, y: 25,
            style: 'bold',
            size: 20,
            color: 'black',
            z: 100)

        #button to create a line
        @shape7 = Quad.new(
            x1: 1720, y1: 15,
            x2: 1820, y2: 15,
            x3: 1820, y3: 60,
            x4: 1720, y4: 60,
            color: '#99B899',
            z: 20)
        
        @shape8 = Quad.new(
            x1: 1720, y1: 15,
            x2: 1830, y2: 15,
            x3: 1830, y3: 65,
            x4: 1720, y4: 65,
            color: '#2A363B',
            z: 19)

        @text2 = Text.new(
            'Arista',
            x: 1730, y: 25,
            style: 'bold',
            size: 20,
            color: 'black',
            z: 100)

        #shape for name of the vertex 
        @shape9 = Quad.new(
            x1: 1590, y1: 90,
            x2: 1830, y2: 90,
            x3: 1830, y3: 130,
            x4: 1590, y4: 130,
            color: 'white',
            z: 19)
        
        @shape10 = Quad.new(
            x1: 1590, y1: 90,
            x2: 1840, y2: 90,
            x3: 1840, y3: 140,
            x4: 1590, y4: 140,
            color: '#2A363B',
            z: 18)
        
        @shape11 = Quad.new(
            x1: 1600, y1: 75,
            x2: 1700, y2: 75,
            x3: 1710, y3: 90,
            x4: 1590, y4: 90,
            color: '#45ADA8',
            z: 19)
        @text3 = Text.new(
            'Nombre',
            x: 1610, y: 75,
            style: 'bold',
            size: 13,
            color: 'black',
            z: 100)
        #shpaes to select wich we want to use to represent the vertex 
        #squre
        @shapeSs = make_Squre(1600,150,100, 35, '#355C7D')
        @shapeS = make_Squre(1610, 160,101, 15, 'white')
        #circle
        @shapeCs = make_Squre(1640,150,100, 35, '#355C7D')
        @shapeC = make_Circle(1657, 165,101, 12,32, 'white')
        #triangle
        @shapeTs = make_Squre(1680,150,100, 35, '#355C7D')
        @shapeT = make_Circle(1696, 165,101, 12,3, 'white')
        #pentagon
        @shapeTs = make_Squre(1720,150,100, 35, '#355C7D')
        @shapeT = make_Circle(1736, 165,101, 12,5, 'white')
        #hexagon 
        @shapeTs = make_Squre(1760,150,100, 35, '#355C7D')
        @shapeT = make_Circle(1776, 165,101, 12,6, 'white')
        
        @text_box1 = Text.new(
            '',
            x: 1600, y: 90,
            font: 'Amatic-Bold.ttf',
            style: 'bold',
            size: 35,
            color: 'black',
            z: 100)
    end


    def is_in_button_vertex(x,y)
        if self.shape5.contains? x,y then
            true
        else 
            false
        end
    end

    def is_in_button_edge(x,y)
        if self.shape7.contains? x,y then
            true
        else 
            false
        end
    end

    def is_in_textbox1(x,y)
        if self.shape9.contains? x,y then
            true 
        else
            false
        end
    end

    def press_button_vertex
        @shape6.opacity = 0
        @shape5.color = '#7CF7FF'
        @vertex_button = true
        if @edge_button == true then
            @edge_button = false
            @shape8.opacity = 1.0
            @shape7.color = '#99B899'
        end

    end 

    def unpress_button_vertex
        @shape6.opacity = 1.0
        @shape5.color = '#99B899'
        @vertex_button = false
    end

    def press_button_edge
        @shape8.opacity  = 0
        @shape7.color = '#7CF7FF'
        @edge_button = true
        if @vertex_button == true then
            @vertex_button =  false
            @shape6.opacity = 1.0
            @shape5.color = '#99B899'
        end
    end 

    def unpress_button_edge
        @shape8.opacity = 1.0
        @shape7.color = '#99B899'
        @edge_button = false 
    end

    def vertex_name_selected
        @name_box1 = true
    end

end



#a = Vertex.new('1',[50,50],'circle', 'black', 50)
edit = Editor.new

po = Square.new(
    x: 1300, y: 10,
    size: 1,
    color: 'red',
    z: 100
)



on :mouse do |event|
    case event.button
    when :left#right button  is used to select any object on the screan
        if edit.is_in_button_vertex(event.x, event.y) then 
            edit.press_button_vertex
        end

        if edit.is_in_button_edge(event.x, event.y) then 
            edit.press_button_edge
        end

        if edit.is_in_textbox1(event.x,event.y) then 
            edit.vertex_name_selected
        end
    when :middle
    # Middle mouse button pressed down
    when :right
    
        system("explorer #{"/home/sergioska8/"}")
    end
end


on :key_down do |event|
    if event.key != 'backspace' 
        x = event.key 
        edit.text_box1.text += x.to_s
    elsif event.key == 'backspace'
        edit.text_box1.text = edit.text_box1.text.chop
    elsif event.key == 'SPACE' or event.key == ' '
        edit.text_box1.text += '_'
    end
end


show