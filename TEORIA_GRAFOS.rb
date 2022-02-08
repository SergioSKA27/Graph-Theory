require 'ruby2d'
#Created by: Sergio Lopez
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
            @vselected =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i + 5,sectors: 3,
                color: color.to_s,z: 10)
            
        when 'circle' then
            @vshape = Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i,sectors: 32,
                color: color.to_s,z: 10)
            @vselected =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i + 5,sectors: 32,
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
            @vselected =  Circle.new(
                x: vertexpos[0].to_i, y: vertexpos[1].to_i,
                radius: size.to_i + 5,sectors: 5,
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
#we can edit this edges at the same form :)


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
    

    def initialize
        #Variables to interact with the GUI 
        #edge and vertex buttons variables are used to specify if the button y selected
        @vertex_button = false
        @edge_button = false
        @name_box1 = false
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

    def press_button_vertex
        @shape6.opacity = 0
        @shape5.color = '#7CF7FF'
        @vertex_button = true
        if @edge_button == true then
            @edge_button = false
            @shape8.opacity = 1.0
            @shape7.color = '#99B899'
        end
        self.show_vertex_Editor
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
        self.hide_vertex_Editor
    end 

    def unpress_button_edge
        @shape8.opacity = 1.0
        @shape7.color = '#99B899'
        @edge_button = false 
    end

    def vertex_name_selected
        @name_box1 = true
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
        @shape9.opacity = 0
        @shape10.opacity = 0
        @shape11.opacity = 0
        @text3.opacity = 0
        @shapeS.opacity = 0
        @shapeSs.opacity = 0
        @shapeT.opacity = 0
        @shapeTs.opacity = 0
        @shapeC.opacity = 0
        @shapeCs.opacity = 0
        @shapeP.opacity = 0
        @shapePs.opacity = 0
        @shapeH.opacity = 0
        @shapeHs.opacity = 0
        @text_box1.opacity = 0
        @color_aqua.opacity = 0
        @color_blue.opacity = 0
        @color_brown.opacity = 0
        @color_fuchsia.opacity = 0
        @color_gray.opacity = 0
        @color_green.opacity = 0
        @color_lime.opacity = 0
        @color_maroon.opacity = 0
        @color_navy.opacity = 0
        @color_olive.opacity = 0
        @color_orange.opacity = 0
        @color_purple.opacity = 0
        @color_red.opacity = 0
        @color_silver.opacity = 0
        @color_teal.opacity = 0
        @color_yellow.opacity = 0
        @textInshape.opacity = 0
        if @shapeIneditor != nil
            @shapeIneditor.opacity = 0
        end
        @createshape.opacity = 0
        @buttonC_text.remove
    end

    def show_vertex_Editor
        @shape9.opacity = 1
        @shape10.opacity = 1
        @shape11.opacity = 1
        @text3.opacity = 1
        @shapeS.opacity = 1
        @shapeSs.opacity = 1
        @shapeT.opacity = 1
        @shapeTs.opacity = 1
        @shapeC.opacity = 1
        @shapeCs.opacity = 1
        @shapeP.opacity = 1
        @shapePs.opacity = 1
        @shapeH.opacity = 1
        @shapeHs.opacity = 1
        @text_box1.opacity = 1
        @color_aqua.opacity = 1
        @color_blue.opacity = 1
        @color_brown.opacity = 1
        @color_fuchsia.opacity = 1
        @color_gray.opacity = 1
        @color_green.opacity = 1
        @color_lime.opacity = 1
        @color_maroon.opacity = 1
        @color_navy.opacity = 1
        @color_olive.opacity = 1
        @color_orange.opacity = 1
        @color_purple.opacity = 1
        @color_red.opacity = 1
        @color_silver.opacity = 1
        @color_teal.opacity = 1
        @color_yellow.opacity = 1
        @textInshape.opacity = 1
        if @shapeIneditor != nil
            @shapeIneditor.opacity = 1
        end
        @createshape.opacity = 1
        @buttonC_text.add
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

        if edit.is_in_shapeSquare(event.x, event.y) then
            edit.squre_shape_selected
        end
        if edit.is_in_shapeTriangle(event.x, event.y) then
            edit.triangle_shape_selected
        end

        if edit.is_in_shapeCircle(event.x, event.y) then
            edit.circle_shape_selected
        end

        if edit.is_in_shapePentagon(event.x, event.y) then
            edit.pentagon_shape_selected
        end

        if edit.is_in_shapeHexagon(event.x, event.y) then
            edit.hexagon_shape_selected
        end
        if edit.is_in_colors(event.x, event.y)
            if edit.shapeIneditor != nil
                edit.shapeIneditor.color = edit.colorShape
            end
        end

        if edit.is_in_buttonCreate(event.x,event.y)
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
            if edit.shapeIneditor != nil and edit.textInshape != '' and edit.text_box1 != '' then 
                x = g.add_vertex((edit.textInshape.text),s,edit.colorShape)
                if  x != nil
                    #edit.reset_vertexEditor
                end
            end
            
        end

        g.vertex.each do |k,s|
            if s.vshape.contains? event.x ,event.y
                if g.selected_key == k
                    g.selected_key = nil
                else
                    g.vertex_Select(k)
                end
            end
        end
    when :middle
    # Middle mouse button pressed down
    when :right
    
        system("explorer #{"/home/sergioska8/"}")
    end
end


on :mouse_move do |event|

    if g.selected_key != nil
        g.vertex[g.selected_key].vshape.x = event.x
        g.vertex[g.selected_key].vshape.y = event.y
        g.vertex[g.selected_key].vselected.x = event.x
        g.vertex[g.selected_key].vselected.y = event.y
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
        if edit.name_box1 then 
            if edit.text_box1.text.length <= 20 then
                edit.text_box1.text += x.to_s
            end
        end
    elsif event.key == 'backspace' and event.key != 'space' and event.key != 'return'
        if edit.name_box1 then
            edit.text_box1.text = edit.text_box1.text.chop
        end
    elsif event.key == 'space' and event.key != 'backspace'and event.key != 'return'
        if edit.name_box1 then 
            if edit.text_box1.text.length <= 15 then
                edit.text_box1.text += '_'
            end
        end
    elsif event.key == 'return' and event.key != 'space' and event.key != 'backspace'
        if edit.name_box1 then
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