require 'spec_helper'

describe "Pokemon" do
  before do 
    @user = User.create(:username => "barack123", :name => "Barack Obama")

    @team = Team.create(:name => "Primary", :size => 6, :user => @user)

    params = {
        :name => "Jolteon",
        :element => "Thunder",
        :gender => "Female",
        :nature => "Cocky",
        :health => 31,
        :attack => 31,
        :defense => 31,
        :special_attack => 31,
        :special_defense => 31,
        :speed => 31,
    }

    @pokemon = Pokemon.create(params)

    # blank_space =  Team.create(:name => "Primary", :artist => @artist) 

    # pop = Genre.create(:name => "Pop")

    # blank_space.genre_ids = pop.id
    
  end
  it "can be initialized" do
    expect(@pokemon).to be_an_instance_of(Pokemon)
  end

  it "can have a name" do
    expect(@pokemon.name).to eq("Jolteon")
  end

  it "can have an element" do
    expect(@pokemon.element).to eq("Thunder")
  end

  it "can have an gender" do
    expect(@pokemon.gender).to eq("Female")
  end

  it "can have an nature" do
    expect(@pokemon.nature).to eq("Cocky")
  end

  it "can have an health" do
    expect(@pokemon.health).to eq(31)
  end

  it "can have an attack" do
    expect(@pokemon.attack).to eq(31)
  end

  it "can have an defense" do
    expect(@pokemon.defense).to eq(31)
  end

  it "can have an special attack" do
    expect(@pokemon.special_attack).to eq(31)
  end

  it "can have an special defense" do
    expect(@pokemon.special_defense).to eq(31)
  end

  it "can have an speed" do
    expect(@pokemon.speed).to eq(31)
  end

  it "has a team" do
    expect(@pokemon.team).to eq(@team)
  end

  it "has a user" do
    expect(@pokemon.team.user).to eq(@user)
  end

  it "can slugify its name" do

    expect(@pokemon.slug).to eq("jolteon")
  end

  describe "Class methods" do
    it "given the slug can find a Team" do
      slug = "jolteon"
      expect((Pokemon.find_by_slug(slug)).name).to eq("Jolteon")
    end
  end

end
