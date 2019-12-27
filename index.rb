require 'nokogiri'
require 'open-uri'

    puts "Enter search keywords seperated by spaces"  
    STDOUT.flush  
    answer = gets.chomp
    a = answer.split(' ')
    b = answer.split(' ')

    a.each do |word|
        word.capitalize!
    end

    b.map! do |word|
        word[0].downcase + word[1..-1]
    end

    keywords = a + b

    puts '------'
    puts

    twitter = [
        'realDonaldTrump',
        'BorisJohnson',
        'JustinTrudeau',
        'scottmorrisonmp',
        'HillaryClinton',
        'BillClinton',
        'BarackObama',
        'MichelleObama'
    ]

    def parse(keywords, account)    
        content = []
        doc = Nokogiri::HTML(open('https://twitter.com/'+account))
        doc.css('p.tweet-text').each do |link|
            content << link.content
        end
        content.each do |text|
            words = text.split
            if  (words & keywords).length > 0 then
                puts "#{account}  --  #{text}"
                puts
            end 
        end
    end

    twitter.each do |account|
        parse(keywords, account)
    end