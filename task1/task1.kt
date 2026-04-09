import kotlin.text.*

fun checkCyclicShift(S: String, T: String): String {
    if (S == T) return "Yes"
    var current = S
    for (i in S.indices) {
        // циклический сдвиг вправо на 1 символ
        current = current.last() + current.dropLast(1)
        if (current == T) return "Yes"
    }
    return "No"
}

fun main() {
    print("Enter string S: ")
    val S = readLine() ?: ""
    print("Enter string T: ")
    val T = readLine() ?: ""
    println(checkCyclicShift(S, T))
}