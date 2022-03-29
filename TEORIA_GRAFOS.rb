require 'ruby2d'
#Created by: Sergio Lopez
#This program was make to represent topics of graph theory
#I used the Ruby2d gem 'https://www.ruby2d.com/'
#:) it's fine 
set title: 'TEORIA DE GRAFOS'
set resizable: true 
set width: 1900
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
    attr_accessor :vshape, :nameshape, :vselected
    #this help us to save diferent information about the current vertex 
    attr_accessor :degree , :adj_vertex, :edges_s #edges_S are the edges for simple 


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

        self.degree = 0 #this is the degre of a vertex in a non directed graph 
        self.adj_vertex = nil #this is a map of adjacent vertex 
        self.edges_s =  nil #this is a map of edges of non directed graphs 
        

        case kshape.downcase
        when 'triangle' then
            #in progress :)
            @vshape =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 3,
                color: color.to_s,z: 10)
            
        when 'circle' then
            @vshape = Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 32,
                color: color.to_s,z: 10)
            
        when 'square' then
            @vshape= Square.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                size: size.to_i, color: color.to_s,z: 10)
        when 'pentagon' then
            @vshape =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 5,
                color: color.to_s,z: 10)
            
        when 'hexagon' then
            @vshape =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 5,
                color: color.to_s,z: 10)
        else
            #Selecciona  una imagen
        end
        @nameshape = Text.new(
            self.vertex_name.to_s,
            x: vertex_pos[0], y: vertex_pos[1],
            font: 'Amatic-Bold.ttf',
            size: 35,
            color: 'black',
            z: 1001)
    end
end
#This class help us to create an edge to connect a pair of vertex
#This edge need a name to diferentiate from other edges, and the 
#two vertex you are connecting, this edge is non directed
class Edge_ND
    attr_accessor :name, :terminalV1, :terminalV2
    attr_accessor :shape
    def initialize(_terminalV1, _terminalV2, _name, color, width)
        @name = _name.to_s
        @terminalV1 = _terminalV1
        @terminalV2 = _terminalV2
        @shape = Line.new(
            x1: self.terminalV1.vertexpos[0], y1: self.terminalV1.vertexpos[1],
            x2: self.terminalV2.vertexpos[0], y2: self.terminalV2.vertexpos[1],
            width: width,
            color: color.to_s,
            z: 9
          )      
    end
end


#this class is for handle non directed graphs :)
class Graph_ND
    attr_accessor :vertex, :edges
    attr_accessor :selected_key
    def initialize
        @vertex = Hash.new
        @edges = Hash.new
        @selected_key = nil
    end

    def add_vertex(name, fig, color)
        if vertex.include?(name) then 
            return nil 
        end
        x = rand(1280)+10
        y = rand(1050)+20
        v = Vertex.new(name,[x,y],fig,color, 50)
        vertex[name] = v
    end

    def vertex_Select(key)
        @selected_key = key
    end

    def vertex_Selected
        self.vertex[self.selected_key]
    end
end


#this class help us to create a vertex or edit any of this 
#and at the same way this can help us to conect any pair of 
#vertex this create an edge with an specific identifier and 
#we can edit this edges at the same form as the vertex :)


