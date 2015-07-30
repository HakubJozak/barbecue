class Barbecue::UploadsController < Barbecue::ApplicationController

  def show
    @expires = Time.now.utc + 10.hour
    filename = upload_params[:name].parameterize
    today = Date.today
    uuid = SecureRandom.uuid

    @key = "#{Rails.env}/#{type}/source/#{ today.year }/#{ today.month }/#{ today.day }/#{ uuid }/#{ filename }"

    render json: {
      acl: 'public-read',
      awsaccesskeyid: ENV['AWS_ACCESS_KEY_ID'],
      bucket: ENV['S3_BUCKET_NAME'],
      expires: @expires,
      key: @key,
      policy: s3_policy,
      signature: s3_bucket_signature,
      success_action_status: '201',
      'Content-Type' => filetype,
      'Cache-Control' => 'max-age=630720000, public'
    }, status: :ok
  end

  private

  def filetype
    raise ArgumentError unless upload_params[:type].present?
    upload_params[:type]
  end

  def type
    type = case filetype
           when %r{\Avideo/.*\z} then 'video'
           when %r{\Aimage/.*\z} then 'image'
           else 'document'
           end
  end

  def s3_bucket_signature
    Base64.strict_encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha1'),
        aws_secret_access_key,
        s3_policy
      )
    )
  end

  def s3_policy
    @s3_policy ||= Base64.strict_encode64(
      {
        expiration: @expires,
        conditions: [
          { bucket: s3_bucket_name },
          { acl: 'public-read' },
          { expires: @expires },
          { success_action_status: '201' },
          [ 'starts-with', '$key', "#{Rails.env}/" ],
          [ 'starts-with', '$Content-Type', "#{type}/" ],
          [ 'starts-with', '$Cache-Control', '' ],
          [ 'content-length-range', 0, 524288000 ]
        ]
      }.to_json
    )
  end

  def upload_params
    params.permit(:type,:name,:size)
  end

  def aws_secret_access_key
    require_env('AWS_SECRET_ACCESS_KEY')
  end

  def s3_bucket_name
    require_env('S3_BUCKET_NAME')
  end

  def require_env(key)
    if value = ENV[key]
      value
    else
      raise "Missing #{key} environment variable"
    end
  end

end
