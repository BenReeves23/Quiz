
class Quiz
	attr_accessor :title, :problems, :score

	def initialize(title, problems, score)
		@title = title
		@problems = problems
		@score = score
	end
end

class Problem
	attr_accessor :question, :answer

	def initialize(question, answer)
		@question = question
		@answer = answer
	end

end

puts "Let's build some quizzes: "

@quizzes = []

def menu
	puts "Would you like to build a quiz or take a quiz (Select 1 or 2)?"
	puts "1. Build a Quiz"
	puts "2. Take a Quiz"
	choice = gets.chomp.to_i

	case choice
		when 1
			system "clear"
			build_quiz
		when 2
			system "clear"
			choose_quiz
		else
			system "clear"
			puts "Try Again."
			menu
	end
end

def build_quiz
	print "What do we want to call our quiz: "
	title = gets.chomp

	print "How many questions do we want the quiz to have: "
	num = gets.chomp.to_i

	problems = []

	num.times do
		puts "Enter a yes or no question:"
		q = gets.chomp
		puts "What is the answer? [Y or N]"
		a = gets.chomp.upcase
		problem = Problem.new(q,a)
		problems.push(problem)
	end

	quiz = Quiz.new(title, problems, 0)
	@quizzes.push(quiz)
	system "clear"
	puts "Our quizzes are ready!"
	menu
end

def choose_quiz
	if @quizzes.length == 0
		puts "There are not any quizzes yet!"
		puts "Let's build some!"
		build_quiz
	else
		puts "Choose a Quiz"
		puts " "

		@quizzes.each_with_index do |quiz, index|
			puts "#{index+1}. #{quiz.title} (#{quiz.score}/#{quiz.problems.length})"
		end

		choice = gets.chomp.to_i

		system "clear"
		take_quiz(@quizzes[choice-1])
	end
end

def take_quiz(quiz)
	# gotta keep score!
	score = 0

	puts quiz.title.upcase
	puts "--------"

	# so now we're iterating through
	# the Quiz's collection of problems
	# and looking at individual Problems
	# (which are objects)
	quiz.problems.each do |problem|
		puts problem.question
		user_ans = gets.chomp.upcase

		if user_ans == "Y" || user_ans == "N"
			if user_ans == problem.answer
				score += 1
			end
		else
			# if they don't give the correct
			# type of answer (Y or N), make
			# them try again.
			puts "Try again: Y or N"
			redo
			# redo this iteration
		end
	end

	puts "You got a score of #{score} out of #{quiz.problems.length}!"

	quiz.score = score

	menu
end

menu