class Editor
    attr_accessor :shape1, :shape2,:shape3, :shape4

    attr_accessor :shape5, :shape6,:shape7, :shape8

    attr_accessor :shape9 , :shape10,:shape11

    attr_accessor :shapeTs, :shapeT,:shapeSs, :shapeS

    attr_accessor :shapeCs, :shapeC,:shapePs, :shapeP, :shapeHs, :shapeH

    attr_accessor :text1, :text2, :text3, :text_box1,:buttonC_text

    attr_accessor :vertex_button , :edge_button, :name_box1, :shapeofvertex

    attr_accessor :shapeIneditor, :textInshape, :colorShape, :button_create, :createshape

    attr_accessor :color_red, :color_navy, :color_blue, :color_aqua, :color_teal, :color_gray
    attr_accessor :color_olive, :color_green, :color_lime, :color_yellow, :color_orange
    attr_accessor :color_brown, :color_fuchsia, :color_purple, :color_maroon, :color_silver

    #this shapes are used in the edge editor
    attr_accessor :shapeE1,:shapeE2,:shapeE3,:shapeE4,:shapeE5,:shapeE6,:shapeE7
    attr_accessor :textE1, :textE2,:textE3,:textE4,:textE5 
    attr_accessor :typeEdge,:typeEdge_shape, :edge_boxE1, :edge_boxE2 ,:text_boxE1, :text_boxE2 
    attr_accessor :txt_boxE1,:txt_boxE2 
    #edge_boxE1 and E2 is for the name of the terminal vertex in a non direcred graph  
    #in a directed edge the edge_boxE1 is the vertex where does the edge come from and E2  
    # is where the edge come into the vertex. E1 -> E2
    

    def initialize
        #Variables to interact with the GUI 
        #edge and vertex buttons variables are used to specify if the button y selected
        @vertex_button = false
        @edge_button = false
        @name_box1 = false
        @txt_boxE1 = false 
        @txt_boxE2 = false 
        #1 is square , 2 is trinagle , 3 is circle, 4 is pentagon , 5 is hexagon, 0 is no shape selected  
        @shapeofvertex = 0
        @colorShape = 'random'
        @button_create = false

        #All of this shapes are just to represent the editor 
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
        @shapePs = make_Squre(1720,150,100, 35, '#355C7D')
        @shapeP = make_Circle(1736, 165,101, 12,5, 'white')
        #hexagon 
        @shapeHs = make_Squre(1760,150,100, 35, '#355C7D')
        @shapeH = make_Circle(1776, 165,101, 12,6, 'white')
        #text to name the vertex
        @text_box1 = Text.new(
            '',
            x: 1600, y: 90,
            font: 'Amatic-Bold.ttf',
            style: 'bold',
            size: 35,
            color: 'black',
            z: 100)
        
        #this shape is to represent the vertex on editor
        @shapeIneditor = nil
        @textInshape = Text.new(
            '',
            x: 1400, y: 130,
            font: 'Amatic-Bold.ttf',
            size: 35,
            color: 'black',
            z: 1001)

        #this shapes are for select colors 
        @color_aqua = make_Squre(1600,195,100, 20, 'aqua')
        @color_blue = make_Squre(1625,195,100, 20, 'blue')
        @color_brown = make_Squre(1650,195,100, 20, 'brown')
        @color_fuchsia = make_Squre(1675,195,100, 20, 'fuchsia')
        @color_gray = make_Squre(1700,195,100, 20, 'gray')
        @color_green = make_Squre(1725,195,100, 20, 'green')
        @color_lime = make_Squre(1750,195,100, 20, 'lime')
        @color_maroon = make_Squre(1775,195,100, 20, 'maroon')
        @color_navy = make_Squre(1800,195,100, 20, 'navy')

        @color_olive = make_Squre(1600,220,100, 20, 'olive')
        @color_orange = make_Squre(1625,220,100, 20, 'orange')
        @color_purple = make_Squre(1650,220,100, 20, 'purple')
        @color_red = make_Squre(1675,220,100, 20, 'red')
        @color_silver = make_Squre(1700,220,100, 20, 'silver')
        @color_teal = make_Squre(1725,220,100, 20, 'teal')
        @color_yellow = make_Squre(1750,220,100, 20, 'yellow')

        @createshape = Image.new(
            '17.png',
            x: 1590, y: 240,
            width: 150, height: 100,
            color: [1.0, 0.5, 0.2, 1.0],
            rotate: 0,
            z: 100)

        @buttonC_text = Text.new(
            'CREAR',
            x: 1635, y: 265,
            font: 'Amatic-Bold.ttf',
            size: 35,
            color: 'black',
            z: 1001, opacity: 0)



        self.hide_vertex_Editor
        #this part is for the edege editor

        @typeEdge = nil #this variable store the type of edge we want to use
        
         #button to create a directed edge
         @shapeE1 = Quad.new(
            x1: 1590, y1: 90,
            x2: 1690, y2: 90,
            x3: 1690, y3: 135,
            x4: 1590, y4: 135,
            color: '#56BBF1',
            z: 20)
        
        @shapeE2 = Quad.new(
            x1: 1590, y1: 90,
            x2: 1695, y2: 90,
            x3: 1695, y3: 140,
            x4: 1590, y4: 140,
            color: '#2A363B',
            z: 19)

        @textE1 = Text.new(
            'Dirigida',
            x: 1600, y: 105,
            style: 'bold',
            size: 20,
            color: 'black',
            z: 100)

        #button to create a non directed edge 
        @shapeE3 = Quad.new(
            x1: 1720, y1: 90,
            x2: 1820, y2: 90,
            x3: 1820, y3: 135,
            x4: 1720, y4: 135,
            color: '#56BBF1',
            z: 20)
        
        @shapeE4 = Quad.new(
            x1: 1720, y1: 90,
            x2: 1830, y2: 90,
            x3: 1830, y3: 140,
            x4: 1720, y4: 140,
            color: '#2A363B',
            z: 19)

        @textE2 = Text.new(
            'No dirigida',
            x: 1730, y: 105,
            style: 'bold',
            size: 15,
            color: 'black',
            z: 100)

        #text box E1 
        @edge_boxE1 =  Quad.new(
            x1: 1600, y1: 150,
            x2: 1685, y2: 150,
            x3: 1685, y3: 185,
            x4: 1600, y4: 185,
            color: 'white',
            z: 19)
        @text_boxE1 =  Text.new(
            'sfh',
            x: 1610, y: 155,
            font: 'Amatic-Bold.ttf',
            style: 'bold',
            size: 25,
            color: 'black',
            z: 100)
        #text box E1 
        @edge_boxE2 =  Quad.new(
            x1: 1730, y1: 150,
            x2: 1815, y2: 150,
            x3: 1815, y3: 185,
            x4: 1730, y4: 185,
            color: 'white',
            z: 19)   
        
        @text_boxE2 =  Text.new(
            'sfh',
            x: 1740, y: 155,
            font: 'Amatic-Bold.ttf',
            style: 'bold',
            size: 25,
            color: 'black',
            z: 100)
        
        @typeEdge_shape = nil
        
        self.hide_edge_editor
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

    def is_in_shapeSquare(x,y)
        if self.shapeSs.contains? x,y then 
            true
        else 
            false
        end
    end

    def is_in_shapeTriangle(x,y)
        if self.shapeTs.contains? x,y then 
            true
        else 
            false
        end
    end

    def is_in_shapeCircle(x,y)
        if self.shapeCs.contains? x,y then 
            true
        else 
            false
        end
    end

    def is_in_shapePentagon(x,y)
        if self.shapePs.contains? x,y then 
            true
        else 
            false
        end
    end

    def is_in_shapeHexagon(x,y)
        if self.shapeHs.contains? x,y then 
            true
        else 
            false
        end
    end

    def is_in_colors(x,y)
        if @color_aqua.contains? x,y
            @colorShape = 'aqua'
            true
        elsif @color_blue.contains? x,y
            @colorShape = 'blue'
            true
        elsif @color_brown.contains? x,y
            @colorShape = 'brown'
            true
        elsif @color_fuchsia.contains? x,y
            @colorShape = 'fuchsia'
            true
        elsif @color_gray.contains? x,y
            @colorShape = 'gray'
            true
        elsif @color_green.contains? x,y
            @colorShape = 'green'
            true
        elsif @color_lime.contains? x,y
            @colorShape = 'lime'
            true
        elsif @color_maroon.contains? x,y
            @colorShape ='maroon'
            true
        elsif @color_navy.contains? x,y
            @colorShape = 'navy'
            true
        elsif @color_olive.contains? x,y
            @colorShape = 'olive'
            true
        elsif @color_orange.contains? x,y
            @colorShape = 'orange'
            true
        elsif @color_purple.contains? x,y
            @colorShape = 'purple'
            true
        elsif @color_red.contains? x,y
            @colorShape = 'red'
            true
        elsif @color_silver.contains? x,y
            @colorShape = 'silver'
            true
        elsif @color_teal.contains? x,y
            @colorShape = 'teal'
            true
        elsif @color_yellow.contains? x,y
            @colorShape = 'yellow'
            true
        end
    end


    def is_in_buttonCreate(x,y)
        if @createshape.contains? x,y or @buttonC_text.contains? x,y then 
            true 
        else
            false 
        end
    end


    def is_in_buttonEdgeND(x,y)
    #this help us to know if the mouse is over the  button to create a non directed edge 
        if @shapeE3.contains? x,y then
            true
        else  
            false
        end        
    end

    def is_in_buttonEdgeD(x,y)
        #this help us to know if the mouse is over the  button to create a directed edge 
        if @shapeE1.contains? x,y then
            true
        else  
            false
        end        
    end


    def is_in_textboxE1(x,y)
        if @edge_boxE1.contains? x,y then 
            true 
        else
            false
        end
    end

    def is_in_textboxE2(x,y)
        if @edge_boxE2.contains? x,y then 
            true 
        else
            false
        end
    end

    def press_button_vertex
        @shape6.remove
        @shape5.color = '#7CF7FF'
        @vertex_button = true
        if @edge_button == true then
            @edge_button = false
            @shape8.add
            @shape7.color = '#99B899'
        end
        self.hide_edge_editor
        self.show_vertex_Editor
    end 

    def unpress_button_vertex
        @shape6.remove
        @shape5.color = '#99B899'
        @vertex_button = false
    end

    def press_button_edge
        @shape8.remove
        @shape7.color = '#7CF7FF'
        @edge_button = true
        if @vertex_button == true then
            @vertex_button =  false
            @shape6.add
            @shape5.color = '#99B899'
        end
        self.hide_vertex_Editor
        self.show_edge_editor
    end 

    def unpress_button_edge
        @shape8.add
        @shape7.color = '#99B899'
        @edge_button = false 
    end

    def press_button_EdgeND 
        @shapeE4.remove
        @shapeE3.color = '#90E0EF'
        if @typeEdge != nil
            self.unpress_button_EdgeD
            @typeEdge = 1
        else  
            @typeEdge = 1 # 1 is for a non directed edge
        end
        if @typeEdge_shape != nil 
            @typeEdge_shape.remove
        end
        @typeEdge_shape = Line.new(
            x1:1685 , y1: 167,
            x2: 1730, y2: 167,
            width: 5,
            color: 'black',
            z: 20
          )
    end


    def unpress_button_EdgeND 
        @shapeE4.add 
        @shapeE3.color =  '#56BBF1' 
        if @typeEdge_shape != nil 
            @typeEdge_shape.remove
        end
        @typeEdge_shape = nil
        @typeEdge = nil
    end


    def press_button_EdgeD 
        @shapeE2.remove
        @shapeE1.color = '#90E0EF'
        if @typeEdge != nil
            self.unpress_button_EdgeND
            @typeEdge = 2
        else  
            @typeEdge = 2 # 2 is for a directed edge
        end
    end

    def unpress_button_EdgeD 
        @shapeE2.add 
        @shapeE1.color =  '#56BBF1' 
        @typeEdge = nil
    end

    def vertex_name_selected
        @name_box1 = true
    end

    def terminalV1_selected
        @txt_boxE1 = true
    end

    def terminalV2_selected
        @txt_boxE2 = true
    end

    def squre_shape_selected
        @shapeofvertex = 1
        self.shapeS.color = 'yellow'
        self.shapeT.color = 'white'
        self.shapeC.color = 'white'
        self.shapeP.color = 'white'
        self.shapeH.color = 'white'
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end

        @shapeIneditor = make_Squre(1375,70,1000,125,self.colorShape)
    end

    def triangle_shape_selected
        @shapeofvertex = 2
        self.shapeS.color = 'white'
        self.shapeT.color = 'yellow'
        self.shapeC.color = 'white'
        self.shapeP.color = 'white'
        self.shapeH.color = 'white'
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end
        @shapeIneditor = make_Circle(1435,140,1000,100,3,self.colorShape)
    end

    def circle_shape_selected
        @shapeofvertex = 3
        self.shapeS.color = 'white'
        self.shapeT.color = 'white'
        self.shapeC.color = 'yellow'
        self.shapeP.color = 'white'
        self.shapeH.color = 'white'
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end
        @shapeIneditor = make_Circle(1435,140,1000,80,35,self.colorShape)
    end

    def pentagon_shape_selected
        @shapeofvertex = 4
        self.shapeS.color = 'white'
        self.shapeT.color = 'white'
        self.shapeC.color = 'white'
        self.shapeP.color = 'yellow'
        self.shapeH.color = 'white'
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end
        @shapeIneditor = make_Circle(1435,140,1000,100,5,self.colorShape)
    end

    def hexagon_shape_selected
        @shapeofvertex = 5
        self.shapeS.color = 'white'
        self.shapeT.color = 'white'
        self.shapeC.color = 'white'
        self.shapeP.color = 'white'
        self.shapeH.color = 'yellow'
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end
        @shapeIneditor = make_Circle(1435,140,1000,100,6,self.colorShape)
    end

    def hide_vertex_Editor
        @shape9.remove
        @shape10.remove
        @shape11.remove
        @text3.remove
        @shapeS.remove
        @shapeSs.remove
        @shapeT.remove
        @shapeTs.remove
        @shapeC.remove
        @shapeCs.remove
        @shapeP.remove
        @shapePs.remove
        @shapeH.remove
        @shapeHs.remove
        @text_box1.remove
        @color_aqua.remove
        @color_blue.remove
        @color_brown.remove
        @color_fuchsia.remove
        @color_gray.remove
        @color_green.remove
        @color_lime.remove
        @color_maroon.remove
        @color_navy.remove
        @color_olive.remove
        @color_orange.remove
        @color_purple.remove
        @color_red.remove
        @color_silver.remove
        @color_teal.remove
        @color_yellow.remove
        @textInshape.remove
        if @shapeIneditor != nil
            @shapeIneditor.remove
        end
        @createshape.remove
        @buttonC_text.remove
    end

    def show_vertex_Editor
        @shape9.add
        @shape10.add
        @shape11.add
        @text3.add
        @shapeS.add
        @shapeSs.add
        @shapeT.add
        @shapeTs.add
        @shapeC.add
        @shapeCs.add
        @shapeP.add
        @shapePs.add
        @shapeH.add
        @shapeHs.add
        @text_box1.add
        @color_aqua.add
        @color_blue.add
        @color_brown.add
        @color_fuchsia.add
        @color_gray.add
        @color_green.add
        @color_lime.add
        @color_maroon.add
        @color_navy.add
        @color_olive.add
        @color_orange.add
        @color_purple.add
        @color_red.add
        @color_silver.add
        @color_teal.add
        @color_yellow.add
        @textInshape.add
        if @shapeIneditor != nil
            @shapeIneditor.add
        end
        @createshape.add
        @buttonC_text.add
    end


    def show_edge_editor
        @shapeE1.add
        @shapeE2.add
        @shapeE3.add
        @shapeE4.add
        @textE1.add
        @textE2.add
        @edge_boxE1.add
        @edge_boxE2.add
        @text_boxE1.add
        @text_boxE2.add
        @color_aqua.add
        @color_blue.add
        @color_brown.add
        @color_fuchsia.add
        @color_gray.add
        @color_green.add
        @color_lime.add
        @color_maroon.add
        @color_navy.add
        @color_olive.add
        @color_orange.add
        @color_purple.add
        @color_red.add
        @color_silver.add
        @color_teal.add
        @color_yellow.add

        if @typeEdge_shape != nil then 
            @typeEdge_shape.add
        end
    end

    def hide_edge_editor
        @shapeE1.remove
        @shapeE2.remove
        @shapeE3.remove
        @shapeE4.remove
        @textE1.remove 
        @textE2.remove
        @edge_boxE1.remove
        @edge_boxE2.remove
        @text_boxE1.remove
        @text_boxE2.remove
        @color_aqua.remove
        @color_blue.remove
        @color_brown.remove
        @color_fuchsia.remove
        @color_gray.remove
        @color_green.remove
        @color_lime.remove
        @color_maroon.remove
        @color_navy.remove
        @color_olive.remove
        @color_orange.remove
        @color_purple.remove
        @color_red.remove
        @color_silver.remove
        @color_teal.remove
        @color_yellow.remove

        if @typeEdge_shape != nil then 
            @typeEdge_shape.remove
        end
    end


    def reset_vertexEditor
        self.shapeofvertex = 0
        self.colorShape = 'random'
        self.textInshape.remove
        self.shapeIneditor.remove
        self.text_box1.text = ''
        self.shapeS.color = 'white'
        self.shapeT.color = 'white'
        self.shapeC.color = 'white'
        self.shapeP.color = 'white'
        self.shapeH.color = 'white'
        self.name_box1 = false
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

