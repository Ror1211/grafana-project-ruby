[back to resource list](https://github.com/sous-chefs/grafana#resources)

---

# grafana_config_metrics

Configures the core metrics section of the configuration <http://docs.grafana.org/installation/configuration/#metrics>

Introduced: v4.0.0

## Actions

`:create`

## Properties

| Name                      | Type          |  Default                          | Description                                                               | Allowed Values
| ------------------------- | ------------- | --------------------------------- | ------------------------------------------------------------------------- | --------------- |
| `enabled`                 | true, false   | `true`                            | Enable metrics reporting                                                  | true, false
| `basic_auth_username`     | String        |                                   | If set configures the username to use for basic authentication on the metrics endpoint.|
| `basic_auth_password`     | String        |                                   | If set configures the password to use for basic authentication on the metrics endpoint.|
| `interval_seconds`        | Integer       | `10`                              | Flush/Write interval when sending metrics to external TSDB. Defaults to 10s.|
| `graphite_address`        | String        |                                   | Format Hostname or ip:port                                                |
| `graphite_prefix`         | String        | `prod.grafana.%(instance_name)s.` | Graphite metric prefix                                                    |

## Examples

```ruby
grafana_config_metrics 'grafana'
```

```ruby
grafana_config_metrics 'grafana' do
  basic_auth_username 'grafana_user'
  basic_auth_password 'MySuperSecretPassword'
  graphite_address '127.0.0.1:8080'
end
```
