class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @won = false
    @playerBusted = false
    @dealerBusted = false
    @dealerScore = 0
    @poppedCard
    @on 'won',=> @createAlert()

  createAlert: ->
    if !@dealerBusted && !@won
      @currentScore = @scores()[0] + @poppedCard.get 'value'
      alert('Dealer Won because player score: ' + @currentScore)
      @won = true
    else if !@playerBusted && !@won
      @currentScore = @scores()[0] + @poppedCard.get 'value'
      alert('Player Won because dealer score: ' + @currentScore)
      @won = true

  hit: ->
    @poppedCard = @deck.pop()
    console.log @poppedCard.get 'value'
    if (@scores()[0] + @poppedCard.get 'value') > 21
      @bust()

    else if (@scores()[0] + @poppedCard.get 'value') == 21
      @checkWinner()

    else
     @add(@poppedCard)
     @poppedCard

  bust: ->
    if @isDealer
      @dealerBusted = true
    else if !@isDealer
      @playerBusted = true

    @trigger 'won'

  checkWinner: ->
    @won = true
    @trigger 'won'

  stand: =>
    @trigger 'stand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    [@minScore(), @minScore() + 10 * @hasAce()]

  currentScore: ->
    @scores()[0]

  drawByDealer: ->
    @playerScore = @get 'playerScore'

    if !@first().get 'revealed'
      @first().flip()
      while ( @scores()[0] < 17 && !@won)
        @.hit()

###      if(!@won)
        if @isDealer
        @dealerScore = @scores()[0]
        # else if !@isDealer
        #   playerScore = @scores()[0]
        console.log(@dealerScore, @)
        if @dealerScore - @playerScore > 0
          alert('Dealer Won -- Closest score of player: ' + @playerScore)
          @won = true
        else if @dealerScore - @playerScore < 0
          alert('Player Won -- Closest score of dealer: ' + @dealerScore)
          @won = true###

