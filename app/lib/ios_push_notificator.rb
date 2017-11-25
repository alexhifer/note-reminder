class IosPushNotificator
  CONFIG_PATH = 'config/grocer.yml'.freeze
  CERTIFICATIONS_FOLDER = 'config/certifications'.freeze

  attr_reader :config
  attr_reader :pusher

  def initialize
    load_config

    @pusher = Grocer.pusher(
      certificate: Rails.root.join(CERTIFICATIONS_FOLDER, config['certificate']).to_s,
      passphrase: config['passphrase'],
      gateway: config['gateway'],
      port: config['port'],
      retries: config['retries']
    )
  end

  # @param device_token [String]
  # @param message [String]
  # @return [Integer] is the number of bytes sent successfully
  def notify(device_token, message)
    notification = Grocer::Notification.new(device_token: device_token, alert: message)
    pusher.push(notification)
  end

  private

  def load_config
    @config = YAML.load(File.read(Rails.root.join(CONFIG_PATH))).with_indifferent_access
  end
end
