module Admin::ProdutosHelper

  def admin_form_for( record, &block )
    result = if record.new_record?
             [send("admin_#{record.class.name.underscore.pluralize}_url"), :post]
             else
             [send("admin_#{record.class.name.underscore}_url", record), :put]
             end


    form_for( record,
            :url => result.first,
            :method => result.last,
            :builder => BootstrapFormBuilder,
            &block )

  end

end