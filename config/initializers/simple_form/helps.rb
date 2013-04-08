module SimpleForm
  module Components
    module Helps
      def help
        @help ||= begin
          help = options[:help]
          help_title = options[:help_title] || options[:label]
          help_component = "<i class='icon-question-sign help-inline' rel='popover' data-content='#{help}' data-trigger='hover' title='#{help_title}'></i>" if help
          help_component.html_safe if help_component
        end
      end

      def has_help?
        help.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Helps)