module VCAP::CloudController
  module Diego
    module Traditional
      class LifecycleData
        attr_accessor :app_bits_download_uri, :build_artifacts_cache_download_uri
        attr_accessor :build_artifacts_cache_upload_uri, :buildpacks, :droplet_upload_uri

        def message
          message = {
              app_bits_download_uri: app_bits_download_uri,
              build_artifacts_cache_upload_uri: build_artifacts_cache_upload_uri,
              droplet_upload_uri: droplet_upload_uri,
              buildpacks: buildpacks,
          }
          if build_artifacts_cache_download_uri
            message[:build_artifacts_cache_download_uri] = build_artifacts_cache_download_uri
          end

          schema.validate(message)
          message
        end

        private

        def schema
          @schema ||= Membrane::SchemaParser.parse do
            {
              app_bits_download_uri: String,
              optional(:build_artifacts_cache_download_uri) => String,
              build_artifacts_cache_upload_uri: String,
              droplet_upload_uri: String,
              buildpacks: Array,
            }
          end
        end
      end
    end
  end
end
