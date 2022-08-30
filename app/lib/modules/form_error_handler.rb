module Modules::FormErrorHandler
  def validate_form(errors)
    unless errors.length.zero?
      errors.each do |error|
        if flash.now[:danger].nil?
          flash.now[:danger] = [error]
        else
          flash.now[:danger] << error
        end
      end
      return true
    end
    false
  end
end
