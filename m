Content-Type: multipart/mixed; boundary="===============3999495517382692392=="
MIME-Version: 1.0
From: r.r.zaripov <r.r.zaripov@gmail.com>
Subject: Re: Huawei E171 modem removed after execute online-modem script.
Date: Tue, 22 Apr 2014 02:45:38 +0400
Message-ID: <CAGNC_aPexNf63pEgPbfVNQBJ9J4zRqUXt_ofC4cFZ=eN7v0ung@mail.gmail.com>
In-Reply-To: <53549EE7.8070203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3999495517382692392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2014-04-21 8:30 GMT+04:00 Denis Kenzior <denkenz@gmail.com>:

>
> > ofonod[9917]: drivers/atmodem/cbs.c:at_cbs_set_topics()
> > ofonod[9917]: PCUI: > AT+CSCB=3D0\r
> > ofonod[9917]: PCUI: < \r\n+CMS ERROR: 302\r\n
> > ofonod[9917]: PCUI: >
> >
> AT+CSCB=3D0,"0-1,3,5,7,11,13,43,130,333,500,555,666,900,4096,4097,4098,40=
99,4100,4101,4102,4103,4104,4105,4352-4356"\r
> > ofonod[9917]: plugins/udevng.c:remove_device()
> >
> /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/ttyUSB0/tty=
/ttyUSB0
> > ofonod[9917]: plugins/udevng.c:destroy_modem()
> > /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
>
> Sounds like your modem doesn't like commands related to Cell Broadcast
> and goes away (likely crashes) when it receives something it finds
> objectionable.
>
> Try removing the CBS atom from this model or quirking the behavior.
>
>
I'm remove CBS atom from huawei.c and now all work fine, thanks!

Best regards,
Renat Zaripov

--===============3999495517382692392==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj5IaSBEZW5pcyw8YnI+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj4yMDE0LTA0LTIxIDg6MzAgR01UKzA0OjAwIERl
bmlzIEtlbnppb3IgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBn
bWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFu
Pjo8YnI+Cgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+PGJyPgomZ3Q7IG9mb25vZFs5OTE3XTogZHJpdmVycy9hdG1vZGVtL2Ni
cy5jOmF0X2Nic19zZXRfdG9waWNzKCk8YnI+CiZndDsgb2Zvbm9kWzk5MTddOiBQQ1VJOiAmZ3Q7
IEFUK0NTQ0I9MFxyPGJyPgomZ3Q7IG9mb25vZFs5OTE3XTogUENVSTogJmx0OyBcclxuK0NNUyBF
UlJPUjogMzAyXHJcbjxicj4KJmd0OyBvZm9ub2RbOTkxN106IFBDVUk6ICZndDs8YnI+CiZndDsg
QVQrQ1NDQj0wLCZxdW90OzAtMSwzLDUsNywxMSwxMyw0MywxMzAsMzMzLDUwMCw1NTUsNjY2LDkw
MCw0MDk2LDQwOTcsNDA5OCw0MDk5LDQxMDAsNDEwMSw0MTAyLDQxMDMsNDEwNCw0MTA1LDQzNTIt
NDM1NiZxdW90O1xyPGJyPgomZ3Q7IG9mb25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpyZW1v
dmVfZGV2aWNlKCk8YnI+CiZndDsgL3N5cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4w
L3VzYjIvMi0xLzItMS4yLzItMS4yOjEuMC90dHlVU0IwL3R0eS90dHlVU0IwPGJyPgomZ3Q7IG9m
b25vZFs5OTE3XTogcGx1Z2lucy91ZGV2bmcuYzpkZXN0cm95X21vZGVtKCk8YnI+CiZndDsgL3N5
cy9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjIvMi0xLzItMS4yPGJyPgo8YnI+
ClNvdW5kcyBsaWtlIHlvdXIgbW9kZW0gZG9lc24mIzM5O3QgbGlrZSBjb21tYW5kcyByZWxhdGVk
IHRvIENlbGwgQnJvYWRjYXN0PGJyPgphbmQgZ29lcyBhd2F5IChsaWtlbHkgY3Jhc2hlcykgd2hl
biBpdCByZWNlaXZlcyBzb21ldGhpbmcgaXQgZmluZHM8YnI+Cm9iamVjdGlvbmFibGUuPGJyPgo8
YnI+ClRyeSByZW1vdmluZyB0aGUgQ0JTIGF0b20gZnJvbSB0aGlzIG1vZGVsIG9yIHF1aXJraW5n
IHRoZSBiZWhhdmlvci48YnI+Cjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+SSYjMzk7bSByZW1v
dmUgQ0JTIGF0b20gZnJvbSBodWF3ZWkuYyBhbmQgbm93IGFsbCB3b3JrIGZpbmUsIHRoYW5rcyE8
YnI+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDxicj48L2Rpdj48ZGl2PlJlbmF0IFphcmlw
b3Y8YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============3999495517382692392==--

