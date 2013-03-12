Content-Type: multipart/mixed; boundary="===============0542179457053410289=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: [PATCH] Add vendor quirk for SIMCOM
Date: Tue, 12 Mar 2013 22:51:32 +0400
Message-ID: <CAGNC_aPtbVKVjUmx5FbJau4wAvPC_rP5p15sJzSQLbGDEGMYXA@mail.gmail.com>
In-Reply-To: <513F6DC2.8070803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0542179457053410289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Anthony, Denis,

2013/3/12 Denis Kenzior <denkenz@gmail.com>

> Hi Anthony,
>
>  And, I saw "ATD*99#" cryptic command was already used in
>> gatchat/gsmdial.c if bluetooth is enabled.
>>
>>
> This is a legacy operation for entering into data mode.  Refer to 27.007
> Section 10.2.1.1.  It can be used as a shortcut for CGDCONT/CGDATA, and it
> seems that some modems do not implement CGDATA at all.
>
>
Yes, sim900 supports AT+CGDATA command, but unfortunately I can't make it
work. I get no error messages, but the connection is not being established.
I wrote about this issue to SIMCOM, but with my local distributor this is
long story.


>  Otherwise, why this \0 after ATD*99# ? :)
>>
>>
> Good spot ;)
>
>
If I get answer from SIMCOM about AT+CGDATA and make it work properly, I
promise that never send again patch with this funny mistake;)

Anyway, Denis wrote some time ago, we can implement quirks for separating
various models of modem modules of one manufacturer. Like this:

OFONO_VENDOR_SIMCOM_SIM900
OFONO_VENDOR_SIMCOM_SIM5216E


> Regards,
> -Denis
>
> ______________________________**_________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/**listinfo/ofono<http://lists.ofono.org/listinfo/o=
fono>
>

--===============0542179457053410289==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8gQW50aG9ueSwgRGVuaXMsPGJyPjxkaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX2V4dHJhIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxMy8zLzEyIERlbmlz
IEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjxi
cj4KCgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+SGkgQW50aG9ueSw8YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpBbmQsIEkgc2F3ICZxdW90
O0FURCo5OSMmcXVvdDsgY3J5cHRpYyBjb21tYW5kIHdhcyBhbHJlYWR5IHVzZWQgaW48YnI+Cmdh
dGNoYXQvZ3NtZGlhbC5jIGlmIGJsdWV0b290aCBpcyBlbmFibGVkLjxicj4KPGJyPgo8L2Jsb2Nr
cXVvdGU+Cjxicj4KVGhpcyBpcyBhIGxlZ2FjeSBvcGVyYXRpb24gZm9yIGVudGVyaW5nIGludG8g
ZGF0YSBtb2RlLiCgUmVmZXIgdG8gMjcuMDA3IFNlY3Rpb24gMTAuMi4xLjEuIKBJdCBjYW4gYmUg
dXNlZCBhcyBhIHNob3J0Y3V0IGZvciBDR0RDT05UL0NHREFUQSwgYW5kIGl0IHNlZW1zIHRoYXQg
c29tZSBtb2RlbXMgZG8gbm90IGltcGxlbWVudCBDR0RBVEEgYXQgYWxsLjxicj4KPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Plllcywgc2ltOTAwIHN1cHBvcnRzIEFUK0NHREFU
QSBjb21tYW5kLCBidXQgdW5mb3J0dW5hdGVseSBJIGNhbiYjMzk7dCBtYWtlIGl0IHdvcmsuIEkg
Z2V0IG5vIGVycm9yIG1lc3NhZ2VzLCBidXQgdGhlIGNvbm5lY3Rpb24gaXMgbm90IGJlaW5nIGVz
dGFibGlzaGVkLiBJIHdyb3RlIGFib3V0IHRoaXMgaXNzdWUgdG8gU0lNQ09NLCBidXQgd2l0aCBt
eSBsb2NhbCBkaXN0cmlidXRvciB0aGlzIGlzIGxvbmcgc3RvcnkuIDxicj4KCjwvZGl2PjxkaXY+
oDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPgpPdGhlcndpc2UsIHdoeSB0aGlzIFwwIGFmdGVyIEFURCo5
OSMgPyA6KTxicj4KPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4KR29vZCBzcG90IDspPGJyPgo8YnI+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPklmIEkgZ2V0IGFuc3dlciBmcm9tIFNJTUNPTSBhYm91dCBB
VCtDR0RBVEEgYW5kIG1ha2UgaXQgd29yayBwcm9wZXJseSwgSSBwcm9taXNlIHRoYXQgbmV2ZXIg
c2VuZCBhZ2FpbiBwYXRjaCB3aXRoIHRoaXMgZnVubnkgbWlzdGFrZTspPGJyPjwvZGl2PjxkaXY+
PGJyPkFueXdheSwgRGVuaXMgd3JvdGUgc29tZSB0aW1lIGFnbywgd2UgY2FuIGltcGxlbWVudCBx
dWlya3MgZm9yIHNlcGFyYXRpbmcgdmFyaW91cyBtb2RlbHMgb2YgbW9kZW0gbW9kdWxlcyBvZiBv
bmUgbWFudWZhY3R1cmVyLiBMaWtlIHRoaXM6PGJyPgoKPGJyPk9GT05PX1ZFTkRPUl9TSU1DT01f
U0lNOTAwPGJyPk9GT05PX1ZFTkRPUl9TSU1DT01fU0lNNTIxNkU8YnI+PC9kaXY+PGRpdj6gPC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8YnI+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXzx1PjwvdT5fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBs
aXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayI+
b2Zvbm9Ab2Zvbm8ub3JnPC9hPjxicj4KPGEgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9s
aXN0aW5mby9vZm9ubyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9saXN0cy5vZm9uby5vcmcvPHU+
PC91Pmxpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48
L2Rpdj48L2Rpdj4K

--===============0542179457053410289==--

