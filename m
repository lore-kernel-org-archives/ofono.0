Content-Type: multipart/mixed; boundary="===============2590677637869783261=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Modem not detected by oFono
Date: Thu, 14 Jun 2018 19:54:07 +0200
Message-ID: <d44a4d52-13a6-ddc7-e28f-c259061f1f89@southpole.se>
In-Reply-To: <CAMp63jXPn1fdzztP9dfJW1ywZyPhQA57Pm0Jqd6P3ideDoX+CA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2590677637869783261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,


On 14/06/18 19:39, Davide Depau wrote:
> Hi Jonas,
>
> On Thu, Jun 14, 2018 at 7:05 PM Jonas Bonn <jonas@southpole.se =

> <mailto:jonas@southpole.se>> wrote:
>
>     systemd will start ofonod without excessive logging.=C2=A0 You will
>     want to run with debug logging on to see what's going on.=C2=A0 Stop
>     the systemd instance and run ofono manually from the command line
>     with:
>
>     # systemctl stop ofono
>     # ofonod -d -n
>
>     Post the logs from that so that we can check what's going on.
>
>
> Here you go: https://hastebin.com/oramuhixas.swift
> I can see there's something going on with the modem, I don't get =

> what's really happening though.
>
 From your log, the relevant bits are:

i) Modem is correctly detected and the relevant driver (huawei) is started:

|ofonod[14886]: plugins/udevng.c:create_modem() =

/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2 ofonod[14886]: =

plugins/udevng.c:create_modem() driver=3Dhuawei ofonod[14886]: =

src/modem.c:ofono_modem_create() name: (null), type: huawei =

ofonod[14886]: plugins/udevng.c:setup_huawei() =

/sys/devices/pci0000:00/0000:00:14.0/usb1/1-2 ofonod[14886]: =

plugins/udevng.c:setup_huawei() quattroggi 2/6/0 00 (null) =

ofonod[14886]: plugins/udevng.c:setup_huawei() /dev/ttyUSB0 255/6/16 02 =

(null) ofonod[14886]: plugins/udevng.c:setup_huawei() /dev/ttyUSB1 =

255/6/19 03 (null) ofonod[14886]: plugins/udevng.c:setup_huawei() =

/dev/ttyUSB2 255/6/18 04 (null) ofonod[14886]: =

plugins/udevng.c:setup_huawei() /dev/ttyUSB3 255/6/20 05 (null) =

ofonod[14886]: plugins/udevng.c:setup_huawei() /dev/ttyUSB4 255/6/27 06 =

(null) |

