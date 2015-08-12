class AddDefaultCentralBanks < ActiveRecord::Migration
  def up
    ['People\'s Bank of China', 'Bank of Japan', 'Reserve Bank of India', 'Reserve Bank of Australia',
     'Reserve Bank of New Zealand', 'Bank of Korea', 'Bank Indonesia', 'Monetary Authority of Singapore',
     'Bank Negara Malaysia', 'Central Bank of the Republic of China (Taiwan)', 'Bank of Thailand',
     'Bangko Sentral ng Pilipinas', 'State Bank of Vietnam'].each do |name|
      bank = CentralBank.new(bank_name: name)
      bank.save(validate: false)
    end
  end

  def down
    CentralBank.destroy_all
  end
end
