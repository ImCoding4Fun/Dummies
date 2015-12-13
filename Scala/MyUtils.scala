package dummies

object MyUtils 
{
   def getCommaSeparated(s1:String,s2:String ): String = s1 + ", " + s2
   
   def quicksort[A <% Ordered[A]](arr: List[A]): List[A] = 
   {
        if (arr.length <= 1) 
          arr
        else 
        {
          val pivot: A = arr(arr.length / 2)
          List.concat(
              quicksort(arr.filter(pivot > _)),
              arr.filter(pivot == _),
              quicksort(arr.filter(pivot < _)))
        }
   }
   
}
