/*
 Title: Oändligt långa sidor i Google
 Author: nsg
 Template: post
 Permalink: /2007/04/15/oandligt-langa-sidor-i-google/
 Date: 2007-04-15T12:22:52+00:00
 Categories: Internet, Teknik
*/
Titeln är inte helt sann då begränsningen är hur många träffar du fått. Men behovet att trycka på &#8220;nästa sida&#8221;-knappen är borta då den automatiskt laddar nästa sida när du närmar dig slutet. Jag pratar om ett Greasemonkey skript som jag hittade genom [Google Operating System][1].

[Greasemonkey][2] är en [extension][3] till [firefox][4], greasemonkey kan ladda små moddar till webbsidor. Det finns gått om olika skript på [userscripts.org][5].

Nu lite bilder för att illustrera.

*Här kommer tre bilder där jag har gått ner tre &#8220;sidor&#8221; i sökningen. Notera att scrollbaren har minskat då sidan växer.*

<div class="middle">
  <img id="image391" src="http://cdn.junkpile.se/2007/04/google1.png" alt="google1.png" /><br /> <img id="image392" src="http://cdn.junkpile.se/2007/04/google2.png" alt="google2.png" /><br /> <img id="image393" src="http://cdn.junkpile.se/2007/04/google3.png" alt="google3.png" />
</div>

**Edit**: Glömde en sak, skriptet ändrar även alla länkar till `target="_blank"`, d.v.s. öppna i nytt fönster/tab. För att stänga av det kommentera bort, eller ta bort följande del av skriptet.

`<br />
var set_links_target = function() {<br />
    <strong>/*var links = document.getElementsByTagName('a');<br />
    for (var i = 0; i < links.length; ++i) {<br />
        links[i].setAttribute('target', '_blank');<br />
    }*/</strong><br />
  };<br />
`  
Notera /\* och \*/.

**Edit 2**:  
Spelade in en liten film.

  
[YouTube][6]

**Edit 2**:  
Tydligen har [Customize Google][7] ([via][8]) inkluderat en nästan identisk funktion, det är inte aktiverat som standard dock.

  
[YouTube][9]

:: Greasemonkey, Google, Sök, Customize Google

<small></small>

 [1]: http://googlesystem.blogspot.com/2007/04/infinite-scrolling-in-google-search.html
 [2]: http://www.greasespot.net/
 [3]: https://addons.mozilla.org/en-US/firefox/browse/type:1
 [4]: http://www.mozilla.com/en-US/firefox/
 [5]: http://userscripts.org/
 [6]: http://www.youtube.com/watch?v=BgKDsP_ETVE
 [7]: http://www.customizegoogle.com/
 [8]: http://googlesystem.blogspot.com/2007/04/customize-google-adds-infinite.html
 [9]: http://www.youtube.com/watch?v=HSQBXrRY-iY