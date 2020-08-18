require 'spec_helper'

platforms = %w(debian ubuntu centos)
platforms.each do |platform|
  describe "grafana_ on #{platform}" do
    step_into :grafana_config, :grafana_install, :grafana_config_enterprise, :grafana_config_server, :grafana_config_writer
    platform platform

    context 'create config with enterprise license key' do
      recipe do
        grafana_install 'package'

        grafana_config 'config' do
        end

        grafana_config_enterprise 'config' do
          license_path 'license.txt'
        end

        grafana_config_writer 'config' do
        end
      end

      it('should render config file') do
        is_expected.to render_file('/etc/grafana/grafana.ini').with_content(/license.txt/)
      end
    end

    context 'create config without serve from sub path as default' do
      recipe do
        grafana_install 'package'

        grafana_config 'config' do
        end

        grafana_config_writer 'config' do
        end
      end

      it('should not contain serve_from_sub_path by default') do
        is_expected.not_to render_file('/etc/grafana/grafana.ini').with_content(/serve_from_sub_path/)
      end
    end

    context 'create config with server from sub path' do
      recipe do
        grafana_install 'package'

        grafana_config 'config' do
        end

        grafana_config_server 'config' do
          serve_from_sub_path true
        end

        grafana_config_writer 'config' do
        end
      end

      it('should contain serve_from_sub_path') do
        is_expected.to render_file('/etc/grafana/grafana.ini').with_content(/serve_from_sub_path/)
      end
    end

    context 'do not enable grafana service' do
      recipe do
        grafana_config 'config' do
        end

        grafana_config_writer 'config' do
          service_enable false
        end
      end

      it('should not enable service') do
        is_expected.to_not enable_service('grafana-server')
      end
    end

    context 'default grafana service enabled' do
      recipe do
        grafana_config 'config' do
        end

        grafana_config_writer 'config' do
        end
      end

      it('should enable service') do
        is_expected.to enable_service('grafana-server')
      end
    end
  end
end