namespace StringUtilsTest

open System
open Microsoft.VisualStudio.TestTools.UnitTesting
open StringUtils.StringExtensions

[<TestClass>]
type TestClass () =

    [<TestMethod>]
    member __.TestToMixedCase () =
        let mixed = "XxXxX"
        let actaual = "xxxxx".ToMixedCase
        let result = mixed = actaual
        Assert.IsTrue(result)

    
    [<TestMethod>]
    member __.Join () =
        let input = ["Hello";" world"]
        let actual = join(input,",")
        let result = actual = "Hello, world"
        Assert.IsTrue(result)