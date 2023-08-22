(:~

    Transformation module generated from TEI ODD extensions for processing models.
    ODD: /db/apps/tei-publisher/odd/ebbe.odd
 :)
xquery version "3.1";

module namespace model="http://www.tei-c.org/pm/models/ebbe/web";

declare default element namespace "http://www.tei-c.org/ns/1.0";

declare namespace xhtml='http://www.w3.org/1999/xhtml';

declare namespace pb='http://teipublisher.com/1.0';

import module namespace css="http://www.tei-c.org/tei-simple/xquery/css";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

import module namespace global="http://www.tei-c.org/tei-simple/config" at "../modules/config.xqm";

(: generated template function for element spec: ptr :)
declare %private function model:template-ptr($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-mei url="{$config?apply-children($config, $node, $params?url)}" player="player">
                              <pb-option name="appXPath" on="./rdg[contains(@label, 'original')]" off="">Original Clefs</pb-option>
                              </pb-mei></t>/*
};
(: generated template function for element spec: ab :)
declare %private function model:template-ab($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><pb-facs-link facs="{$config?apply-children($config, $node, $params?facs)}" coordinates="{$config?apply-children($config, $node, $params?coordinates)}" emit="transcription">{$config?apply-children($config, $node, $params?content)}</pb-facs-link></t>/*
};
(: generated template function for element spec: respStmt :)
declare %private function model:template-respStmt($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><div>{$config?apply-children($config, $node, $params?resp)}: {$config?apply-children($config, $node, $params?name)}</div></t>/*
};
(: generated template function for element spec: name :)
declare %private function model:template-name($config as map(*), $node as node()*, $params as map(*)) {
    <t xmlns=""><span><a href="{$config?apply-children($config, $node, $params?href)}" target="_ebbe"><iron-icon icon="launch"/></a>{$config?apply-children($config, $node, $params?content)}</span></t>/*
};
(:~

    Main entry point for the transformation.
    
 :)
declare function model:transform($options as map(*), $input as node()*) {
        
    let $config :=
        map:merge(($options,
            map {
                "output": ["web"],
                "odd": "/db/apps/tei-publisher/odd/ebbe.odd",
                "apply": model:apply#2,
                "apply-children": model:apply-children#3
            }
        ))
    
    return (
        html:prepare($config, $input),
    
        let $output := model:apply($config, $input)
        return
            html:finish($config, $output)
    )
};

declare function model:apply($config as map(*), $input as node()*) {
        let $parameters := 
        if (exists($config?parameters)) then $config?parameters else map {}
        let $mode := 
        if (exists($config?mode)) then $config?mode else ()
        let $trackIds := 
        $parameters?track-ids
        let $get := 
        model:source($parameters, ?)
    return
    $input !         (
            let $node := 
                .
            return
                            typeswitch(.)
                    case element(licence) return
                        if (@target) then
                            html:link($config, ., ("tei-licence1", "licence", css:map-rend-to-class(.)), 'Licence', @target, (), map {})                            => model:map($node, $trackIds)
                        else
                            html:omit($config, ., ("tei-licence2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(listBibl) return
                        if (bibl) then
                            html:list($config, ., ("tei-listBibl1", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-listBibl2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(castItem) return
                        (: Insert item, rendered as described in parent list rendition. :)
                        html:listItem($config, ., ("tei-castItem", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(item) return
                        html:listItem($config, ., ("tei-item", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(teiHeader) return
                        if ($parameters?mode='metadata') then
                            html:block($config, ., ("tei-teiHeader1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                html:block($config, ., ("tei-teiHeader4", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                html:metadata($config, ., ("tei-teiHeader5", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(figure) return
                        if (head or @rendition='simple:display') then
                            html:block($config, ., ("tei-figure1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-figure2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(supplied) return
                        if (parent::choice) then
                            html:inline($config, ., ("tei-supplied1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@reason='damage') then
                                html:inline($config, ., ("tei-supplied2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (@reason='illegible' or not(@reason)) then
                                    html:inline($config, ., ("tei-supplied3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    if (@reason='omitted') then
                                        html:inline($config, ., ("tei-supplied4", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        html:inline($config, ., ("tei-supplied5", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                    case element(g) return
                        if (not(text())) then
                            html:glyph($config, ., ("tei-g1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-g2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(author) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-author1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-author2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(castList) return
                        if (child::*) then
                            html:list($config, ., css:get-rendition(., ("tei-castList", css:map-rend-to-class(.))), castItem, ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(l) return
                        html:block($config, ., css:get-rendition(., ("tei-l", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(ptr) return
                        if (parent::notatedMusic) then
                            let $params := 
                                map {
                                    "url": @target,
                                    "content": .
                                }

                                                        let $content := 
                                model:template-ptr($config, ., $params)
                            return
                                                        html:pass-through(map:merge(($config, map:entry("template", true()))), ., ("tei-ptr", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(closer) return
                        html:block($config, ., ("tei-closer", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(signed) return
                        if (parent::closer) then
                            html:block($config, ., ("tei-signed1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-signed2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(p) return
                        html:paragraph($config, ., css:get-rendition(., ("tei-p2", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(list) return
                        html:list($config, ., css:get-rendition(., ("tei-list", css:map-rend-to-class(.))), item, ())                        => model:map($node, $trackIds)
                    case element(q) return
                        if (l) then
                            html:block($config, ., css:get-rendition(., ("tei-q1", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                        else
                            if (ancestor::p or ancestor::cell) then
                                html:inline($config, ., css:get-rendition(., ("tei-q2", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                            else
                                html:block($config, ., css:get-rendition(., ("tei-q3", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                    case element(pb) return
                        if (starts-with(@facs, 'iiif:')) then
                            html:webcomponent($config, ., css:get-rendition(., ("tei-pb", "facs", css:map-rend-to-class(.))), @n, 'pb-facs-link', map {"emit": 'transcription', "facs": replace(@facs, '^iiif:(.*)$', '$1')})                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(epigraph) return
                        html:block($config, ., ("tei-epigraph", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(lb) return
                        html:break($config, ., css:get-rendition(., ("tei-lb", css:map-rend-to-class(.))), ., 'line', @n)                        => model:map($node, $trackIds)
                    case element(docTitle) return
                        html:block($config, ., css:get-rendition(., ("tei-docTitle", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(w) return
                        html:inline($config, ., ("tei-w", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(TEI) return
                        html:document($config, ., ("tei-TEI", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(anchor) return
                        html:anchor($config, ., ("tei-anchor", css:map-rend-to-class(.)), ., @xml:id)                        => model:map($node, $trackIds)
                    case element(titlePage) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePage", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(stage) return
                        html:block($config, ., ("tei-stage", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(lg) return
                        html:block($config, ., ("tei-lg", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(front) return
                        html:block($config, ., ("tei-front", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(formula) return
                        if (@rendition='simple:display') then
                            html:block($config, ., ("tei-formula1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@rend='display') then
                                html:webcomponent($config, ., ("tei-formula4", css:map-rend-to-class(.)), ., 'pb-formula', map {"display": true()})                                => model:map($node, $trackIds)
                            else
                                html:webcomponent($config, ., ("tei-formula5", css:map-rend-to-class(.)), ., 'pb-formula', map {})                                => model:map($node, $trackIds)
                    case element(publicationStmt) return
                        html:block($config, ., ("tei-publicationStmt1", css:map-rend-to-class(.)), availability/licence)                        => model:map($node, $trackIds)
                    case element(choice) return
                        if (sic and corr) then
                            html:alternate($config, ., ("tei-choice1", css:map-rend-to-class(.)), ., corr[1], sic[1], map {})                            => model:map($node, $trackIds)
                        else
                            if (abbr and expan) then
                                html:alternate($config, ., ("tei-choice2", css:map-rend-to-class(.)), ., expan[1], abbr[1], map {})                                => model:map($node, $trackIds)
                            else
                                if (orig and reg) then
                                    html:alternate($config, ., ("tei-choice3", css:map-rend-to-class(.)), ., reg[1], orig[1], map {})                                    => model:map($node, $trackIds)
                                else
                                    $config?apply($config, ./node())
                    case element(role) return
                        html:block($config, ., ("tei-role", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(hi) return
                        html:inline($config, ., css:get-rendition(., ("tei-hi", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(note) return
                        html:note($config, ., ("tei-note", css:map-rend-to-class(.)), ., @place, @n)                        => model:map($node, $trackIds)
                    case element(code) return
                        html:inline($config, ., ("tei-code", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(postscript) return
                        html:block($config, ., ("tei-postscript", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(dateline) return
                        html:block($config, ., ("tei-dateline", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(back) return
                        html:block($config, ., ("tei-back", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(edition) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-edition", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(del) return
                        html:inline($config, ., ("tei-del", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(cell) return
                        (: Insert table cell. :)
                        html:cell($config, ., ("tei-cell", css:map-rend-to-class(.)), ., ())                        => model:map($node, $trackIds)
                    case element(trailer) return
                        html:block($config, ., ("tei-trailer", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(div) return
                        if (@type='title_page') then
                            html:block($config, ., ("tei-div1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (parent::body or parent::front or parent::back) then
                                html:section($config, ., ("tei-div2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                html:block($config, ., ("tei-div3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(graphic) return
                        html:graphic($config, ., ("tei-graphic", css:map-rend-to-class(.)), ., @url, @width, @height, @scale, desc)                        => model:map($node, $trackIds)
                    case element(ref) return
                        if (starts-with(@target, 'EBBE_')) then
                            html:link($config, ., ("tei-ref1", css:map-rend-to-class(.)), ., 'https://www.estreicher.uj.edu.pl/staropolska/baza/wpis/?sort=nazwisko_imie&amp;order=1&amp;id=' || substring-after(@target, 'EBBE_'), '_ebbe', map {})                            => model:map($node, $trackIds)
                        else
                            if (parent::cit or parent::def) then
                                (: references (authors) within translations, examples or definitions :)
                                html:inline($config, ., ("tei-ref2", "ref-author", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (not(@target)) then
                                    html:alternate($config, ., ("tei-ref3", css:map-rend-to-class(.)), ., ., 'odsyłacz niezidentyfikowany', map {})                                    => model:map($node, $trackIds)
                                else
                                    if (not(node())) then
                                        html:link($config, ., ("tei-ref4", css:map-rend-to-class(.)), @target, @target, (), map {})                                        => model:map($node, $trackIds)
                                    else
                                        html:link($config, ., ("tei-ref5", css:map-rend-to-class(.)), ., @target, (), map {})                                        => model:map($node, $trackIds)
                    case element(titlePart) return
                        html:block($config, ., css:get-rendition(., ("tei-titlePart", css:map-rend-to-class(.))), .)                        => model:map($node, $trackIds)
                    case element(ab) return
                        if (starts-with(@facs, 'iiif:')) then
                            let $params := 
                                map {
                                    "facs": replace(@facs, '^iiif:([^/]+).*$', '$1'),
                                    "content": .,
                                    "coordinates": ('[' || replace(@facs, '^iiif:[^/]+/(.*)$', '$1') || ']')
                                }

                                                        let $content := 
                                model:template-ab($config, ., $params)
                            return
                                                        html:block(map:merge(($config, map:entry("template", true()))), ., ("tei-ab1", "ab", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-ab2", "ab", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(add) return
                        html:inline($config, ., ("tei-add", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(revisionDesc) return
                        html:omit($config, ., ("tei-revisionDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(head) return
                        if ($parameters?header='short') then
                            html:inline($config, ., ("tei-head1", css:map-rend-to-class(.)), replace(string-join(.//text()[not(parent::ref)]), '^(.*?)[^\w]*$', '$1'))                            => model:map($node, $trackIds)
                        else
                            if (parent::figure) then
                                html:block($config, ., ("tei-head2", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if (parent::table) then
                                    html:block($config, ., ("tei-head3", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                                else
                                    if (parent::lg) then
                                        html:block($config, ., ("tei-head4", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        if (parent::list) then
                                            html:block($config, ., ("tei-head5", css:map-rend-to-class(.)), .)                                            => model:map($node, $trackIds)
                                        else
                                            if (parent::div) then
                                                html:heading($config, ., ("tei-head6", css:map-rend-to-class(.)), ., count(ancestor::div))                                                => model:map($node, $trackIds)
                                            else
                                                html:block($config, ., ("tei-head7", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds)
                    case element(roleDesc) return
                        html:block($config, ., ("tei-roleDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(opener) return
                        html:block($config, ., ("tei-opener", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(speaker) return
                        html:block($config, ., ("tei-speaker", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(time) return
                        html:inline($config, ., ("tei-time", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(castGroup) return
                        if (child::*) then
                            (: Insert list. :)
                            html:list($config, ., ("tei-castGroup", css:map-rend-to-class(.)), castItem|castGroup, ())                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(imprimatur) return
                        html:block($config, ., ("tei-imprimatur", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(bibl) return
                        if (parent::listBibl) then
                            html:listItem($config, ., ("tei-bibl1", css:map-rend-to-class(.)), ., ())                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-bibl2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(unclear) return
                        html:inline($config, ., ("tei-unclear", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(salute) return
                        if (parent::closer) then
                            html:inline($config, ., ("tei-salute1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-salute2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(title) return
                        if ($parameters?mode='metadata') then
                            html:omit($config, ., ("tei-title1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                html:heading($config, ., ("tei-title2", css:map-rend-to-class(.)), ., 5)                                => model:map($node, $trackIds)
                            else
                                if (parent::titleStmt/parent::fileDesc) then
                                    (
                                        if (preceding-sibling::title) then
                                            html:text($config, ., ("tei-title3", css:map-rend-to-class(.)), ' — ')                                            => model:map($node, $trackIds)
                                        else
                                            (),
                                        html:inline($config, ., ("tei-title4", "foo", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    )

                                else
                                    if (not(@level) and parent::bibl) then
                                        html:inline($config, ., ("tei-title5", css:map-rend-to-class(.)), .)                                        => model:map($node, $trackIds)
                                    else
                                        if (@level='m' or not(@level)) then
                                            (
                                                html:inline($config, ., ("tei-title6", css:map-rend-to-class(.)), .)                                                => model:map($node, $trackIds),
                                                if (ancestor::biblFull) then
                                                    html:text($config, ., ("tei-title7", css:map-rend-to-class(.)), ', ')                                                    => model:map($node, $trackIds)
                                                else
                                                    ()
                                            )

                                        else
                                            if (@level='s' or @level='j') then
                                                (
                                                    html:inline($config, ., ("tei-title8", css:map-rend-to-class(.)), .)                                                    => model:map($node, $trackIds),
                                                    if (following-sibling::* and     (  ancestor::biblFull)) then
                                                        html:text($config, ., ("tei-title9", css:map-rend-to-class(.)), ', ')                                                        => model:map($node, $trackIds)
                                                    else
                                                        ()
                                                )

                                            else
                                                if (@level='u' or @level='a') then
                                                    (
                                                        html:inline($config, ., ("tei-title10", css:map-rend-to-class(.)), .)                                                        => model:map($node, $trackIds),
                                                        if (following-sibling::* and     (    ancestor::biblFull)) then
                                                            html:text($config, ., ("tei-title11", css:map-rend-to-class(.)), '. ')                                                            => model:map($node, $trackIds)
                                                        else
                                                            ()
                                                    )

                                                else
                                                    html:inline($config, ., ("tei-title12", css:map-rend-to-class(.)), .)                                                    => model:map($node, $trackIds)
                    case element(date) return
                        if (@when) then
                            html:alternate($config, ., ("tei-date1", css:map-rend-to-class(.)), ., ., @when, map {})                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-date2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(argument) return
                        html:block($config, ., ("tei-argument", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(corr) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            (: simple inline, if in parent choice. :)
                            html:inline($config, ., ("tei-corr1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-corr2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(foreign) return
                        html:inline($config, ., ("tei-foreign", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(cit) return
                        if (@type='example') then
                            html:block($config, ., ("tei-cit1", "example", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@type='translation') then
                                html:block($config, ., ("tei-cit2", "translation", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                $config?apply($config, ./node())
                    case element(titleStmt) return
                        if ($parameters?mode='title' ) then
                            (
                                html:inline($config, ., ("tei-titleStmt3", css:map-rend-to-class(.)), title[1])                                => model:map($node, $trackIds),
                                html:inline($config, ., ("tei-titleStmt4", css:map-rend-to-class(.)), subsequence(title, 2))                                => model:map($node, $trackIds)
                            )

                        else
                            if ($parameters?mode='metadata') then
                                html:block($config, ., ("tei-titleStmt5", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                            else
                                if ($parameters?header='short') then
                                    (
                                        html:link($config, ., ("tei-titleStmt6", css:map-rend-to-class(.)), title[1], $parameters?doc, (), map {})                                        => model:map($node, $trackIds),
                                        html:block($config, ., ("tei-titleStmt7", css:map-rend-to-class(.)), subsequence(title, 2))                                        => model:map($node, $trackIds),
                                        html:block($config, ., ("tei-titleStmt8", css:map-rend-to-class(.)), (author, editor))                                        => model:map($node, $trackIds)
                                    )

                                else
                                    html:block($config, ., ("tei-titleStmt9", css:map-rend-to-class(.)), .)                                    => model:map($node, $trackIds)
                    case element(fileDesc) return
                        if ($parameters?mode='metadata') then
                            html:block($config, ., ("tei-fileDesc1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if ($parameters?header='short') then
                                (
                                    html:block($config, ., ("tei-fileDesc2", "header-short", css:map-rend-to-class(.)), titleStmt)                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-fileDesc3", "header-short", css:map-rend-to-class(.)), editionStmt)                                    => model:map($node, $trackIds),
                                    html:block($config, ., ("tei-fileDesc4", "header-short", css:map-rend-to-class(.)), publicationStmt)                                    => model:map($node, $trackIds),
                                    (: Output abstract containing demo description :)
                                    html:block($config, ., ("tei-fileDesc5", "sample-description", css:map-rend-to-class(.)), ../profileDesc/abstract)                                    => model:map($node, $trackIds)
                                )

                            else
                                html:title($config, ., ("tei-fileDesc6", css:map-rend-to-class(.)), titleStmt)                                => model:map($node, $trackIds)
                    case element(sic) return
                        if (parent::choice and count(parent::*/*) gt 1) then
                            html:inline($config, ., ("tei-sic1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-sic2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(spGrp) return
                        html:block($config, ., ("tei-spGrp", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(body) return
                        (
                            html:index($config, ., ("tei-body1", css:map-rend-to-class(.)), 'toc', .)                            => model:map($node, $trackIds),
                            html:block($config, ., ("tei-body2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        )

                    case element(fw) return
                        if (ancestor::p or ancestor::ab) then
                            html:inline($config, ., ("tei-fw1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:block($config, ., ("tei-fw2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(encodingDesc) return
                        html:omit($config, ., ("tei-encodingDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(quote) return
                        if (ancestor::cit) then
                            (: quotes within cit should be treated as inline, cit is the block unit :)
                            html:inline($config, ., ("tei-quote1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (ancestor::p) then
                                (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                                html:inline($config, ., css:get-rendition(., ("tei-quote2", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                            else
                                (: If it is inside a paragraph then it is inline, otherwise it is block level :)
                                html:block($config, ., css:get-rendition(., ("tei-quote3", css:map-rend-to-class(.))), .)                                => model:map($node, $trackIds)
                    case element(gap) return
                        if (desc) then
                            html:inline($config, ., ("tei-gap1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            if (@extent) then
                                html:inline($config, ., ("tei-gap2", css:map-rend-to-class(.)), @extent)                                => model:map($node, $trackIds)
                            else
                                html:inline($config, ., ("tei-gap3", css:map-rend-to-class(.)), .)                                => model:map($node, $trackIds)
                    case element(seg) return
                        if (@type='location') then
                            html:inline($config, ., ("tei-seg1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., css:get-rendition(., ("tei-seg2", css:map-rend-to-class(.))), .)                            => model:map($node, $trackIds)
                    case element(notatedMusic) return
                        html:figure($config, ., ("tei-notatedMusic", css:map-rend-to-class(.)), ptr, label)                        => model:map($node, $trackIds)
                    case element(profileDesc) return
                        html:omit($config, ., ("tei-profileDesc", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(row) return
                        if (@role='label') then
                            html:row($config, ., ("tei-row1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            (: Insert table row. :)
                            html:row($config, ., ("tei-row2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(text) return
                        html:body($config, ., ("tei-text", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(floatingText) return
                        html:block($config, ., ("tei-floatingText", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(sp) return
                        html:block($config, ., ("tei-sp", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(byline) return
                        html:block($config, ., ("tei-byline", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(table) return
                        html:table($config, ., ("tei-table", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(group) return
                        html:block($config, ., ("tei-group", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(cb) return
                        html:break($config, ., ("tei-cb", css:map-rend-to-class(.)), ., 'column', @n)                        => model:map($node, $trackIds)
                    case element(gram) return
                        html:inline($config, ., ("tei-gram", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(oRef) return
                        (: marker for headword reference; rendered as dash :)
                        html:inline($config, ., ("tei-oRef", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(gen) return
                        html:alternate($config, ., ("tei-gen", css:map-rend-to-class(.)), ., ., @norm, map {})                        => model:map($node, $trackIds)
                    case element(pos) return
                        html:alternate($config, ., ("tei-pos", css:map-rend-to-class(.)), ., ., @norm, map {})                        => model:map($node, $trackIds)
                    case element(editor) return
                        if (ancestor::teiHeader) then
                            html:block($config, ., ("tei-editor1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        else
                            html:inline($config, ., ("tei-editor2", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                    case element(msDesc) return
                        (
                            (: retrieves the primary language :)
                            html:block($config, ., ("tei-msDesc1", css:map-rend-to-class(.)), (root(.)//langUsage/language))                            => model:map($node, $trackIds),
                            (: retrieves the form of the source from taxonomy file :)
                            html:block($config, ., ("tei-msDesc2", css:map-rend-to-class(.)), id(substring-after(root(.)//catRef[@scheme='#form']/@target, '#'), doc('/db/apps/tei-publisher/data/taxonomy.xml')))                            => model:map($node, $trackIds),
                            html:block($config, ., ("tei-msDesc3", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds)
                        )

                    case element(institution) return
                        html:inline($config, ., ("tei-institution", css:map-rend-to-class(.)), .)                        => model:map($node, $trackIds)
                    case element(respStmt) return
                        let $params := 
                            map {
                                "resp": resp,
                                "name": persName,
                                "content": .
                            }

                                                let $content := 
                            model:template-respStmt($config, ., $params)
                        return
                                                html:pass-through(map:merge(($config, map:entry("template", true()))), ., ("tei-respStmt", css:map-rend-to-class(.)), $content)                        => model:map($node, $trackIds)
                    case element(idno) return
                        (
                            html:inline($config, ., ("tei-idno1", css:map-rend-to-class(.)), .)                            => model:map($node, $trackIds),
                            html:inline($config, ., ("tei-idno2", css:map-rend-to-class(.)), ancestor::msDesc/@type)                            => model:map($node, $trackIds)
                        )

                    case element(name) return
                        if (parent::ab) then
                            let $params := 
                                map {
                                    "content": .,
                                    "href": 'https://www.estreicher.uj.edu.pl/staropolska/baza/wpis/?sort=nazwisko_imie&amp;order=1&amp;id=' || substring-after((ancestor::div/@xml:id[starts-with(., 'EBBE_')])[1], 'EBBE_') || '&amp;offset=0'
                                }

                                                        let $content := 
                                model:template-name($config, ., $params)
                            return
                                                        html:inline(map:merge(($config, map:entry("template", true()))), ., ("tei-name", css:map-rend-to-class(.)), $content)                            => model:map($node, $trackIds)
                        else
                            $config?apply($config, ./node())
                    case element(exist:match) return
                        html:match($config, ., .)
                    case element() return
                        if (namespace-uri(.) = 'http://www.tei-c.org/ns/1.0') then
                            $config?apply($config, ./node())
                        else
                            .
                    case text() | xs:anyAtomicType return
                        html:escapeChars(.)
                    default return 
                        $config?apply($config, ./node())

        )

};

declare function model:apply-children($config as map(*), $node as element(), $content as item()*) {
        
    if ($config?template) then
        $content
    else
        $content ! (
            typeswitch(.)
                case element() return
                    if (. is $node) then
                        $config?apply($config, ./node())
                    else
                        $config?apply($config, .)
                default return
                    html:escapeChars(.)
        )
};

declare function model:source($parameters as map(*), $elem as element()) {
        
    let $id := $elem/@exist:id
    return
        if ($id and $parameters?root) then
            util:node-by-id($parameters?root, $id)
        else
            $elem
};

declare function model:process-annotation($html, $context as node()) {
        
    let $classRegex := analyze-string($html/@class, '\s?annotation-([^\s]+)\s?')
    return
        if ($classRegex//fn:match) then (
            if ($html/@data-type) then
                ()
            else
                attribute data-type { ($classRegex//fn:group)[1]/string() },
            if ($html/@data-annotation) then
                ()
            else
                attribute data-annotation {
                    map:merge($context/@* ! map:entry(node-name(.), ./string()))
                    => serialize(map { "method": "json" })
                }
        ) else
            ()
                    
};

declare function model:map($html, $context as node(), $trackIds as item()?) {
        
    if ($trackIds) then
        for $node in $html
        return
            typeswitch ($node)
                case document-node() | comment() | processing-instruction() return 
                    $node
                case element() return
                    if ($node/@class = ("footnote")) then
                        if (local-name($node) = 'pb-popover') then
                            ()
                        else
                            element { node-name($node) }{
                                $node/@*,
                                $node/*[@class="fn-number"],
                                model:map($node/*[@class="fn-content"], $context, $trackIds)
                            }
                    else
                        element { node-name($node) }{
                            attribute data-tei { util:node-id($context) },
                            $node/@*,
                            model:process-annotation($node, $context),
                            $node/node()
                        }
                default return
                    <pb-anchor data-tei="{ util:node-id($context) }">{$node}</pb-anchor>
    else
        $html
                    
};

