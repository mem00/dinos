class MoveDinosaur
  def self.move_to_cage(dinosaur, cage)
    raise 'cage is full' unless cage.has_space?
    if cage.is_empty?
      raise 'cage is down' if cage.down?
      dinosaur.cage = cage
      if dinosaur.is_carnivore?
        cage.contains_carnivores = true
        cage.species = dinosaur.species
      else
        cage.contains_carnivores = false
      end
      cage.save!
    else
      if dinosaur.is_carnivore?
        if cage.contains_carnivores?
          cage.species == dinosaur.species ? dinosaur.cage = cage : raise('carnivorous must be of same species')
        else
          raise 'cannot put carnivore in herbivore cage'
        end
      else
        if cage.contains_carnivores? 
          raise 'cannot put herbivore in carnivore cage'
        else
          dinosaur.cage = cage
        end
      end
    end
    dinosaur
  end
end