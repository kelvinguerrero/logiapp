class ClientTax < ActiveRecord::Base
  has_many :invoices, inverse_of: :client_tax

  def get_name_client_tax
    name ? name : 'N/A'
  end

  def get_iva_client_tax
    iva ? iva : 'N/A'
  end

  def get_reteica_client_tax
    reteica ? reteica : 'N/A'
  end

  def get_retefuente_client_tax
    retefuente ? retefuente : 'N/A'
  end

end
