User.find_or_create_by!(name: 'admin') do |user|
  user.password = 'admin'
  user.password_confirmation = 'admin'
  user.admin = true
end

# Create some test products
Product.create!([
  {
    name: 'Mona Lisa',
    description: 'A famous painting by Vermeer, known as "The Mona Lisa of the North."',
    price: 99999.99,
    image_url: '1.jpg'
  },
  {
    name: 'Girl with a Pearl Earring',
    description: 'Leonardo da Vinci\'s most famous masterpiece, the mysterious smile has been celebrated for centuries.',
    price: 89999.99,
    image_url: '2.jpg'
  },
  {
    name: 'Squidward Tentacles',
    description: 'This is Squidward Tentacles.',
    price: 79999.99,
    image_url: '3.jpg'
  },
  {
    name: 'Vincent van Gogh',
    description: 'This is Vincent van Gogh.',
    price: 69999.99,
    image_url: '4.jpg'
  },
  {
    name: 'SpongeBob SquarePants',
    description: 'This is SpongeBob SquarePants.',
    price: 59999.99,
    image_url: '5.jpg'
  },
  {
    name: 'TPatrick Star',
    description: 'This is Patrick Star.',
    price: 49999.99,
    image_url: '6.jpg'
  }
])