g = Graph_ND.new



on :mouse do |event|
    #puts event
    case event.button
    when :left#right button  is used to select any object on the screen
        if edit.is_in_button_vertex(event.x, event.y)  then 
            edit.press_button_vertex
        end

        if edit.is_in_button_edge(event.x, event.y) then 
            edit.press_button_edge
        end

        if edit.is_in_textbox1(event.x,event.y)  and edit.vertex_button == true then 
            edit.vertex_name_selected
        end

        if edit.is_in_shapeSquare(event.x, event.y) and edit.vertex_button == true then
            edit.squre_shape_selected
        end
        if edit.is_in_shapeTriangle(event.x, event.y) and edit.vertex_button == true then
            edit.triangle_shape_selected
        end

        if edit.is_in_shapeCircle(event.x, event.y) and edit.vertex_button == true then
            edit.circle_shape_selected
        end

        if edit.is_in_shapePentagon(event.x, event.y) and edit.vertex_button == true then
            edit.pentagon_shape_selected
        end

        if edit.is_in_shapeHexagon(event.x, event.y) and edit.vertex_button == true then
            edit.hexagon_shape_selected
        end
        if edit.is_in_colors(event.x, event.y) and edit.vertex_button == true
            if edit.shapeIneditor != nil
                edit.shapeIneditor.color = edit.colorShape
            end
        end

        if edit.is_in_buttonCreate(event.x,event.y) and edit.vertex_button == true
            s = ''
            case edit.shapeofvertex
            when 1 
                s = 'square'
            when 2
                s = 'triangle'
            when 3
                s = 'circle'
            when 4
                s = 'pentagon'
            when 5
                s = 'hexagon'
            else
                s = 'circle'
            end
            if edit.shapeIneditor != nil  then 
                if edit.textInshape.text.length > 0
                    x = g.add_vertex((edit.textInshape.text),s,edit.colorShape)
                elsif edit.text_box1.text.length > 0 
                    x = g.add_vertex((edit.text_box1.text),s,edit.colorShape)
                else 
                    
                    x = g.add_vertex('NULL0',s,edit.colorShape)
                
                end
                
                if  x != nil
                    edit.reset_vertexEditor
                end
            end
            
        end

        if edit.is_in_buttonEdgeND(event.x,event.y) and edit.edge_button == true
            edit.press_button_EdgeND
        end

        if edit.is_in_buttonEdgeD(event.x,event.y) and edit.edge_button == true
            edit.press_button_EdgeD
        end

        if edit.is_in_textboxE1(event.x,event.y) and edit.edge_button == true
            if edit.txt_boxE2
                edit.txt_boxE2 = false
            end
            edit.terminalV1_selected
        end

        if edit.is_in_textboxE2(event.x,event.y) and edit.edge_button == true
            if edit.txt_boxE1
                edit.txt_boxE1 = false
            end
            edit.terminalV2_selected
        end

        if edit.txt_boxE1 or edit.txt_boxE2 then 
            g.vertex.each do |k,s|
                if s.vshape.contains? event.x ,event.y
                     if edit.txt_boxE1
                         edit.text_boxE1.text = k.to_s
                     end

                     if edit.txt_boxE2
                        edit.text_boxE2.text = k.to_s
                    end
                end 
            end
        else 
            g.vertex.each do |k,s|
                if s.vshape.contains? event.x ,event.y
                    if g.selected_key == k
                        g.selected_key = nil
                    else
                        g.vertex_Select(k)
                    end
                end
            end
        end

        
    when :middle
    # Middle mouse button pressed down
    when :right
        if g.selected_key != nil
            g.vertex[g.selected_key].vshape.x = event.x
            g.vertex[g.selected_key].vshape.y = event.y
            g.vertex[g.selected_key].nameshape.x = event.x
            g.vertex[g.selected_key].nameshape.y = event.y
            g.selected_key = nil
        end
        #system("explorer #{"/home/sergioska8/"}")
    end
