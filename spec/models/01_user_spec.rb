require 'spec_helper'

describe "User" do
  before do 
    @user = User.create(:username => "barack123", :name => "Barack Obama")

    @team = Team.create(:name => "Primary", :size => 6, :user => @user)

    # blank_space =  Team.create(:name => "Primary", :artist => @artist) 

    # pop = Genre.create(:name => "Pop")

    # blank_space.genre_ids = pop.id
    
  end
  it "can be initialized" do
    expect(@user).to be_an_instance_of(User)
  end

  it "can have a name" do
    expect(@user.name).to eq("Barack Obama")
  end

  it "can have a username" do
    expect(@user.username).to eq("barack123")
  end

  it "has many teams" do
    expect(@user.teams.count).to eq(1)
  end

  it "can have many pokemons" do
    expect(@artist.genres.count).to eq(1)
  end

  it "can slugify its name" do

    expect(@user.slug).to eq("barack-obama")
  end

  describe "Class methods" do
    it "given the slug can find a User" do
      slug = "barack-obama"
      expect((User.find_by_slug(slug)).name).to eq("Barack Obama")
    end
  end

end
