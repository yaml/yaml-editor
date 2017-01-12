import yaml/stream, yaml/parser, yaml/taglib, streams

var
  tags = initExtendedTagLibrary()
  p = newYamlParser(tags)
  yaml = newFileStream(stdin)
  events = p.parse(yaml)
  output = ""

for event in events: output.add($event & "\n")

stdout.write(output)
