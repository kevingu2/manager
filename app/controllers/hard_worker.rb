class HardWorker
  include Sidekiq::Worker

  def perform(excelFileName, arg)
    print "Z"*30, excelFileName
    puts `python bin/cellEditor.py "#{excelFileName}" "#{arg}"`
  end
end
