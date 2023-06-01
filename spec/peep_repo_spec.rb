require 'peep'
require 'peep_repository'

def reset_chitter_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe PeepRepository do
  before(:each) do 
    reset_chitter_db
  end
  
  describe "#all" do
    it "returns all Peeps" do
      peeps = PeepRepository.new.all
      
      expect(peeps.length).to eq 2
      expect(peeps[0].id).to eq  1
      expect(peeps[0].content).to eq 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      expect(peeps[0].time).to eq '2023-03-08 04:05:06'
      expect(peeps[0].maker_id).to eq  '1'
    end
  end
  
  describe "#find" do
    it "returns a Peep by ID" do
      peep = PeepRepository.new.find(2)
      
      expect(peep.id).to eq 2
      expect(peep.content).to eq 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      expect(peep.time).to eq '2023-05-06 10:11:12'
      expect(peep.maker_id).to eq 2
    end
  end

  describe "#create" do
    it "creates a new Peep" do
      peep = instance_double("Peep", content: "Lorem ipsum.", time: "2023-05-20 13:14:15", maker_id: "1")
      repo = PeepRepository.new
      repo.create(peep)
      
      expect(repo.all.last.content).to eq("Lorem ipsum.")
    end
  end
end
