class AddVideoUrlToDistillery < ActiveRecord::Migration[5.1]
  def change
    add_column :distilleries, :youtube_video_url, :string
  end
end
