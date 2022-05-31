# Pet Aggregator test automation suite

Automation tests ensure that the service works as expected

## Installation

Clone repository:

```ruby
git clone https://github.com/rmarunchak/pets
```

And then execute:

    $ bundle install

## Usage

    $ Rspec

## Descripton

`cat_id` - returns cats offers , **with {"kind": "cat"} param**

`dog_id` - returns dogs offers , **with {"kind": "cat"} param**

`nil_id` - returns cats and dogs offers **with {"kind": "cat"} {"kind": "dog} params**

`Endpoint supports the following parameters:`

`sort_by` - supports sorting by price

`direction` - supports asc or desc

`price_lt` - price lesser than N

`price_gt` - price greater than N

## Code of Conduct

Everyone interacting in the Matic project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/matic/blob/master/CODE_OF_CONDUCT.md).
