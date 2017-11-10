
import Foundation

extension Array {
	func shuffle(iterations: Int=1) -> Array {
		var new = self
		for _ in 1...iterations {
			var current: Array = []
			for _ in 1...new.count {
				current.append(new.remove(at: getRandom(min: 0, max: new.count-1)))
			}
			new = current
		}
		return new
	}
}

func getRandom(min:Int, max:Int) -> Int {
	return Int(arc4random_uniform(UInt32(max - min + 1)) + UInt32(min))
}

class Suit {
	let name: String
	let letter: String

	init(name: String, letter: String) {
		self.name = name
		self.letter = letter
	}

	static let suits: Array<Suit> = [
		Suit(name: "Spades", letter: "S"),
		Suit(name: "Hearts", letter: "H"),
		Suit(name: "Clubs", letter: "C"),
		Suit(name: "Diamonds", letter: "D")
	]
}

class Rank {
	let name: String
	let letter: String
	let rank: Int
	let value: Int

	init(name: String, letter: String, rank: Int, value: Int) {
		self.name = name
		self.letter = letter
		self.rank = rank
		self.value = value
	}

	static let ranks: Array<Rank> = [
		Rank(name: "Ace", letter: "A", rank: 14, value: 11),
		Rank(name: "Two", letter: "2", rank: 2, value: 2),
		Rank(name: "Three", letter: "3", rank: 3, value: 3),
		Rank(name: "Four", letter: "4", rank: 4, value: 4),
		Rank(name: "Five", letter: "5", rank: 5, value: 5),
		Rank(name: "Six", letter: "6", rank: 6, value: 6),
		Rank(name: "Seven", letter: "7", rank: 7, value: 7),
		Rank(name: "Eight", letter: "8", rank: 8, value: 8),
		Rank(name: "Nine", letter: "9", rank: 9, value: 9),
		Rank(name: "Ten", letter: "X", rank: 10, value: 10),
		Rank(name: "Jack", letter: "J", rank: 11, value: 10),
		Rank(name: "Queen", letter: "Q", rank: 12, value: 10),
		Rank(name: "King", letter: "K", rank: 13, value: 10)
	]
}

class Card: CustomStringConvertible {
	let suit: Suit
	let rank: Rank
	var description: String {
		return "<\(self.getPrint())>"
	}

	init(suit: Suit, rank: Rank) {
		self.suit = suit
		self.rank = rank
	}

	func getPrint(abbreviate: Bool=false) -> String {
		if abbreviate {
			return self.rank.letter + self.suit.letter
		}
		return "\(self.rank.name) of \(self.suit.name)"
	}

	static var cards: Array<Card> {
		var cards: Array<Card> = []
		for suit in Suit.suits {
			for rank in Rank.ranks {
				cards.append(Card(suit: suit, rank: rank))
			}
		}
		return cards
	}
}

class Deck: CustomStringConvertible {
	var cards: Array<Card>
	var description: String {
		return "<\(self.getPrint())>"
	}

	init(full: Bool=true, shuffle: Bool=false) {
		self.cards = full ? Card.cards : []
		if shuffle {
			self.shuffle()
		}
	}

	func shuffle(iterations: Int=1) {
		self.cards = self.cards.shuffle(iterations: iterations)
	}

	func getPrint(abbreviate: Bool=false, separator: String=", ") -> String {
		var array: Array<String> = []
		for c in self.cards {
			array.append(c.getPrint(abbreviate: abbreviate))
		}
		return array.joined(separator: separator)
	}
}
// var d = Deck(shuffle: true)
// print(d.cards[0])
