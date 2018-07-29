require 'spec_helper'

describe "Team" do
  before do 
    @user = User.create(:username => "barack123", :name => "Barack Obama")

    @team = Team.create(:name => "Primary", :size => 6, :user => @user)

    # blank_space =  Team.create(:name => "Primary", :artist => @artist) 

    # pop = Genre.create(:name => "Pop")

    # blank_space.genre_ids = pop.id
    
  end
  it "can be initialized" do
    expect(@team).to be_an_instance_of(Team)
  end

  it "can have a name" do
    expect(@team.name).to eq("Primary")
  end

  it "can have a size" do
    expect(@team.size).to eq(6)
  end

  it "has many pokemons" do
    expect(@team.pokemons.count).to eq(1)
  end

  it "has a user" do
    expect(@team.user).to eq(@user)
  end

  it "can slugify its name" do

    expect(@team.slug).to eq("primary")
  end

  describe "Class methods" do
    it "given the slug can find a Team" do
      slug = "primary"
      expect((Team.find_by_slug(slug)).name).to eq("Primary")
    end
  end

end
