package Utils

import java.text.DateFormatSymbols
import kotlin.text.Regex

public  fun String?.getItalianFiscalCodeInfo() : String {

    var regEx : String = "^[A-Za-z]{6}[0-9]{2}[A-Za-z]{1}[0-9]{2}[A-Za-z]{1}[0-9]{3}[A-Za-z]{1}$"

    var fiscalCodePattern : Regex = Regex(regEx)

    if(this.isNullOrEmpty() || !this!!.matches(fiscalCodePattern))
        return "Invalid input data: $this"

    //Not in regular expression for language testing purpose only.
    var monthsMap: Array<Char> = arrayOf('A', 'B', 'C', 'D', 'E', 'H', 'L', 'M', 'P', 'R', 'S', 'T')
    var month : Char = this!!.filter { c -> c.isLetter() }.take(7).last()

    var monthOfBirthIndex : Int = monthsMap.indexOf(month)

    if( monthOfBirthIndex == -1)
        return "Invalid input data: $this"

    var dayOfBirth : Int = this.filter { c-> c.isDigit() }.take(4).takeLast(2).toInt()
    var sex : Char

    if(dayOfBirth > 40)
    {
        dayOfBirth -=40
        sex = 'F'
    }
    else
        sex = 'M'

    var monthOfBirth : String = DateFormatSymbols.getInstance().months[monthOfBirthIndex]
    var yearOfBirth : String = this.filter { c -> c.isDigit()}.take(2)

    return  "Date of Birth: $dayOfBirth-$monthOfBirth-$yearOfBirth " + System.lineSeparator() + "Sex: $sex"
}