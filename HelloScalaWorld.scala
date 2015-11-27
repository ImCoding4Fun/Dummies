/**
  * Created by _x_ on 16/11/2015.
  * Testing purpose and self-explanatory code only
  */

package dummies

import MyExtensions._
import MyUtils._

object HelloScalaWorld
{
  def main(args: Array[String]) {
      
    firstDummies(args);
  }
  
  def firstDummies(args: Array[String])=
  {
    //Testing purpose and self-explanatory code only
    //_+_ = syntactic sugar for: (a1:String,a2:String) => a1+a2 => reduce using the operator "+" as input function
    val commaSeparatedArgs : String = (for(i <- args)  yield i+ ", ").reduce(_+_).dropRight(2)
    val anotherCommaSeparatedArgs : String = args.reduce(getCommaSeparated)
    val yetAnotherCommaSeparatedArgs: String = args.reduce((a1:String,a2:String) => a1+", "+a2)
    val ultimateCommaSeparatedArgs = args.deep.mkString(", ")
    
    //screen output
    println("args".tab(3)+ commaSeparatedArgs)
    println("always the same args".tab(3)+ yetAnotherCommaSeparatedArgs)
    println("Here we go again...".tab(3)+ ultimateCommaSeparatedArgs)
    println("the same args".tab(3)+ anotherCommaSeparatedArgs)
    println("SELECT ID_TABLE, NAME, DESC FROM TABLE WHERE ID_TABLE BETWEEN 30 AND 100".toHTML)
    //end screen-out
    
     var myList : List[Int] = List(777, 10,9,8,7,6,5,4,3,2,1,0)
      println(myList.mkString(","))
      
      myList = quicksort(myList)
      println(myList.mkString(","))
      
      10.countDown()
    
  }
  
  
}
