/**
 * @ClassName LocalDateExample
 * @Description 描述本地时间
 * @Author qianjw
 * @Date 2023/9/20 10:26
 */
import java.time.LocalDate;

public class LocalDateExample {
    public static void main(String[] args) {
        for (int i = 0; i < 5; i++) {
            LocalDate currentDate = LocalDate.now();
            System.out.println("调用 " + (i + 1) + ": " + currentDate);
        }
    }
}