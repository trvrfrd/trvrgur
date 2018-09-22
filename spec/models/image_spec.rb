require "rails_helper"

RSpec.describe Image do
  let(:file) { File.new("#{Rails.root}/spec/fixtures/files/image.png") }

  it "doesn't explode when instantiated without params" do
    expect { Image.new }.not_to raise_exception
  end

  it "doesn't explode when instantiated with a file: param" do
    expect { Image.new(file: file) }.not_to raise_exception
  end

  # I don't remember what error this was testing for and I think the mock
  # makes it not test for it anymore but I'm leaving it until I write good tests
  it "doesn't explode when saved" do
    allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
    expect { Image.new(file: file).save }.not_to raise_exception
  end
end
