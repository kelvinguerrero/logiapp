require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Logiapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    #config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    #--------------------------------------
    #Parametros globales de la platafroma
    #--------------------------------------

    #Tipo de transaccion Entrada
    ENTRADA = 'Entrada'
    #Tipo de transaccion Salida
    SALIDA = 'Salida'
    #Cantidad de dias base en vias
    CANTIDAD_DIAS_VIAS = 'cantidad_dias_vias'
    #Cantidad de dias maximo en via
    CANTIDAD_DIAS_MAXIMO = 'cantidad_dia_maximo'
    #Cantidad de dias para realizar facturacion
    CANTIDAD_DIAS_FACTURA = 'cantidad_dia_factura'
  end
end
