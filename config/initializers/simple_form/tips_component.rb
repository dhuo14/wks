module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module Tips
      # Name of the component method
      def tip
        @tip ||= begin
          "<span data-content='#{options[:tip]}' data-placement='right' data-title='提示' style='margin-left: 2px;' class='icon-question-sign has-popover' data-original-title='' title=''></span>".html_safe if options[:tip].present?
        end
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Tips)