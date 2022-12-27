+++
date = "2010-09-14T12:14:23+00:00"
title = "Problem med att starta gdesklets i ubuntu?"
tags = ["gdesklets", "Linux", "Python"]
+++

Jag saknade en snygg klocka att ha på min externa skärm, tanken föll på gdesklets och jag installerade det.

Jag råkade dock nästan direkt ut för problem då saker inte startade korrekt då något är fel på paketet som kommer med Ubuntu 10.04. Förmodligen är Ubuntu skeppad med för ny/gammal version av något python-bibliotek. Lösningen är dock enkel:

Redigera filen  
`/usr/lib/gdesklets/utils/ErrorFormatter.py`  
ändra:  
`def _new_imp(name, globs = {}, locls = {}, fromlist = []):`  
till:  
`def _new_imp(name, globs = {}, locls = {}, fromlist = []<strong>, test = []</strong>):`  
Klart, saker bör nu funka som de ska.

Du kan läsa mer om det här:  
<http://forum.linuxmint.com/viewtopic.php?f=90&t=32554>

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/gdesklets' rel='tag' target='_self'>gdesklets</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/python' rel='tag' target='_self'>python</a>
</p></small>
