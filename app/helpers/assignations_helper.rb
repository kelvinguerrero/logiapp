module AssignationsHelper
  def invoice_status_assignation(assignation)
    if assignation.get_Remaining > 0
        'class="warning"'.html_safe
    elsif assignation.get_Remaining <= 0  and assignation.paid_invoices
        'class="info"'.html_safe
    else
        'class="danger"'.html_safe
    end
  end
end
