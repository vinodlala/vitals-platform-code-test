require 'award'

BLUE_COMPARE = 'Blue Compare'
BLUE_DISTINCTION_PLUS = 'Blue Distinction Plus'
BLUE_FIRST = 'Blue First'
BLUE_STAR = 'Blue Star'

QUALITY_INCREASES = [BLUE_FIRST, BLUE_COMPARE]

QUALITY_INCREASES_BY_1 = [BLUE_FIRST]
QUALITY_IS_CONSTANT = [BLUE_DISTINCTION_PLUS]
QUALITY_DECREASES_BY_2 = [BLUE_STAR]

QUALITY_IS_ZERO_AFTER_EXPIRATION = [BLUE_COMPARE]

EXPIRES_IN_IS_CONSTANT = [BLUE_DISTINCTION_PLUS]

def update_quality(awards)

  awards.each do |award|
    case
      when QUALITY_INCREASES.include?(award.name)
        if award.quality < 50
          award.quality += 1
          if award.name == BLUE_COMPARE
            award.quality += 1 if award.quality < 50 && award.expires_in < 11
            award.quality += 1 if award.quality < 50 && award.expires_in < 6
          end
        end
      when QUALITY_IS_CONSTANT.include?(award.name)
        # do nothing
      when QUALITY_DECREASES_BY_2.include?(award.name)
        award.quality -= 2 if award.quality > 0
      else
        award.quality -= 1 if award.quality > 0
    end
    unless EXPIRES_IN_IS_CONSTANT.include?(award.name)
      award.expires_in -= 1
    end
    if award.expires_in < 0
      case
        when QUALITY_INCREASES_BY_1.include?(award.name)
          award.quality += 1 if award.quality < 50
        when QUALITY_IS_CONSTANT.include?(award.name)
          # do nothing
        when QUALITY_IS_ZERO_AFTER_EXPIRATION.include?(award.name)
          award.quality = 0
        when QUALITY_DECREASES_BY_2.include?(award.name)
          award.quality -= 2 if award.quality > 0
        else
          award.quality -= 1 if award.quality > 0
      end
    end
    award.quality = 0 if award.quality < 0
  end
end






def update_quality_old(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus' && award.name != 'Blue Star'
          award.quality -= 1
        else
          if award.name == 'Blue Star'
            award.quality -= 2
          end
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus' && award.name != 'Blue Star'
              award.quality -= 1
            else
              if award.name == 'Blue Star'
                award.quality -= 2
              end
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
