import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in, "UTF-8");
        OutputStream out = System.out;
        
        out.write("Введите количество пар городов: ".getBytes("UTF-8"));
        int n = sc.nextInt();
        
        List<String[]> pairs = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            String a = sc.next();
            String b = sc.next();
            pairs.add(new String[]{a, b});
        }

        boolean error = false;

        for (String[] p : pairs) {
            if (p[0].equals(p[1])) {
                error = true;
                break;
            }
        }

        Map<String, Integer> startCount = new HashMap<>();
        for (String[] p : pairs) {
            int cnt = startCount.getOrDefault(p[0], 0) + 1;
            if (cnt > 1) {
                error = true;
                break;
            }
            startCount.put(p[0], cnt);
        }

        Map<String, Integer> endCount = new HashMap<>();
        for (String[] p : pairs) {
            int cnt = endCount.getOrDefault(p[1], 0) + 1;
            if (cnt > 1) {
                error = true;
                break;
            }
            endCount.put(p[1], cnt);
        }

        if (error) {
            out.write("Ошибка".getBytes("UTF-8"));
            out.write('\n');
            return;
        }

        Map<String, String> next = new HashMap<>();
        for (String[] p : pairs) {
            next.put(p[0], p[1]);
        }

        Set<String> starts = new HashSet<>();
        for (String[] p : pairs) {
            if (!endCount.containsKey(p[0])) {
                starts.add(p[0]);
            }
        }

        if (starts.isEmpty()) {
            out.write("Ошибка".getBytes("UTF-8"));
            out.write('\n');
            return;
        }

        String bestEnd = "";
        int maxLen = -1;
        for (String start : starts) {
            String cur = start;
            int len = 0;
            while (next.containsKey(cur)) {
                cur = next.get(cur);
                len++;
            }
            if (len > maxLen) {
                maxLen = len;
                bestEnd = cur;
            }
        }

        out.write(bestEnd.getBytes("UTF-8"));
        out.write('\n');
    }
}