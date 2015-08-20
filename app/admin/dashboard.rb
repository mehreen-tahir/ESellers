ActiveAdmin::Dashboards.build do
      section "Recent Products" do
        table_for Product.order("created_at desc").limit(5) do
          column :title do |product|
            link_to product.title, [:admin, product]
          end
          column :created_at
        end
        strong { link_to "View All Products", admin_products_path }
      end
    end
