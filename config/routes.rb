Shoes1::Application.routes.draw do
  root to: 'shoes#index'
  resources :shoes do
    resources :parts
  end
  resources :matters
  resources :partypes do
    resources :matters, controller: :partype_matters,
                        only: [:index, :new]
  end

  get '/partypes/:partype_id/matters/:id/add', to: 'partype_matters#add', as: 'add_partype_matter'
  get '/partypes/:partype_id/matters/:id/remove', to: 'partype_matters#destroy', as: 'remove_partype_matter'

  resources :colors

  get '/shoes/:shoe_id/select_color',                 to: 'colors#select',  as: 'shoe_color'
  get '/shoes/:shoe_id/parts/:part_id/select_partype',to: 'partypes#select',as: 'part_partype'
  get '/shoes/:shoe_id/parts/:part_id/select_matter/:partype_id',
                                                      to: 'matters#select', as: 'part_matter'

  get '/partypes/:partype_id/matters/:matter_id/select_matter/',to: 'matters#select', as: 'part_matter_no_partype'
end
