module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module RequiredType
      # Name of the component method
      def required_type
        if options[:required_type]
          options[:required_type].each do |k,v|
            input_html_options["data-rule-#{k}"] = v
          end
        end
        nil
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::RequiredType)