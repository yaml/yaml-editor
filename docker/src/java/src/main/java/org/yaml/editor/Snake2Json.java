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
        for (final Object node : new Yaml().loadAll(in)) {
            new Gson().toJson(node, out);
            /* XXX Need to add newline after each JSON object. */
            /* out.append('\n'); */
        }
    }

    public static void main(final String[] args) {
        new Snake2Json().yamlToJson(System.in, System.out);
    }
}
