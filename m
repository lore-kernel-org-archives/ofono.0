Content-Type: multipart/mixed; boundary="===============6590397833768851194=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 12:49:40 +0200
Message-ID: <CAKSBH7GZ4CMsrEj97Y1PSVwQQCDQ1KkaqXbFezSqrsm5HhzSWg@mail.gmail.com>
In-Reply-To: <CAFJydPUsTRmFcP+34bCe_YufRh-atSmmeY5TOPDts+XDbGKf_A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6590397833768851194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi Frank,

can you send the result of "lsusb" and "lsusb -t"?

Giacinto

On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:

> Greetings,
>
> I have an embedded device with a ublox TOBY-R200 on it.  I want to use
> connman to manage any cellular connection on that modem since connman is
> already managing ethernet and wifi connectivity.  oFono seems like the be=
st
> option.  I see that there is already a ublox plugin for oFono but I don't
> think the TOBY-R200 is supported.  The cell module is soldered onto the
> board and appears as a USB device.
>
> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
> SerialNumber=3D3
> [    6.519197] usb 1-1: Product: u-blox Cellular Module
> [    6.519204] usb 1-1: Manufacturer: u-blox
> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>
> I can send AT commands to the modem over /dev/ttyACM0.
>
> Cheers,
> Frank
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============6590397833768851194==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9ImF1dG8iPmhpIEZyYW5rLDxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBk
aXI9ImF1dG8iPmNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFu
ZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2Pjxk
aXYgZGlyPSJhdXRvIj5HaWFjaW50bzwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCAxMyBTZXAgMjAxOCwgMDA6NDEgRnJhbmsgVmFz
cXVleiwgJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVsaXVtLmNvbSI+ZnJhbmt2QGhlbGl1
bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdz
LDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGFuIGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJs
b3ggVE9CWS1SMjAwIG9uIGl0LsKgIEkgd2FudCB0byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55
IGNlbGx1bGFyIGNvbm5lY3Rpb24gb24gdGhhdCBtb2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVh
ZHkgbWFuYWdpbmcgZXRoZXJuZXQgYW5kIHdpZmkgY29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1z
IGxpa2UgdGhlIGJlc3Qgb3B0aW9uLsKgIEkgc2VlIHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVi
bG94IHBsdWdpbiBmb3Igb0Zvbm8gYnV0IEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAg
aXMgc3VwcG9ydGVkLsKgIFRoZSBjZWxsIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2Fy
ZCBhbmQgYXBwZWFycyBhcyBhIFVTQiBkZXZpY2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
ZGl2PlvCoCDCoCA2LjUxOTE5MF0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZy
PTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTM8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10g
dXNiIDEtMTogUHJvZHVjdDogdS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKg
IDYuNTE5MjA0XSB1c2IgMS0xOiBNYW51ZmFjdHVyZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKg
IDYuNTE5MjExXSB1c2IgMS0xOiBTZXJpYWxOdW1iZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2Pjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBjYW4gc2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9k
ZW0gb3ZlciAvZGV2L3R0eUFDTTAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9k
aXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2PgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVm
PSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVy
Ij5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zv
bm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============6590397833768851194==--

