Content-Type: multipart/mixed; boundary="===============1202762755948667576=="
MIME-Version: 1.0
From: Davide Depau <davide@depau.eu>
Subject: Modem not detected by oFono
Date: Sat, 09 Jun 2018 15:37:18 +0200
Message-ID: <CAMp63jVABRSRaEKcf6HikG5438wX8jA-xAbQQfUYaMmXSSeZqQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1202762755948667576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,
I just built oFono on Arch Linux from git [1]. I made sure no other program
was using the modem (Huawei ME906s LTE M.2 Module) and started oFono. The
modem is not recognized and I get no output in logs:

systemd[1]: Starting Telephony service...
ofonod[32448]: oFono version 1.23
systemd[1]: Started Telephony service.
ofonod[32448]: parse_devices_reply: found 1st battery device:
/org/freedesktop/UPower/devices/battery_BAT0

I checked the DBus org.ofono.Manager interface: GetModems() returns an
empty list.
It behaves like no modem is present, even though it's detected by the
kernel:

[ 1471.866434] usb 1-2: new high-speed USB device number 8 using xhci_hcd
[ 1472.008230] usb 1-2: New USB device found, idVendor=3D12d1, idProduct=3D=
15c1
[ 1472.008234] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[ 1472.008237] usb 1-2: Product: HUAWEI Mobile
[ 1472.008239] usb 1-2: Manufacturer: Huawei Technologies Co., Ltd.
[ 1472.008241] usb 1-2: SerialNumber: 0123456789ABCDEF
[ 1472.012514] cdc_ether 1-2:2.0 wwan0: register 'cdc_ether' at
usb-0000:00:14.0-2, Mobile Broadband Network Device, [MAC addr removed]
[ 1472.013268] option 1-2:2.2: GSM modem (1-port) converter detected
[ 1472.013414] usb 1-2: GSM modem (1-port) converter now attached to ttyUSB0
[ 1472.013641] option 1-2:2.3: GSM modem (1-port) converter detected
[ 1472.013715] usb 1-2: GSM modem (1-port) converter now attached to ttyUSB1
[ 1472.013904] option 1-2:2.4: GSM modem (1-port) converter detected
[ 1472.013972] usb 1-2: GSM modem (1-port) converter now attached to ttyUSB2
[ 1472.014160] option 1-2:2.5: GSM modem (1-port) converter detected
[ 1472.014229] usb 1-2: GSM modem (1-port) converter now attached to ttyUSB3
[ 1472.014415] option 1-2:2.6: GSM modem (1-port) converter detected
[ 1472.014480] usb 1-2: GSM modem (1-port) converter now attached to ttyUSB4
[ 1472.592941] cdc_ether 1-2:2.0 wwp0s20f0u2c2: renamed from wwan0

Did I miss or mess up something?

Thank you,
Davide

[1] https://aur.archlinux.org/packages/ofono-git
-- =


--

Davide Depau
PoliEdro <https://poliedro-polimi.it/> =E2=80=93 PoliMi Pride <https://poli=
mipride.it/>
Cell: +39 327 798 7963

