Content-Type: multipart/mixed; boundary="===============1515322930521446092=="
MIME-Version: 1.0
From: Davide Depau <davide@depau.eu>
Subject: Re: Modem not detected by oFono
Date: Thu, 14 Jun 2018 18:24:54 +0200
Message-ID: <CAMp63jVPH5bpEm6PjWuL8YsdK7cU8mz_Hpyc6kQNqrdUqoq=UA@mail.gmail.com>
In-Reply-To: <20180614121905.GA8798@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1515322930521446092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,
thank you. I checked `udevng.c` and I see the vendor ID:

>        { "huawei",     "cdc_wdm",      "12d1"          },
>        { "huawei",     "cdc_ether",    "12d1"          },
>        { "huawei",     "qmi_wwan",     "12d1"          },
>        { "huawei",     "option",       "12d1"          },

(btw the modem is 12d1:15c1). Maybe it is being detect but discarded
somewhere else (I'm just guessing). Is it possible to increase logging
level to system log?

Davide

On Thu, Jun 14, 2018 at 2:19 PM Pavel Machek <pavel@ucw.cz> wrote:

> On Sat 2018-06-09 15:37:18, Davide Depau wrote:
> > Hello,
> > I just built oFono on Arch Linux from git [1]. I made sure no other
> program
> > was using the modem (Huawei ME906s LTE M.2 Module) and started oFono. T=
he
> > modem is not recognized and I get no output in logs:
> >
> > systemd[1]: Starting Telephony service...
> > ofonod[32448]: oFono version 1.23
> > systemd[1]: Started Telephony service.
> > ofonod[32448]: parse_devices_reply: found 1st battery device:
> > /org/freedesktop/UPower/devices/battery_BAT0
> >
> > I checked the DBus org.ofono.Manager interface: GetModems() returns an
> > empty list.
> > It behaves like no modem is present, even though it's detected by the
> > kernel:
> >
> > [ 1471.866434] usb 1-2: new high-speed USB device number 8 using xhci_h=
cd
> > [ 1472.008230] usb 1-2: New USB device found, idVendor=3D12d1,
> idProduct=3D15c1
> > [ 1472.008234] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,
> > SerialNumber=3D3
> > [ 1472.008237] usb 1-2: Product: HUAWEI Mobile
> > [ 1472.008239] usb 1-2: Manufacturer: Huawei Technologies Co., Ltd.
> > [ 1472.008241] usb 1-2: SerialNumber: 0123456789ABCDEF
> > [ 1472.012514 <0125%2014>] cdc_ether 1-2:2.0 wwan0: register
> 'cdc_ether' at
> > usb-0000:00:14.0-2, Mobile Broadband Network Device, [MAC addr removed]
> > [ 1472.013268] option 1-2:2.2: GSM modem (1-port) converter detected
> > [ 1472.013414] usb 1-2: GSM modem (1-port) converter now attached to
> ttyUSB0
> > [ 1472.013641] option 1-2:2.3: GSM modem (1-port) converter detected
> > [ 1472.013715] usb 1-2: GSM modem (1-port) converter now attached to
> ttyUSB1
> > [ 1472.013904] option 1-2:2.4: GSM modem (1-port) converter detected
> > [ 1472.013972] usb 1-2: GSM modem (1-port) converter now attached to
> ttyUSB2
> > [ 1472.014160 <0141%2060>] option 1-2:2.5: GSM modem (1-port) converter
> detected
> > [ 1472.014229 <0142%2029>] usb 1-2: GSM modem (1-port) converter now
> attached to ttyUSB3
> > [ 1472.014415 <0144%2015>] option 1-2:2.6: GSM modem (1-port) converter
> detected
> > [ 1472.014480 <0144%2080>] usb 1-2: GSM modem (1-port) converter now
> attached to ttyUSB4
> > [ 1472.592941] cdc_ether 1-2:2.0 wwp0s20f0u2c2: renamed from wwan0
> >
> > Did I miss or mess up something?
>
> Perhaps modems vid/pid needs to the list somewhere? (Maybe udevng.c ?)
>
> Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
-- =


--

Davide Depau
PoliEdro <https://poliedro-polimi.it/> =E2=80=93 PoliMi Pride <https://poli=
mipride.it/>
Cell: +39 327 798 7963

--===============1515322930521446092==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBQYXZlbCw8L2Rpdj48ZGl2PnRoYW5rIHlvdS4gSSBjaGVj
a2VkIGB1ZGV2bmcuY2AgYW5kIEkgc2VlIHRoZSB2ZW5kb3IgSUQ6PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj4mZ3Q7wqDCoMKgwqDCoMKgwqAgeyAmcXVvdDtodWF3ZWkmcXVvdDsswqDCoMKgwqAg
JnF1b3Q7Y2RjX3dkbSZxdW90OyzCoMKgwqDCoMKgICZxdW90OzEyZDEmcXVvdDvCoMKgwqDCoMKg
wqDCoMKgwqAgfSw8YnI+Jmd0O8KgwqDCoMKgwqDCoMKgIHsgJnF1b3Q7aHVhd2VpJnF1b3Q7LMKg
wqDCoMKgICZxdW90O2NkY19ldGhlciZxdW90OyzCoMKgwqAgJnF1b3Q7MTJkMSZxdW90O8KgwqDC
oMKgwqDCoMKgwqDCoCB9LDxicj4mZ3Q7wqDCoMKgwqDCoMKgwqAgeyAmcXVvdDtodWF3ZWkmcXVv
dDsswqDCoMKgwqAgJnF1b3Q7cW1pX3d3YW4mcXVvdDsswqDCoMKgwqAgJnF1b3Q7MTJkMSZxdW90
O8KgwqDCoMKgwqDCoMKgwqDCoCB9LDxicj4mZ3Q7wqDCoMKgwqDCoMKgwqAgeyAmcXVvdDtodWF3
ZWkmcXVvdDsswqDCoMKgwqAgJnF1b3Q7b3B0aW9uJnF1b3Q7LMKgwqDCoMKgwqDCoCAmcXVvdDsx
MmQxJnF1b3Q7wqDCoMKgwqDCoMKgwqDCoMKgIH0sPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4o
YnR3CiB0aGUgbW9kZW0gaXMgMTJkMToxNWMxKS4gTWF5YmUgaXQgaXMgYmVpbmcgZGV0ZWN0IGJ1
dCBkaXNjYXJkZWQgCnNvbWV3aGVyZSBlbHNlIChJJiMzOTttIGp1c3QgZ3Vlc3NpbmcpLiBJcyBp
dCBwb3NzaWJsZSB0byBpbmNyZWFzZSBsb2dnaW5nIApsZXZlbCB0byBzeXN0ZW0gbG9nPzwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+RGF2aWRlPGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBKdW4gMTQsIDIwMTggYXQgMjox
OSBQTSBQYXZlbCBNYWNoZWsgJmx0OzxhIGhyZWY9Im1haWx0bzpwYXZlbEB1Y3cuY3oiPnBhdmVs
QHVjdy5jejwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij5PbiBTYXQgMjAxOC0wNi0wOSAxNTozNzoxOCwgRGF2aWRlIERl
cGF1IHdyb3RlOjxicj4KJmd0OyBIZWxsbyw8YnI+CiZndDsgSSBqdXN0IGJ1aWx0IG9Gb25vIG9u
IEFyY2ggTGludXggZnJvbSBnaXQgWzFdLiBJIG1hZGUgc3VyZSBubyBvdGhlciBwcm9ncmFtPGJy
PgomZ3Q7IHdhcyB1c2luZyB0aGUgbW9kZW0gKEh1YXdlaSBNRTkwNnMgTFRFIE0uMiBNb2R1bGUp
IGFuZCBzdGFydGVkIG9Gb25vLiBUaGU8YnI+CiZndDsgbW9kZW0gaXMgbm90IHJlY29nbml6ZWQg
YW5kIEkgZ2V0IG5vIG91dHB1dCBpbiBsb2dzOjxicj4KJmd0OyA8YnI+CiZndDsgc3lzdGVtZFsx
XTogU3RhcnRpbmcgVGVsZXBob255IHNlcnZpY2UuLi48YnI+CiZndDsgb2Zvbm9kWzMyNDQ4XTog
b0Zvbm8gdmVyc2lvbiAxLjIzPGJyPgomZ3Q7IHN5c3RlbWRbMV06IFN0YXJ0ZWQgVGVsZXBob255
IHNlcnZpY2UuPGJyPgomZ3Q7IG9mb25vZFszMjQ0OF06IHBhcnNlX2RldmljZXNfcmVwbHk6IGZv
dW5kIDFzdCBiYXR0ZXJ5IGRldmljZTo8YnI+CiZndDsgL29yZy9mcmVlZGVza3RvcC9VUG93ZXIv
ZGV2aWNlcy9iYXR0ZXJ5X0JBVDA8YnI+CiZndDsgPGJyPgomZ3Q7IEkgY2hlY2tlZCB0aGUgREJ1
cyBvcmcub2Zvbm8uTWFuYWdlciBpbnRlcmZhY2U6IEdldE1vZGVtcygpIHJldHVybnMgYW48YnI+
CiZndDsgZW1wdHkgbGlzdC48YnI+CiZndDsgSXQgYmVoYXZlcyBsaWtlIG5vIG1vZGVtIGlzIHBy
ZXNlbnQsIGV2ZW4gdGhvdWdoIGl0JiMzOTtzIGRldGVjdGVkIGJ5IHRoZTxicj4KJmd0OyBrZXJu
ZWw6PGJyPgomZ3Q7IDxicj4KJmd0OyBbIDE0NzEuODY2NDM0XSB1c2IgMS0yOiBuZXcgaGlnaC1z
cGVlZCBVU0IgZGV2aWNlIG51bWJlciA4IHVzaW5nIHhoY2lfaGNkPGJyPgomZ3Q7IFsgMTQ3Mi4w
MDgyMzBdIHVzYiAxLTI6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRvcj0xMmQxLCBpZFBy
b2R1Y3Q9MTVjMTxicj4KJmd0OyBbIDE0NzIuMDA4MjM0XSB1c2IgMS0yOiBOZXcgVVNCIGRldmlj
ZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLDxicj4KJmd0OyBTZXJpYWxOdW1iZXI9Mzxicj4K
Jmd0OyBbIDE0NzIuMDA4MjM3XSB1c2IgMS0yOiBQcm9kdWN0OiBIVUFXRUkgTW9iaWxlPGJyPgom
Z3Q7IFsgMTQ3Mi4wMDgyMzldIHVzYiAxLTI6IE1hbnVmYWN0dXJlcjogSHVhd2VpIFRlY2hub2xv
Z2llcyBDby4sIEx0ZC48YnI+CiZndDsgWyAxNDcyLjAwODI0MV0gdXNiIDEtMjogU2VyaWFsTnVt
YmVyOiAwMTIzNDU2Nzg5QUJDREVGPGJyPgomZ3Q7IFsgMTQ3Mi48YSBocmVmPSJ0ZWw6MDEyNSUy
MDE0IiB2YWx1ZT0iKzM5MDEyNTE0IiB0YXJnZXQ9Il9ibGFuayI+MDEyNTE0PC9hPl0gY2RjX2V0
aGVyIDEtMjoyLjAgd3dhbjA6IHJlZ2lzdGVyICYjMzk7Y2RjX2V0aGVyJiMzOTsgYXQ8YnI+CiZn
dDsgdXNiLTAwMDA6MDA6MTQuMC0yLCBNb2JpbGUgQnJvYWRiYW5kIE5ldHdvcmsgRGV2aWNlLCBb
TUFDIGFkZHIgcmVtb3ZlZF08YnI+CiZndDsgWyAxNDcyLjAxMzI2OF0gb3B0aW9uIDEtMjoyLjI6
IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgZGV0ZWN0ZWQ8YnI+CiZndDsgWyAxNDcyLjAx
MzQxNF0gdXNiIDEtMjogR1NNIG1vZGVtICgxLXBvcnQpIGNvbnZlcnRlciBub3cgYXR0YWNoZWQg
dG8gdHR5VVNCMDxicj4KJmd0OyBbIDE0NzIuMDEzNjQxXSBvcHRpb24gMS0yOjIuMzogR1NNIG1v
ZGVtICgxLXBvcnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj4KJmd0OyBbIDE0NzIuMDEzNzE1XSB1
c2IgMS0yOiBHU00gbW9kZW0gKDEtcG9ydCkgY29udmVydGVyIG5vdyBhdHRhY2hlZCB0byB0dHlV
U0IxPGJyPgomZ3Q7IFsgMTQ3Mi4wMTM5MDRdIG9wdGlvbiAxLTI6Mi40OiBHU00gbW9kZW0gKDEt
cG9ydCkgY29udmVydGVyIGRldGVjdGVkPGJyPgomZ3Q7IFsgMTQ3Mi4wMTM5NzJdIHVzYiAxLTI6
IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVTQjI8YnI+
CiZndDsgWyAxNDcyLjxhIGhyZWY9InRlbDowMTQxJTIwNjAiIHZhbHVlPSIrMzkwMTQxNjAiIHRh
cmdldD0iX2JsYW5rIj4wMTQxNjA8L2E+XSBvcHRpb24gMS0yOjIuNTogR1NNIG1vZGVtICgxLXBv
cnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj4KJmd0OyBbIDE0NzIuPGEgaHJlZj0idGVsOjAxNDIl
MjAyOSIgdmFsdWU9IiszOTAxNDIyOSIgdGFyZ2V0PSJfYmxhbmsiPjAxNDIyOTwvYT5dIHVzYiAx
LTI6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVTQjM8
YnI+CiZndDsgWyAxNDcyLjxhIGhyZWY9InRlbDowMTQ0JTIwMTUiIHZhbHVlPSIrMzkwMTQ0MTUi
IHRhcmdldD0iX2JsYW5rIj4wMTQ0MTU8L2E+XSBvcHRpb24gMS0yOjIuNjogR1NNIG1vZGVtICgx
LXBvcnQpIGNvbnZlcnRlciBkZXRlY3RlZDxicj4KJmd0OyBbIDE0NzIuPGEgaHJlZj0idGVsOjAx
NDQlMjA4MCIgdmFsdWU9IiszOTAxNDQ4MCIgdGFyZ2V0PSJfYmxhbmsiPjAxNDQ4MDwvYT5dIHVz
YiAxLTI6IEdTTSBtb2RlbSAoMS1wb3J0KSBjb252ZXJ0ZXIgbm93IGF0dGFjaGVkIHRvIHR0eVVT
QjQ8YnI+CiZndDsgWyAxNDcyLjU5Mjk0MV0gY2RjX2V0aGVyIDEtMjoyLjAgd3dwMHMyMGYwdTJj
MjogcmVuYW1lZCBmcm9tIHd3YW4wPGJyPgomZ3Q7IDxicj4KJmd0OyBEaWQgSSBtaXNzIG9yIG1l
c3MgdXAgc29tZXRoaW5nPzxicj4KPGJyPgpQZXJoYXBzIG1vZGVtcyB2aWQvcGlkIG5lZWRzIHRv
IHRoZSBsaXN0IHNvbWV3aGVyZT8gKE1heWJlIHVkZXZuZy5jID8pPGJyPgrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQYXZlbDxicj4KLS0gPGJyPgoo
ZW5nbGlzaCkgPGEgaHJlZj0iaHR0cDovL3d3dy5saXZlam91cm5hbC5jb20vfnBhdmVsbWFjaGVr
IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmxpdmVqb3VybmFs
LmNvbS9+cGF2ZWxtYWNoZWs8L2E+PGJyPgooY2Vza3ksIHBpY3R1cmVzKSA8YSBocmVmPSJodHRw
Oi8vYXRyZXkua2FybGluLm1mZi5jdW5pLmN6L35wYXZlbC9waWN0dXJlL2hvcnNlcy9ibG9nLmh0
bWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9hdHJleS5rYXJsaW4u
bWZmLmN1bmkuY3ovfnBhdmVsL3BpY3R1cmUvaG9yc2VzL2Jsb2cuaHRtbDwvYT48YnI+CjwvYmxv
Y2txdW90ZT48L2Rpdj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVy
ZSIgZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PHByZSBz
dHlsZT0iY29sb3I6cmdiKDAsMCwwKTttYXJnaW4tdG9wOjBweDttYXJnaW4tYm90dG9tOjBweDtw
YWRkaW5nOjBweDt3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+PGZvbnQgc2l6ZT0iMiIgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+LS08L2ZvbnQ+PC9wcmU+PHByZSBzdHlsZT0iY29sb3I6cmdiKDAs
MCwwKTttYXJnaW4tdG9wOjBweDttYXJnaW4tYm90dG9tOjBweDtwYWRkaW5nOjBweDt3aGl0ZS1z
cGFjZTpwcmUtd3JhcCI+PGZvbnQgc2l6ZT0iMiIgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
RGF2aWRlIERlcGF1PGJyPjxhIGhyZWY9Imh0dHBzOi8vcG9saWVkcm8tcG9saW1pLml0LyI+PGZv
bnQgY29sb3I9IiMwMDUwOGYiPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxmb250
IHN0eWxlPSJmb250LXNpemU6MTBwdCIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQ6
dHJhbnNwYXJlbnQgbm9uZSByZXBlYXQgc2Nyb2xsIDAlIDAlIj5Qb2xpRWRybzwvc3Bhbj48L2Zv
bnQ+PC9mb250PjwvZm9udD48L2E+PGZvbnQgY29sb3I9IiMwMDAwMDAiPjxmb250IGZhY2U9InZl
cmRhbmEsIHNhbnMtc2VyaWYiPjxmb250IHN0eWxlPSJmb250LXNpemU6MTBwdCIgc2l6ZT0iMiI+
PHNwYW4gc3R5bGU9ImJhY2tncm91bmQ6dHJhbnNwYXJlbnQgbm9uZSByZXBlYXQgc2Nyb2xsIDAl
IDAlIj4g4oCTIDwvc3Bhbj48L2ZvbnQ+PC9mb250PjwvZm9udD48YSBocmVmPSJodHRwczovL3Bv
bGltaXByaWRlLml0LyI+PGZvbnQgY29sb3I9IiMwMDUwOGYiPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPjxmb250IHN0eWxlPSJmb250LXNpemU6MTBwdCIgc2l6ZT0iMiI+PHNwYW4g
c3R5bGU9ImJhY2tncm91bmQ6dHJhbnNwYXJlbnQgbm9uZSByZXBlYXQgc2Nyb2xsIDAlIDAlIj5Q
b2xpTWkgUHJpZGU8L3NwYW4+PC9mb250PjwvZm9udD48L2ZvbnQ+PC9hPgpDZWxsOiArMzkgMzI3
IDc5OCA3OTYzPGJyPjwvZm9udD48L3ByZT48L2Rpdj48L2Rpdj4K

--===============1515322930521446092==--

