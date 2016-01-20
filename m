Content-Type: multipart/mixed; boundary="===============3330285500310125314=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 20 Jan 2016 16:47:01 +0200
Message-ID: <CADnUhn1DZzkaO7wo2f7OpxA+F+mNF96XwGiS-O_Fh8svADxgwQ@mail.gmail.com>
In-Reply-To: <CADnUhn0LoDXE5j+XRMU_6EgvtRuALH1oz8TfbHcS4etN2Be=rg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3330285500310125314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I tried other modem with same type. It worked exactly the same, so this
should not be related to broken modem or corrupted firmware. What else
could I try?

Bj=C3=B8rn, is there something missing in initialization?
Is there something wrong with firmware?
Is there any chance switching modem to HiLink mode (=3D using cdc_ether) li=
ke
the older versions did?
Would it be possible by downgrading firmware or by usb_modeswitch?

If all the answers are no, I suppose I need to switch to for instance to
ModemManager or ppp without any managers.

Cheers,
Matti

2016-01-15 12:14 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com>:

> Hi Denis,
> I tried what you suggested below. Shortly: it did not work.
>
> 2016-01-14 17:32 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:
>
>> if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE) {
>>         gcd->dhcp_source =3D g_timeout_add_seconds(1, dhcp_poll, gc);
>>         return;
>> }
>>
>
> Log:
> ..drivers/huaweimodem/gprs-context.c:huawei_gprs_activate_primary() cid 1
> ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
> ofonod: Modem: < \r\nOK\r\n
> ..drivers/huaweimodem/gprs-context.c:at_cgdcont_cb() ok 1
> ofonod: Modem: > AT^NDISDUP=3D1,1\r
> ofonod: Modem: < \r\nOK\r\n
> ..drivers/huaweimodem/gprs-context.c:at_ndisdup_up_cb() ok 1
>
> ## 22 times following block
> ofonod: Modem: > AT^DHCP?\r
> ofonod: Modem: < \r\nOK\r\n
> ..drivers/huaweimodem/gprs-context.c:dhcp_query_cb() ok 1
>
> ## after that
> ..src/gprs.c:pri_activate_callback() 0x120500
> ..src/gprs.c:pri_activate_callback() Activating context failed with error:
> Unknown error type
>
> So I guess we have a problem.
> I also tried running above commands manually and really AT^DHCP? returns
> just ok.
>
> ## I compared ModemManager log with ofono.log:
> ## it has
> AT+CGDCONT=3D?
> ## command returning:
> +CGDCONT:
> (1-11),"IP",,,(0-2),(0-3)
> +CGDCONT:
> (1-11),"IPV6",,,(0-2),(0-3)
> +CGDCONT:
> (1-11),"IPV4V6",,,(0-2),(0-3)
> +CGDCONT:
> (1-11),"PPP",,,(0-2),(0-3)
>
> OK
>
> ## It also has
> AT+CGDCONT?
> ## command returning:
> +CGDCONT: 1,"IP","internet","",0,0
>
> OK
>
> I can get same values if I run same commands manually from terminal after
> killing ofonod.
> However, I do not see any AT^DHCP? nor AT^NDISDUP. So, I suppose
> ModemManager is using some other procedure while connecting.
>
> Regards,
> Matti
>

