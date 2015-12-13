package dummies

object MyExtensions 
{
  
  implicit class RichString(val s: String) 
  {
    def tab = s.padTo(8,' ')
    def tab(n: Int) = s.padTo(8*n,' ')
  }

  implicit class SQLString(var s: String) 
  {
    val KeyWords :Array[String] =
      Array("SELECT","FROM","WHERE","BETWEEN","AND") //...
    
    def toHTML: String =
    { 
      KeyWords.foreach { kw => s=s.replace(kw,"<font color='blue'>" + kw + "</font>")}
      s
    }
  }
  
  implicit class Timer(var count: Int)
  {
     def countDown()
     {
       oncePerSecond(() => {println(count); count -=1; count > 0})
      
       def oncePerSecond(callback: () => Boolean)
       {
          while(callback()) 
            Thread sleep 1000
       }
     }
  }
}
