/**
  * Created by _x_ on 16/11/2015.
  * Testing purpose and self-explanatory code only.
  * Scala extension methods
  */

object MyExtensions {
  implicit class RichString(s: String) {
    def Tab = s.padTo(8,' ')
    def Tab(n: Int) = s.padTo(8*n,' ')
  }

  implicit class SQLString(var s: String) {

    val KeyWords :Array[String] =
      Array("SELECT","FROM","WHERE","BETWEEN","AND") //...

    //For each keywords applies the following:
    //<font color='blue'>KEY WORDS</font>
    def HTML():String =
    {
      KeyWords.map(kw => {s=s.replace(kw,"<font color='blue'>" + kw + "</font>")})
      return s
    }

  }

}
