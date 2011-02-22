Content-Type: multipart/mixed; boundary="===============2108844892683324348=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 16:20:54 +0100
Message-ID: <AANLkTik5Yf6bbhE5QEuaT0wkookN1ExcQ=pNram37JyQ@mail.gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1E7BDF9@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2108844892683324348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/2/22 <Vijay.Nayani@elektrobit.com>

>
>
> > -----Original Message-----
> > From: Tomasz Gregorek [mailto:tomasz.gregorek(a)gmail.com]
> > Sent: 22 February 2011 16:09
> > To: ofono(a)ofono.org
> > Cc: Nayani Vijay
> > Subject: Re: [PATCH] atmodem: CEREG support for LTE network
> > status reporting in AT modem
> >
> > Hi Vijay
> >
> >
> > 2011/2/22 <Vijay.Nayani@elektrobit.com>
> >
> >
> >
> >
> >       > Subject: [PATCH] atmodem: CEREG support for LTE network
> >       > status reporting in AT modem
> >       >
> >       > [PATCH] atmodem: CEREG support for LTE network status
> >       > reporting in AT modem Tomasz Gregorek tomasz.gregorek at
> >       > gmail.com Thu Feb 17 19:52:45 PST 2011
> >       >
> >       >     * Previous message: [PATCH 2/5] bluetooth: add a
> >       > bluetoothd connect watch
> >       >     * Next message: Problem with SIM lock states not showing
> >       > correctly in Ofono API.
> >       >     * Messages sorted by: [ date ] [ thread ] [
> > subject ] [ author ]
> >       >
> >       > From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>
> >
> >       >
> >       > This is a proposal for CEREG support based on the AT modem.
> >       > Support in driver should work, though I have an issue
> > with the core.
> >       >
> >       > The core has one gprs status currently. In case of having
> >       > second status for LTE, there is need of having two satuses,
> >       > one for each, 3G and LTE, or to combine those two into one.
> >       >
> >       > I took second approach as it leaves current oFono API, though
> >       > it is not perfect.
> >
> >
> >       I have been working on solution that comprises of
> > separate eps atom and
> >       corresponding driver. Code has been tested against
> > modified phonesim for
> >       eps.Will provide an RFC patch soon once I bring it to
> > certain logical
> >       end.
> >
> >       Regards,
> >       Vijay
> >
> >
> >
> > This is what I was thinking about too.
> > For me, from status point of view, both networks look very
> > similar, thats why I was thinking about using gprs atom /
> > driver for status handling and create separate atom for QoS / IMS.
> >
>
> I agree with you , both bearers are almost similar.Minor difference i
> see are context managment (especially default context creation) and some
> eps related spill over on other existing atoms (For ex SIM would not
> contain some ISIM (IMPU/IMPI)related stuff).My idea is seperate atoms
> solution would even work for legacy switch back(CSFB) too with a minimal
> impact on exiting architecture.Your comments on these ideas would also
> very valuable here as i assume you have real modem unlike me.
>
> My main concern is about LTE only modems, these ones would not register
gprs
atom so all stuff from gprs atom needs to be done in eps atom, plus CEREG
and initial PDN. Than if you have a mix modem with 3G and LTE than all this
"stuff"
would be done twice without some additional logic. Sounds complicated to me.
About initial PDN, acually I think it can be placed in gprs atom
too, it won't influence 3G modems at all and we have +CGEV: handling there
already
(maybe not the strongest argument but would make things easier).


> > I am at most interested in your solution. I know from Denis
> > that this is what was agreed.
> >
> > Br
> > Tomasz Gregorek
> >
>
> Will submit the rfc patch and short design write up once i have code
> ready.
>
Ok. More comments as soon as there will be some code.


>
> Br,
> Vijay
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

Br
Tomasz

