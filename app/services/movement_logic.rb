class MovementLogic

  def initialize(params,p_movement)
    @params = params
    @movement = p_movement
  end

  def generate_movement_box_logic(params_box)
    if params_box[:movement_type] == 'black_box_exit'
      movement_exit_box_logic
    elsif params_box[:movement_type] == 'black_box_enter'
      movement_enter_box_logic
    end
  end

  def movement_exit_box_logic
    valor = @params[:value].to_d

    parametro_salida = Parameter.find_by_name('Salida')

    last_box = Box.last
    v_total = ((last_box ? last_box.total : 0) - valor).to_d
    if v_total < 0
      @movement.errors.add(:value, ": Error, no se le pueden retirar $#{valor} de la caja")
      raise StandardError.new("Error en la cuenta")
    end
    v_box = Box.create(:name=>"#{parametro_salida.value}", :value=>valor,:total=>v_total,:incomeDate=>@params[:movementDate])
    @movement.boxes << v_box
    @movement.save
  end

  def movement_enter_box_logic
    valor = @params[:value].to_d

    v_type = TypeMovement.find_by(:name=>'Salida')
    cuenta = LogiBill.find_by(:id => @params[:logi_bill_id])
    movements = cuenta.bill_movements.where(:lastChange=>true)

    if movements.empty?
      raise StandardError.new("Error en la cuenta")
    else
      ultimo = movements.first
      ultimo.lastChange=false
      total = ultimo.total - valor
      v_bill_movement_temp = BillMovement.create(:total =>total, :value=>valor,:type_movement_id=>v_type.id,
                              :lastChange=>true, :previous_bill_movement=> ultimo)
      cuenta.bill_movements << v_bill_movement_temp
      ultimo.save

      last_box = Box.last
      v_total = ((last_box ? last_box.total : 0) + valor).to_d
      v_box = Box.create(:name=>"#{Parameter.find_by_name('Entrada').value}", :value=>valor,:total=>v_total,:incomeDate=>@params[:movementDate])

      @movement.boxes << v_box
      @movement.save
    end
  end

end
