deck1 = Deck.new(name: "State Capitals")
deck1.save

card1 = Card.new(question: "What is the capital of New York?", answer: "Albany", deck_id: 2)
card2 = Card.new(question: "What is the capital of California?", answer: "Sacramento", deck_id: 2)
card3 = Card.new(question: "What is the capital of Mass?", answer: "Boston", deck_id: 2)


card1.save
card2.save
card3.save
