module DownloadsHelper
  def bytesToSize(bytes)
    sizes = ['B', 'KB', 'MB', 'GB', 'TB']
    return '0 B' if(bytes == 0)
    i = ((Math.log(bytes) / Math.log(1000)).floor)
    return ((bytes.to_f / (1000**i)).round(1).to_s + ' ' + sizes[i])
  end
end
