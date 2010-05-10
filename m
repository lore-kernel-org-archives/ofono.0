Content-Type: multipart/mixed; boundary="===============0048576476437718512=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 10:53:54 +0530
Message-ID: <COL106-W144A139CEFE4D2FDFAC5A9F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0048576476437718512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Yoon,

Thank very much for your guidance. I followed the same procedure ...

You already did following procedure.
1. ofono-phonesim -p 12345 -gui ~/data/moblin.xml
2. sudo ofonod -nd =


And then, you need to type following command to power up modem(phonesim).
3. dbus-send --system --print-reply --dest=3Dorg.ofono / phonesim0 org.ofon=
o.Modem.SetProperty string:Powered variant:boolean:true

I got below response....

Must use org.mydomain.Interface.Method notation, no dot in "phonesim0"

Please see the ps ax | grep ofono*
---------------------------------------------------------------------------=
----------------------------------------------
 1609 pts/0    S+     0:00 ofono-phonesim -p 12345 -gui /home/kandukis/data=
/moblin.xml
 1654 pts/2    S+     0:00 ofonod -nd
---------------------------------------------------------------------------=
---------------------------------------------

Can you please suggest  how to get-rid from this problem.

regards,
Krishna K Kandula 		 	   		  =

_________________________________________________________________
The amazing world in sharp snaps
http://news.in.msn.com/gallery/archive.aspx

--===============0048576476437718512==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGkg
WW9vbiw8YnI+PGJyPlRoYW5rIHZlcnkgbXVjaCBmb3IgeW91ciBndWlkYW5jZS4gSSBmb2xsb3dl
ZCB0aGUgc2FtZSBwcm9jZWR1cmUgLi4uPGJyPjxicj5Zb3UgYWxyZWFkeSBkaWQgZm9sbG93aW5n
IHByb2NlZHVyZS48YnI+MS4gb2Zvbm8tcGhvbmVzaW0gLXAgMTIzNDUgLWd1aSB+L2RhdGEvbW9i
bGluLnhtbDxicj4yLiBzdWRvIG9mb25vZCAtbmQgPGJyPjxicj5BbmQgdGhlbiwgeW91IG5lZWQg
dG8gdHlwZSBmb2xsb3dpbmcgY29tbWFuZCB0byBwb3dlciB1cCBtb2RlbShwaG9uZXNpbSkuPGJy
PjMuIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50LXJlcGx5IC0tZGVzdD1vcmcub2Zvbm8gLyBw
aG9uZXNpbTAgb3JnLm9mb25vLk1vZGVtLlNldFByb3BlcnR5IHN0cmluZzpQb3dlcmVkIHZhcmlh
bnQ6Ym9vbGVhbjp0cnVlPGJyPjxicj5JIGdvdCBiZWxvdyByZXNwb25zZS4uLi48YnI+PGJyPk11
c3QgdXNlIG9yZy5teWRvbWFpbi5JbnRlcmZhY2UuTWV0aG9kIG5vdGF0aW9uLCBubyBkb3QgaW4g
InBob25lc2ltMCI8YnI+PGJyPlBsZWFzZSBzZWUgdGhlIHBzIGF4IHwgZ3JlcCBvZm9ubyo8YnI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj4mbmJzcDsxNjA5IHB0cy8wJm5ic3A7Jm5ic3A7Jm5ic3A7IFMrJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IDA6MDAgb2Zvbm8tcGhvbmVzaW0gLXAgMTIzNDUgLWd1aSAvaG9tZS9r
YW5kdWtpcy9kYXRhL21vYmxpbi54bWw8YnI+Jm5ic3A7MTY1NCBwdHMvMiZuYnNwOyZuYnNwOyZu
YnNwOyBTKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAwOjAwIG9mb25vZCAtbmQ8YnI+LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PGJyPjxicj5DYW4geW91IHBsZWFzZSBzdWdnZXN0Jm5ic3A7IGhvdyB0byBnZXQtcmlkIGZyb20g
dGhpcyBwcm9ibGVtLjxicj48YnI+cmVnYXJkcyw8YnI+S3Jpc2huYSBLIEthbmR1bGEgCQkgCSAg
IAkJICA8YnIgLz48aHIgLz5DYXRjaCB0aGUgY2hhbmdpbmcgc2VjdXJpdHkgZW52aXJvbm1lbnQg
PGEgaHJlZj0naHR0cDovL25ld3MuaW4ubXNuLmNvbS9pbnRlcm5hbHNlY3VyaXR5LycgdGFyZ2V0
PSdfbmV3Jz5HZXQgaXQgbm93LjwvYT48L2JvZHk+CjwvaHRtbD4=
--===============0048576476437718512==--

