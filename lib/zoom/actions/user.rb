# frozen_string_literal: true

module Zoom
  module Actions
    module User
      def user_list(*args)
        options = Utils.extract_options!(args)
        Utils.permit_params(%i[status page_size page_number], options)
        Utils.parse_response self.class.get('/users', query: options.merge(access_token: access_token))
      end

      def user_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[email type first_name last_name password], options)
        Utils.parse_response self.class.post('/users', body: { action: 'create', user_info: options }, query: { access_token: access_token }))
      end

      def user_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.permit_params(%i[id login_type], options)
        Utils.parse_response self.class.get("/users/#{options[:id]}", query: options.merge(access_token: access_token))
      end

      def user_update(*args)
        options = Utils.extract_options!(args)
        Utils.permit_params(%i[first_name last_name type pmi timezone dept vanity_name host_key cms_user_id], options)
        Utils.parse_response self.class.patch('/users', body: options, query: { access_token: access_token })
      end

      def user_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.permit_params(%i[action transfer_email transfer_meeting transfer_webinar transfer_recording], options)
        Utils.parse_response self.class.delete("/users/#{options.slice!(:id)}", query: options.merge(access_token: access_token))
      end

      def user_assistants_list(*args)
        # TODO: implement user_assistants_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_assistants_list is not yet implemented'
      end

      def user_assistants_create(*args)
        # TODO: implement user_assistants_create
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_assistants_create is not yet implemented'
      end

      def user_assistants_delete_all(*args)
        # TODO: implement user_assistants_delete_all
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_assistants_delete_all is not yet implemented'
      end

      def user_assistants_delete(*args)
        # TODO: implement user_assistants_delete
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_assistants_delete is not yet implemented'
      end

      def user_schedulers_list(*args)
        # TODO: implement user_schedulers_list
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_schedulers_list is not yet implemented'
      end

      def user_schedulers_delete_all(*args)
        # TODO: implement user_schedulers_delete_all
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_schedulers_delete_all is not yet implemented'
      end

      def user_schedulers_delete(*args)
        # TODO: implement user_schedulers_delete
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_schedulers_delete is not yet implemented'
      end

      def user_upload_picture(*args)
        # TODO: implement user_upload_picture
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_upload_picture is not yet implemented'
      end

      def user_settings_get(*args)
        # TODO: implement user_settings_get
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_settings_get is not yet implemented'
      end

      def user_settings_update(*args)
        # TODO: implement user_settings_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_settings_update is not yet implemented'
      end

      def user_status_update(*args)
        # TODO: implement user_status_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_status_update is not yet implemented'
      end

      def user_password_update(*args)
        # TODO: implement user_password_update
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_password_update is not yet implemented'
      end

      def user_permissions_get(*args)
        # TODO: implement user_permissions_get
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_permissions_get is not yet implemented'
      end

      def user_token_get(*args)
        # TODO: implement user_token_get
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_token_get is not yet implemented'
      end

      def user_token_delete(*args)
        # TODO: implement user_token_delete
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_token_delete is not yet implemented'
      end

      def user_email_check(*args)
        # TODO: implement user_email_check
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_email_check is not yet implemented'
      end

      def user_vanity_name_check(*args)
        # TODO: implement user_vanity_name_check
        # options = Utils.extract_options!(args)
        raise Zoom::NotImplemented, 'user_vanity_name_check is not yet implemented'
      end

      Utils.define_bang_methods(self)
    end
  end
end