+++
date = "2011-07-11T14:47:24+00:00"
title = "Några små förbättringar till Gmails nya gränssnitt"
[taxonomies]
tags = ["GMail", "Google", "Stylish"]
+++

*Det här blir andra försöket att skriva det här inlägget, sist råkade jag ut för lite problem som du kan läsa mer om i [förra inlägget][1].*

Jag provade nyligen det nya temat i Gmail som är en förhandsvisning av det nya gränssnittet. Över lag är det snyggt och clean men det var en del små saker jag störde mig på.

För det första blev det den mer kompakta layouten då den vanliga var lite väl luftig. Visst det var kanske snyggare men man vill ju kunna få lite översikt på skärmen med.

[<img class="aligncenter size-large wp-image-1035" title="gmail-gp-stylish-before" src="/images/2011/07/gmail-gp-stylish-before1-1024x637.png" alt="" width="1024" height="637" />][2]

Det var tre saker som jag störde mig på. Jag tyckte inte om att de hade flyttat ner reklamen till botten, den var i vägen. Även om den rent teknisk var mindre i vägen där nere så såg jag den oftare och jag fick känslan att den var i vägen. Som synes på bilden så har jag min chat på höger sida (en funktion från Google Labs) och det blev för stort utrymme till vänster om den, det såg fult ut. Slutligen när jag ändå var inne på att ändra saker så passade jag på att göra &#8220;Compose&#8221;-knappen lite mindre dominerande. Klickar aldrig på den ändå (kör med c på tangentbordet).

Jag valde mig att använda Firefox tillägget [Stylish][3] där man kan redigera stilmallen på webbsidor på ett enkelt sätt om man kan css. Resultatet blev så här:

[<img class="aligncenter size-large wp-image-1034" title="gmail-gp-stylish-after" src="/images/2011/07/gmail-gp-stylish-after1-1024x650.png" alt="" width="1024" height="650" />][4]

Mycket bättre. Här kommer koden om du vill se hur jag gjorde. Kanske du har fler förbättringar eller ett bättre/snyggare sätt att göra det på. Dela gärna med dig.

<pre>@namespace url(http://www.w3.org/1999/xhtml);
@-moz-document domain("mail.google.com") {
.mq {
  display: none !important;
}
.nH div.pp div.s {
  margin-left: -37px;
  margin-right: 5px;
}
div.qRauBc {
  margin-right: -35px;
}
div.z0 div {
  border: 1px solid black;
  background: none !important;
  color: black !important;
  padding: 0px !important;
  font-weight: normal !important;
}
}</pre>

Happy hacking!

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/gmail' rel='tag' target='_self'>gmail</a>, <a class='technorati-link' href='http://bloggar.se/om/google' rel='tag' target='_self'>google</a>, <a class='technorati-link' href='http://bloggar.se/om/stylish' rel='tag' target='_self'>stylish</a>
</p></small>

 [1]: http://nsg.cc/2011/07/10/det-ar-inte-alltid-bast-att-kora-paketen-fran-dist/
 [2]: /images/2011/07/gmail-gp-stylish-before1.png
 [3]: https://addons.mozilla.org/en-US/firefox/addon/stylish/
 [4]: /images/2011/07/gmail-gp-stylish-after1.png