--===============1202762755948667576==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2PkkganVzdCBidWlsdCBvRm9ubyBv
biBBcmNoIExpbnV4IGZyb20gZ2l0IFsxXS4gSSBtYWRlIHN1cmUgbm8gb3RoZXIgcHJvZ3JhbSB3
YXMgdXNpbmcgdGhlIG1vZGVtIChIdWF3ZWkgTUU5MDZzIExURSBNLjIgTW9kdWxlKSBhbmQgc3Rh
cnRlZCBvRm9uby4gVGhlIG1vZGVtIGlzIG5vdCByZWNvZ25pemVkIGFuZCBJIGdldCBubyBvdXRw
dXQgaW4gbG9nczo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnN5c3RlbWRbMV06IFN0YXJ0aW5n
IFRlbGVwaG9ueSBzZXJ2aWNlLi4uPGJyPm9mb25vZFszMjQ0OF06IG9Gb25vIHZlcnNpb24gMS4y
Mzxicj5zeXN0ZW1kWzFdOiBTdGFydGVkIFRlbGVwaG9ueSBzZXJ2aWNlLjxicj5vZm9ub2RbMzI0
NDhdOiBwYXJzZV9kZXZpY2VzX3JlcGx5OiBmb3VuZCAxc3QgYmF0dGVyeSBkZXZpY2U6IC9vcmcv
ZnJlZWRlc2t0b3AvVVBvd2VyL2RldmljZXMvYmF0dGVyeV9CQVQwPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5JIGNoZWNrZWQgdGhlIERCdXMgb3JnLm9mb25vLk1hbmFnZXIgaW50ZXJmYWNlOiBH
ZXRNb2RlbXMoKSByZXR1cm5zIGFuIGVtcHR5IGxpc3QuPC9kaXY+PGRpdj5JdCBiZWhhdmVzIGxp
a2Ugbm8gbW9kZW0gaXMgcHJlc2VudCwgZXZlbiB0aG91Z2ggaXQmIzM5O3MgZGV0ZWN0ZWQgYnkg
dGhlIGtlcm5lbDo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlsgMTQ3MS44NjY0MzRdIHVzYiAx
LTI6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDggdXNpbmcgeGhjaV9oY2Q8YnI+
WyAxNDcyLjAwODIzMF0gdXNiIDEtMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTEy
ZDEsIGlkUHJvZHVjdD0xNWMxPGJyPlsgMTQ3Mi4wMDgyMzRdIHVzYiAxLTI6IE5ldyBVU0IgZGV2
aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0zPGJyPlsgMTQ3Mi4w
MDgyMzddIHVzYiAxLTI6IFByb2R1Y3Q6IEhVQVdFSSBNb2JpbGU8YnI+WyAxNDcyLjAwODIzOV0g
dXNiIDEtMjogTWFudWZhY3R1cmVyOiBIdWF3ZWkgVGVjaG5vbG9naWVzIENvLiwgTHRkLjxicj5b
IDE0NzIuMDA4MjQxXSB1c2IgMS0yOiBTZXJpYWxOdW1iZXI6IDAxMjM0NTY3ODlBQkNERUY8YnI+
WyAxNDcyLjAxMjUxNF0gY2RjX2V0aGVyIDEtMjoyLjAgd3dhbjA6IHJlZ2lzdGVyICYjMzk7Y2Rj
X2V0aGVyJiMzOTsgYXQgdXNiLTAwMDA6MDA6MTQuMC0yLCBNb2JpbGUgQnJvYWRiYW5kIE5ldHdv
cmsgRGV2aWNlLCBbTUFDIGFkZHIgcmVtb3ZlZF08YnI+WyAxNDcyLjAxMzI2OF0gb3B0aW9uIDEt
MjoyLjI6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgZGV0ZWN0ZWQ8YnI+WyAxNDcyLjAx
MzQxNF0gdXNiIDEtMjogR1NNIG1vZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNoZWQg
dG8gdHR5VVNCMDxicj5bIDE0NzIuMDEzNjQxXSBvcHRpb24gMS0yOjIuMzogR1NNIG1vZGVtICgx
LXBvcnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj5bIDE0NzIuMDEzNzE1XSB1c2IgMS0yOiBHU00g
bW9kZW0gKDEtcG9ydCkgY29udmVydGVyIG5vdyBhdHRhY2hlZCB0byB0dHlVU0IxPGJyPlsgMTQ3
Mi4wMTM5MDRdIG9wdGlvbiAxLTI6Mi40OiBHU00gbW9kZW0gKDEtcG9ydCkgY29udmVydGVyIGRl
dGVjdGVkPGJyPlsgMTQ3Mi4wMTM5NzJdIHVzYiAxLTI6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252
ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVTQjI8YnI+WyAxNDcyLjAxNDE2MF0gb3B0aW9uIDEt
MjoyLjU6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgZGV0ZWN0ZWQ8YnI+WyAxNDcyLjAx
NDIyOV0gdXNiIDEtMjogR1NNIG1vZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNoZWQg
dG8gdHR5VVNCMzxicj5bIDE0NzIuMDE0NDE1XSBvcHRpb24gMS0yOjIuNjogR1NNIG1vZGVtICgx
LXBvcnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj5bIDE0NzIuMDE0NDgwXSB1c2IgMS0yOiBHU00g
bW9kZW0gKDEtcG9ydCkgY29udmVydGVyIG5vdyBhdHRhY2hlZCB0byB0dHlVU0I0PGJyPlsgMTQ3
Mi41OTI5NDFdIGNkY19ldGhlciAxLTI6Mi4wIHd3cDBzMjBmMHUyYzI6IHJlbmFtZWQgZnJvbSB3
d2FuMDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRpZCBJIG1pc3Mgb3IgbWVzcyB1cCBz
b21ldGhpbmc/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmsgeW91LDwvZGl2Pjxk
aXY+RGF2aWRlPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+WzFdIDxhIGhyZWY9Imh0dHBz
Oi8vYXVyLmFyY2hsaW51eC5vcmcvcGFja2FnZXMvb2Zvbm8tZ2l0Ij5odHRwczovL2F1ci5hcmNo
bGludXgub3JnL3BhY2thZ2VzL29mb25vLWdpdDwvYT48YnI+PC9kaXY+PC9kaXY+LS0gPGJyPjxk
aXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWlsPSJnbWFp
bF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxwcmUgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7
bWFyZ2luLXRvcDowcHg7bWFyZ2luLWJvdHRvbTowcHg7cGFkZGluZzowcHg7d2hpdGUtc3BhY2U6
cHJlLXdyYXAiPjxmb250IHNpemU9IjIiIGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0tPC9m
b250PjwvcHJlPjxwcmUgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7bWFyZ2luLXRvcDowcHg7bWFy
Z2luLWJvdHRvbTowcHg7cGFkZGluZzowcHg7d2hpdGUtc3BhY2U6cHJlLXdyYXAiPjxmb250IHNp
emU9IjIiIGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPkRhdmlkZSBEZXBhdTxicj48YSBocmVm
PSJodHRwczovL3BvbGllZHJvLXBvbGltaS5pdC8iPjxmb250IGNvbG9yPSIjMDA1MDhmIj48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48Zm9udCBzdHlsZT0iZm9udC1zaXplOjEwcHQi
IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kOnRyYW5zcGFyZW50IG5vbmUgcmVwZWF0
IHNjcm9sbCAwJSAwJSI+UG9saUVkcm88L3NwYW4+PC9mb250PjwvZm9udD48L2ZvbnQ+PC9hPjxm
b250IGNvbG9yPSIjMDAwMDAwIj48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48Zm9u
dCBzdHlsZT0iZm9udC1zaXplOjEwcHQiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5k
OnRyYW5zcGFyZW50IG5vbmUgcmVwZWF0IHNjcm9sbCAwJSAwJSI+IOKAkyA8L3NwYW4+PC9mb250
PjwvZm9udD48L2ZvbnQ+PGEgaHJlZj0iaHR0cHM6Ly9wb2xpbWlwcmlkZS5pdC8iPjxmb250IGNv
bG9yPSIjMDA1MDhmIj48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48Zm9udCBzdHls
ZT0iZm9udC1zaXplOjEwcHQiIHNpemU9IjIiPjxzcGFuIHN0eWxlPSJiYWNrZ3JvdW5kOnRyYW5z
cGFyZW50IG5vbmUgcmVwZWF0IHNjcm9sbCAwJSAwJSI+UG9saU1pIFByaWRlPC9zcGFuPjwvZm9u
dD48L2ZvbnQ+PC9mb250PjwvYT4KQ2VsbDogKzM5IDMyNyA3OTggNzk2Mzxicj48L2ZvbnQ+PC9w
cmU+PC9kaXY+PC9kaXY+Cg==

--===============1202762755948667576==--

