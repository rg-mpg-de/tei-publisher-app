import module namespace m='http://www.tei-c.org/pm/models/shakespeare/printcss' at '/db/apps/tei-publisher/transform/shakespeare-printcss.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/shakespeare.css"],
    "collection": "/db/apps/tei-publisher/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)