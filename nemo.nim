import xmltree, nimquery, nimpy, sequtils, strtabs, tables
from htmlparser import parseHtml
from streams import newStringStream

proc parse(html:string):XmlNode = newStringStream(html).parseHtml()

func fields(node:XmlNode):Table[string,string] = 
  result = toTable({"text" : innerText(node), "tag" : tag(node)})
  if attrsLen(node) > 0 : (for prop, val in attrs(node).pairs(): result[prop]=val)

proc find(html : string, selectors : seq[string]) : seq[(string, seq[Table[string, string]])] {.exportpy.} = 
  let parsed = parse(html)
  return selectors.mapIt((it, parsed.querySelectorAll(it).map(fields)))
