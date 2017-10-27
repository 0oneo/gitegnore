require 'spec_helper'

module Gitegnore
  describe Gitegnore do
    it "should return list of all supported languages" do
      supported_languages = Gitegnore.languages()
      supported_languages.should_not be_nil
    end
  end
end