--===============3330285500310125314==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+SGksPGJyPjwvZGl2
PkkgdHJpZWQgb3RoZXIgbW9kZW0gd2l0aCBzYW1lIHR5cGUuIEl0IHdvcmtlZCBleGFjdGx5IHRo
ZSBzYW1lLCBzbyB0aGlzIHNob3VsZCBub3QgYmUgcmVsYXRlZCB0byBicm9rZW4gbW9kZW0gb3Ig
Y29ycnVwdGVkIGZpcm13YXJlLiBXaGF0IGVsc2UgY291bGQgSSB0cnk/PGJyPjxicj48L2Rpdj5C
asO4cm4sIGlzIHRoZXJlIHNvbWV0aGluZyBtaXNzaW5nIGluIGluaXRpYWxpemF0aW9uPyA8YnI+
SXMgdGhlcmUgc29tZXRoaW5nIHdyb25nIHdpdGggZmlybXdhcmU/PGJyPklzIHRoZXJlIGFueSBj
aGFuY2Ugc3dpdGNoaW5nIG1vZGVtIHRvIEhpTGluayBtb2RlICg9IHVzaW5nIGNkY19ldGhlcikg
bGlrZSB0aGUgb2xkZXIgdmVyc2lvbnMgZGlkPzxicj48L2Rpdj5Xb3VsZCBpdCBiZSBwb3NzaWJs
ZSBieSBkb3duZ3JhZGluZyBmaXJtd2FyZSBvciBieSB1c2JfbW9kZXN3aXRjaD88YnI+PGJyPjwv
ZGl2PklmIGFsbCB0aGUgYW5zd2VycyBhcmUgbm8sIEkgc3VwcG9zZSBJIG5lZWQgdG8gc3dpdGNo
IHRvIGZvciBpbnN0YW5jZSB0byBNb2RlbU1hbmFnZXIgb3IgcHBwIHdpdGhvdXQgYW55IG1hbmFn
ZXJzLjxicj48YnI+PC9kaXY+Q2hlZXJzLDxicj48L2Rpdj5NYXR0aTxicj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2LTAxLTE1
IDEyOjE0IEdNVCswMjowMCBtYXR0aSBrYWFzaW5lbiA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzptYXR0aS5rYWFzaW5lbkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXR0
aS5rYWFzaW5lbkBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgY2xhc3M9Imdt
YWlsX2V4dHJhIj5IaSBEZW5pcyw8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkkg
dHJpZWQgd2hhdCB5b3Ugc3VnZ2VzdGVkIGJlbG93LiBTaG9ydGx5OiBpdCBkaWQgbm90IHdvcmsu
PGJyPjwvZGl2PjxzcGFuIGNsYXNzPSIiPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE2
LTAxLTE0IDE3OjMyIEdNVCswMjowMCBEZW5pcyBLZW56aW9yIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGVua2Vu
ekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IHN0eWxlPSJvdmVyZmxv
dzpoaWRkZW4iPmlmIChnX2F0X3Jlc3VsdF9pdGVyX25leHQoJmFtcDtpdGVyLCAmcXVvdDteREhD
UDomcXVvdDspID09IEZBTFNFKSB7PGJyPgrCoCDCoCDCoCDCoCBnY2QtJmd0O2RoY3Bfc291cmNl
ID0gZ190aW1lb3V0X2FkZF9zZWNvbmRzKDEsIGRoY3BfcG9sbCwgZ2MpOzxicj4KwqAgwqAgwqAg
wqAgcmV0dXJuOzxicj4KfTwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9zcGFu
PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5Mb2c6PHNwYW4gY2xhc3M9IiI+PGJyPi4uZHJpdmVy
cy9odWF3ZWltb2RlbS9ncHJzLWNvbnRleHQuYzpodWF3ZWlfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5
KCkgY2lkIDE8YnI+b2Zvbm9kOiBNb2RlbTogJmd0OyBBVCtDR0RDT05UPTEsJnF1b3Q7SVAmcXVv
dDssJnF1b3Q7aW50ZXJuZXQmcXVvdDtccjxicj5vZm9ub2Q6IE1vZGVtOiAmbHQ7IFxyXG5PS1xy
XG48YnI+Li5kcml2ZXJzL2h1YXdlaW1vZGVtL2dwcnMtY29udGV4dC5jOmF0X2NnZGNvbnRfY2Io
KSBvayAxPGJyPm9mb25vZDogTW9kZW06ICZndDsgQVReTkRJU0RVUD0xLDFccjxicj5vZm9ub2Q6
IE1vZGVtOiAmbHQ7IFxyXG5PS1xyXG48YnI+PC9zcGFuPi4uZHJpdmVycy9odWF3ZWltb2RlbS9n
cHJzLWNvbnRleHQuYzphdF9uZGlzZHVwX3VwX2NiKCkgb2sgMTxicj48YnI+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZXh0cmEiPiMjIDIyIHRpbWVzIGZvbGxvd2luZyBibG9jazxicj48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PHNwYW4gY2xhc3M9IiI+b2Zvbm9kOiBNb2RlbTogJmd0
OyBBVF5ESENQP1xyPGJyPm9mb25vZDogTW9kZW06ICZsdDsgXHJcbk9LXHJcbjxicj48L3NwYW4+
Li5kcml2ZXJzL2h1YXdlaW1vZGVtL2dwcnMtY29udGV4dC5jOmRoY3BfcXVlcnlfY2IoKSBvayAx
PGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+IyMgYWZ0ZXIgdGhhdCA8YnI+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPi4uc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVf
Y2FsbGJhY2soKSAweDEyMDUwMDxicj4uLnNyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxiYWNr
KCkgQWN0aXZhdGluZyBjb250ZXh0IGZhaWxlZCB3aXRoIGVycm9yOiBVbmtub3duIGVycm9yIHR5
cGU8YnI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5TbyBJIGd1ZXNzIHdlIGhh
dmUgYSBwcm9ibGVtLjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+SSBhbHNvIHRy
aWVkIHJ1bm5pbmcgYWJvdmUgY29tbWFuZHMgbWFudWFsbHkgYW5kIHJlYWxseSBBVF5ESENQPyBy
ZXR1cm5zIGp1c3Qgb2suPGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+IyMg
SSBjb21wYXJlZCBNb2RlbU1hbmFnZXIgbG9nIHdpdGggb2Zvbm8ubG9nOiA8YnI+IyMgaXQgaGFz
IDxicj4gQVQrQ0dEQ09OVD0/PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj4jIyBj
b21tYW5kIHJldHVybmluZzo8YnI+K0NHRENPTlQ6ICgxLTExKSwmcXVvdDtJUCZxdW90OywsLCgw
LTIpLCgwLTMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8YnI+K0NHRENPTlQ6ICgxLTExKSwm
cXVvdDtJUFY2JnF1b3Q7LCwsKDAtMiksKDAtMynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPGJyPitD
R0RDT05UOiAoMS0xMSksJnF1b3Q7SVBWNFY2JnF1b3Q7LCwsKDAtMiksKDAtMynCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCA8YnI+K0NHRENPTlQ6ICgxLTExKSwmcXVvdDtQUFAmcXVvdDssLCwoMC0yKSwoMC0z
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPGJyPk9L
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgPGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
IyMgSXQgYWxzbyBoYXMgPGJyPkFUK0NHRENPTlQ/PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2V4dHJhIj4jIyBjb21tYW5kIHJldHVybmluZzo8YnI+K0NHRENPTlQ6IDEsJnF1b3Q7SVAmcXVv
dDssJnF1b3Q7aW50ZXJuZXQmcXVvdDssJnF1b3Q7JnF1b3Q7LDAsMMKgwqDCoMKgwqAgPGJyPsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA8YnI+T0vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8YnI+PGJyPjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5JIGNhbiBnZXQgc2FtZSB2YWx1ZXMgaWYgSSBydW4g
c2FtZSBjb21tYW5kcyBtYW51YWxseSBmcm9tIHRlcm1pbmFsIGFmdGVyIGtpbGxpbmcgb2Zvbm9k
Ljxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+SG93ZXZlciwgSSBkbyBub3Qgc2Vl
IGFueSBBVF5ESENQPyBub3IgQVReTkRJU0RVUC4gU28sIEkgc3VwcG9zZSBNb2RlbU1hbmFnZXIg
aXMgdXNpbmcgc29tZSBvdGhlciBwcm9jZWR1cmUgd2hpbGUgY29ubmVjdGluZy48YnI+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+UmVnYXJkcyw8YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPk1hdHRpPGJyPjwv
ZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============3330285500310125314==--

