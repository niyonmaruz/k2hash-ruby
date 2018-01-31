require "k2hash/version"
require "k2hash/k2hash"
require "k2hash/db"

module K2hash
#class K2hash

  def self.open(path=nil, mode="r", fullmap=true, maskbitcnt=8, cmaskbitcnt=4, maxelementcnt=32, pagesize=128)
    # memory is used when path.nil? is true
    db = Db.new()

    unless block_given?
      return _open(db, path, mode, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
    end

    begin
      instance = yield _open(db, path, mode, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
    ensure
      response_close = _close(db)
      raise Error, "close error" if response_close == 0
    end 
    instance
  end

  def self.close(instance)
    instance.close()
  end

  def self._open(db, path, mode, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
    raise "db open error" if !db.open(path, mode, fullmap, maskbitcnt, cmaskbitcnt, maxelementcnt, pagesize)
    db 
  end

  def self._close(db)
    db.close()
  end

end
