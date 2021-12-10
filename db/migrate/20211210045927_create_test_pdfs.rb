class CreateTestPdfs < ActiveRecord::Migration[6.1]
  def change
    create_table :test_pdfs do |t|

      t.timestamps
    end
  end
end
