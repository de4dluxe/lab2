package main

import (
	"fmt"
)

func checkCycleShift(s string, t string) string {
	runes := []rune(s)
	for i := 0; i < len(s); i++ {
		runes = append(runes[1:], runes[0])
		if string(runes) == t {
			return "Yes"
		}
	}
	return "No"
}

func main() {
	var s string
	var t string
	fmt.Printf("Введите строку s: ")
	fmt.Scan(&s)
	fmt.Printf("Введите строку t: ")
    fmt.Scan(&t)
    fmt.Printf(checkCycleShift(s,t))
}