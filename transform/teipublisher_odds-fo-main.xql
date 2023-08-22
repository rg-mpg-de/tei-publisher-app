import module namespace m='http://www.tei-c.org/pm/models/teipublisher_odds/fo' at 'teipublisher_odds-fo.xql';

declare variable $xml external;

declare variable $parameters external;

let $options := map {
    "styles": ["transform/teipublisher_odds.css"],
    "collection": "/db/apps/tei-publisher/transform",
    "parameters": if (exists($parameters)) then $parameters else map {}
}
return m:transform($options, $xml)