ii)=C2=A0 The interfaces 255/6/* here aren't supported by the 'huawei' =

driver.=C2=A0 See src/udevng.c.=C2=A0 The relevant function is setup_huawei=
().

You'll need to add mapping from USB interface identifier to 'function'.=C2=
=A0 =

Essentially you want to match cases like:

....
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (g_strcmp0(info->interface, "255/6/16") =3D=3D=
 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdm =3D =
info->devnode;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 } else if (g_strcmp0(info->interface, "255/6/19") =3D=3D=
 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net =3D =
info->devnode;
... etc.
....

That's matching the interface string in order to set the function. Which =

interface corresponds to which function is for you to figure out, but =

usually these are reasonably consistent in ordering for any given =

manufacturer so compare with the order of the interfaces already present =

in the huawei driver.

/Jonas

--===============2590677637869783261==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+SGksPGJyPgogICAgPC9wPgogICAgPGJy
PgogICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAxNC8wNi8xOCAxOTozOSwgRGF2
aWRlIERlcGF1IHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIKY2l0ZT0ibWlkOkNBTXA2M2pYUG4xZmR6enRQOWRmSlcxeXdaeVBoUUE1N1BtMEpxZDZQM2lk
ZURvWCtDQUBtYWlsLmdtYWlsLmNvbSI+CiAgICAgIDxkaXYgZGlyPSJsdHIiPkhpIEpvbmFzLDxi
cj4KICAgICAgICA8YnI+CiAgICAgICAgPGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPgogICAgICAg
ICAgPGRpdiBkaXI9Imx0ciI+T24gVGh1LCBKdW4gMTQsIDIwMTggYXQgNzowNSBQTSBKb25hcyBC
b25uICZsdDs8YQogICAgICAgICAgICAgIGhyZWY9Im1haWx0bzpqb25hc0Bzb3V0aHBvbGUuc2Ui
IG1vei1kby1ub3Qtc2VuZD0idHJ1ZSI+am9uYXNAc291dGhwb2xlLnNlPC9hPiZndDsKICAgICAg
ICAgICAgd3JvdGU6PGJyPgogICAgICAgICAgPC9kaXY+CiAgICAgICAgICA8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAKICAgICAgICAgICAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5zeXN0ZW1kCiAgICAg
ICAgICAgIHdpbGwgc3RhcnQgb2Zvbm9kIHdpdGhvdXQgZXhjZXNzaXZlIGxvZ2dpbmcuwqAgWW91
IHdpbGwgd2FudAogICAgICAgICAgICB0byBydW4gd2l0aCBkZWJ1ZyBsb2dnaW5nIG9uIHRvIHNl
ZSB3aGF0J3MgZ29pbmcgb24uwqAgU3RvcAogICAgICAgICAgICB0aGUgc3lzdGVtZCBpbnN0YW5j
ZSBhbmQgcnVuIG9mb25vIG1hbnVhbGx5IGZyb20gdGhlIGNvbW1hbmQKICAgICAgICAgICAgbGlu
ZSB3aXRoOjxicj4KICAgICAgICAgICAgPGRpdiB0ZXh0PSIjMDAwMDAwIiBiZ2NvbG9yPSIjRkZG
RkZGIj4gPGJyPgogICAgICAgICAgICAgICMgc3lzdGVtY3RsIHN0b3Agb2Zvbm88YnI+CiAgICAg
ICAgICAgICAgIyBvZm9ub2QgLWQgLW48YnI+CiAgICAgICAgICAgICAgPGJyPgogICAgICAgICAg
ICAgIFBvc3QgdGhlIGxvZ3MgZnJvbSB0aGF0IHNvIHRoYXQgd2UgY2FuIGNoZWNrIHdoYXQncyBn
b2luZwogICAgICAgICAgICAgIG9uLjwvZGl2PgogICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAg
ICAgICAgPGRpdj48YnI+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDxkaXY+SGVyZSB5b3Ug
Z286wqA8YQogICAgICAgICAgICAgIGhyZWY9Imh0dHBzOi8vaGFzdGViaW4uY29tL29yYW11aGl4
YXMuc3dpZnQiCiAgICAgICAgICAgICAgbW96LWRvLW5vdC1zZW5kPSJ0cnVlIj5odHRwczovL2hh
c3RlYmluLmNvbS9vcmFtdWhpeGFzLnN3aWZ0PC9hPjwvZGl2PgogICAgICAgICAgPGRpdj5JIGNh
biBzZWUgdGhlcmUncyBzb21ldGhpbmcgZ29pbmcgb24gd2l0aCB0aGUgbW9kZW0sIEkKICAgICAg
ICAgICAgZG9uJ3QgZ2V0IHdoYXQncyByZWFsbHkgaGFwcGVuaW5nIHRob3VnaC48L2Rpdj4KICAg
ICAgICAgIDxkaXY+PGJyPgogICAgICAgICAgPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwv
ZGl2PgogICAgPC9ibG9ja3F1b3RlPgogICAgRnJvbSB5b3VyIGxvZywgdGhlIHJlbGV2YW50IGJp
dHMgYXJlOjxicj4KICAgIDxicj4KICAgIGkpIE1vZGVtIGlzIGNvcnJlY3RseSBkZXRlY3RlZCBh
bmQgdGhlIHJlbGV2YW50IGRyaXZlciAoaHVhd2VpKSBpcwogICAgc3RhcnRlZDo8YnI+CiAgICA8
cHJlIGlkPSJib3giIHN0eWxlPSIiIGNsYXNzPSJobGpzIiB0YWJpbmRleD0iMCI+PGNvZGU+Cm9m
b25vZFs8c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjE0ODg2PC9zcGFuPl06IHBsdWdpbnMvdWRl
dm5nLjxzcGFuIGNsYXNzPSJobGpzLWJ1aWx0X2luIj5jPC9zcGFuPjpjcmVhdGVfbW9kZW0oKSAv
c3lzL2RldmljZXMvcGNpMDAwMDo8c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjAwPC9zcGFuPi88
c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjAwMDA8L3NwYW4+OjxzcGFuIGNsYXNzPSJobGpzLW51
bWJlciI+MDA8L3NwYW4+OjxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MTQuMDwvc3Bhbj4vdXNi
MS88c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjE8L3NwYW4+LTxzcGFuIGNsYXNzPSJobGpzLW51
bWJlciI+Mjwvc3Bhbj4Kb2Zvbm9kWzxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MTQ4ODY8L3Nw
YW4+XTogcGx1Z2lucy91ZGV2bmcuPHNwYW4gY2xhc3M9ImhsanMtYnVpbHRfaW4iPmM8L3NwYW4+
OmNyZWF0ZV9tb2RlbSgpIGRyaXZlcj1odWF3ZWkKb2Zvbm9kWzxzcGFuIGNsYXNzPSJobGpzLW51
bWJlciI+MTQ4ODY8L3NwYW4+XTogc3JjL21vZGVtLjxzcGFuIGNsYXNzPSJobGpzLWJ1aWx0X2lu
Ij5jPC9zcGFuPjpvZm9ub19tb2RlbV9jcmVhdGUoKSBuYW1lOiAobnVsbCksIHR5cGU6IGh1YXdl
aQpvZm9ub2RbPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBwbHVnaW5z
L3VkZXZuZy48c3BhbiBjbGFzcz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBfaHVhd2Vp
KCkgL3N5cy9kZXZpY2VzL3BjaTAwMDA6PHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4wMDwvc3Bh
bj4vPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4wMDAwPC9zcGFuPjo8c3BhbiBjbGFzcz0iaGxq
cy1udW1iZXIiPjAwPC9zcGFuPjo8c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjE0LjA8L3NwYW4+
L3VzYjEvPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xPC9zcGFuPi08c3BhbiBjbGFzcz0iaGxq
cy1udW1iZXIiPjI8L3NwYW4+Cm9mb25vZFs8c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjE0ODg2
PC9zcGFuPl06IHBsdWdpbnMvdWRldm5nLjxzcGFuIGNsYXNzPSJobGpzLWJ1aWx0X2luIj5jPC9z
cGFuPjpzZXR1cF9odWF3ZWkoKSBxdWF0dHJvZ2dpIDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+
Mjwvc3Bhbj4vPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj42PC9zcGFuPi88c3BhbiBjbGFzcz0i
aGxqcy1udW1iZXIiPjA8L3NwYW4+IDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MDA8L3NwYW4+
IChudWxsKQpvZm9ub2RbPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBw
bHVnaW5zL3VkZXZuZy48c3BhbiBjbGFzcz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBf
aHVhd2VpKCkgL2Rldi90dHlVU0IwIDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjU1PC9zcGFu
Pi88c3BhbiBjbGFzcz0iaGxqcy1udW1iZXIiPjY8L3NwYW4+LzxzcGFuIGNsYXNzPSJobGpzLW51
bWJlciI+MTY8L3NwYW4+IDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MDI8L3NwYW4+IChudWxs
KQpvZm9ub2RbPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBwbHVnaW5z
L3VkZXZuZy48c3BhbiBjbGFzcz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBfaHVhd2Vp
KCkgL2Rldi90dHlVU0IxIDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjU1PC9zcGFuPi88c3Bh
biBjbGFzcz0iaGxqcy1udW1iZXIiPjY8L3NwYW4+LzxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+
MTk8L3NwYW4+IDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MDM8L3NwYW4+IChudWxsKQpvZm9u
b2RbPHNwYW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBwbHVnaW5zL3VkZXZu
Zy48c3BhbiBjbGFzcz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBfaHVhd2VpKCkgL2Rl
di90dHlVU0IyIDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjU1PC9zcGFuPi88c3BhbiBjbGFz
cz0iaGxqcy1udW1iZXIiPjY8L3NwYW4+LzxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MTg8L3Nw
YW4+IDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MDQ8L3NwYW4+IChudWxsKQpvZm9ub2RbPHNw
YW4gY2xhc3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBwbHVnaW5zL3VkZXZuZy48c3Bh
biBjbGFzcz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlV
U0IzIDxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjU1PC9zcGFuPi88c3BhbiBjbGFzcz0iaGxq
cy1udW1iZXIiPjY8L3NwYW4+LzxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjA8L3NwYW4+IDxz
cGFuIGNsYXNzPSJobGpzLW51bWJlciI+MDU8L3NwYW4+IChudWxsKQpvZm9ub2RbPHNwYW4gY2xh
c3M9ImhsanMtbnVtYmVyIj4xNDg4Njwvc3Bhbj5dOiBwbHVnaW5zL3VkZXZuZy48c3BhbiBjbGFz
cz0iaGxqcy1idWlsdF9pbiI+Yzwvc3Bhbj46c2V0dXBfaHVhd2VpKCkgL2Rldi90dHlVU0I0IDxz
cGFuIGNsYXNzPSJobGpzLW51bWJlciI+MjU1PC9zcGFuPi88c3BhbiBjbGFzcz0iaGxqcy1udW1i
ZXIiPjY8L3NwYW4+LzxzcGFuIGNsYXNzPSJobGpzLW51bWJlciI+Mjc8L3NwYW4+IDxzcGFuIGNs
YXNzPSJobGpzLW51bWJlciI+MDY8L3NwYW4+IChudWxsKQoKCjwvY29kZT48L3ByZT4KICAgIGlp
KcKgIFRoZSBpbnRlcmZhY2VzIDI1NS82LyogaGVyZSBhcmVuJ3Qgc3VwcG9ydGVkIGJ5IHRoZSAn
aHVhd2VpJwogICAgZHJpdmVyLsKgIFNlZSBzcmMvdWRldm5nLmMuwqAgVGhlIHJlbGV2YW50IGZ1
bmN0aW9uIGlzIHNldHVwX2h1YXdlaSgpLjxicj4KICAgIDxicj4KICAgIFlvdSdsbCBuZWVkIHRv
IGFkZCBtYXBwaW5nIGZyb20gVVNCIGludGVyZmFjZSBpZGVudGlmaWVyIHRvCiAgICAnZnVuY3Rp
b24nLsKgIEVzc2VudGlhbGx5IHlvdSB3YW50IHRvIG1hdGNoIGNhc2VzIGxpa2U6PGJyPgogICAg
PGJyPgogICAgLi4uLjxicj4KICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2UgaWYgKGdfc3RyY21wMChpbmZvLSZndDtpbnRlcmZhY2UsICIyNTUvNi8xNiIpCiAgICA9PSAw
KSB7PGJyPgogICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtZG0gPSBpbmZvLSZndDtkZXZub2RlOzxicj4KICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLSZndDtpbnRlcmZhY2UsICIyNTUvNi8x
OSIpCiAgICA9PSAwKSB7PGJyPgogICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBuZXQgPSBpbmZvLSZndDtkZXZub2RlOzxicj4KICAgIC4uLiBldGMuPGJy
PgogICAgLi4uLjxicj4KICAgIDxicj4KICAgIFRoYXQncyBtYXRjaGluZyB0aGUgaW50ZXJmYWNl
IHN0cmluZyBpbiBvcmRlciB0byBzZXQgdGhlIGZ1bmN0aW9uLsKgCiAgICBXaGljaCBpbnRlcmZh
Y2UgY29ycmVzcG9uZHMgdG8gd2hpY2ggZnVuY3Rpb24gaXMgZm9yIHlvdSB0byBmaWd1cmUKICAg
IG91dCwgYnV0IHVzdWFsbHkgdGhlc2UgYXJlIHJlYXNvbmFibHkgY29uc2lzdGVudCBpbiBvcmRl
cmluZyBmb3IgYW55CiAgICBnaXZlbiBtYW51ZmFjdHVyZXIgc28gY29tcGFyZSB3aXRoIHRoZSBv
cmRlciBvZiB0aGUgaW50ZXJmYWNlcwogICAgYWxyZWFkeSBwcmVzZW50IGluIHRoZSBodWF3ZWkg
ZHJpdmVyLjxicj4KICAgIDxicj4KICAgIC9Kb25hczxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============2590677637869783261==--

