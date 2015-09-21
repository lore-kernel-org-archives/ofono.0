Content-Type: multipart/mixed; boundary="===============2164770480843044723=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Hands Free/Pulse - not working well
Date: Mon, 21 Sep 2015 07:38:53 +0200
Message-ID: <55FF97ED.5030604@chini.tk>
In-Reply-To: <CAHY_EhVpk=fOi2H-aKWgW13vPH5jf6mLbTNyHN7D1V7319zwGw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2164770480843044723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21.09.2015 02:40, Jason Gauthier wrote:
>
> On Sun, Sep 20, 2015 at 3:04 PM, Georg Chini <georg@chini.tk =

> <mailto:georg@chini.tk>> wrote:
>
>     On 20.09.2015 20:27, Jason Gauthier wrote:
>>     Follow up:
>>
>>     I rebooted and I was able to make and hang up 5 calls in a row.  =

>>     All the audio was redirected correctly.
>>     I had some of the  "SCO packet" errors.
>
>     >What kind of bluetooth dongle are you using? I had completely
>     unreliable
>     >behavior with a Belkin dongle while others (MSI, Gembird) work fine.
>
>
> Bus 001 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd =

> Bluetooth Dongle (HCI mode)
> According to lsusb.
>
>     >Further down I read that you are trying this on a virtual
>     machine. Maybe
>     >the virtualization layer is the reason for the kernel crashes.
>     Did you also
>     >test it on a physical machine?
>
>
>
> You are correct.  I do a bunch of my R&D on a VM because the hardware =

> is so much faster than the pi.. and I try not to compile over and over =

> on the pi.
> So, I went through the set up this on my pi, to verify functionality.
>
> It really does work much better. As far as stability and functionality =

> I would say it works like it should.
> After the first call, the audio is broken and distorted.  the A2DP =

> profile still plays perfectly though.
>
> I don't know which layer this is happening it.  I restarted pulse, =

> ofono, and bluetoothd methodically testing after each and could not =

> improve it.
> So, that could at any layer.
>
> Thanks for your help.  I've been struggling with this setup for a few =

> weeks, trying to get it all to work.
>
>
The remaining problem is probably somewhere in the audio stack of the =

PI. As far as I understand
audio works well on your VM but you get crashes there. Can you run =

pulseaudio with debugging
(pulseaudio -vvv) on your PI and post the relevant parts of the output? =

Maybe you can even see
some difference for the second call when you compare the output of the =

PI to that of the VM.

