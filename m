Content-Type: multipart/mixed; boundary="===============6585654613817857035=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 11:12:22 +0100
Message-ID: <CABvLYuB1FDRiL7n3u3XmDqRpKz8z5j0PxnXH00MPfEMeY3dc=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6585654613817857035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm looking to extend the alcatel plugin to be able to setup a pdp context
with an Alcatel dongle.

The first issue i ran into is right after entering the pin, "AT+CPIN?" is
returning a CME Error: SIM busy. And the PinRequired property is not
updated.
I have taken logs with the software from Alcatel, and in those logs i see
"AT+CNUM" and "AT+CSCA?" also return the same error.
I think we can get these errors while the sim is initializing.

It looks like AT+CPIN? should be polled on this device. I wanted to do this
from the alcatel plugin, but I don't know how to update the sim state from
there to change Pinrequired.
It would be done automatically if i would call __ofono_sim_recheck_pin from
the plugin, but i'm not sure if it can be called from a plugin.

Do you have any advice for me on this?

Thanks,
Cedric

--===============6585654613817857035==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIGxvb2tpbmcgdG8gZXh0ZW5kIHRoZSBhbGNh
dGVsIHBsdWdpbiB0byBiZSBhYmxlIHRvIHNldHVwIGEgcGRwIGNvbnRleHQgd2l0aCBhbiBBbGNh
dGVsIGRvbmdsZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBmaXJzdCBpc3N1ZSBpIHJh
biBpbnRvIGlzIHJpZ2h0IGFmdGVyIGVudGVyaW5nIHRoZSBwaW4sICZxdW90O0FUK0NQSU4/JnF1
b3Q7IGlzIHJldHVybmluZyBhIENNRSBFcnJvcjogU0lNIGJ1c3kuIEFuZCB0aGUgUGluUmVxdWly
ZWQgcHJvcGVydHkgaXMgbm90IHVwZGF0ZWQuPC9kaXY+CjxkaXY+SSBoYXZlIHRha2VuIGxvZ3Mg
d2l0aCB0aGUgc29mdHdhcmUgZnJvbSBBbGNhdGVsLCBhbmQgaW4gdGhvc2UgbG9ncyBpIHNlZSAm
cXVvdDtBVCtDTlVNJnF1b3Q7IGFuZCAmcXVvdDtBVCtDU0NBPyZxdW90OyBhbHNvIHJldHVybiB0
aGUgc2FtZSBlcnJvci48L2Rpdj48ZGl2PkkgdGhpbmsgd2UgY2FuIGdldCB0aGVzZSBlcnJvcnMg
d2hpbGUgdGhlIHNpbSBpcyBpbml0aWFsaXppbmcuPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+
SXQgbG9va3MgbGlrZSBBVCtDUElOPyBzaG91bGQgYmUgcG9sbGVkIG9uIHRoaXMgZGV2aWNlLiBJ
IHdhbnRlZCB0byBkbyB0aGlzIGZyb20gdGhlIGFsY2F0ZWwgcGx1Z2luLCBidXQgSSBkb24mIzM5
O3Qga25vdyBob3cgdG8gdXBkYXRlIHRoZSBzaW0gc3RhdGUgZnJvbSB0aGVyZSB0byBjaGFuZ2Ug
UGlucmVxdWlyZWQuoDwvZGl2PjxkaXY+SXQgd291bGQgYmUgZG9uZSBhdXRvbWF0aWNhbGx5IGlm
IGkgd291bGQgY2FsbCBfX29mb25vX3NpbV9yZWNoZWNrX3BpbiBmcm9tIHRoZSBwbHVnaW4sIGJ1
dCBpJiMzOTttIG5vdCBzdXJlIGlmIGl0IGNhbiBiZSBjYWxsZWQgZnJvbSBhIHBsdWdpbi48L2Rp
dj4KPGRpdj48YnI+PC9kaXY+PGRpdj5EbyB5b3UgaGF2ZSBhbnkgYWR2aWNlIGZvciBtZSBvbiB0
aGlzPzwvZGl2PjxkaXY+PGJyPlRoYW5rcyw8L2Rpdj48ZGl2PkNlZHJpYzwvZGl2Pgo=

--===============6585654613817857035==--

