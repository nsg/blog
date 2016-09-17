+++
date = "2011-03-28T21:23:06+00:00"
title = "Inget tema i Ubuntu? Har du en SSD eller mycket snabb disk?"
tags = ["Gnome", "Linux", "SSD", "Ubuntu"]
+++

Jag köpte en ny dator för en vecka sedan, det vanliga med moderkort, minne, cpu o.s.v&#8230; jag kostade dock på mig två SSD:er som jag valde att köra i RAID 0 (strip) med motiveringen &#8220;att det är kul&#8221;. Det resulterar till en ganska brutal läs och skrivhastighet och jag stötte på ett ganska lustigt problem.

Om datorn startar för snabbt så kan Ubuntu råka ut för  det roliga problemet att temat inte laddas. Jag påstår inte att jag vet vad som går fel men gnome-settings-daemon hinner starta för fort innan något annat är startat.

Lösningen är enkelt, lägg en liten fördröjning innan gnome-settings-daemon och låt &#8220;vad det nu är&#8221; hinna starta. Det är vad jag kallar ett fulhack men ett acceptabelt sådant för att fixa en bugg i väntan på att den blir fixad.

Redigera filen  
`/etc/xdg/autostart/gnome-settings-daemon.desktop`

Ändra raden Exec till  
`Exec= bash -c “sleep 2; /usr/lib/gnome-settings-daemon/gnome-settings-daemon”`

Notera &#8220;sleep 2&#8243;, om du vill experimentera kan du prova med en sekund i stället, men en sekund hit eller dit känns inte märkbart. Hjälper inte det prova med en större siffra. Kanske din dator behöver lite mer tid på sig.

Jag hoppas det hjälper någon.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/gnome' rel='tag' target='_self'>gnome</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/SSD' rel='tag' target='_self'>SSD</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>
