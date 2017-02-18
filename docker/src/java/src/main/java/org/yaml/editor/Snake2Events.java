package org.yaml.editor;

import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.events.*;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class Snake2Events {

    private interface EventRenderer {
        String write(final Event e);
    }

    private final Map<Class, EventRenderer> renderers = new HashMap<Class, EventRenderer>() {
        /**
         * This method is needed because Java's type inference is too dumb to
         * recognize the EventRenderer class.
         */
        private void doPut(final Class c, final EventRenderer r) {
            super.put(c, r);
        }

        private String tag(final Event e) {
            if (e instanceof CollectionStartEvent) {
                return ((CollectionStartEvent)e).getTag();
            } else if (e instanceof ScalarEvent) {
                return ((ScalarEvent)e).getTag();
            } else {
                throw new IllegalArgumentException(e.getClass().toString());
            }
        }

        private String anchor(final Event e) {
            if (e instanceof CollectionStartEvent) {
                return ((CollectionStartEvent)e).getAnchor();
            } else if (e instanceof ScalarEvent) {
                return ((ScalarEvent)e).getAnchor();
            } else {
                throw new IllegalArgumentException(e.getClass().toString());
            }
        }

        private String tagAndAnchor(final Event e) {
            final String tag = tag(e);
            final String anchor = anchor(e);
            final StringBuilder builder = new StringBuilder();
            if (anchor != null) {
                builder.append(" &").append(anchor);
            }
            if (tag != null) {
                builder.append(" <").append(tag).append(">");
            }
            return builder.toString();
        }

        private String value(final Event e) {
            final ScalarEvent ev = (ScalarEvent) e;
            return " " + (ev.getStyle() == '\0' ? ':' : ev.getStyle()) + ev.getValue();
        }

        {
            doPut(AliasEvent.class,
                    (final Event e) -> "=ALI *" + ((AliasEvent)e).getAnchor());
            doPut(DocumentEndEvent.class,
                    (final Event e) -> "-DOC" + (((DocumentEndEvent)e).getExplicit() ? " ..." : ""));
            doPut(DocumentStartEvent.class,
                    (final Event e) -> "+DOC" +(((DocumentStartEvent)e).getExplicit() ? " ---" : ""));
            doPut(MappingEndEvent.class,
                    (final Event e) -> "-MAP");
            doPut(MappingStartEvent.class,
                    (final Event e) -> "+MAP" + tagAndAnchor(e));
            doPut(MappingEndEvent.class,
                    (final Event e) -> "-MAP");
            doPut(ScalarEvent.class,
                    (final Event e) -> "=VAL" + tagAndAnchor(e) + value(e));
            doPut(SequenceEndEvent.class,
                    (final Event e) -> "-SEQ");
            doPut(SequenceStartEvent.class,
                    (final Event e) -> "+SEQ" + tagAndAnchor(e));
            doPut(StreamEndEvent.class,
                    (final Event e) -> "-STR");
            doPut(StreamStartEvent.class,
                    (final Event e) -> "+STR");

        }
    };

    void yamlToEvents(final InputStream in, final Writer out) throws IOException {
        final Yaml yaml = new Yaml();
        for (final Event event: yaml.parse(new InputStreamReader(in))) {
            out.write(renderers.get(event.getClass()).write(event));
            out.write('\n');
        }
    }

    public static void main(final String[] args) throws IOException {
        final Writer writer = new OutputStreamWriter(System.out);
        new Snake2Events().yamlToEvents(System.in, writer);
        writer.close();
    }
}
