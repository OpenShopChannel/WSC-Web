How to use these translations? Glad you asked.

### Compile Translations
`pybabel compile -d translations`

### Extract new strings
`pybabel extract -F babel.cfg -o messages.pot .`

### Initialize a new translation for a language
`pybabel init -i messages.pot -d translations -l de`

### Update existing translation files with new strings
`pybabel update -i messages.pot -d translations`
