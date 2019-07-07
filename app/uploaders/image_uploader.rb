class ImageUploader < CarrierWave::Uploader::Base

  # MiniMagickを使用
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # fogはAWSなどのグラウド用？
  # storage :fog

  # jpegファイルに変換保存
  process convert: 'jpg'

  # 保存ディレクトリ
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロードできるファイルを制限
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # 縦横比を維持したまま400x400にリサイズする
  process resize_to_fit: [400, 400]

  # 変換したファイルのファイル名の規則
  def filename
    "#{secure_token}.jpg" if original_filename.present?
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  protected
  #一意のファイル名を作成
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
