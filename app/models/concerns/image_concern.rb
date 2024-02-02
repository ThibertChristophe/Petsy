module ImageConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def has_image(_field, _options = {})
      attr_accessor "#{_field}_file".to_sym

      validates "#{_field}_file".to_sym, file: { ext: %i[jpg] }
      before_save "#{_field}_before_upload".to_sym
      after_save "#{_field}_after_upload".to_sym
      after_destroy_commit "#{_field}_destroy".to_sym

      class_eval <<-METHODS, __FILE__, __LINE__ + 1
      def #{_field}_url
       '/' + [
         self.class.name.downcase.pluralize,
         id.to_s,
         '#{_field}.jpg'
       ].join('/')
      end

     def #{_field}_path
       # public/users/id/avatar.jpg
       File.join(Rails.public_path, self.class.name.downcase.pluralize, id.to_s, '#{_field}.jpg')
     end

     private

     # Enregistre physiquement le fichier et le resize
     def #{_field}_after_upload
       path = #{_field}_path
       if #{_field}_file.respond_to? :path

      dir = File.dirname path
       FileUtils.mkdir_p(dir) unless Dir.exist? dir
       # resize de l'image
       image = MiniMagick::Image.new(#{_field}_file.path) do |b|
         b.resize '150x150^'
         b.gravity 'Center'
         b.crop '150x150+0+0'
       end
       image.format 'jpg'
       image.write path
      end
     end

    # Set le boolean a true si on a bien placé un fichier
    def #{_field}_before_upload
      if #{_field}_file.respond_to?(:path) and self.respond_to?(:#{_field})
       self.#{_field} = true
      end
     end

    def #{_field}_destroy
      dir = File.dirname #{_field}_path
      FileUtils.rm_r dir if dir.exist? dir
    end
      METHODS
    end
  end
end
