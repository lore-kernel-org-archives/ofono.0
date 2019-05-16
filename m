Content-Type: multipart/mixed; boundary="===============0234291433523627405=="
MIME-Version: 1.0
From: riccardo.sala <riccardo.sala@springtech.it>
Subject: Re: Simcom SIM800 gprs data connection not working
Date: Thu, 16 May 2019 21:32:32 +0200
Message-ID: <PRM3MC$A827E4DA24FB85833943D175F226015A@springtech.it>
In-Reply-To: <cbedc417-1540-937a-357d-e91d56e33661@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0234291433523627405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thank you Danis for your support. =




The problem was the missing TAP/TUN support in my kernel! Now everything is=
 working.


The sim800 is similar to sim900, it has the same features. I've made this l=
ittle fix to sim900.c:




420c420
< =C2=A0=C2=A0 =C2=A0if (data->modem_type =3D=3D SIM900) {
---
> =C2=A0=C2=A0 =C2=A0if ((data->modem_type =3D=3D SIM900) || (data->modem_t=
ype =3D=3D SIM800)) {



to enable sms and gprs for the SIM800.


Regards


Da: "Denis Kenzior" denkenz(a)gmail.com
A: "Riccardo Sala" riccardo.sala(a)springtech.it, ofono(a)ofono.org
Cc: =

Data: Thu, 16 May 2019 10:39:59 -0500
Oggetto: Re: Simcom SIM800 gprs data connection not working


Hi Riccardo,
=C2=A0
> =

> # dbus-send --system --print-reply --dest=3Dorg.ofono /sim900_0/context1 =

> org.ofono.ConnectionContext.SetProperty string:"Active" =

> variant:boolean:true
> Error org.ofono.Error.NotImplemented: Implementation not provided
=C2=A0
This basically means that no gprs_context atom has been created by the =

modem driver or the driver initialization has failed.  Briefly looking =

at plugins/sim900.c, I can see that only sim900 (not sim800) supports =

gprs.  Given that you get this far, I assume you hacked this part to =

create gprs/gprs_context...
=C2=A0
The other place to look is to see whether the 'atmodem' gprs_context =

driver is working properly.  Perhaps you're missing the TUN/TAP support =

in your kernel?  Run 'sudo modprobe tun' and see if that fixes things.
=C2=A0
See drivers/atmodem/gprs-context.c for more details.
=C2=A0
Regards,
-Denis

--===============0234291433523627405==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBzdHlsZT0iZm9udDogbm9ybWFsIDEzcHggQXJpYWw7IGNvbG9yOnJnYigwLCAwLCAwKTsi
PjxkaXY+VGhhbmsgeW91IERhbmlzIGZvciB5b3VyIHN1cHBvcnQuIDxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlRoZSBwcm9ibGVtIHdhcyB0aGUgbWlzc2luZyBUQVAvVFVOIHN1cHBvcnQg
aW4gbXkga2VybmVsISBOb3cgZXZlcnl0aGluZyBpcyB3b3JraW5nLjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+VGhlIHNpbTgwMCBpcyBzaW1pbGFyIHRvIHNpbTkwMCwgaXQgaGFzIHRoZSBzYW1l
IGZlYXR1cmVzLiBJJ3ZlIG1hZGUgdGhpcyBsaXR0bGUgZml4IHRvIHNpbTkwMC5jOjxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj40MjBjNDIwPGJyPiZsdDsgJm5ic3A7Jm5i
c3A7ICZuYnNwO2lmIChkYXRhLSZndDttb2RlbV90eXBlID09IFNJTTkwMCkgezxicj4tLS08YnI+
Jmd0OyAmbmJzcDsmbmJzcDsgJm5ic3A7aWYgKChkYXRhLSZndDttb2RlbV90eXBlID09IFNJTTkw
MCkgfHwgKGRhdGEtJmd0O21vZGVtX3R5cGUgPT0gU0lNODAwKSkgezxicj48YnI+PGRpdj48YnI+
PC9kaXY+PGRpdj50byBlbmFibGUgc21zIGFuZCBncHJzIGZvciB0aGUgU0lNODAwLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkczwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsOyBmb250LXNpemU6MTFweDsgY29sb3I6IzVGNUY1Rjsi
PkRhPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbDsgZm9udC1zaXplOjEycHg7
IGNvbG9yOiM1RjVGNUY7IHBhZGRpbmctbGVmdDo1cHg7Ij46ICJEZW5pcyBLZW56aW9yIiBkZW5r
ZW56QGdtYWlsLmNvbTwvc3Bhbj48L2Rpdj4KPGRpdj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6
QXJpYWw7IGZvbnQtc2l6ZToxMXB4OyBjb2xvcjojNUY1RjVGOyI+QTwvc3Bhbj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6QXJpYWw7IGZvbnQtc2l6ZToxMnB4OyBjb2xvcjojNUY1RjVGOyBwYWRk
aW5nLWxlZnQ6NXB4OyI+OiAiUmljY2FyZG8gU2FsYSIgcmljY2FyZG8uc2FsYUBzcHJpbmd0ZWNo
Lml0LCBvZm9ub0BvZm9uby5vcmc8L3NwYW4+PC9kaXY+CjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OkFyaWFsOyBmb250LXNpemU6MTFweDsgY29sb3I6IzVGNUY1RjsiPkNjPC9zcGFuPjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbDsgZm9udC1zaXplOjEycHg7IGNvbG9yOiM1RjVG
NUY7IHBhZGRpbmctbGVmdDo1cHg7Ij46IDwvc3Bhbj48L2Rpdj4KPGRpdj48c3BhbiBzdHlsZT0i
Zm9udC1mYW1pbHk6QXJpYWw7IGZvbnQtc2l6ZToxMXB4OyBjb2xvcjojNUY1RjVGOyI+RGF0YTwv
c3Bhbj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWw7IGZvbnQtc2l6ZToxMnB4OyBjb2xv
cjojNUY1RjVGOyBwYWRkaW5nLWxlZnQ6NXB4OyI+OiBUaHUsIDE2IE1heSAyMDE5IDEwOjM5OjU5
IC0wNTAwPC9zcGFuPjwvZGl2Pgo8ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbDsg
Zm9udC1zaXplOjExcHg7IGNvbG9yOiM1RjVGNUY7Ij5PZ2dldHRvPC9zcGFuPjxzcGFuIHN0eWxl
PSJmb250LWZhbWlseTpBcmlhbDsgZm9udC1zaXplOjEycHg7IGNvbG9yOiM1RjVGNUY7IHBhZGRp
bmctbGVmdDo1cHg7Ij46IFJlOiBTaW1jb20gU0lNODAwIGdwcnMgZGF0YSBjb25uZWN0aW9uIG5v
dCB3b3JraW5nPC9zcGFuPjwvZGl2Pgo8YnI+CjxkaXY+SGkgUmljY2FyZG8sPC9kaXY+PGRpdj4m
bmJzcDs8L2Rpdj48ZGl2PiZndDsgPC9kaXY+PGRpdj4mZ3Q7ICMgZGJ1cy1zZW5kIC0tc3lzdGVt
IC0tcHJpbnQtcmVwbHkgLS1kZXN0PW9yZy5vZm9ubyAvc2ltOTAwXzAvY29udGV4dDEgPC9kaXY+
PGRpdj4mZ3Q7IG9yZy5vZm9uby5Db25uZWN0aW9uQ29udGV4dC5TZXRQcm9wZXJ0eSBzdHJpbmc6
IkFjdGl2ZSIgPC9kaXY+PGRpdj4mZ3Q7IHZhcmlhbnQ6Ym9vbGVhbjp0cnVlPC9kaXY+PGRpdj4m
Z3Q7IEVycm9yIG9yZy5vZm9uby5FcnJvci5Ob3RJbXBsZW1lbnRlZDogSW1wbGVtZW50YXRpb24g
bm90IHByb3ZpZGVkPC9kaXY+PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PlRoaXMgYmFzaWNhbGx5IG1l
YW5zIHRoYXQgbm8gZ3Byc19jb250ZXh0IGF0b20gaGFzIGJlZW4gY3JlYXRlZCBieSB0aGUgPC9k
aXY+PGRpdj5tb2RlbSBkcml2ZXIgb3IgdGhlIGRyaXZlciBpbml0aWFsaXphdGlvbiBoYXMgZmFp
bGVkLiAgQnJpZWZseSBsb29raW5nIDwvZGl2PjxkaXY+YXQgcGx1Z2lucy9zaW05MDAuYywgSSBj
YW4gc2VlIHRoYXQgb25seSBzaW05MDAgKG5vdCBzaW04MDApIHN1cHBvcnRzIDwvZGl2PjxkaXY+
Z3Bycy4gIEdpdmVuIHRoYXQgeW91IGdldCB0aGlzIGZhciwgSSBhc3N1bWUgeW91IGhhY2tlZCB0
aGlzIHBhcnQgdG8gPC9kaXY+PGRpdj5jcmVhdGUgZ3Bycy9ncHJzX2NvbnRleHQuLi48L2Rpdj48
ZGl2PiZuYnNwOzwvZGl2PjxkaXY+VGhlIG90aGVyIHBsYWNlIHRvIGxvb2sgaXMgdG8gc2VlIHdo
ZXRoZXIgdGhlICdhdG1vZGVtJyBncHJzX2NvbnRleHQgPC9kaXY+PGRpdj5kcml2ZXIgaXMgd29y
a2luZyBwcm9wZXJseS4gIFBlcmhhcHMgeW91J3JlIG1pc3NpbmcgdGhlIFRVTi9UQVAgc3VwcG9y
dCA8L2Rpdj48ZGl2PmluIHlvdXIga2VybmVsPyAgUnVuICdzdWRvIG1vZHByb2JlIHR1bicgYW5k
IHNlZSBpZiB0aGF0IGZpeGVzIHRoaW5ncy48L2Rpdj48ZGl2PiZuYnNwOzwvZGl2PjxkaXY+U2Vl
IGRyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYyBmb3IgbW9yZSBkZXRhaWxzLjwvZGl2Pjxk
aXY+Jm5ic3A7PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+LURlbmlzPC9kaXY+PC9kaXY+
--===============0234291433523627405==--

