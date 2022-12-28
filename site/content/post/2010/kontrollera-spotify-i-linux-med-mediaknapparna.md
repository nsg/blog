+++
date = "2010-09-05T00:02:01+00:00"
title = "Kontrollera Spotify i Linux med mediaknapparna."
[taxonomies]
tags = ["Linux", "Spotify", "xdotool"]
+++

Är du en användare av Spotify samt Linux så har du säkert inte missat att det nu äntligen finns en riktig Linux-klient. Här kommer en kort beskrivning ifall du missat det.

<p style="padding-left: 30px;">
  Innan var vi tvungna att köra Windows-binären genom Wine. En lösning som funkade helt ok men långt från bra. Linuxvarianten har nästan alla funktioner som du hittar i Windowsversionen, jag har inte hittat något som jag missar. En av de större sakerna som inte är implementerade i Linuxversionen är reklam så du måste vara en betalande reklamfri kund för att kunna använda programmet.
</p>

<p style="padding-left: 30px;">
  <a href="http://www.spotify.com/se/download/previews/">Spotify för Linux</a>
</p>

Det jag har saknat mest med Spotify har varit möjligheten att kontrollera programmet med minna media-knappar som jag har på tangentbordet. De flesta inbyggda programmen lyssnar på dem men enda sättet för mig att byta låt eller stanna musiken har varit att leta rätt på programmet och trycka på &#8220;pause&#8221;. Det har varit en irritation så möjligheten att just kunna pausa musiken är trevlig att ha lätt åtkomlig om någon pratar med en och man vill få tyst på ljudet fort, att leta rätt på Spotify kan ta ett par sekunder.

Jag hittade lösningen för några dagar sedan när jag hittade det mycket trevliga programmet xdotool. xdotool är ett program för att bl.a. hantera fönster samt simulera tangentryckningar. Jag har skrivit ett litet skript som gör följande:

*   Spara undan fönstret som jag har aktivt
*   Sök upp spotify och gör aktivt (utan att fönstret blir synligt)
*   Tryck på mellanslag
*   Återställ aktivt fönster

Här ovan ser du logiken för att hantera play/pause för spotify. Här kommer koden:

``cur_focus=`xdotool getactivewindow`<br />
xdotool windowfocus $(xdotool search --title spotify | head -1)<br />
xdotool key space<br />
xdotool windowfocus $cur_focus``

Nu är det bara och göra det till ett litet skript och binda &#8220;play/pause&#8221; knappen till skriptet.

Du kan göra mycket kul med xdotool, jag har t.ex. skrivit en mobilanpassad webbsida som skickar kommandon till min dator som med hjälp av xdotool kontrollerar olika delar som t.ex. pilarna, spotify, mplayer. Allt för att jag ska kunna ligga i min säng någon meter bort med min iPod eller mobil och kontrollera datorn när jag t.ex. ser på film.

Har du hittat någon kul användning för xdotool så skriv gärna en kommentar. Samma sak om du behöver hjälp med att få något att funka.

<p style="padding-left: 30px;">
  <a href="http://www.semicomplete.com/projects/xdotool/">xdotool -- fake keyboard/mouse input, window management, and more</a>
</p>

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/spotify' rel='tag' target='_self'>spotify</a>, <a class='technorati-link' href='http://bloggar.se/om/xdotool' rel='tag' target='_self'>xdotool</a>
</p></small>