--===============2164770480843044723==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxkaXYgY2xhc3M9Im1v
ei1jaXRlLXByZWZpeCI+T24gMjEuMDkuMjAxNSAwMjo0MCwgSmFzb24gR2F1dGhpZXIKICAgICAg
d3JvdGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZQpjaXRlPSJtaWQ6Q0FIWV9FaFZw
az1mT2kySC1hS1dnVzEzdlBINWpmNm1MYlROeUhON0QxVjczMTl6d0d3QG1haWwuZ21haWwuY29t
IgogICAgICB0eXBlPSJjaXRlIj4KICAgICAgPGRpdiBkaXI9Imx0ciI+CiAgICAgICAgPGRpdiBj
bGFzcz0iZ21haWxfZXh0cmEiPjxicj4KICAgICAgICAgIDxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij5PbiBTdW4sIFNlcCAyMCwgMjAxNSBhdCAzOjA0IFBNLAogICAgICAgICAgICBHZW9yZyBDaGlu
aSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSIKICAgICAgICAg
ICAgICAgIGhyZWY9Im1haWx0bzpnZW9yZ0BjaGluaS50ayIgdGFyZ2V0PSJfYmxhbmsiPmdlb3Jn
QGNoaW5pLnRrPC9hPiZndDs8L3NwYW4+CiAgICAgICAgICAgIHdyb3RlOjxicj4KICAgICAgICAg
ICAgPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4CjAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0
LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgogICAg
ICAgICAgICAgIDxkaXYgYmdjb2xvcj0iI0ZGRkZGRiIgdGV4dD0iIzAwMDAwMCI+CiAgICAgICAg
ICAgICAgICA8ZGl2Pk9uIDIwLjA5LjIwMTUgMjA6MjcsIEphc29uIEdhdXRoaWVyIHdyb3RlOjxi
cj4KICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICAgIDxkaXYgZGlyPSJsdHIiPkZvbGxvdyB1cDoKICAg
ICAgICAgICAgICAgICAgICA8ZGl2Pjxicj4KICAgICAgICAgICAgICAgICAgICA8L2Rpdj4KICAg
ICAgICAgICAgICAgICAgICA8ZGl2PkkgcmVib290ZWQgYW5kIEkgd2FzIGFibGUgdG8gbWFrZSBh
bmQgaGFuZyB1cCA1CiAgICAgICAgICAgICAgICAgICAgICBjYWxscyBpbiBhIHJvdy4goCBBbGwg
dGhlIGF1ZGlvIHdhcyByZWRpcmVjdGVkCiAgICAgICAgICAgICAgICAgICAgICBjb3JyZWN0bHku
PC9kaXY+CiAgICAgICAgICAgICAgICAgICAgPGRpdj5JIGhhZCBzb21lIG9mIHRoZSCgIlNDTyBw
YWNrZXQiIGVycm9ycy48L2Rpdj4KICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAg
ICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAm
Z3Q7V2hhdCBraW5kIG9mIGJsdWV0b290aCBkb25nbGUgYXJlIHlvdSB1c2luZz8gSSBoYWQKICAg
ICAgICAgICAgICAgIGNvbXBsZXRlbHkgdW5yZWxpYWJsZTxicj4KICAgICAgICAgICAgICAgICZn
dDtiZWhhdmlvciB3aXRoIGEgQmVsa2luIGRvbmdsZSB3aGlsZSBvdGhlcnMgKE1TSSwKICAgICAg
ICAgICAgICAgIEdlbWJpcmQpIHdvcmsgZmluZS48YnI+CiAgICAgICAgICAgICAgICA8YnI+CiAg
ICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAg
PGRpdj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2PgogICAgICAgICAg
ICAgIDxkaXY+QnVzIDAwMSBEZXZpY2UgMDA2OiBJRCAwYTEyOjAwMDEgQ2FtYnJpZGdlIFNpbGlj
b24KICAgICAgICAgICAgICAgIFJhZGlvLCBMdGQgQmx1ZXRvb3RoIERvbmdsZSAoSENJIG1vZGUp
PC9kaXY+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2PkFjY29yZGluZyB0byBs
c3VzYi48L2Rpdj4KICAgICAgICAgICAgPGRpdj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAg
ICAgICAgICA8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHgKMC44ZXg7Ym9yZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJn
YigyMDQsMjA0LDIwNCk7Ym9yZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
CiAgICAgICAgICAgICAgPGRpdiBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4mZ3Q7
RnVydGhlciBkb3duIEkKICAgICAgICAgICAgICAgIHJlYWQgdGhhdCB5b3UgYXJlIHRyeWluZyB0
aGlzIG9uIGEgdmlydHVhbCBtYWNoaW5lLgogICAgICAgICAgICAgICAgTWF5YmU8YnI+CiAgICAg
ICAgICAgICAgICAmZ3Q7dGhlIHZpcnR1YWxpemF0aW9uIGxheWVyIGlzIHRoZSByZWFzb24gZm9y
IHRoZQogICAgICAgICAgICAgICAga2VybmVsIGNyYXNoZXMuIERpZCB5b3UgYWxzbzxicj4KICAg
ICAgICAgICAgICAgICZndDt0ZXN0IGl0IG9uIGEgcGh5c2ljYWwgbWFjaGluZT88YnI+CiAgICAg
ICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgPGRp
dj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2Pjxicj4KICAgICAgICAg
ICAgPC9kaXY+CiAgICAgICAgICAgIDxkaXY+WW91IGFyZSBjb3JyZWN0LqAgSSBkbyBhIGJ1bmNo
IG9mIG15IFImYW1wO0Qgb24gYSBWTQogICAgICAgICAgICAgIGJlY2F1c2UgdGhlIGhhcmR3YXJl
IGlzIHNvIG11Y2ggZmFzdGVyIHRoYW4gdGhlIHBpLi4gYW5kIEkKICAgICAgICAgICAgICB0cnkg
bm90IHRvIGNvbXBpbGUgb3ZlciBhbmQgb3ZlciBvbiB0aGUgcGkuPC9kaXY+CiAgICAgICAgICAg
IDxkaXY+U28sIEkgd2VudCB0aHJvdWdoIHRoZSBzZXQgdXAgdGhpcyBvbiBteSBwaSwgdG8gdmVy
aWZ5CiAgICAgICAgICAgICAgZnVuY3Rpb25hbGl0eS48L2Rpdj4KICAgICAgICAgICAgPGRpdj48
YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8ZGl2Pkl0IHJlYWxseSBkb2VzIHdv
cmsgbXVjaCBiZXR0ZXIuIEFzIGZhciBhcyBzdGFiaWxpdHkKICAgICAgICAgICAgICBhbmQgZnVu
Y3Rpb25hbGl0eSBJIHdvdWxkIHNheSBpdCB3b3JrcyBsaWtlIGl0IHNob3VsZC48L2Rpdj4KICAg
ICAgICAgICAgPGRpdj5BZnRlciB0aGUgZmlyc3QgY2FsbCwgdGhlIGF1ZGlvIGlzIGJyb2tlbiBh
bmQKICAgICAgICAgICAgICBkaXN0b3J0ZWQuIKB0aGUgQTJEUCBwcm9maWxlIHN0aWxsIHBsYXlz
IHBlcmZlY3RseSB0aG91Z2guPC9kaXY+CiAgICAgICAgICAgIDxkaXY+PGJyPgogICAgICAgICAg
ICA8L2Rpdj4KICAgICAgICAgICAgPGRpdj5JIGRvbid0IGtub3cgd2hpY2ggbGF5ZXIgdGhpcyBp
cyBoYXBwZW5pbmcgaXQuoCBJCiAgICAgICAgICAgICAgcmVzdGFydGVkIHB1bHNlLCBvZm9ubywg
YW5kIGJsdWV0b290aGQgbWV0aG9kaWNhbGx5CiAgICAgICAgICAgICAgdGVzdGluZyBhZnRlciBl
YWNoIGFuZCBjb3VsZCBub3QgaW1wcm92ZSBpdC48L2Rpdj4KICAgICAgICAgICAgPGRpdj5Tbywg
dGhhdCBjb3VsZCBhdCBhbnkgbGF5ZXIuPC9kaXY+CiAgICAgICAgICAgIDxkaXY+PGJyPgogICAg
ICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPGRpdj5UaGFua3MgZm9yIHlvdXIgaGVscC6gIEkn
dmUgYmVlbiBzdHJ1Z2dsaW5nIHdpdGggdGhpcwogICAgICAgICAgICAgIHNldHVwIGZvciBhIGZl
dyB3ZWVrcywgdHJ5aW5nIHRvIGdldCBpdCBhbGwgdG8gd29yay48L2Rpdj4KICAgICAgICAgICAg
PGRpdj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8YnI+CiAgICAgICAgICA8
L2Rpdj4KICAgICAgICA8L2Rpdj4KICAgICAgPC9kaXY+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICBU
aGUgcmVtYWluaW5nIHByb2JsZW0gaXMgcHJvYmFibHkgc29tZXdoZXJlIGluIHRoZSBhdWRpbyBz
dGFjayBvZgogICAgdGhlIFBJLiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kPGJyPgogICAgYXVkaW8g
d29ya3Mgd2VsbCBvbiB5b3VyIFZNIGJ1dCB5b3UgZ2V0IGNyYXNoZXMgdGhlcmUuIENhbiB5b3Ug
cnVuCiAgICBwdWxzZWF1ZGlvIHdpdGggZGVidWdnaW5nPGJyPgogICAgKHB1bHNlYXVkaW8gLXZ2
dikgb24geW91ciBQSSBhbmQgcG9zdCB0aGUgcmVsZXZhbnQgcGFydHMgb2YgdGhlCiAgICBvdXRw
dXQ/IE1heWJlIHlvdSBjYW4gZXZlbiBzZWU8YnI+CiAgICBzb21lIGRpZmZlcmVuY2UgZm9yIHRo
ZSBzZWNvbmQgY2FsbCB3aGVuIHlvdSBjb21wYXJlIHRoZSBvdXRwdXQgb2YKICAgIHRoZSBQSSB0
byB0aGF0IG9mIHRoZSBWTS6gIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============2164770480843044723==--

