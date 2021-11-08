JobVacancy::App.controllers :users do
  get :new, map: '/register' do
    @user = UserForm.new
    render 'users/new'
  end

  post :create do
    password_confirmation = params[:user_form][:password_confirmation]
    params[:user_form].reject! { |k, _| k == 'password_confirmation' }

    @user = User.new(params[:user_form])

    if params[:user_form][:password] == password_confirmation
      if UserRepository.new.save(@user)
        flash[:success] = 'User created'
        redirect '/'
      else
        flash.now[:error] = 'All fields are mandatory'
        render 'users/new'
      end
    else
      flash.now[:error] = 'Passwords do not match'
      render 'users/new'
    end

  rescue ActiveModel::ValidationError => e
    @user = UserForm.new
    @errors = e.model.errors
    flash.now[:error] = 'Please review the errors'
    render 'users/new'
  end
end
