SalesforceRails::Application.routes.draw do
  #only did symbol this way because of syntax highlighter copy/paste issue
  root 'to'.to_sym => 'welcome#index'
	match "logout" => "welcome#logout" , via: [:get, :post]
	match "*rest" => "welcome#index" , via: [:get, :post]

end

