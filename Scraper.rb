require 'open-uri'
require 'nokogiri'
require_relative 'Curso'


class Scraper
  
  def initialize
  end

  def extraer(tema)
    url = "https://www.coursera.org/search?query=#{tema}"  
    cursosHTML = open(url)
    data = cursosHTML.read
    parsed_content = Nokogiri::HTML(data)
    elements = parsed_content.css('.ais-InfiniteHits-item')
    numero_cursos= elements.length() 
    fp = File.open("valores.csv", "w") # --> Solo para reiniciar el archivo 
   
    # ITERACIÓN DE ELEMENTOS DEL CONTENEDOR DE TODOS LOS RESULTADOS 
    elements.each do |i|

      # RECOLECCIÓN DE ATRIBUTOS
      nombre = i.css('.color-primary-text.card-title.headline-1-text').inner_text
      imagen = i.at_css('img')['src']
      nivel = i.css('.difficulty').inner_text
      tipo = i.css('._jen3vs._1d8rgfy3').inner_text
      institucion = i.css('.partner-name').inner_text
      calificacion = i.css('.ratings-text').inner_text
     
      # REGISTRAR EN DOCUMENTO
      curso = Curso.new(nombre, imagen, nivel, tipo, institucion, calificacion) 
      curso.registrar()

      # PRUEBAS POR CONSOLA 
      puts "Nombre: #{nombre}"       
      puts "Imagen: #{imagen}"
      puts "Nivel: #{nivel}"
      puts "Tipo: #{tipo}"
      puts "Institución: #{institucion}"
      puts "Calificación: #{calificacion}"
      
      
      puts ""
      puts ""
    end

    fp.close
    puts "Su búsqueda ha terminado produciendo un total de #{numero_cursos} cursos. Se ha generado con éxito un csv con los valores recolectados (valores.csv).\n\n"
    
  
  end


end