--===============2108844892683324348==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMS8yLzIyICA8c3BhbiBkaXI9Imx0
ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpWaWpheS5OYXlhbmlAZWxla3Ryb2JpdC5jb20iPlZpamF5
Lk5heWFuaUBlbGVrdHJvYml0LmNvbTwvYT4mZ3Q7PC9zcGFuPjxicj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXIt
bGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4K
PGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+Cjxicj4KJmd0OyAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLTxicj4KJmd0OyBGcm9tOiBUb21hc3ogR3JlZ29yZWsgW21haWx0bzo8
YSBocmVmPSJtYWlsdG86dG9tYXN6LmdyZWdvcmVrQGdtYWlsLmNvbSI+dG9tYXN6LmdyZWdvcmVr
QGdtYWlsLmNvbTwvYT5dPGJyPgomZ3Q7IFNlbnQ6IDIyIEZlYnJ1YXJ5IDIwMTEgMTY6MDk8YnI+
CiZndDsgVG86IDxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9y
ZzwvYT48YnI+CiZndDsgQ2M6IE5heWFuaSBWaWpheTxicj4KJmd0OyBTdWJqZWN0OiBSZTogW1BB
VENIXSBhdG1vZGVtOiBDRVJFRyBzdXBwb3J0IGZvciBMVEUgbmV0d29yazxicj4KJmd0OyBzdGF0
dXMgcmVwb3J0aW5nIGluIEFUIG1vZGVtPGJyPgomZ3Q7PGJyPgomZ3Q7IEhpIFZpamF5PGJyPgom
Z3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IDIwMTEvMi8yMiAmbHQ7PGEgaHJlZj0ibWFpbHRvOlZpamF5
Lk5heWFuaUBlbGVrdHJvYml0LmNvbSI+VmlqYXkuTmF5YW5pQGVsZWt0cm9iaXQuY29tPC9hPiZn
dDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDs8YnI+CiZndDsgoCCgIKAgJmd0
OyBTdWJqZWN0OiBbUEFUQ0hdIGF0bW9kZW06IENFUkVHIHN1cHBvcnQgZm9yIExURSBuZXR3b3Jr
PGJyPgomZ3Q7IKAgoCCgICZndDsgc3RhdHVzIHJlcG9ydGluZyBpbiBBVCBtb2RlbTxicj4KJmd0
OyCgIKAgoCAmZ3Q7PGJyPgomZ3Q7IKAgoCCgICZndDsgW1BBVENIXSBhdG1vZGVtOiBDRVJFRyBz
dXBwb3J0IGZvciBMVEUgbmV0d29yayBzdGF0dXM8YnI+CiZndDsgoCCgIKAgJmd0OyByZXBvcnRp
bmcgaW4gQVQgbW9kZW0gVG9tYXN6IEdyZWdvcmVrIHRvbWFzei5ncmVnb3JlayBhdDxicj4KJmd0
OyCgIKAgoCAmZ3Q7IDxhIGhyZWY9Imh0dHA6Ly9nbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5n
bWFpbC5jb208L2E+IFRodSBGZWIgMTcgMTk6NTI6NDUgUFNUIDIwMTE8YnI+CiZndDsgoCCgIKAg
Jmd0Ozxicj4KJmd0OyCgIKAgoCAmZ3Q7IKAgoCAqIFByZXZpb3VzIG1lc3NhZ2U6IFtQQVRDSCAy
LzVdIGJsdWV0b290aDogYWRkIGE8YnI+CiZndDsgoCCgIKAgJmd0OyBibHVldG9vdGhkIGNvbm5l
Y3Qgd2F0Y2g8YnI+CiZndDsgoCCgIKAgJmd0OyCgIKAgKiBOZXh0IG1lc3NhZ2U6IFByb2JsZW0g
d2l0aCBTSU0gbG9jayBzdGF0ZXMgbm90IHNob3dpbmc8YnI+CiZndDsgoCCgIKAgJmd0OyBjb3Jy
ZWN0bHkgaW4gT2Zvbm8gQVBJLjxicj4KJmd0OyCgIKAgoCAmZ3Q7IKAgoCAqIE1lc3NhZ2VzIHNv
cnRlZCBieTogWyBkYXRlIF0gWyB0aHJlYWQgXSBbPGJyPgomZ3Q7IHN1YmplY3QgXSBbIGF1dGhv
ciBdPGJyPgomZ3Q7IKAgoCCgICZndDs8YnI+CiZndDsgoCCgIKAgJmd0OyBGcm9tOiBUb21hc3og
R3JlZ29yZWsgJmx0O3RvbWFzei5ncmVnb3JlayBhdCA8YSBocmVmPSJodHRwOi8vc3Rlcmljc3Nv
bi5jb20iIHRhcmdldD0iX2JsYW5rIj5zdGVyaWNzc29uLmNvbTwvYT4mZ3Q7PGJyPgomZ3Q7PGJy
PgomZ3Q7IKAgoCCgICZndDs8YnI+CiZndDsgoCCgIKAgJmd0OyBUaGlzIGlzIGEgcHJvcG9zYWwg
Zm9yIENFUkVHIHN1cHBvcnQgYmFzZWQgb24gdGhlIEFUIG1vZGVtLjxicj4KJmd0OyCgIKAgoCAm
Z3Q7IFN1cHBvcnQgaW4gZHJpdmVyIHNob3VsZCB3b3JrLCB0aG91Z2ggSSBoYXZlIGFuIGlzc3Vl
PGJyPgomZ3Q7IHdpdGggdGhlIGNvcmUuPGJyPgomZ3Q7IKAgoCCgICZndDs8YnI+CiZndDsgoCCg
IKAgJmd0OyBUaGUgY29yZSBoYXMgb25lIGdwcnMgc3RhdHVzIGN1cnJlbnRseS4gSW4gY2FzZSBv
ZiBoYXZpbmc8YnI+CiZndDsgoCCgIKAgJmd0OyBzZWNvbmQgc3RhdHVzIGZvciBMVEUsIHRoZXJl
IGlzIG5lZWQgb2YgaGF2aW5nIHR3byBzYXR1c2VzLDxicj4KJmd0OyCgIKAgoCAmZ3Q7IG9uZSBm
b3IgZWFjaCwgM0cgYW5kIExURSwgb3IgdG8gY29tYmluZSB0aG9zZSB0d28gaW50byBvbmUuPGJy
PgomZ3Q7IKAgoCCgICZndDs8YnI+CiZndDsgoCCgIKAgJmd0OyBJIHRvb2sgc2Vjb25kIGFwcHJv
YWNoIGFzIGl0IGxlYXZlcyBjdXJyZW50IG9Gb25vIEFQSSwgdGhvdWdoPGJyPgomZ3Q7IKAgoCCg
ICZndDsgaXQgaXMgbm90IHBlcmZlY3QuPGJyPgomZ3Q7PGJyPgomZ3Q7PGJyPgomZ3Q7IKAgoCCg
IEkgaGF2ZSBiZWVuIHdvcmtpbmcgb24gc29sdXRpb24gdGhhdCBjb21wcmlzZXMgb2Y8YnI+CiZn
dDsgc2VwYXJhdGUgZXBzIGF0b20gYW5kPGJyPgomZ3Q7IKAgoCCgIGNvcnJlc3BvbmRpbmcgZHJp
dmVyLiBDb2RlIGhhcyBiZWVuIHRlc3RlZCBhZ2FpbnN0PGJyPgomZ3Q7IG1vZGlmaWVkIHBob25l
c2ltIGZvcjxicj4KJmd0OyCgIKAgoCBlcHMuV2lsbCBwcm92aWRlIGFuIFJGQyBwYXRjaCBzb29u
IG9uY2UgSSBicmluZyBpdCB0bzxicj4KJmd0OyBjZXJ0YWluIGxvZ2ljYWw8YnI+CiZndDsgoCCg
IKAgZW5kLjxicj4KJmd0Ozxicj4KJmd0OyCgIKAgoCBSZWdhcmRzLDxicj4KJmd0OyCgIKAgoCBW
aWpheTxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyBUaGlzIGlzIHdoYXQgSSB3
YXMgdGhpbmtpbmcgYWJvdXQgdG9vLjxicj4KJmd0OyBGb3IgbWUsIGZyb20gc3RhdHVzIHBvaW50
IG9mIHZpZXcsIGJvdGggbmV0d29ya3MgbG9vayB2ZXJ5PGJyPgomZ3Q7IHNpbWlsYXIsIHRoYXRz
IHdoeSBJIHdhcyB0aGlua2luZyBhYm91dCB1c2luZyBncHJzIGF0b20gLzxicj4KJmd0OyBkcml2
ZXIgZm9yIHN0YXR1cyBoYW5kbGluZyBhbmQgY3JlYXRlIHNlcGFyYXRlIGF0b20gZm9yIFFvUyAv
IElNUy48YnI+CiZndDs8YnI+Cjxicj4KPC9kaXY+PC9kaXY+SSBhZ3JlZSB3aXRoIHlvdSAsIGJv
dGggYmVhcmVycyBhcmUgYWxtb3N0IHNpbWlsYXIuTWlub3IgZGlmZmVyZW5jZSBpPGJyPgpzZWUg
YXJlIGNvbnRleHQgbWFuYWdtZW50IChlc3BlY2lhbGx5IGRlZmF1bHQgY29udGV4dCBjcmVhdGlv
bikgYW5kIHNvbWU8YnI+CmVwcyByZWxhdGVkIHNwaWxsIG92ZXIgb24gb3RoZXIgZXhpc3Rpbmcg
YXRvbXMgKEZvciBleCBTSU0gd291bGQgbm90PGJyPgpjb250YWluIHNvbWUgSVNJTSAoSU1QVS9J
TVBJKXJlbGF0ZWQgc3R1ZmYpLk15IGlkZWEgaXMgc2VwZXJhdGUgYXRvbXM8YnI+CnNvbHV0aW9u
IHdvdWxkIGV2ZW4gd29yayBmb3IgbGVnYWN5IHN3aXRjaCBiYWNrKENTRkIpIHRvbyB3aXRoIGEg
bWluaW1hbDxicj4KaW1wYWN0IG9uIGV4aXRpbmcgYXJjaGl0ZWN0dXJlLllvdXIgY29tbWVudHMg
b24gdGhlc2UgaWRlYXMgd291bGQgYWxzbzxicj4KdmVyeSB2YWx1YWJsZSBoZXJlIGFzIGkgYXNz
dW1lIHlvdSBoYXZlIHJlYWwgbW9kZW0gdW5saWtlIG1lLjxicj4KPGRpdiBjbGFzcz0iaW0iPjxi
cj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5NeSBtYWluIGNvbmNlcm4gaXMgYWJvdXQgTFRFIG9u
bHkgbW9kZW1zLCB0aGVzZSBvbmVzIHdvdWxkIG5vdCByZWdpc3RlciBncHJzPGJyPmF0b20gc28g
YWxsIHN0dWZmIGZyb20gZ3BycyBhdG9tIG5lZWRzIHRvIGJlIGRvbmUgaW4gZXBzIGF0b20sIHBs
dXMgQ0VSRUc8YnI+YW5kIGluaXRpYWwgUEROLiBUaGFuIGlmIHlvdSBoYXZlIGEgbWl4IG1vZGVt
IHdpdGggM0cgYW5kIExURSB0aGFuIGFsbCB0aGlzICZxdW90O3N0dWZmJnF1b3Q7PGJyPgp3b3Vs
ZCBiZSBkb25lIHR3aWNlIHdpdGhvdXQgc29tZSBhZGRpdGlvbmFsIGxvZ2ljLiBTb3VuZHMgY29t
cGxpY2F0ZWQgdG8gbWUuPGJyPkFib3V0IGluaXRpYWwgUEROLCBhY3VhbGx5IEkgdGhpbmsgaXQg
Y2FuIGJlIHBsYWNlZCBpbiBncHJzIGF0b208YnI+dG9vLCBpdCB3b24mIzM5O3QgaW5mbHVlbmNl
IDNHIG1vZGVtcyBhdCBhbGwgYW5kIHdlIGhhdmUgK0NHRVY6IGhhbmRsaW5nIHRoZXJlIGFscmVh
ZHk8YnI+CihtYXliZSBub3QgdGhlIHN0cm9uZ2VzdCBhcmd1bWVudCBidXQgd291bGQgbWFrZSB0
aGluZ3MgZWFzaWVyKS48YnI+oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQg
cmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsiPjxkaXYgY2xhc3M9ImltIj4K
Jmd0OyBJIGFtIGF0IG1vc3QgaW50ZXJlc3RlZCBpbiB5b3VyIHNvbHV0aW9uLiBJIGtub3cgZnJv
bSBEZW5pczxicj4KJmd0OyB0aGF0IHRoaXMgaXMgd2hhdCB3YXMgYWdyZWVkLjxicj4KJmd0Ozxi
cj4KJmd0OyBCcjxicj4KJmd0OyBUb21hc3ogR3JlZ29yZWs8YnI+CiZndDs8YnI+Cjxicj4KPC9k
aXY+V2lsbCBzdWJtaXQgdGhlIHJmYyBwYXRjaCBhbmQgc2hvcnQgZGVzaWduIHdyaXRlIHVwIG9u
Y2UgaSBoYXZlIGNvZGU8YnI+CnJlYWR5Ljxicj48L2Jsb2NrcXVvdGU+PGRpdj5Pay4gTW9yZSBj
b21tZW50cyBhcyBzb29uIGFzIHRoZXJlIHdpbGwgYmUgc29tZSBjb2RlLjxicj6gPGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAw
cHQgMC44ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRk
aW5nLWxlZnQ6IDFleDsiPgoKPGJyPgpCciw8YnI+CjxkaXY+PGRpdj48L2Rpdj48ZGl2IGNsYXNz
PSJoNSI+VmlqYXk8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0Bv
Zm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5v
Zm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vbGlzdHMub2Zv
bm8ub3JnL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2Pjxicj5Ccjxicj5Ub21hc3o8YnI+Cg==

--===============2108844892683324348==--

