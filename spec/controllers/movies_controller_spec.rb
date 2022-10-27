require 'rails_helper'

describe MoviesController do
  describe 'Find movies with same director' do
    it 'should return correct matches if director exists' do
      @movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')
      Movie.stub(:find).with('1').and_return(@movie)
      @fake_results = [double('Movie1'), double('Movie2')]
      Movie.stub(:search_same_director).with('Guy Ritchie').and_return(@fake_results)
      get :search, {:id => 1}
      expect(assigns(:same_director_movies)).to eq(@fake_results)
    end

    it 'should not return matches if director does not exists' do
      @movie = Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => '')
      Movie.stub(:find).with('1').and_return(@movie)
      get :search, {:id => 1}
      expect(response).to redirect_to(movies_path)
    end
  end
end