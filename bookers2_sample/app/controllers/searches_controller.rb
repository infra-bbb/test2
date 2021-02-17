class SearchesController < ApplicationController

	def index
		@book = Book.new
		@model = params[:search][:model]
		@word = params[:search][:word]
		@method = params[:search][:method]
		@results = search(@model, @word, @method)
	end

	private

	def search(model, word, method)
		case method
		when 'completely'
			model == 'Book' ? Book.completely_search(word) : User.completely_search(word)
		when 'forward'
			model == 'Book' ? Book.forward_search(word) : User.forward_search(word)
		when 'backward'
			model == 'Book' ? Book.backward_search(word) : User.backward_search(word)
		when 'partial'
			model == 'Book' ? Book.partial_search(word) : User.partial_search(word)
		end
	end
end
