# EXPLANATORY NOTES

Verbalyser is written to assist in the mastery of Lithuanian verbs.
To use it, you execute the "exec" file in the "exe/" folder with a text file of Lithuanian infinitive verbs (one verb per line) as an argument.
Verbalyser analyses the infinitive into its constituent components:

LEMMA + LEMMA SUFFIX + INFINITIVE SUFFIX
LEMMA + INFINITIVE SUFFIX

Then it fetches the main conjugated forms (present tense third person and past tense third person), creates a file in the output folder, and appends the full details of the verb to a new line in the file.

The file name is a derivation of either the lemma suffix or the last syllable of the lemma.

In order to ascertain whether a verb contains a lemma suffix, Verbalyser scans the *lemma database* to find the longest matching lemma.
Any letters in the infinitive verb string between the lemma and the infinitive suffix are taken as the lemma suffix.

## Example: aktyvuoti

The infinitive verb *aktyvuoti* is composed of the following:
* Lemma: "aktyv"
* Lemma suffix: "uo"
* Infinitive suffix "ti"

Therefore it is read as "aktyv" + "uo" + "ti".

The other forms:

Present tense third person: "aktyvuoja" => "aktyv" + "uoja"
Present tense third person: "akyvavo" => "aktyv" + "avo"

Therefore, the file name for this verb will be:

*"uoti_uoja_avo.txt"*

Any any other verb found with these endings will be appended to the same file.

# OUTPUT

The final result is a collection of files that automatically group verbs from the source file according to their endings, greatly facilitating refined analysis of conjugation patterns and lemma mutations within said patterns.

# Future Developments

The "data" folder contains the refined catalogue of verbs, divided into three main groups and subdivided by suffix patterns and lemma mutations.

The next version of Verbalyser will automate this process.

# Verbalyser

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/verbalyser`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'verbalyser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install verbalyser

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clockworkpc/verbalyser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
