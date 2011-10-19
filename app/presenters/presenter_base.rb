class PresenterBase
  
  def initialize(params=nil)
    params.each_pair do |attribute, value|
      self.send :"#{attribute}=", value
    end unless params.nil?
  end
  
  def method_missing(model_attribute, *args)
    model, *method_name = model_attribute.to_s.split("_")
    super unless self.respond_to? model.to_sym
    self.send(model.to_sym).send(method_name.join("_").to_sym, *args)
  end
  
end
