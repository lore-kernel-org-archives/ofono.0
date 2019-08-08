Content-Type: multipart/mixed; boundary="===============6905952929673295817=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: Duplicated contexts...
Date: Thu, 08 Aug 2019 17:00:33 +0000
Message-ID: <CAHB-PjnzsOxc-ZbH95LQ94R05wCUz4UCdhgphNiseubEfCwZsQ@mail.gmail.com>
In-Reply-To: <d54d9b0c-d450-e021-881b-d05431588966@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6905952929673295817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 8 aug. 2019 kl 00:08 skrev Denis Kenzior <denkenz@gmail.com>:

> Hi Richard,
>
> On 8/7/19 4:44 PM, Richard R=C3=B6jfors wrote:
> > Hi,
> >
> > Just want to hear your thoughts of how to fix an issue I saw.
> >
> > The modem was told to activate with COPS=3D0, that took time.
> > And a context was activated ME PDN ACT, almost immediately when
> > registered (LTE).
>
> Interesting.  How'd you get here?  From what I understand you somehow
> got from post_sim to post_online in record time such that the sim atom
> hasn't finished initializing?
>

I think what happened was that the network.c called register_auto very
early.
Then a lot of commands were queued up, waiting for it to finish, it took
long time several seconds.
Then very quickly the modem registered the LTE context automatically.

Unfortunately I can not dig up the complete log right now, this is what I
had saved in my scratch buffer.

21:01:42 daemon.info ofonod[547]: Aux: > AT+CPMS=3D?\r
21:01:42 daemon.info ofonod[547]: Aux: < \r\n+CPMS:
("BM","ME","MT","SM","SR"),("ME","MT","SM"),("ME","MT","SM")\r\n
21:01:42 daemon.info ofonod[547]: Aux: < \r\nOK\r\n
21:01:42 daemon.info ofonod[547]: Aux: > AT+CRSM=3D178,28480,1,4,34\r
21:01:42 daemon.info ofonod[547]: Aux: < \r\n+CRSM:
144,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
"\r\n
21:01:42 daemon.info ofonod[547]: Aux: < \r\nOK\r\n
21:01:42 daemon.debug ofonod[547]:
../git/drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 34
21:01:42 daemon.info ofonod[547]: Aux: > AT+COPS=3D0\r
21:01:46 daemon.debug ofonod[547]: ../git/src/modem.c:get_modem_property()
modem 0x1b717b8 property SystemPath
21:01:51 daemon.debug ofonod[547]: ../git/src/modem.c:get_modem_property()
modem 0x1b717b8 property SystemPath
21:01:52 daemon.info ofonod[547]: Aux: < \r\nOK\r\n
21:01:52 daemon.info ofonod[547]: Aux: > AT+CMGF=3D0\r
21:01:52 daemon.info ofonod[547]: Aux: < \r\n+CIEV: 2,2\r\n
21:01:52 daemon.info ofonod[547]: Aux: < \r\n+CGEV: ME PDN ACT 4\r\n
21:01:52 daemon.info ofonod[547]: Aux: < \r\n+CGEV: NW CLASS "B"\r\n
21:01:52 daemon.info ofonod[547]: Aux: < \r\n+CREG:
5,"0080","00000006",7\r\n

So I think the interesting part is the ME PDN ACT here. and you see before
the cops=3D0 sim is still reading stuff...


> Really, a connection manager should not Online the modem until the
> SubscriberIdentity has been pushed out via signal...
>
> >
> > So gprs got notified that the CID was activated. But at that stage SIM
> > had not finished, it was queued after the COPS=3D0 and there is a long
> > sequence... So gprs had not read its provision contexts.
> > So a new context was created.....
>
> Yes, so in theory gprs atom doesn't even appear on D-Bus until the SPN
> is read from the SIM and the contexts are bootstrapped.  So in theory
> you can merge these somewhere during ofono_gprs_finish_register and the
> application won't know any difference
>

Ahh didn't think of that, that makes things easier...


>
> >
> > Later on provision contexts were read and a second context was added for
> > the same APN...
> >
> > Ideas of how to fix this:
> > 1. Delay creation of context until the GPRS atom is registered, but that
> > is racy in case the context gets activated (we have no check for
> > deactivation without a created context).
>
> This could work if we added a list_contexts method or something...
>

That would work, but be a bigger change.


>
> > 2. Merge provision context into the created context when provisioning
> > happens and send proprtychanged.
>
> You might not even need the PropertyChanged at all...
>

