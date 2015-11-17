/**
  * Created by _x_ on 16/11/2015.
  * Testing purpose and self-explanatory code only
  */

import MyExtensions.RichString

object HelloScalaWorld
{
  def main(args: Array[String]) {

    //Testing purpose and self-explanatory code only
    //_+_ = syntactic sugar for: (a1:String,a2:String) => a1+a2
    val commaSeparatedArgs : String = (for(i <- args)  yield i+",").reduce(_+_).dropRight(1)
    println("args".Tab(3)+ commaSeparatedArgs)

    val anotherCommaSeparatedArgs : String = args.reduce(getCommaSeparated)
    println("the same args".Tab(3)+ anotherCommaSeparatedArgs)

    val yetAnotherCommaSeparatedArgs: String = args.reduce((a1:String,a2:String) => a1+","+a2)
    println("always the same args".Tab(3)+ yetAnotherCommaSeparatedArgs)
  }

  def getCommaSeparated(s1:String,s2:String ): String =
  {
    return s1 + "," + s2
  }

}
