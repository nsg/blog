+++
date = "2010-10-18T15:18:32+00:00"
title = "HTTP proxy från terminalen"
tags = ["Bash", "Linux", "Proxy", "Skript"]
+++

Jag har arbetat på en server som inte är kopplad direkt mot nätet utan sitter bakom en proxy, att ladda ner filer på min arbetsstation för att sedan flytta de till servern är omständigt och onödigt jobb.

Räddningen är variabeln http_proxy som du kan sätta, syntaxen är:

`http://user:pass@min.fina.url:8080`

Då jag inte ville spara lösenordet i klartext så skrev jag ett litet skript som gör att jag kan skriva:

`proxy wget http://example.com/file.txt`

Det är inte perfekt men ett snabbt lite hack som gör vad det ska.

`proxy() {<br />
&nbsp;&nbsp;echo -n "Username: "<br />
&nbsp;&nbsp;read -e _username<br />
&nbsp;&nbsp;echo -n "Password: "<br />
&nbsp;&nbsp;read -es _password<br />
&nbsp;&nbsp;echo<br />
&nbsp;&nbsp;http_proxy="http://$_username:$_password@proxy.url:8080" $@<br />
}`

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/bash' rel='tag' target='_self'>bash</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/proxy' rel='tag' target='_self'>proxy</a>, <a class='technorati-link' href='http://bloggar.se/om/skript' rel='tag' target='_self'>skript</a>
</p></small>
