class DispatchLogic

  def initialize(params, p_dispatch)
    @dispatch =p_dispatch
    @params = params
  end

  def edit_dispatch_logic(dispatch,anterior_advance,anterior_balance)
    if (not dispatch.driver.nil?)
      driver = Driver.find_by(:id=>dispatch.driver.id)
      driver.busy =true
      driver.save
      @v_anterior_advance = anterior_advance
      @v_anterior_balance = anterior_balance
    end
    advance_accounting(dispatch)
  end

  def create_dispatch_logic
    if ((not @params[:driver_id].nil?) and @params[:driver_id].to_s.length > 0)
      var_driver_logic = DriverLogic.new(@params)
      var_driver_logic.validate_status_driver(@params[:driver_id])
    else
      @dispatch.errors.add(:driver, ": Error, no se le generar el despacho pues no existe conductor")
      raise StandardError.new("Error en la generacion de el despacho")
    end
  end

  def advance_accounting(dispatch)

    if(not @params[:advance].empty?)

        parametro_salida = Parameter.find_by_name('Salida')
        parametro_sale_advance = Parameter.find_by_name('sale_advance').value.to_i
        v_sale = dispatch.sales.find_by(:lastChange=>true, :saleType=>parametro_sale_advance)
        if not v_sale.nil?

          if @v_anterior_advance != @params[:advance].to_d
            v_sale.lastChange = false
            v_sale.save

            anterior = @v_anterior_advance
            correccion = anterior - @params[:advance].to_d
            v_outflow = Outflow.create(:concept=>"#{parametro_salida.value}: anticipo, Corrección",:flowDate=>Date.current,:value=>correccion)
            Sale.create(:dispatch=>dispatch,:outflow=>v_outflow,:lastChange=>true, :saleDescription=> v_outflow.concept,:saleType=> parametro_sale_advance )
            last = Box.last
            total_box = ( last ? last.total : 0 ) + correccion
            v_box = Box.create(:name=>"#{parametro_salida.value}: anticipo, corrección", :value=>correccion,:total=>total_box,:incomeDate=>Date.current)
            v_outflow.boxes << v_box
          end

        else
          v_outflow = Outflow.create(:concept=>"#{parametro_salida.value}: anticipo",:flowDate=>Date.current,:value=>@params[:advance].to_d)
          Sale.create(:dispatch=>dispatch,:outflow=>v_outflow,:lastChange=>true, :saleDescription=> v_outflow.concept,:saleType=> parametro_sale_advance )
          last = Box.last
          total_box = ( last ? last.total : 0 ) - @params[:advance].to_d
          v_box = Box.create(:name=>"#{parametro_salida.value}: anticipo", :value=>@params[:advance].to_d,:total=>total_box,:incomeDate=>Date.current)
          v_outflow.boxes << v_box
        end
    end

    if(not @params[:balance].empty?)

        parametro_salida = Parameter.find_by_name('Salida')
        parametro_sale_balance = Parameter.find_by_name('sale_balance').value.to_i
        v_sale = dispatch.sales.find_by(:lastChange=>true, :saleType=>parametro_sale_balance)
        if not v_sale.nil?

          if @v_anterior_balance != @params[:balance].to_d
            v_sale.lastChange = false
            v_sale.save

            anterior = @v_anterior_balance
            correccion = anterior - @params[:balance].to_d
            v_outflow = Outflow.create(:concept=>"#{parametro_salida.value}: saldo, Corrección",:flowDate=>Date.current,:value=>correccion)
            Sale.create(:dispatch=>dispatch,:outflow=>v_outflow, :saleDescription=> v_outflow.concept,:saleType=> parametro_sale_balance )
            last = Box.last
            total_box = ( last ? last.total : 0 ) + correccion
            v_box = Box.create(:name=>"#{parametro_salida.value}: saldo, corrección", :value=>correccion,:total=>total_box,:incomeDate=>Date.current)
            v_outflow.boxes << v_box
          end

        else
          v_outflow = Outflow.create(:concept=>"#{parametro_salida.value}: saldo",:flowDate=>Date.current,:value=>@params[:balance].to_d)
          Sale.create(:dispatch=>dispatch,:outflow=>v_outflow, :saleDescription=> v_outflow.concept,:saleType=> parametro_sale_balance )
          last = Box.last
          total_box = ( last ? last.total : 0 ) - @params[:balance].to_d
          v_box = Box.create(:name=>"#{parametro_salida.value}: saldo", :value=>@params[:balance].to_d,:total=>total_box,:incomeDate=>Date.current)
          v_outflow.boxes << v_box
        end

    end
  end

end
