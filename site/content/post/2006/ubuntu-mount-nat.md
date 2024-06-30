+++
date = "2006-05-25T13:43:03+00:00"
title = "Ubuntu &#8211; Mount &#038; Nät"
[taxonomies]
tags = ["ubuntu", "linux", "mount", "wlan", "nätverk"]
+++

De senaste dagarna har jag bråkat lite med nätet, jag har både ett wlan-kort och ett vanligt nätverkskort i datorn. WLAN:et kör jag i skolan och sladd här hemma. Problemet är ett datorn har en förkärlek för att låta båda vara på när den går ur suspend eller startar, det kan skapa lite prob då datorn inte vet om det är på min eller min grannes upploppling den ska surfa på :)  
En mindre sak igentligen, men rätt störande i längden, men då jag ändå hoppar mellan skola/hemma en del så gör det inte så mycket.

En smart funktion vore (skriver i psedo-kod):  
`<br />
Vid start eller resume:<br />
&nbsp;&nbsp;&nbsp;&nbsp;wlan: på<br />
&nbsp;&nbsp;&nbsp;&nbsp;lan: av<br />
&nbsp;&nbsp;&nbsp;&nbsp;kolla om ett spec wlan-ssid finns, om nej:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;wlan: av<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;lan: på<br />
`

Då skulle den ställa in sig för wlan om jag var i skolan, och lan om jag var hemma, riktigt bekvämt, någon som vet om lått liknade, låt mig veta. Vet ej om jag har tid att skriva ett sådant själv, dessutom försöker jag inte att göra något i shell nu, vill prova hur mycket man kan göra från GUI:t i Ubuntu.

Jag har en partition på ca 20G som jag vill mounta i ubuntu, inge problem, men för att få den att automatiskt mounta till nästa start OCH att få skrivrättingheter för min användare på den är inget som jag har hittat någon GUI-inställning för, Något jag har missat? någon som vet? Eller är det en manuell editering av fstab som gäller?



<small></small>
