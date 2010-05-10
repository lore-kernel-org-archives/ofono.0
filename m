Content-Type: multipart/mixed; boundary="===============1588173971214312865=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Date: Mon, 10 May 2010 10:52:08 +0530
Message-ID: <COL106-W364D8C11A4928E5B0ADA04F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1588173971214312865==
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
Krishna K Kandula


 		 	   		  =

_________________________________________________________________
South Cinema This Decade
http://entertainment.in.msn.com/southcinemathisdecade/

--===============1588173971214312865==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGkg
WW9vbiw8YnI+PGJyPlRoYW5rIHZlcnkgbXVjaCBmb3IgeW91ciBndWlkYW5jZS4gSSBmb2xsb3dl
ZCB0aGUgc2FtZSBwcm9jZWR1cmUgLi4uPGJyPjxicj48cHJlPllvdSBhbHJlYWR5IGRpZCBmb2xs
b3dpbmcgcHJvY2VkdXJlLjxicj4xLiBvZm9uby1waG9uZXNpbSAtcCAxMjM0NSAtZ3VpIH4vZGF0
YS9tb2JsaW4ueG1sPGJyPjIuIHN1ZG8gb2Zvbm9kIC1uZCA8YnI+PGJyPkFuZCB0aGVuLCB5b3Ug
bmVlZCB0byB0eXBlIGZvbGxvd2luZyBjb21tYW5kIHRvIHBvd2VyIHVwIG1vZGVtKHBob25lc2lt
KS48YnI+My4gZGJ1cy1zZW5kIC0tc3lzdGVtIC0tcHJpbnQtcmVwbHkgLS1kZXN0PW9yZy5vZm9u
byAvIHBob25lc2ltMCBvcmcub2Zvbm8uTW9kZW0uU2V0UHJvcGVydHkgc3RyaW5nOlBvd2VyZWQg
dmFyaWFudDpib29sZWFuOnRydWU8YnI+PC9wcmU+SSBnb3QgYmVsb3cgcmVzcG9uc2UuLi4uPGJy
Pjxicj48Zm9udCBzdHlsZT0iIiBjb2xvcj0iI2MwMDAwMCI+PGI+TXVzdCB1c2Ugb3JnLm15ZG9t
YWluLkludGVyZmFjZS5NZXRob2Qgbm90YXRpb24sIG5vIGRvdCBpbiAicGhvbmVzaW0wIjwvYj48
L2ZvbnQ+PGJyPjxicj5QbGVhc2Ugc2VlIHRoZSBwcyBheCB8IGdyZXAgb2Zvbm8qPGJyPjxiPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS08L2I+PGJyPiZuYnNwOzE2MDkgcHRzLzAmbmJzcDsmbmJzcDsmbmJzcDsgUysmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgMDowMCA8Yj5vZm9uby1waG9uZXNpbTwvYj4gLXAgMTIzNDUgLWd1
aSAvaG9tZS9rYW5kdWtpcy9kYXRhL21vYmxpbi54bWw8YnI+Jm5ic3A7MTY1NCBwdHMvMiZuYnNw
OyZuYnNwOyZuYnNwOyBTKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAwOjAwIDxiPm9mb25vZDwv
Yj4gLW5kPGJyPjxiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLTwvYj48YnI+PGJyPkNhbiB5b3UgcGxlYXNlIHN1Z2dlc3QmbmJz
cDsgaG93IHRvIGdldC1yaWQgZnJvbSB0aGlzIHByb2JsZW0uPGJyPjxicj5yZWdhcmRzLDxicj5L
cmlzaG5hIEsgS2FuZHVsYTxicj48YnI+PGJyPiAJCSAJICAgCQkgIDxiciAvPjxociAvPlRoZSBs
YXRlc3QgYXV0byBsYXVuY2hlcyBhbmQgdGVzdCBkcml2ZXMgPGEgaHJlZj0naHR0cDovL2F1dG9z
LmluLm1zbi5jb20vJyB0YXJnZXQ9J19uZXcnPkRyYWcgbicgZHJvcDwvYT48L2JvZHk+CjwvaHRt
bD4=
--===============1588173971214312865==--

