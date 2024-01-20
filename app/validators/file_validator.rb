class FileValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value
      if value.respond_to?(:path) && !(options[:ext].include? File.extname(value.path).delete('.').to_sym)
        record.errors[attribute] << "is not a file (#{options[:ext].join(',')}"
      end
    else
      record.errors[attribute] << 'is not a file'
    end
  end
end
