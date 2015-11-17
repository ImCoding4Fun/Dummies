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
}
