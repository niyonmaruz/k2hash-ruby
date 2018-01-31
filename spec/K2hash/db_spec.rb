require "spec_helper"
require "fileutils"

RSpec.describe K2hash::Db do

  before :all do
    FileUtils.rm_rf(__dir__ + "/../../tmp")
    FileUtils.mkdir_p(__dir__ + "/../../tmp")
  end

  let(:db) { K2hash::Db.new }

  describe "db open" do

    let(:file) { __dir__ + "/../../tmp" + "/dbopen.k2h" }

    context "readonly mode" do
      it "got handle" do
        expect(db.open(file, "r", true)).to eq(true)
      end
    end
    context "read/write mode" do
      it "got handle" do
        expect(db.open(file, "w", true)).to eq(true)
      end
    end
    context "memory mode" do
      it "got handle" do
        expect(db.open(nil, "w", true)).to eq(true)
      end
    end
  end

  describe "db close" do

    let(:file) { __dir__ + "/../../tmp" + "/dbclose.k2h" }

    before do
      db.open(file, "w", true)
    end
    it "success" do
      expect(db.close).to eq(true)
    end
  end

  describe "set_str_value" do

    let(:file) { __dir__ + "/../../tmp" + "/setstrvalue.k2h" }

    before do
      db.open(file, "w", true)
    end
    context "string key value" do
      it "get true" do
        expect(db.set_str_value("foo", "bar")).to eq(true)
      end
    end
    context "invalid key value" do
      it "get false" do
        expect(db.set_str_value(4, "bar")).to eq(false)
        expect(db.set_str_value("foo", 8)).to eq(false)
      end
    end
  end

  describe "get_str_direct_value" do

    let(:file) { __dir__ + "/../../tmp" + "/getstrdirectvalue.k2h" }

    before do
      db.open(file, "w", true)
      db.set_str_value("key01", "value01")
    end
    context "exists key" do
      it "get value" do
        expect(db.get_str_direct_value("key01")).to eq("value01")
      end
    end
    context "not exitsts key" do
      it "not get value" do
        expect(db.get_str_direct_value("key02")).to eq(nil)
      end
    end
  end

end
