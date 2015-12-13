# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @playerHand = @get('playerHand')
    @dealerHand = @get('dealerHand')

    @playerHand.on 'stand', =>
      @dealerHand.drawByDealer()
      console.log @playerHand.won, @dealerHand.won
      neverWon =  !@playerHand.won || !@dealerHand.won
      if neverWon
        @playerScore = @playerHand.currentScore()
        @dealerScore = @dealerHand.currentScore()
        console.log(@dealerScore, @playerScore)
        if @dealerScore - @playerScore > 0
          alert('Dealer Won -- Closest score of player: ' + @playerScore)
        else if @dealerScore - @playerScore < 0
          alert('Player Won -- Closest score of dealer: ' + @dealerScore)



