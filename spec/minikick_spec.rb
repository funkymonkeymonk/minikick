require 'rspec'
require 'minikick'

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

describe Minikick do
  describe "#project" do
    let(:output) { capture(:stdout) { subject.project project_name, target_amount } }

    context "when project name and backing amount is valid" do
      let(:project_name) { "Test_proj-ect" }
      let(:target_amount) { 1000.25 }
      it 'returns a success message' do
        expect(output).to eq("That's NUMBERWANG")
      end
    end
  end
end
