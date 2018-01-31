require "spec_helper"
require "fileutils"

RSpec.describe K2hash do

  before :all do
    FileUtils.rm_rf(__dir__ + "/../tmp")
    FileUtils.mkdir_p(__dir__ + "/../tmp")
  end

  describe "Version" do
    it "has version number" do
      expect(K2hash::VERSION).not_to be nil
    end
  end

  describe "Open" do

    let(:file) { __dir__ + "/../tmp" + "/open.k2h" }

    context "db open with block" do
      it "get file handle" do
        K2hash.open(file, "w", true, 8, 4, 32, 128) do |db|
          expect(db).not_to be nil
        end
      end
    end
    context "db open with block (omit parameters)" do
      it "get file handle" do
        K2hash.open(file) do |db|
          expect(db).not_to be nil
        end
      end
    end
    context "db open with block (memory)" do
      it "get file handle" do
        K2hash.open("") do |db|
          expect(db).not_to be nil
        end
      end
    end
    context "db open without block" do
      it "return handle" do
        expect(K2hash.open(file)).to be_a(K2hash::Db)
      end
    end
  end


  describe "Write,Read value" do

    let(:file) { __dir__ + "/../tmp" + "/wrvalue.k2h" }

    context "write by set_str_value()" do
      it "get true" do
        K2hash.open(file, "w") do |db|
          expect(db.set_str_value("mykey", "myval")).to eq(true)
        end
      end
    end

    context "read by get_str_direct_value()" do
      it "get expected value" do
        K2hash.open(file, "r") do |db|
          value = db.get_str_direct_value("mykey")
          expect("myval").to eq(value)
        end
      end
    end

  end

  describe "Write,Read subkeys" do

    let(:file) { __dir__ + "/../tmp" + "/wrsubkeys.k2h" }

    context "write by add_str_subkey()" do
      it "get true" do
        K2hash.open(file, "w") do |db|
          expect(db.add_str_subkey("add_str_subkey", "add_str_subkey", "add_str_subkey")).to eq(true)
        end
      end
    end

    context "read by get_str_direct_subkeys()" do
      it "get expected value" do
        K2hash.open(file, "r") do |db|
          key = "add_str_subkey"
          value = db.get_str_direct_subkeys(key)
          value.each {|subkey|
            expect("add_str_subkey").to eq(subkey)
          }
        end
      end
    end

  end



end
