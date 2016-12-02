ActiveAdmin.register Tag do
  permit_params :name

  index do
    selectable_column
    column :id
    column :name
    column :taggings_count
    actions
  end
end
