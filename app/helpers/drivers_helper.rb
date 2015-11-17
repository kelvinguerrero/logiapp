module DriversHelper
  def status_driver(driver)
    if driver.get_black_list_driver
      'class="danger"'.html_safe
    else
      ''.html_safe
    end
  end
end
