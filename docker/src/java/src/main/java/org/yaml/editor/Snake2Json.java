package org.yaml.editor;

import com.google.gson.Gson;
import org.yaml.snakeyaml.Yaml;

import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

public class Snake2Json {
    /**
     * Convert a YAML character stream into a JSON character stream.
     * This is not directly in {@see main} to facilitate JUnit tests.
     * @param in Stream to read YAML from
     * @param out Stream to write JSON to
     */
    public void yamlToJson(final InputStream in, final Appendable out) {
        final Object input = new Yaml().load(in);
        new Gson().toJson(input, out);
    }

    public static void main(final String[] args) {
        new Snake2Json().yamlToJson(System.in, System.out);
    }
}
