package dponyatov;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class App {
    public static void main(String[] args) {
        for (String arg : args) { //
            System.out.println(arg);
            try {
                BufferedReader reader = Files.newBufferedReader(Paths.get(arg));
                System.out.println(reader.read());
                System.out.println();
            } catch (IOException e) { e.printStackTrace(); }
        }
    }
}
