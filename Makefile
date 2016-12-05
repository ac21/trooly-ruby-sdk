RUBY_VER=$(shell (head -n 1 .ruby-version))

setup:
	echo "Installing Ruby $(RUBY_VER)..."
	rbenv install $(RUBY_VER) -s
	bin/setup
	echo "Setup Complete"

specs:
	bundle exec rspec

install:
	bundle exec rake install
