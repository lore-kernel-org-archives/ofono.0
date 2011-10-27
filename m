Content-Type: multipart/mixed; boundary="===============4931604218836369706=="
MIME-Version: 1.0
From: Kristen Eisenberg <kristen.eisenberg@yahoo.com>
Subject: [PATCH] Phonesim HACKING updated to refer to phonesim.conf instead of
 modem.conf.
Date: Thu, 27 Oct 2011 02:47:09 -0700
Message-ID: <1319708829.80121.YahooMailNeo@web122319.mail.ne1.yahoo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4931604218836369706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Essi,

2011/2/1 Essi Vehmersalo <essi.vehmersalo@nokia.com>:
> -automatically includes this option.
> +automatically includes this option. See phonesim.conf sample configurati=
on
> +under ofono/plugins on how to configure oFono to use phonesim.
>
>   Run phonesim in foreground using the following options
>     # ./src/phonesim -p 12345 -gui src/default.xml
>
> -Check your modem.conf file and enable the phonesim configuration before
> -executing the above command. Argument -p should be followed by the proper
> -port number, in case you have changed the default "12345". Argument -gui
> -will launch the gui once the modem is enabled.
> +Argument -p should be followed by the proper port number, in case you ha=
ve
> +changed the default "12345". Argument -gui will launch the gui once the
> +modem is enabled.

A couple of nits: there are some extra whitespace at the end of the
lines, and also, the commit message header should be below 50
characters.



Kristen Eisenberg
Billige Fl=C3=BCge
Marketing GmbH
Emanuelstr. 3,
10317 Berlin
Deutschland
Telefon: +49 (33)
5310967
Email:
utebachmeier at
gmail.com
Site:
http://flug.airego.de
- Billige Fl=C3=BCge vergleichen

