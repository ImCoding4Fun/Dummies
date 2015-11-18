/**
  * Created by _x_ on 16/11/2015.
  * Testing purpose and self-explanatory code only
  */

import MyExtensions.RichString
import MyExtensions.SQLString
object HelloScalaWorld
{
  def main(args: Array[String]) {

    //Testing purpose and self-explanatory code only
    //_+_ = syntactic sugar for: (a1:String,a2:String) => a1+a2
    val commaSeparatedArgs : String = (for(i <- args)  yield i+ ",").reduce(_+_).dropRight(1)
    println("args".Tab(3)+ commaSeparatedArgs)

    val anotherCommaSeparatedArgs : String = args.reduce(getCommaSeparated)
    println("the same args".Tab(3)+ anotherCommaSeparatedArgs)

    val yetAnotherCommaSeparatedArgs: String = args.reduce((a1:String,a2:String) => a1+","+a2)
    println("always the same args".Tab(3)+ yetAnotherCommaSeparatedArgs)

    var query = ""
    query ="SELECT ID_TABLE, NAME, DESC FROM TABLE WHERE ID_TABLE BETWEEN 30 AND 100"

    println(query.HTML)

  }

  def getCommaSeparated(s1:String,s2:String ): String = s1 + "," + s2

}
