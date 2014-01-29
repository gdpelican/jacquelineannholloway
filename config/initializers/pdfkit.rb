# Be sure to restart your server when you modify this file.

PDFKit.configure do |config|
  config.wkhtmltopdf = (Rails.env.production?) ? Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s
                                               : 'C:/Sites/Misc/wkhtmltopdf/wkhtmltopdf.exe'
end