# STUDY-GRAPHQL-RUBY

graphql-ruby: https://graphql-ruby.org/

tutorial: https://graphql-ruby.org/getting_started

## 導入

#### 1. Create new rails project

```
$ rails new study-graphql-ruby
```

#### 2. Edit Gemfile (add graphql package)

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

#### 3. Generate graphql-ruby boilerplate

On Rails, you can get started with a few GraphQL generators:

(Add graphql-ruby boilerplate and mount graphiql in development)
```
$ rails g graphql:install
$ bundle install    # <- Gemfile が更新されるので、もう一度 bundle install しておく 
```

```
app/graphql
├── study_graphql_ruby_schema.rb
├── mutations
└── types
    ├── mutation_type.rb
    └── query_type.rb
```

ここでいちど、動作確認。

```
$ rails s
```

http://localhost:3000/graphiql で GraphiQL のコンソールが開くので、以下の qeury を実行。

```
{
  testField
}
```

以下のレスポンスが返ってくる。

```
{
  "data": {
    "testField": "Hello World!"
  }
}
```

## Object Type の追加

#### User モデルを作成し、rake db:migrate を流す。

```
$ rails g model User first_name:string last_name:string email:string
$ rake db:migrate
```

#### Queryでデータを取得できる事を確認するため、 rails console を使用して事前にデータを作成。

```
$ rails c
$ User.create(email:"hoge@email.com", first_name: "hoge", last_name:"fuga")
$ User.create(email:"po@email.com", first_name: "po", last_name:"va")
```

#### GraphQL の User Type を作成

```
$ rails g graphql:object User id:ID! first_name:String! last_name:String! email:String!
```

#### Query のスキーマに resolver を定義

（Class Based Syntax で書く https://graphql-ruby.org/schema/class_based_api.html#classes）

``` types/query_type.rb
module Types
  class QueryType < Types::BaseObject

    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :user, Types::UserType, null: true do
      description "Find a user by ID"
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

  end
end

```
