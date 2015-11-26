module ContainersHelper
  def container_form_name
    veinte_st = Parameter.find_by_name('name_cont_20_st')
    cuarenta_hq = Parameter.find_by_name('name_cont_40_hq')
    cuarenta_st = Parameter.find_by_name('name_cont_40_st')
    cities_array = [veinte_st.value, cuarenta_st.value, cuarenta_hq.value]
    return cities_array
  end
end
