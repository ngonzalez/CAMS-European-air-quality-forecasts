#!/usr/bin/env ruby

require 'fileutils'

require 'origami'
include Origami

DATA_PATH = "/data/netcdf"

class RotatePDF
  attr_accessor :import_files, :export_path
  def initialize(import_files: nil, export_path: nil)
    @import_files = import_files
    @export_path  = export_path
  end
  def create_folder
    FileUtils.mkdir_p(export_path)
  end
  def process_files
    Dir[import_files].each do |file|
      rotate_pages(file)
    end
  end
  private
  def rotate_pages(file)
    pdf = PDF.read file, lazy: true
    pdf.pages.each do |page|
      page.setRotate 90
    end
    pdf.save "/#{DATA_PATH}/pdf/%s" %
      file.split('/').last
  end
end

RotatePDF.new(
  export_path: "#{DATA_PATH}/pdf",
  import_files: "#{DATA_PATH}/*.pdf"
)

exit 0
