# Wootric API Ruby Client

Unofficial Ruby client for the [Wootric API](https://github.com/wootric/knowledge-base/wiki/API-for-export-CSV,-JSON).

## Installation

Add `gem 'wootric'` to your application's Gemfile, and then run `bundle` to install.

## Configuration

To get started, you need to configure the client with your secret API key. If you're using Rails, you should add the following to new initializer file in `config/initializers/wootric.rb`.

```ruby
require 'wootric'
Wootric.api_key = 'YOUR_API_KEY'
```

For further options, read the [advanced configuration section](#advanced-configuration).

**Note:** Your API key is secret, and you should treat it like a password. You can find your API key in your Wootric account, under *Settings* > *Integrations* > *API Keys*.


Retrieving a survey response:

```ruby
# Retrieve an existing survey response
survey_response3 = Wootric::SurveyResponse.retrieve('123')
```

Listing survey responses:

```ruby
# List all survey responses
survey_responses = Wootric::SurveyResponse.all({
  created: {
    gte: 1.day.ago.to_i
  },
  page: 3,
  per_page: 50
})
```

## <a name="advanced-configuration"></a> Advanced configuration & testing

The following options are configurable for the client:

```ruby
Wootric.api_key
Wootric.app_id
Wootric.http_adapter # default: Wootric::HTTPAdapter.new
```

By default, a shared instance of `Wootric::Client` is created lazily in `Wootric.shared_client`. If you want to create your own client, perhaps for test or if you have multiple API keys, you can:

```ruby
# Create an custom client instance, and pass as last argument to resource actions
client = Wootric::Client.new(:api_key => 'API_KEY',
  :api_base_url => 'https://api.wootric.com/v1',
  :http_adapter => Wootric::HTTPAdapter.new)
metrics_from_custom_client = Wootric::SurveyResponse.retrieve({}, client)

# Or, you can set Wootric.shared_client yourself
Wootric.shared_client = Wootric::Client.new(:api_key => 'API_KEY',
  :api_base_url => 'https://api.wootric.com/v1',
  :http_adapter => Wootric::HTTPAdapter.new)
metrics_from_custom_shared_client = Wootric::SurveyResponse.retrieve
```

## Supported runtimes

- Ruby MRI (1.8.7+)
- JRuby (1.8 + 1.9 modes)
- RBX (2.1.1)
- REE (1.8.7-2012.02)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run the tests (`rake test`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
