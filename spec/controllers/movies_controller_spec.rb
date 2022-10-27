require 'rails_helper'

describe MoviesController do
  describe 'Find movies with same director (GET /search)' do
    it 'should return correct matches if director exists' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      fake_results = [double('Movie1'), double('Movie2')]
      Movie.stub(:search_same_director).with(movie.director).and_return(fake_results)
      get :search, {:id => movie.id}
      expect(assigns(:same_director_movies)).to eq(fake_results)
      expect(response).to render_template('search')
    end

    it 'should not return matches if director does not exists' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => '')
      get :search, {:id => movie.id}
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'Show movie detail (GET /show)' do
    it 'should successfully show movie detail' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      get :show, {:id => movie.id}
      expect(assigns(:movie)).to eq(movie)
      expect(response).to render_template('show')
    end
  end

  describe 'Home page (GET /index)' do
    it 'should successfully display home page' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'Create new movie (POST /create)' do
    it 'should successfully create a new movie' do
      params = ActionController::Parameters.new(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      expect{post :create, {:movie => params}}.to change{Movie.count}.by(1)
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'Edit movie details (GET /edit)' do
    it 'should find movie details waiting to be edited' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      get :edit, {:id => movie.id}
      expect(assigns(:movie)).to eq(movie)
      expect(response).to render_template('edit')
    end
  end

  describe 'Update movie details (PUT /update)' do
    it 'should successfully update movie details' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      params = ActionController::Parameters.new(:rating => 'PG', :director => 'Somebody')
      put :update, {:id => movie.id, :movie => params}
      movie.reload
      expect(movie.rating).to eq('PG')
      expect(movie.director).to eq('Somebody')
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe 'Delete a movie (DELETE /destroy)' do
    it 'should successfully delete a movie' do
      movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      expect{delete :destroy, {:id => movie.id}}.to change{Movie.count}.by(-1)
      expect(response).to redirect_to(movies_path)
    end
  end
end