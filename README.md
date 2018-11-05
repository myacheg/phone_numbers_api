# README


## Usage examples
to generate a new number:

```
/numbers/new.json?user_name=UserName
```

to get a custom number (if available, otherwise you get a regular number):

```
/numbers/new.json?user_name=UserName&number=111-222-3333
```

response example:

```
{
  user_name: "UserName",
  number: "111-222-3333"
}
```

## Tests

```
rspec spec
```

## What was used

```
Ruby 2.5.1, Rails 5.2, rspec, pry
```