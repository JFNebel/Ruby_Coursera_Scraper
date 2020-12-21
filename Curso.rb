

class Curso
  attr_accessor :nombre, :link, :tipo, :nivel, :institucion, :calificacion

  def initialize(nombre, link, nivel, tipo, institucion, calificacion)
    @nombre = nombre
    @link   = link
    @nivel = nivel
    @tipo = tipo
    @institucion = institucion
    @calificacion = calificacion
  end

  def registrar()
    File.open("valores.csv", "a") do |file| 
      linea = "#{@nombre},#{@link},#{@nivel},#{@tipo},#{@institucion},#{@calificacion}\n"
      file.write(linea)
      file.close
    end
  end


end



