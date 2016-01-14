Content-Type: multipart/mixed; boundary="===============3804344898289289054=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Thu, 14 Jan 2016 17:53:38 +0200
Message-ID: <CADnUhn1eDqxzZ2j1CuvnD8hQ5UYGYuwjYa8gR+oZ=yf4NjHCMQ@mail.gmail.com>
In-Reply-To: <5697BF90.8020806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3804344898289289054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,
I'll try it tomorrow. I suppose you are present about at the same time if I
have something more to comment about?

Cheers,
Matti

2016-01-14 17:32 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:

> Hi Matti,
>
>
> ..drivers/huaweimodem/gprs-context.c:huawei_gprs_activate_primary() cid 1
> ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
> ofonod: Modem: < \r\nOK\r\n
> ..drivers/huaweimodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod: Modem: > AT^NDISDUP=3D1,1\r
> ofonod: Modem: < \r\nOK\r\n
>
> ----> Activating NDIS interface seems to be okay
>
> ..drivers/huaweimodem/gprs-context.c:at_ndisdup_up_cb() ok 1
> ofonod: Modem: > AT^DHCP?\r
> ofonod: Modem: < \r\nOK\r\n
>
> ----> This is where we fail.  For some reason the firmware returns an
> empty result with an 'OK' here.  This is something the gprs-context driver
> isn't expecting.  See drivers/huaweimodem/gprs-context.c dhcp_query_cb():
>
>         if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE)
>                 return;
>
> Can you try activating the polling logic in this case as well.  E.g. by
> changing that chunk to read:
>
> if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE) {
>         gcd->dhcp_source =3D g_timeout_add_seconds(1, dhcp_poll, gc);
>         return;
> }
>
> Regards,
> -Denis
>

--===============3804344898289289054==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+RGVuaXMsPGJyPjwvZGl2PkkmIzM5O2xsIHRy
eSBpdCB0b21vcnJvdy4gSSBzdXBwb3NlIHlvdSBhcmUgcHJlc2VudCBhYm91dCBhdCB0aGUgc2Ft
ZSB0aW1lIGlmIEkgaGF2ZSBzb21ldGhpbmcgbW9yZSB0byBjb21tZW50IGFib3V0Pzxicj48YnI+
PC9kaXY+Q2hlZXJzLDxicj48L2Rpdj5NYXR0aTxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9l
eHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2LTAxLTE0IDE3OjMyIEdNVCsw
MjowMCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRl
bmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0
Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PkhpIE1hdHRpLDxicj4KPGJyPgo8YnI+Ci4uZHJpdmVycy9odWF3ZWltb2RlbS9ncHJzLWNvbnRl
eHQuYzpodWF3ZWlfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkIDE8c3BhbiBjbGFzcz0iIj48
YnI+Cm9mb25vZDogTW9kZW06ICZndDsgQVQrQ0dEQ09OVD0xLCZxdW90O0lQJnF1b3Q7LCZxdW90
O2ludGVybmV0JnF1b3Q7XHI8YnI+PC9zcGFuPjxzcGFuIGNsYXNzPSIiPgpvZm9ub2Q6IE1vZGVt
OiAmbHQ7IFxyXG5PS1xyXG48YnI+PC9zcGFuPgouLmRyaXZlcnMvaHVhd2VpbW9kZW0vZ3Bycy1j
b250ZXh0LmM6YXRfY2dkY29udF9jYigpIG9rIDE8YnI+Cm9mb25vZDogTW9kZW06ICZndDsgQVRe
TkRJU0RVUD0xLDFccjxzcGFuIGNsYXNzPSIiPjxicj4Kb2Zvbm9kOiBNb2RlbTogJmx0OyBcclxu
T0tcclxuPGJyPgo8YnI+PC9zcGFuPgotLS0tJmd0OyBBY3RpdmF0aW5nIE5ESVMgaW50ZXJmYWNl
IHNlZW1zIHRvIGJlIG9rYXk8YnI+Cjxicj4KLi5kcml2ZXJzL2h1YXdlaW1vZGVtL2dwcnMtY29u
dGV4dC5jOmF0X25kaXNkdXBfdXBfY2IoKSBvayAxPGJyPgpvZm9ub2Q6IE1vZGVtOiAmZ3Q7IEFU
XkRIQ1A/XHI8c3BhbiBjbGFzcz0iIj48YnI+Cm9mb25vZDogTW9kZW06ICZsdDsgXHJcbk9LXHJc
bjxicj4KPGJyPjwvc3Bhbj4KLS0tLSZndDsgVGhpcyBpcyB3aGVyZSB3ZSBmYWlsLsKgIEZvciBz
b21lIHJlYXNvbiB0aGUgZmlybXdhcmUgcmV0dXJucyBhbiBlbXB0eSByZXN1bHQgd2l0aCBhbiAm
IzM5O09LJiMzOTsgaGVyZS7CoCBUaGlzIGlzIHNvbWV0aGluZyB0aGUgZ3Bycy1jb250ZXh0IGRy
aXZlciBpc24mIzM5O3QgZXhwZWN0aW5nLsKgIFNlZSBkcml2ZXJzL2h1YXdlaW1vZGVtL2dwcnMt
Y29udGV4dC5jIGRoY3BfcXVlcnlfY2IoKTo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgaWYgKGdfYXRf
cmVzdWx0X2l0ZXJfbmV4dCgmYW1wO2l0ZXIsICZxdW90O15ESENQOiZxdW90OykgPT0gRkFMU0Up
PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPgo8YnI+CkNhbiB5b3UgdHJ5
IGFjdGl2YXRpbmcgdGhlIHBvbGxpbmcgbG9naWMgaW4gdGhpcyBjYXNlIGFzIHdlbGwuwqAgRS5n
LiBieSBjaGFuZ2luZyB0aGF0IGNodW5rIHRvIHJlYWQ6PGJyPgo8YnI+CmlmIChnX2F0X3Jlc3Vs
dF9pdGVyX25leHQoJmFtcDtpdGVyLCAmcXVvdDteREhDUDomcXVvdDspID09IEZBTFNFKSB7PGJy
PgrCoCDCoCDCoCDCoCBnY2QtJmd0O2RoY3Bfc291cmNlID0gZ190aW1lb3V0X2FkZF9zZWNvbmRz
KDEsIGRoY3BfcG9sbCwgZ2MpOzxicj4KwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4KfTxicj4KPGJy
PgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============3804344898289289054==--