Good point. I vote for option 2, I think its less intrusive. agree its an
OK way forward?

BR
Richard

--===============6905952929673295817==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBEZW5pcyw8L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5EZW4gdG9ycyA4IGF1Zy4g
MjAxOSBrbCAwMDowOCBza3JldiBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVu
a2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDs6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij5IaSBSaWNoYXJkLDxicj4KPGJyPgpPbiA4LzcvMTkgNDo0NCBQTSwgUmljaGFyZCBSw7ZqZm9y
cyB3cm90ZTo8YnI+CiZndDsgSGksPGJyPgomZ3Q7IDxicj4KJmd0OyBKdXN0IHdhbnQgdG8gaGVh
ciB5b3VywqB0aG91Z2h0cyBvZiBob3cgdG8gZml4IGFuIGlzc3VlIEkgc2F3Ljxicj4KJmd0OyA8
YnI+CiZndDsgVGhlIG1vZGVtIHdhcyB0b2xkIHRvIGFjdGl2YXRlIHdpdGggQ09QUz0wLCB0aGF0
IHRvb2sgdGltZS48YnI+CiZndDsgQW5kIGEgY29udGV4dCB3YXMgYWN0aXZhdGVkIE1FIFBETiBB
Q1QsIGFsbW9zdCBpbW1lZGlhdGVseSB3aGVuIDxicj4KJmd0OyByZWdpc3RlcmVkIChMVEUpLjxi
cj4KPGJyPgpJbnRlcmVzdGluZy7CoCBIb3cmIzM5O2QgeW91IGdldCBoZXJlP8KgIEZyb20gd2hh
dCBJIHVuZGVyc3RhbmQgeW91IHNvbWVob3cgPGJyPgpnb3QgZnJvbSBwb3N0X3NpbSB0byBwb3N0
X29ubGluZSBpbiByZWNvcmQgdGltZSBzdWNoIHRoYXQgdGhlIHNpbSBhdG9tIDxicj4KaGFzbiYj
Mzk7dCBmaW5pc2hlZCBpbml0aWFsaXppbmc/PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PkkgdGhpbmsgd2hhdCBoYXBwZW5lZCB3YXMgdGhhdCB0aGUgbmV0d29yay5jIGNhbGxl
ZCByZWdpc3Rlcl9hdXRvIHZlcnkgZWFybHkuPGJyPlRoZW4gYSBsb3Qgb2YgY29tbWFuZHMgd2Vy
ZSBxdWV1ZWQgdXAsIHdhaXRpbmcgZm9yIGl0IHRvIGZpbmlzaCwgaXQgdG9vayBsb25nIHRpbWUg
c2V2ZXJhbCBzZWNvbmRzLjwvZGl2PjxkaXY+VGhlbiB2ZXJ5IHF1aWNrbHkgdGhlIG1vZGVtIHJl
Z2lzdGVyZWQgdGhlIExURSBjb250ZXh0IGF1dG9tYXRpY2FsbHkuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5VbmZvcnR1bmF0ZWx5IEkgY2FuIG5vdCBkaWcgdXAgdGhlIGNvbXBsZXRlIGxvZyBy
aWdodCBub3csIHRoaXMgaXMgd2hhdCBJIGhhZCBzYXZlZCBpbiBteSBzY3JhdGNoIGJ1ZmZlci48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjIxOjAxOjQyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24u
aW5mbyI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1NDddOiBBdXg6ICZndDsgQVQrQ1BNUz0/XHI8
YnI+MjE6MDE6NDIgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4g
b2Zvbm9kWzU0N106IEF1eDogJmx0OyBcclxuK0NQTVM6ICgmcXVvdDtCTSZxdW90OywmcXVvdDtN
RSZxdW90OywmcXVvdDtNVCZxdW90OywmcXVvdDtTTSZxdW90OywmcXVvdDtTUiZxdW90OyksKCZx
dW90O01FJnF1b3Q7LCZxdW90O01UJnF1b3Q7LCZxdW90O1NNJnF1b3Q7KSwoJnF1b3Q7TUUmcXVv
dDssJnF1b3Q7TVQmcXVvdDssJnF1b3Q7U00mcXVvdDspXHJcbjxicj4yMTowMTo0MiA8YSBocmVm
PSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5pbmZvPC9hPiBvZm9ub2RbNTQ3XTogQXV4OiAm
bHQ7IFxyXG5PS1xyXG48YnI+MjE6MDE6NDIgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZvIj5k
YWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0N106IEF1eDogJmd0OyBBVCtDUlNNPTE3OCwyODQ4MCwx
LDQsMzRccjxicj4yMTowMTo0MiA8YSBocmVmPSJodHRwOi8vZGFlbW9uLmluZm8iPmRhZW1vbi5p
bmZvPC9hPiBvZm9ub2RbNTQ3XTogQXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsJnF1b3Q7RkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkYmcXVvdDtcclxuPGJyPjIxOjAxOjQyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5m
byI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1NDddOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4y
MTowMTo0MiBkYWVtb24uZGVidWcgb2Zvbm9kWzU0N106IC4uL2dpdC9kcml2ZXJzL2F0bW9kZW0v
c2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM0PGJyPjIxOjAx
OjQyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1
NDddOiBBdXg6ICZndDsgQVQrQ09QUz0wXHI8YnI+MjE6MDE6NDYgZGFlbW9uLmRlYnVnIG9mb25v
ZFs1NDddOiAuLi9naXQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgx
YjcxN2I4IHByb3BlcnR5IFN5c3RlbVBhdGg8YnI+MjE6MDE6NTEgZGFlbW9uLmRlYnVnIG9mb25v
ZFs1NDddOiAuLi9naXQvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHgx
YjcxN2I4IHByb3BlcnR5IFN5c3RlbVBhdGg8YnI+MjE6MDE6NTIgPGEgaHJlZj0iaHR0cDovL2Rh
ZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0N106IEF1eDogJmx0OyBcclxuT0tc
clxuPGJyPjIxOjAxOjUyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24uaW5mbyI+ZGFlbW9uLmluZm88
L2E+IG9mb25vZFs1NDddOiBBdXg6ICZndDsgQVQrQ01HRj0wXHI8YnI+MjE6MDE6NTIgPGEgaHJl
Zj0iaHR0cDovL2RhZW1vbi5pbmZvIj5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0N106IEF1eDog
Jmx0OyBcclxuK0NJRVY6IDIsMlxyXG48YnI+MjE6MDE6NTIgPGEgaHJlZj0iaHR0cDovL2RhZW1v
bi5pbmZvIj5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0N106IEF1eDogJmx0OyBcclxuK0NHRVY6
IE1FIFBETiBBQ1QgNFxyXG48YnI+MjE6MDE6NTIgPGEgaHJlZj0iaHR0cDovL2RhZW1vbi5pbmZv
Ij5kYWVtb24uaW5mbzwvYT4gb2Zvbm9kWzU0N106IEF1eDogJmx0OyBcclxuK0NHRVY6IE5XIENM
QVNTICZxdW90O0ImcXVvdDtcclxuPGJyPjIxOjAxOjUyIDxhIGhyZWY9Imh0dHA6Ly9kYWVtb24u
aW5mbyI+ZGFlbW9uLmluZm88L2E+IG9mb25vZFs1NDddOiBBdXg6ICZsdDsgXHJcbitDUkVHOiA1
LCZxdW90OzAwODAmcXVvdDssJnF1b3Q7MDAwMDAwMDYmcXVvdDssN1xyXG48YnI+PC9kaXY+PGRp
dj7CoDwvZGl2PjxkaXY+U28gSSB0aGluayB0aGUgaW50ZXJlc3RpbmcgcGFydCBpcyB0aGUgTUUg
UEROIEFDVCBoZXJlLiBhbmQgeW91IHNlZSBiZWZvcmUgdGhlIGNvcHM9MCBzaW0gaXMgc3RpbGwg
cmVhZGluZyBzdHVmZi4uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpSZWFsbHks
IGEgY29ubmVjdGlvbiBtYW5hZ2VyIHNob3VsZCBub3QgT25saW5lIHRoZSBtb2RlbSB1bnRpbCB0
aGUgPGJyPgpTdWJzY3JpYmVySWRlbnRpdHkgaGFzIGJlZW4gcHVzaGVkIG91dCB2aWEgc2lnbmFs
Li4uPGJyPgo8YnI+CiZndDsgPGJyPgomZ3Q7IFNvIGdwcnMgZ290IG5vdGlmaWVkIHRoYXQgdGhl
IENJRCB3YXMgYWN0aXZhdGVkLiBCdXQgYXQgdGhhdCBzdGFnZSBTSU0gPGJyPgomZ3Q7IGhhZCBu
b3QgZmluaXNoZWQsIGl0IHdhcyBxdWV1ZWQgYWZ0ZXIgdGhlIENPUFM9MCBhbmQgdGhlcmUgaXMg
YSBsb25nIDxicj4KJmd0OyBzZXF1ZW5jZS4uLiBTbyBncHJzIGhhZCBub3QgcmVhZCBpdHMgcHJv
dmlzaW9uIGNvbnRleHRzLjxicj4KJmd0OyBTbyBhIG5ldyBjb250ZXh0IHdhcyBjcmVhdGVkLi4u
Li48YnI+Cjxicj4KWWVzLCBzbyBpbiB0aGVvcnkgZ3BycyBhdG9tIGRvZXNuJiMzOTt0IGV2ZW4g
YXBwZWFyIG9uIEQtQnVzIHVudGlsIHRoZSBTUE4gPGJyPgppcyByZWFkIGZyb20gdGhlIFNJTSBh
bmQgdGhlIGNvbnRleHRzIGFyZSBib290c3RyYXBwZWQuwqAgU28gaW4gdGhlb3J5IDxicj4KeW91
IGNhbiBtZXJnZSB0aGVzZSBzb21ld2hlcmUgZHVyaW5nIG9mb25vX2dwcnNfZmluaXNoX3JlZ2lz
dGVyIGFuZCB0aGUgPGJyPgphcHBsaWNhdGlvbiB3b24mIzM5O3Qga25vdyBhbnkgZGlmZmVyZW5j
ZTxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5BaGggZGlkbiYjMzk7dCB0aGlu
ayBvZiB0aGF0LCB0aGF0IG1ha2VzIHRoaW5ncyBlYXNpZXIuLi48L2Rpdj48ZGl2PsKgPC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPgo8YnI+CiZndDsgPGJyPgomZ3Q7IExhdGVyIG9uIHByb3Zpc2lvbiBjb250ZXh0cyB3
ZXJlIHJlYWQgYW5kIGEgc2Vjb25kIGNvbnRleHQgd2FzIGFkZGVkIGZvciA8YnI+CiZndDsgdGhl
IHNhbWUgQVBOLi4uPGJyPgomZ3Q7IDxicj4KJmd0OyBJZGVhcyBvZiBob3cgdG8gZml4IHRoaXM6
PGJyPgomZ3Q7IDEuIERlbGF5IGNyZWF0aW9uIG9mIGNvbnRleHQgdW50aWwgdGhlIEdQUlMgYXRv
bSBpcyByZWdpc3RlcmVkLCBidXQgdGhhdCA8YnI+CiZndDsgaXMgcmFjeSBpbiBjYXNlIHRoZSBj
b250ZXh0IGdldHMgYWN0aXZhdGVkICh3ZSBoYXZlIG5vIGNoZWNrIGZvciA8YnI+CiZndDsgZGVh
Y3RpdmF0aW9uIHdpdGhvdXQgYSBjcmVhdGVkIGNvbnRleHQpLjxicj4KPGJyPgpUaGlzIGNvdWxk
IHdvcmsgaWYgd2UgYWRkZWQgYSBsaXN0X2NvbnRleHRzIG1ldGhvZCBvciBzb21ldGhpbmcuLi48
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhdCB3b3VsZCB3b3JrLCBidXQg
YmUgYSBiaWdnZXIgY2hhbmdlLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+CiZn
dDsgMi4gTWVyZ2UgcHJvdmlzaW9uIGNvbnRleHQgaW50byB0aGUgY3JlYXRlZCBjb250ZXh0IHdo
ZW4gcHJvdmlzaW9uaW5nIDxicj4KJmd0OyBoYXBwZW5zIGFuZCBzZW5kIHByb3BydHljaGFuZ2Vk
Ljxicj4KPGJyPgpZb3UgbWlnaHQgbm90IGV2ZW4gbmVlZCB0aGUgUHJvcGVydHlDaGFuZ2VkIGF0
IGFsbC4uLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5Hb29kIHBvaW50LiBJ
IHZvdGUgZm9yIG9wdGlvbiAyLCBJIHRoaW5rIGl0cyBsZXNzIGludHJ1c2l2ZS4gYWdyZWUgaXRz
IGFuIE9LIHdheSBmb3J3YXJkPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QlI8L2Rpdj48ZGl2
PlJpY2hhcmQ8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============6905952929673295817==--

