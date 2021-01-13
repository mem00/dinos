class Dinosaur < ApplicationRecord
  belongs_to :cage, counter_cache: true

  enum species: {
    tyrannosaurus: 'tyrannosaurus',
    velociraptor: 'velociraptor',
    spinosaurus: 'spinosaurus',
    megalosaurus: 'megalosaurus',
    brachiosaurus: 'brachiosaurus',
    stegosaurus: 'stegosaurus',
    ankylosaurus: 'ankylosaurus',
    triceratops: 'triceratops'
  }
  
  def carnivore?
    species.in?(['tyrannosaurus', 'velociraptor', 'spinosaurus', 'megalosaurus'])
  end
end
