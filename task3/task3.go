package main

import "fmt"

func main() {
    var n int
    fmt.Scan(&n) 
    results := make([]string, n)

    for i := 0; i < n; i++ {
        var x int
        fmt.Scan(&x)
        if x >= 0 && x < 10 {
            results[i] = "-"
            continue
        }
        counter := 0
        for x > 0 {
            if (x % 10) %2 == 0 {
                counter++
            }
            x /= 10
        }
        results[i] = fmt.Sprintf("%d", counter)
    }
    for i, res := range results {
        if i > 0 {
            fmt.Print(" ")
        }
        fmt.Print(res)
    }
}