end


on :mouse_move do |event|

    if g.selected_key != nil
        g.vertex[g.selected_key].vshape.x = event.x
        g.vertex[g.selected_key].vshape.y = event.y
        g.vertex[g.selected_key].nameshape.x = event.x
        g.vertex[g.selected_key].nameshape.y = event.y
    end
    if edit.is_in_buttonCreate(event.x,event.y)
        edit.buttonC_text.color = 'blue'
    else
        edit.buttonC_text.color = 'black'
    end
end

#this help us to introduce text with the keyboard
on :key_down do |event|
    if event.key != 'backspace' and event.key != 'space' and event.key != 'return'
        x = event.key 
        if edit.name_box1 and edit.vertex_button then 
            if edit.text_box1.text.length <= 20 then
                edit.text_box1.text += x.to_s
            end
        end

        if edit.txt_boxE1 and edit.edge_button then 
            if edit.text_boxE1.text.length <= 20 then
                edit.text_boxE1.text += x.to_s
            end
        end

        if edit.txt_boxE2 and edit.edge_button then 
            if edit.text_boxE2.text.length <= 20 then
                edit.text_boxE2.text += x.to_s
            end
        end
    elsif event.key == 'backspace' and event.key != 'space' and event.key != 'return'
        if edit.name_box1 and edit.vertex_button then
            edit.text_box1.text = edit.text_box1.text.chop
        end

        if edit.txt_boxE1 and edit.edge_button then
            edit.text_boxE1.text = edit.text_boxE1.text.chop
        end

        if edit.txt_boxE2 and edit.edge_button then
            edit.text_boxE2.text = edit.text_boxE2.text.chop
        end
    elsif event.key == 'space' and event.key != 'backspace'and event.key != 'return'
        if edit.name_box1 then 
            if edit.text_box1.text.length <= 15 then
                edit.text_box1.text += '_'
            end
        end

        if edit.txt_boxE1 then 
            if edit.text_boxE1.text.length <= 15 then
                edit.text_boxE1.text += '_'
            end
        end

        if edit.txt_boxE2 then 
            if edit.text_boxE2.text.length <= 15 then
                edit.text_boxE2.text += '_'
            end
        end
    elsif event.key == 'return' and event.key != 'space' and event.key != 'backspace'
        if edit.name_box1 and edit.vertex_button then
            if edit.text_box1.text.length > 0 then 
                edit.textInshape.add
                edit.textInshape.text = edit.text_box1.text
            else 
                edit.textInshape.text = 'NULL'
            end
        end
    end
end


show