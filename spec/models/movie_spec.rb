require 'rails_helper'

describe Movie do
  describe 'method search_same_director' do
    let(:movie1) {Movie.create(:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Guy Ritchie')}
    let(:movie2) {Movie.create(:title => 'Star Wars', :rating => 'PG', :release_date => '25-May-1977', :director => 'George Lucas')}
    let(:movie3) {Movie.create(:title => 'Alien', :rating => 'R', :release_date => '25-May-1979', :director => '')}
    let(:movie4) {Movie.create(:title => 'THX-1138', :rating => 'R', :release_date => '11-Mar-1971', :director => 'George Lucas')}

    context 'director exists' do
      it 'should return correct matches when no other movies are found' do
        result = Movie.search_same_director(movie1.director)
        expect(result).to eq([movie1])
      end

      it 'should return correct matches when other movies are found' do
        result = Movie.search_same_director(movie2.director)
        expect(result).to eq([movie2, movie4])
      end
    end

    context 'director does not exist' do
      it 'should not return matches' do
        result = Movie.search_same_director(movie3.director)
        expect(result).to eq(nil)
      end
    end
  end
end