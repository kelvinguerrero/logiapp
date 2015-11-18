class Driver < ActiveRecord::Base

  validates :name, format: { with: /\A[a-zA-Z’ ñÑ']+\z/ , message: "El nombre no puede contener caracteres especiales"}
  validates :lastName, format: { with: /\A[a-zA-Z’ ñÑ']+\z/ , message: "El apellido no puede contener caracteres especiales"}
  validates_length_of :cellPhone, :maximum => 10, :message => "El tamaño de caracteres del año es incorrecto (debe ser de 10 digitos sin espacios)"
  validates_presence_of :car, :message => "Tiene que seleccionar la placa del carro al conductor."
  validates_presence_of :name, :message => "Tiene que ingresar un nombre para el conductor."
  validates_presence_of :lastName, :message => "Tiene que ingresar un apellido para el conductor."
  validates_presence_of :document, :message => "Tiene que ingresar el documento del conductor."
  validates_presence_of :cellPhone, :message => "Tiene que ingresar el numero de celular del conductor."
  validates :document, uniqueness: { message: "Ya existe un conductor con el mismo documento." }

  has_one :car, inverse_of: :driver
  has_many :dispatches, inverse_of: :driver

  accepts_nested_attributes_for :car

  #------------------------------------------
  # Dar el nombre del conductor
  #------------------------------------------
  def get_name_driver
    name ? name : 'N/A'
  end

  #------------------------------------------
  # Dar el apellido del conductor
  #------------------------------------------
  def get_last_name_driver
    lastName ? lastName : 'N/A'
  end

  #------------------------------------------
  # Dar el documento del conductor
  #------------------------------------------
  def get_document_driver
    document ? document : 'N/A'
  end

  #------------------------------------------
  # Dar el celular del conductor
  #------------------------------------------
  def get_cell_phone_driver
    cellPhone ? cellPhone : 'N/A'
  end

  #------------------------------------------
  # Dar el estado si esta ocupado o no
  # el conductor
  #------------------------------------------
  def get_busy_driver
    busy ? busy : false
  end

  #------------------------------------------
  # Dar el carro del conductor
  #------------------------------------------
  def get_car_driver
    car ? car.plate : 'N/A'
  end

  #------------------------------------------
  # Dar el id del carro del conductor
  #------------------------------------------
  def get_car_id_driver
    car ? car.id : 'N/A'
  end

  #------------------------------------------
  # Dar el id del carro del conductor
  # en caso contrario retorna Nil
  #------------------------------------------
  def get_car_id_driver_form
    car ? car.id : nil
  end

  #------------------------------------------
  # Dar el black list, para saber si el
  # conductor esta o no el el black list
  #------------------------------------------
  def get_black_list_driver
    blacklist ? blacklist : false
  end

  #------------------------------------------
  # Dar el comentario del black list del
  # conductor
  #------------------------------------------
  def get_black_list_comment_driver
    blacklistComment ? blacklistComment : 'N/A'
  end

  def add_error_car
    errors.add(:car, ": No se puede registrar el carro, pues no ya esta asociado con a otro conductor.")
  end
end
