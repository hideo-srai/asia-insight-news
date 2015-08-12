class HTMLUtils
  def self.decode_special_chars(string)
    return string unless string.include? '&'
    enc = string.encoding

    asciicompat = Encoding.compatible?(string, "a")
    string.gsub(/&(apos|amp|quot|gt|lt|lsquo|rsquo|sbquo|ldquo|rdquo|bdquo|nbsp|trade|lsaquo|rsaquo|cent|pound|yen|euro|laquo|raquo|mdash|dash|\#[0-9]+|\#[xX][0-9A-Fa-f]+);/) do
      match = $1.dup
      case match
        when 'apos'                then "'"
        when 'amp'                 then '&'
        when 'quot'                then '"'
        when 'gt'                  then '>'
        when 'lt'                  then '<'

        when 'lsquo'               then '‘'
        when 'rsquo'               then '’'
        when 'sbquo'               then '‚'
        when 'ldquo'               then '“'
        when 'rdquo'               then '”'
        when 'bdquo'               then '„'
        when 'nbsp'                then ' '
        when 'trade'               then '™'
        when 'lsaquo'              then '‹'
        when 'rsaquo'              then '›'
        when 'cent'                then '¢'
        when 'pound'               then '£'
        when 'yen'                 then '¥'
        when 'euro'                then '€'
        when 'raquo'               then '»'
        when 'laquo'               then '«'
        when 'mdash'               then '–'
        when 'dash'                then '-'

        when /\A#0*(\d+)\z/
          n = $1.to_i
          if enc == Encoding::UTF_8 or
            enc == Encoding::ISO_8859_1 && n < 256 or
            asciicompat && n < 128
            n.chr(enc)
          else
            "&##{$1};"
          end
        when /\A#x([0-9a-f]+)\z/i
          n = $1.hex
          if enc == Encoding::UTF_8 or
            enc == Encoding::ISO_8859_1 && n < 256 or
            asciicompat && n < 128
            n.chr(enc)
          else
            "&#x#{$1};"
          end
        else
          "&#{match};"
      end
    end
  end
end