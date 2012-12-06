Content-Type: multipart/mixed; boundary="===============0447589250953372828=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: tun interface name conflicts with ppp driver
Date: Thu, 06 Dec 2012 15:58:13 +0100
Message-ID: <CABvLYuBcciGaMBvJK0ss1PiufW2=bMFsonEnmyT+Q2HeshzBtw@mail.gmail.com>
In-Reply-To: <1354794625.1815.25.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0447589250953372828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,


> actually we are using ppp%d syntax to assign the network interfaces. So
> the kernel does the numbering. This is a bug in pppd and not ours.
>
> Looking at the pppd code, it seems to hardcodes ppp0. So please complain
> to them for assuming that a certain device name is owned by them.
>

pppd requests the ppp driver to create a network interface with the ioctl
 PPPIOCNEWUNIT. If the parameter passed to the ioctl is -1, the ppp driver
will allocate the unit itself. Because it's the first network interface
created by the ppp driver, and the ppp driver doesn't know about the tun
interface, it's choosing 0. Check ppp_create_interface() in ppp_generic.c
in the kernel to see how this is done.

So it seems the ppp driver reserves the ppp%d interface names.

Regards,
Cedric

--===============0447589250953372828==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXY+SGkgTWFyY2VsLDwvZGl2PjxkaXY+oDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdiBj
bGFzcz0iaDUiPgo8L2Rpdj48L2Rpdj5hY3R1YWxseSB3ZSBhcmUgdXNpbmcgcHBwJWQgc3ludGF4
IHRvIGFzc2lnbiB0aGUgbmV0d29yayBpbnRlcmZhY2VzLiBTbzxicj4KdGhlIGtlcm5lbCBkb2Vz
IHRoZSBudW1iZXJpbmcuIFRoaXMgaXMgYSBidWcgaW4gcHBwZCBhbmQgbm90IG91cnMuPGJyPgo8
YnI+Ckxvb2tpbmcgYXQgdGhlIHBwcGQgY29kZSwgaXQgc2VlbXMgdG8gaGFyZGNvZGVzIHBwcDAu
IFNvIHBsZWFzZSBjb21wbGFpbjxicj4KdG8gdGhlbSBmb3IgYXNzdW1pbmcgdGhhdCBhIGNlcnRh
aW4gZGV2aWNlIG5hbWUgaXMgb3duZWQgYnkgdGhlbS48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2PjxkaXY+cHBwZCByZXF1ZXN0cyB0aGUgcHBwIGRyaXZlciB0byBjcmVhdGUgYSBuZXR3
b3JrIGludGVyZmFjZSB3aXRoIHRoZSBpb2N0bCCgUFBQSU9DTkVXVU5JVC4gSWYgdGhlIHBhcmFt
ZXRlciBwYXNzZWQgdG8gdGhlIGlvY3RsIGlzIC0xLCB0aGUgcHBwIGRyaXZlciB3aWxsIGFsbG9j
YXRlIHRoZSB1bml0IGl0c2VsZi4gQmVjYXVzZSBpdCYjMzk7cyB0aGUgZmlyc3QgbmV0d29yayBp
bnRlcmZhY2UgY3JlYXRlZCBieSB0aGUgcHBwIGRyaXZlciwgYW5kIHRoZSBwcHAgZHJpdmVyIGRv
ZXNuJiMzOTt0IGtub3cgYWJvdXQgdGhlIHR1biBpbnRlcmZhY2UsIGl0JiMzOTtzIGNob29zaW5n
IDAuIENoZWNroHBwcF9jcmVhdGVfaW50ZXJmYWNlKCkgaW4gcHBwX2dlbmVyaWMuYyBpbiB0aGUg
a2VybmVsIHRvIHNlZSBob3cgdGhpcyBpcyBkb25lLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2
PlNvIGl0IHNlZW1zIHRoZSBwcHAgZHJpdmVyIHJlc2VydmVzIHRoZSBwcHAlZCBpbnRlcmZhY2Ug
bmFtZXMuoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2PkNlZHJp
YzwvZGl2PjwvZGl2Pgo=

--===============0447589250953372828==--

