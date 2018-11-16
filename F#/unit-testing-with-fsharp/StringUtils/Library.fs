namespace StringUtils

module StringExtensions =
    open System
    open System.Linq
    open System.Collections

    type String with
        member __.ToMixedCase =  String.Join("", __.Select(fun c i -> if i%2=0 then Char.ToUpper(c) else Char.ToLower(c) ) )
    
    let join(list: List<string>, sep: string) = list |> List.reduce(fun x y -> x + sep + y)