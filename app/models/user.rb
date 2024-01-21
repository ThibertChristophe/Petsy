class User < ApplicationRecord
  attr_accessor :avatar_file

  has_secure_password
  has_secure_token :confirmation_token

  before_save :avatar_before_upload
  after_save :avatar_after_upload
  after_destroy_commit :avatar_destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :avatar_file, file: { ext: %i[jpg png] }

  def avatar_path
    # public/users/id/avatar.jpg
    File.join(Rails.public_path, self.class.name.downcase.pluralize, id.to_s, 'avatar.jpg')
  end

  # pour pouvoir l'image dans la view
  def avatar_url
    '/' + [
      self.class.name.downcase.pluralize,
      id.to_s,
      'avatar.jpg'
    ].join('/')
  end

  private

  # Enregistre physiquement le fichier et le resize
  def avatar_after_upload
    path = avatar_path
    return unless avatar_file.respond_to? :path

    dir = File.dirname path
    FileUtils.mkdir_p(dir) unless Dir.exist? dir
    # resize de l'image
    image = MiniMagick::Image.new(avatar_file.path) do |b|
      b.resize '150x150'
      b.gravity 'Center'
      b.crop '150x150+0+0'
    end
    image.format 'jpg'
    image.write path
  end

  # Set le boolean a true si on a bien placé un fichier
  def avatar_before_upload
    return unless avatar_file.respond_to? :path

    self.avatar = true
  end

  def avatar_destroy
    dir = File.dirname avatar_path
    FileUtils.rm_r dir if dir.exist? dir
  end
end
