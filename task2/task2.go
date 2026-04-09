package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func longestChainEnd(pairs [][]string) string {
	graph := make(map[string]string)
	cities := make(map[string]bool)

	for _, p := range pairs {
		if len(p) != 2 {
			continue
		}
		from, to := p[0], p[1]
		if from == to {
			return "Ошибка"
		}
		graph[from] = to
		cities[from] = true
		cities[to] = true
	}

	inDegree := make(map[string]int)
	for from, to := range graph {
		if _, ok := inDegree[from]; !ok {
			inDegree[from] = 0
		}
		inDegree[to]++
		if _, ok := inDegree[from]; !ok {
			inDegree[from] = 0
		}
	}
	for city := range cities {
		if _, ok := inDegree[city]; !ok {
			inDegree[city] = 0
		}
	}

	deg := make(map[string]int)
	for k, v := range inDegree {
		deg[k] = v
	}
	queue := []string{}
	for city, d := range deg {
		if d == 0 {
			queue = append(queue, city)
		}
	}
	for len(queue) > 0 {
		cur := queue[0]
		queue = queue[1:]
		if to, ok := graph[cur]; ok {
			deg[to]--
			if deg[to] == 0 {
				queue = append(queue, to)
			}
		}
	}
	for _, d := range deg {
		if d > 0 {
			return "Ошибка"
		}
	}

	type Chain struct {
		length int
		end    string
	}
	longest := Chain{length: -1, end: ""}

	for city, d := range inDegree {
		if d == 0 {
			cur := city
			steps := 0
			for {
				next, ok := graph[cur]
				if !ok {
					break
				}
				steps++
				cur = next
			}
			if steps > longest.length {
				longest.length = steps
				longest.end = cur
			}
		}
	}

	if longest.length == -1 {
		return ""
	}
	return longest.end
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	fmt.Print("Введите количество пар городов: ")
	var n int
	_, err := fmt.Fscan(reader, &n)
	if err != nil {
		fmt.Println("Ошибка чтения количества пар:", err)
		return
	}
	reader.ReadString('\n')

	pairs := make([][]string, 0, n)
	fmt.Println("Введите пары городов (каждая пара на новой строке, города разделены пробелом):")
	for i := 0; i < n; i++ {
		line, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("Ошибка чтения строки:", err)
			return
		}
		line = strings.TrimSpace(line)
		fields := strings.Fields(line)
		if len(fields) != 2 {
			fmt.Printf("Ошибка: строка '%s' не содержит двух городов\n", line)
			return
		}
		pairs = append(pairs, []string{fields[0], fields[1]})
	}

	result := longestChainEnd(pairs)
	if result == "Ошибка" {
		fmt.Println("Ошибка")
	} else if result == "" {
		fmt.Println("Нет ни одной цепочки")
	} else {
		fmt.Printf("Конечный город самой длинной цепочки: %s\n", result)
	}
}