Content-Type: multipart/mixed; boundary="===============7450499163798882784=="
MIME-Version: 1.0
From: WuYongbo <wilbur.unail@gmail.com>
Subject: Re: ofono Digest, Vol 20, Issue 83
Date: Tue, 21 Dec 2010 23:22:06 +0800
Message-ID: <AANLkTi=hr-oFdhKC3FZywxmjRngMz3ZCYAdZdfkxez7o@mail.gmail.com>
In-Reply-To: <mailman.3351.1292942253.10513.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7450499163798882784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

How can I get the log of ofonod on N900 with meego trunk image?
I tried modifying the /etc/rc.sysinit as following:

*if [ -x "/usr/sbin/bluetoothd" ] ; then*
*             /usr/sbin/ofonod -nd  >> /var/log/ofonod.log 2>&1*
*fi*

it does not work, even /var/log/ofonod.log is not created.

--===============7450499163798882784==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPgo8ZGl2PjxkaXY+SGkgYWxsLKA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvdyBjYW4g
SSBnZXQgdGhlIGxvZyBvZiBvZm9ub2Qgb24gTjkwMCB3aXRoIG1lZWdvIHRydW5rIGltYWdlPzwv
ZGl2PjxkaXY+SSB0cmllZCBtb2RpZnlpbmcgdGhlIC9ldGMvcmMuc3lzaW5pdCBhcyBmb2xsb3dp
bmc6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48aT48Zm9udCBjbGFzcz0iQXBwbGUtc3R5bGUt
c3BhbiIgY29sb3I9IiNGRjAwMDAiPmlmIFsgLXggJnF1b3Q7L3Vzci9zYmluL2JsdWV0b290aGQm
cXVvdDsgXSA7IHRoZW48L2ZvbnQ+PC9pPjwvZGl2Pgo8ZGl2PjxpPjxmb250IGNsYXNzPSJBcHBs
ZS1zdHlsZS1zcGFuIiBjb2xvcj0iI0ZGMDAwMCI+oKAgoCCgIKAgoCCgIC91c3Ivc2Jpbi9vZm9u
b2QgLW5kIKAmZ3Q7Jmd0OyAvdmFyL2xvZy9vZm9ub2QubG9nIDImZ3Q7JmFtcDsxPC9mb250Pjwv
aT48L2Rpdj48ZGl2PjxpPjxmb250IGNsYXNzPSJBcHBsZS1zdHlsZS1zcGFuIiBjb2xvcj0iI0ZG
MDAwMCI+Zmk8L2ZvbnQ+PC9pPjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pml0IGRvZXMgbm90
IHdvcmssIGV2ZW4gL3Zhci9sb2cvb2Zvbm9kLmxvZyBpcyBub3QgY3JlYXRlZC48L2Rpdj48L2Rp
dj4K

--===============7450499163798882784==--

