class BillMovementLogic

  def initialize

  end

  def movement_enter_logi_bill(p_id_logi_bill,p_total)
    v_bill=LogiBill.find_by(:id =>p_id_logi_bill)
    movements = v_bill.bill_movements.where(:lastChange=>true)
    v_type = TypeMovement.find_by(:name=>'Entrada')

    if movements.empty?
      v_bill_movement_temp = BillMovement.create(:total =>p_total, :value=>p_total,:type_movement_id=>v_type.id,
                                                 :lastChange=>true, :previous_bill_movement=> nil)
      v_bill.bill_movements << v_bill_movement_temp
    else
      movements = v_bill.bill_movements.where(:lastChange=>true)
      ultimo = movements.first
      ultimo.lastChange=false
      total = ultimo.total + p_total.to_f
      v_bill_movement_temp = BillMovement.create(:total =>total, :value=>p_total,:type_movement_id=>v_type.id,
                                                 :lastChange=>true, :previous_bill_movement=> ultimo)
      v_bill.bill_movements << v_bill_movement_temp
      ultimo.save
      Movement.create(:concept=>"Entrada al banco", :movementDate=>Date.current,:value=>p_total,
                      :logi_bill_id=>p_id_logi_bill,:type_movement =>TypeMovement.find_by_name('Entrada'))
    end
    v_bill.save
  end

end