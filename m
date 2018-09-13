Content-Type: multipart/mixed; boundary="===============5632862760334287760=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 10:21:11 -0700
Message-ID: <CAFJydPUVNVhBcmDcYAmx1=ggEXCxvZz=7EYXHdgjmhMspGny2Q@mail.gmail.com>
In-Reply-To: <CAKSBH7GZ4CMsrEj97Y1PSVwQQCDQ1KkaqXbFezSqrsm5HhzSWg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5632862760334287760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> can you send the result of "lsusb" and "lsusb -t"?

# lsusb -t
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 002: ID 1546:1107
Bus 002 Device 001: ID 1d6b:0003

I am running BusyBox's stripped down version of lsusb that's why
information is so lacking.
I'll install usbutils on my device's Buildroot image and rerun the commands.

Cheers,
Frank

On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> hi Frank,
>
> can you send the result of "lsusb" and "lsusb -t"?
>
> Giacinto
>
> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:
>
>> Greetings,
>>
>> I have an embedded device with a ublox TOBY-R200 on it.  I want to use
>> connman to manage any cellular connection on that modem since connman is
>> already managing ethernet and wifi connectivity.  oFono seems like the b=
est
>> option.  I see that there is already a ublox plugin for oFono but I don't
>> think the TOBY-R200 is supported.  The cell module is soldered onto the
>> board and appears as a USB device.
>>
>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
>> SerialNumber=3D3
>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>> [    6.519204] usb 1-1: Manufacturer: u-blox
>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>
>> I can send AT commands to the modem over /dev/ttyACM0.
>>
>> Cheers,
>> Frank
>> _______________________________________________
>> ofono mailing list
>> ofono(a)ofono.org
>> https://lists.ofono.org/mailman/listinfo/ofono
>>
>

--===============5632862760334287760==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPGRpdj48YnI+PC9kaXY+
PGRpdj4mZ3Q7IGNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFu
ZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+IyBs
c3VzYiAtdDwvZGl2PjxkaXY+QnVzIDAwMSBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDI8L2Rpdj48
ZGl2PkJ1cyAwMDEgRGV2aWNlIDAwMjogSUQgMTU0NjoxMTA3PC9kaXY+PGRpdj5CdXMgMDAyIERl
dmljZSAwMDE6IElEIDFkNmI6MDAwMzwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBh
bSBydW5uaW5nIEJ1c3lCb3gmIzM5O3Mgc3RyaXBwZWQgZG93biB2ZXJzaW9uIG9mIGxzdXNiIHRo
YXQmIzM5O3Mgd2h5IGluZm9ybWF0aW9uIGlzIHNvIGxhY2tpbmcuPC9kaXY+PGRpdj5JJiMzOTts
bCBpbnN0YWxsIHVzYnV0aWxzIG9uIG15IGRldmljZSYjMzk7cyBCdWlsZHJvb3QgaW1hZ2UgYW5k
IHJlcnVuIHRoZSBjb21tYW5kcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rp
dj48ZGl2PkZyYW5rPC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAzOjQ5IEFNIEdpYWNpbnRv
IENpZmVsbGkgJmx0OzxhIGhyZWY9Im1haWx0bzpnY2lvZm9ub0BnbWFpbC5jb20iPmdjaW9mb25v
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0iYXV0byI+aGkgRnJhbmssPGRpdiBkaXI9
ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+Y2FuIHlvdSBzZW5kIHRoZSByZXN1bHQg
b2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7PzwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkdpYWNpbnRvPC9kaXY+PC9kaXY+
PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIDEzIFNl
cCAyMDE4LCAwMDo0MSBGcmFuayBWYXNxdWV6LCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBo
ZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90
ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxkaXY+PGJyPjwvZGl2Pjxk
aXY+SSBoYXZlIGFuIGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJsb3ggVE9CWS1SMjAwIG9uIGl0
LsKgIEkgd2FudCB0byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55IGNlbGx1bGFyIGNvbm5lY3Rp
b24gb24gdGhhdCBtb2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVhZHkgbWFuYWdpbmcgZXRoZXJu
ZXQgYW5kIHdpZmkgY29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1zIGxpa2UgdGhlIGJlc3Qgb3B0
aW9uLsKgIEkgc2VlIHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVibG94IHBsdWdpbiBmb3Igb0Zv
bm8gYnV0IEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAgaXMgc3VwcG9ydGVkLsKgIFRo
ZSBjZWxsIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2FyZCBhbmQgYXBwZWFycyBhcyBh
IFVTQiBkZXZpY2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PlvCoCDCoCA2LjUxOTE5
MF0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2Vy
aWFsTnVtYmVyPTM8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10gdXNiIDEtMTogUHJvZHVjdDog
dS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjA0XSB1c2IgMS0x
OiBNYW51ZmFjdHVyZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjExXSB1c2IgMS0x
OiBTZXJpYWxOdW1iZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSBjYW4gc2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9kZW0gb3ZlciAvZGV2L3R0eUFD
TTAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2
PjwvZGl2PjwvZGl2PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zv
bm8ub3JnIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8
L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L29mb25vIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2Nr
cXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============5632862760334287760==--

