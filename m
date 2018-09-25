Content-Type: multipart/mixed; boundary="===============3437584411790394799=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] atmodem/sim: added vendor Gemalto
Date: Tue, 25 Sep 2018 06:24:30 +0200
Message-ID: <CAKSBH7HUW004S+khVThGkq45ZURzED7vXTEwMN6gTxJk1CUNaA@mail.gmail.com>
In-Reply-To: <a1ed5e09-2be3-1ad3-dfe4-3841afb58366@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3437584411790394799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

But still, can we strive for self-contained change sets?  Just take out
> VENDOR_CINTERION use inside the sim driver and change over to
> VENDOR_GEMALTO for any modem drivers that need it.  That makes things
> much easier to follow compared to doing only the sim driver changes now
> and then flipping from one VENDOR to another at some later point.
>

they are self-contained, but I see what you mean.
I will have to submit together then a file from atmodem and a change in
plugin/cinterion.c, to be self-contained.
Another exception to the rule, I suppose, but I will do so.

Regards,
> -Denis
>

Regards,
Giacinto

--===============3437584411790394799==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRGVuaXM8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5CdXQgc3RpbGwsIGNh
biB3ZSBzdHJpdmUgZm9yIHNlbGYtY29udGFpbmVkIGNoYW5nZSBzZXRzP8KgIEp1c3QgdGFrZSBv
dXQgPGJyPgpWRU5ET1JfQ0lOVEVSSU9OIHVzZSBpbnNpZGUgdGhlIHNpbSBkcml2ZXIgYW5kIGNo
YW5nZSBvdmVyIHRvIDxicj4KVkVORE9SX0dFTUFMVE8gZm9yIGFueSBtb2RlbSBkcml2ZXJzIHRo
YXQgbmVlZCBpdC7CoCBUaGF0IG1ha2VzIHRoaW5ncyA8YnI+Cm11Y2ggZWFzaWVyIHRvIGZvbGxv
dyBjb21wYXJlZCB0byBkb2luZyBvbmx5IHRoZSBzaW0gZHJpdmVyIGNoYW5nZXMgbm93IDxicj4K
YW5kIHRoZW4gZmxpcHBpbmcgZnJvbSBvbmUgVkVORE9SIHRvIGFub3RoZXIgYXQgc29tZSBsYXRl
ciBwb2ludC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+dGhleSBhcmUgc2Vs
Zi1jb250YWluZWQsIGJ1dCBJIHNlZSB3aGF0IHlvdSBtZWFuLjwvZGl2PjxkaXY+SSB3aWxsIGhh
dmUgdG8gc3VibWl0IHRvZ2V0aGVyIHRoZW4gYSBmaWxlIGZyb20gYXRtb2RlbSBhbmQgYSBjaGFu
Z2UgaW4gcGx1Z2luL2NpbnRlcmlvbi5jLCB0byBiZSBzZWxmLWNvbnRhaW5lZC48L2Rpdj48ZGl2
PkFub3RoZXIgZXhjZXB0aW9uIHRvIHRoZSBydWxlLCBJIHN1cHBvc2UsIGJ1dCBJIHdpbGwgZG8g
c28uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+UmVnYXJkcyw8YnI+Ci1EZW5pczxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+
PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48ZGl2PsKgPC9kaXY+
PC9kaXY+PC9kaXY+Cg==

--===============3437584411790394799==--