--===============4931604218836369706==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGJvZHk+PGRpdiBzdHlsZT0iY29sb3I6IzAwMDsgYmFja2dyb3VuZC1jb2xvcjojZmZm
OyBmb250LWZhbWlseTp0aW1lcyBuZXcgcm9tYW4sIG5ldyB5b3JrLCB0aW1lcywgc2VyaWY7Zm9u
dC1zaXplOjEycHQiPjxkaXY+SGkgRXNzaSw8YnI+PGJyPjIwMTEvMi8xIEVzc2kgVmVobWVyc2Fs
byAmbHQ7ZXNzaS52ZWhtZXJzYWxvIGF0IG5va2lhLmNvbSZndDs6PGJyPiZndDsgLWF1dG9tYXRp
Y2FsbHkgaW5jbHVkZXMgdGhpcyBvcHRpb24uPGJyPiZndDsgK2F1dG9tYXRpY2FsbHkgaW5jbHVk
ZXMgdGhpcyBvcHRpb24uIFNlZSBwaG9uZXNpbS5jb25mIHNhbXBsZSBjb25maWd1cmF0aW9uPGJy
PiZndDsgK3VuZGVyIG9mb25vL3BsdWdpbnMgb24gaG93IHRvIGNvbmZpZ3VyZSBvRm9ubyB0byB1
c2UgcGhvbmVzaW0uPGJyPiZndDs8YnI+Jmd0OyAgIFJ1biBwaG9uZXNpbSBpbiBmb3JlZ3JvdW5k
IHVzaW5nIHRoZSBmb2xsb3dpbmcgb3B0aW9uczxicj4mZ3Q7ICAgICAjIC4vc3JjL3Bob25lc2lt
IC1wIDEyMzQ1IC1ndWkgc3JjL2RlZmF1bHQueG1sPGJyPiZndDs8YnI+Jmd0OyAtQ2hlY2sgeW91
ciBtb2RlbS5jb25mIGZpbGUgYW5kIGVuYWJsZSB0aGUgcGhvbmVzaW0gY29uZmlndXJhdGlvbiBi
ZWZvcmU8YnI+Jmd0OyAtZXhlY3V0aW5nIHRoZSBhYm92ZSBjb21tYW5kLiBBcmd1bWVudCAtcCBz
aG91bGQgYmUgZm9sbG93ZWQgYnkgdGhlIHByb3Blcjxicj4mZ3Q7IC1wb3J0IG51bWJlciwgaW4g
Y2FzZSB5b3UgaGF2ZSBjaGFuZ2VkIHRoZSBkZWZhdWx0ICIxMjM0NSIuIEFyZ3VtZW50IC1ndWk8
YnI+Jmd0OyAtd2lsbCBsYXVuY2ggdGhlIGd1aSBvbmNlIHRoZSBtb2RlbSBpcyBlbmFibGVkLjxi
cj4mZ3Q7ICtBcmd1bWVudCAtcCBzaG91bGQgYmUgZm9sbG93ZWQgYnkgdGhlIHByb3BlciBwb3J0
IG51bWJlciwgaW4gY2FzZSB5b3UgaGF2ZTxicj4mZ3Q7ICtjaGFuZ2VkIHRoZSBkZWZhdWx0CiAi
MTIzNDUiLiBBcmd1bWVudCAtZ3VpIHdpbGwgbGF1bmNoIHRoZSBndWkgb25jZSB0aGU8YnI+Jmd0
OyArbW9kZW0gaXMgZW5hYmxlZC48YnI+PGJyPkEgY291cGxlIG9mIG5pdHM6IHRoZXJlIGFyZSBz
b21lIGV4dHJhIHdoaXRlc3BhY2UgYXQgdGhlIGVuZCBvZiB0aGU8YnI+bGluZXMsIGFuZCBhbHNv
LCB0aGUgY29tbWl0IG1lc3NhZ2UgaGVhZGVyIHNob3VsZCBiZSBiZWxvdyA1MDxicj5jaGFyYWN0
ZXJzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+CgoKPGRpdiBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJERSIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdlOkRF
Ij5LcmlzdGVuIEVpc2VuYmVyZzwvc3Bhbj48L2Rpdj4KCjxkaXYgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gbGFuZz0iREUiIHN0eWxlPSJtc28tYW5zaS1sYW5ndWFnZTpERSI+QmlsbGlnZSBGbPxn
ZTwvc3Bhbj48L2Rpdj4KCjxkaXYgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iREUiIHN0
eWxlPSJtc28tYW5zaS1sYW5ndWFnZTpERSI+TWFya2V0aW5nIEdtYkg8L3NwYW4+PC9kaXY+Cgo8
ZGl2IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkRFIiBzdHlsZT0ibXNvLWFuc2ktbGFu
Z3VhZ2U6REUiPkVtYW51ZWxzdHIuIDMsPC9zcGFuPjwvZGl2PgoKPGRpdiBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBsYW5nPSJERSIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdlOkRFIj4xMDMxNyBC
ZXJsaW48L3NwYW4+PC9kaXY+Cgo8ZGl2IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkRF
IiBzdHlsZT0ibXNvLWFuc2ktbGFuZ3VhZ2U6REUiPkRldXRzY2hsYW5kPC9zcGFuPjwvZGl2PgoK
PGRpdiBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJERSIgc3R5bGU9Im1zby1hbnNpLWxh
bmd1YWdlOkRFIj5UZWxlZm9uOiArNDkgKDMzKTwvc3Bhbj48L2Rpdj4KCjxkaXYgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gbGFuZz0iREUiIHN0eWxlPSJtc28tYW5zaS1sYW5ndWFnZTpERSI+NTMx
MDk2Nzwvc3Bhbj48L2Rpdj4KCjxkaXYgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iREUi
IHN0eWxlPSJtc28tYW5zaS1sYW5ndWFnZTpERSI+RW1haWw6PC9zcGFuPjwvZGl2PgoKPGRpdiBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJERSIgc3R5bGU9Im1zby1hbnNpLWxhbmd1YWdl
OkRFIj51dGViYWNobWVpZXIgYXQ8L3NwYW4+PC9kaXY+Cgo8ZGl2IGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIGxhbmc9IkRFIiBzdHlsZT0ibXNvLWFuc2ktbGFuZ3VhZ2U6REUiPmdtYWlsLmNvbTwv
c3Bhbj48L2Rpdj4KCjxkaXYgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iREUiIHN0eWxl
PSJtc28tYW5zaS1sYW5ndWFnZTpERSI+U2l0ZTo8L3NwYW4+PC9kaXY+Cgo8ZGl2IGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIGxhbmc9IkRFIiBzdHlsZT0ibXNvLWFuc2ktbGFuZ3VhZ2U6REUiPmh0
dHA6Ly9mbHVnLmFpcmVnby5kZQotIEJpbGxpZ2UgRmz8Z2UgdmVyZ2xlaWNoZW48L3NwYW4+PC9k
aXY+PC9kaXY+PC9kaXY+PC9ib2R5PjwvaHRtbD4=
--===============4931604218836369706==--

