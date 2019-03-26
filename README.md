# STUDY-GRAPHQL-RUBY

see https://graphql-ruby.org/getting_started

### 1. Create new rails project

```
$ rails new study-graphql-ruby
```

### 2. Edit Gemfile (add graphql package)

You can install graphql from RubyGems by adding to your application’s Gemfile:

```
gem "graphql"
```

- sqlite のバージョンを指定しないとエラーになる。 https://qiita.com/Kta-M/items/254a1ba141827a989cb7


```
# gem 'sqlite3' # このままだとエラー
gem 'sqlite3', '~> 1.3.6'
```

Then, running bundle install:

```
$ bundle install
```

### 3. Generate graphql-ruby boilerplate

On Rails, you can get started with a few GraphQL generators:

(Add graphql-ruby boilerplate and mount graphiql in development)
```
$ rails g graphql:install
$ bundle install    # <- Gemfile が更新されるので、もう一度 bundle install しておく 
```

```
app/graphql
├── graphql_ruby_demo_schema.rb
├── mutations
└── types
    ├── mutation_type.rb
    └── query_type.rb
```