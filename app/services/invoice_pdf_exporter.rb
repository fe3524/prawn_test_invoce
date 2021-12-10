require 'prawn'

class InvoicePdfExporter
  FONT_PATH = Rails.root + 'public/fonts/Honoka_Shin_Mincho_L.otf'

  def initialize
    # Prawnドキュメントを生成
    # ページサイズやマージンを指定
    Prawn::Document.generate(
      Rails.root + 'invoice.pdf',
      page_size: 'A4',
      top_margin: 35,
      bottom_margin: 35,
      left_margin: 35,
      right_margin: 35
    ) do |pdf|

      # フォントを指定しないと Prawn::Errors::IncompatibleStringEncoding 例外が発生する
      pdf.font FONT_PATH

      # 本文の生成
      self.create_contents pdf
    end

    def create_contents(doc)
      doc.text '請求書', size: 20, align: :center
  
      doc.bounding_box([0, 555], width: 310, height: 65) do
        doc.move_down 10
        doc.text "合計金額 11,000円", size: 16, align: :left
      end
  
      doc.bounding_box([320, 555], width: 310, height: 65) do
        doc.text "日付： 2020年10月01日", size: 12, align: :left
      end
  
      rows = [['詳細', '数量', '単価', '金額'], ['雑費', '1', '10000', '10000']]
  
      # tableメソッドでテーブルを生成する
      # rowsは多重配列
      # 多重配列でない場合 Prawn::Errors::InvalidTableData 例外が発生する
      doc.table(rows, column_widths: [370, 30, 60, 60], position: :center) do |table|
        # セルのサイズの指定
        table.cells.size = 10
  
        # 1行目のalignを真ん中寄せにしている
        table.row(0).align = :center
      end
  
      doc.bounding_box([373, 300], width: 150, height: 100) do
        doc.table [['小計', "11000円"], ['消費税', "1000円"], ['合計金額', "11000円"]], column_widths: [50, 100], position: :right do |table|
          table.cells.size = 10
        end
      end
    end
  end
end