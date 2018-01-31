require "k2hash/version"
#require "/tmp/work/k2hash-ruby/ext/k2hash/k2hash"
require "k2hash/k2hash"

module K2hash
#class K2hash
  #
  # K2hash::Db
  #
  class Db

    def initialize()
      @handle = nil
    end

    def open(path=nil, mode="r", fullmap=true, maskbitcnt=8, cmaskbitcnt=4, maxelementcnt=32, pagesize=128)
      if !path.nil? && mode == "w" && !File.exist?(path)
        return false if !K2hash::k2h_create(path, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
      end

      @handle = if mode == "r" && !path.nil?
                  K2hash::k2h_open_ro(path, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
                elsif mode == "w" && !path.nil?
                  K2hash::k2h_open_rw(path, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
                elsif (mode == "r" || mode == "w") && path.nil?
                  K2hash::k2h_open_mem(maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
                end
      return false if @handle.nil?
      true
    end

    def close
      return false if !K2hash::k2h_close(@handle)
      true
    end

    def set_str_value(key, val)
      return false if !key.is_a?(String) || !val.is_a?(String)
      K2hash::k2h_set_str_value(@handle, key, val)
    end

    def get_str_direct_value(key)
      return nil if !key.is_a?(String)
      val = K2hash::k2h_get_str_direct_value(@handle, key)
      return nil if val.nil?
      val.to_s
    end

    def add_str_subkey(key, subkey, val)
      return false if !key.is_a?(String) || !subkey.is_a?(String) || !val.is_a?(String)
      K2hash::k2h_add_str_subkey(@handle, key, subkey, val)
    end

    def get_str_direct_subkeys(key)
      return false if !key.is_a?(String)
      K2hash::k2h_get_str_direct_subkeys(@handle, key)
    end

  end
end
