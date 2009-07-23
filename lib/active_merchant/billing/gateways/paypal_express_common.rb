module ActiveMerchant
  module Billing
    module PaypalExpressCommon
      def self.included(base)
        base.cattr_accessor :test_redirect_url
        base.cattr_accessor :test_redirect_giropay_url
        base.cattr_accessor :live_redirect_url
        base.cattr_accessor :live_redirect_giropay_url
        base.live_redirect_url = 'https://www.paypal.com/cgibin/webscr?cmd=_express-checkout&token='
        base.live_redirect_giropay_url = 'https://www.paypal.com/webscr?cmd=_complete-express-checkout&token='
      end

      def redirect_url(options)
        if test?
          options[:giropay_url] ? test_redirect_giropay_url : test_redirect_url
        else
          options[:giropay_url] ? live_redirect_giropay_url : live_redirect_url
        end
      end

      def redirect_url_for(token, options = {})
        options = {:review => true, :giropay_url => false}.update(options)
        options[:review] ? "#{redirect_url(options)}#{token}" : "#{redirect_url(options)}#{token}&useraction=commit"
      end
    end
  end
end
