ActiveAdmin.register Discount do
  index do
    column :coupon
    column :status
    column :discount_percentage
    column "Created Date", :created_at

    default_actions
  end
end
