ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  filter :email
  filter :authentication_token
  filter :created_at
  filter :updated_at

  index download_links: false do
    selectable_column
    id_column
    column :email
    column :authentication_token
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :authentication_token
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
