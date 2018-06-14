Content-Type: multipart/mixed; boundary="===============2292784456199897649=="
MIME-Version: 1.0
From: Davide Depau <davide@depau.eu>
Subject: Re: Modem not detected by oFono
Date: Thu, 14 Jun 2018 19:39:01 +0200
Message-ID: <CAMp63jXPn1fdzztP9dfJW1ywZyPhQA57Pm0Jqd6P3ideDoX+CA@mail.gmail.com>
In-Reply-To: <386eb57f-cd39-0f3e-b25c-3410851dab90@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2292784456199897649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Thu, Jun 14, 2018 at 7:05 PM Jonas Bonn <jonas@southpole.se> wrote:

> Hi Davide,
>
> On 14/06/18 18:24, Davide Depau wrote:
>
> Hi Pavel,
> thank you. I checked `udevng.c` and I see the vendor ID:
>
> >        { "huawei",     "cdc_wdm",      "12d1"          },
> >        { "huawei",     "cdc_ether",    "12d1"          },
> >        { "huawei",     "qmi_wwan",     "12d1"          },
> >        { "huawei",     "option",       "12d1"          },
>
> (btw the modem is 12d1:15c1). Maybe it is being detect but discarded
> somewhere else (I'm just guessing). Is it possible to increase logging
> level to system log?
>
> Davide
>
> On Thu, Jun 14, 2018 at 2:19 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>> On Sat 2018-06-09 15:37:18, Davide Depau wrote:
>> > Hello,
>> > I just built oFono on Arch Linux from git [1]. I made sure no other
>> program
>> > was using the modem (Huawei ME906s LTE M.2 Module) and started oFono.
>> The
>> > modem is not recognized and I get no output in logs:
>> >
>> > systemd[1]: Starting Telephony service...
>> > ofonod[32448]: oFono version 1.23
>> > systemd[1]: Started Telephony service.
>>
>
> systemd will start ofonod without excessive logging.  You will want to run
> with debug logging on to see what's going on.  Stop the systemd instance
> and run ofono manually from the command line with:
>
> # systemctl stop ofono
> # ofonod -d -n
>
> Post the logs from that so that we can check what's going on.
>

Here you go: https://hastebin.com/oramuhixas.swift
I can see there's something going on with the modem, I don't get what's
really happening though.

Davide


>
>
> /Jonas
>
> --

--

Davide Depau
PoliEdro <https://poliedro-polimi.it/> =E2=80=93 PoliMi Pride <https://poli=
mipride.it/>
Cell: +39 327 798 7963

--===============2292784456199897649==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgSm9uYXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBKdW4gMTQsIDIwMTggYXQgNzowNSBQTSBKb25hcyBCb25u
ICZsdDs8YSBocmVmPSJtYWlsdG86am9uYXNAc291dGhwb2xlLnNlIj5qb25hc0Bzb3V0aHBvbGUu
c2U8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+CiAgCiAgICAKICAKICA8ZGl2IHRleHQ9IiMwMDAwMDAiIGJnY29sb3I9
IiNGRkZGRkYiPgogICAgPHA+SGkgRGF2aWRlLDxicj4KICAgIDwvcD48L2Rpdj48ZGl2IHRleHQ9
IiMwMDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPGJyPgogICAgPGRpdiBjbGFzcz0ibV82
NzQ5NjM5OTgzNzEyNjgyNzY0bW96LWNpdGUtcHJlZml4Ij5PbiAxNC8wNi8xOCAxODoyNCwgRGF2
aWRlIERlcGF1IHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSI+CiAgICAgIDxkaXYgZGlyPSJsdHIiPgogICAgICAgIDxkaXY+SGkgUGF2ZWwsPC9kaXY+CiAg
ICAgICAgPGRpdj50aGFuayB5b3UuIEkgY2hlY2tlZCBgdWRldm5nLmNgIGFuZCBJIHNlZSB0aGUg
dmVuZG9yIElEOjwvZGl2PgogICAgICAgIDxkaXY+PGJyPgogICAgICAgIDwvZGl2PgogICAgICAg
IDxkaXY+Jmd0O8KgwqDCoMKgwqDCoMKgIHsgJnF1b3Q7aHVhd2VpJnF1b3Q7LMKgwqDCoMKgICZx
dW90O2NkY193ZG0mcXVvdDsswqDCoMKgwqDCoCAmcXVvdDsxMmQxJnF1b3Q7wqDCoMKgwqDCoMKg
wqDCoMKgCiAgICAgICAgICB9LDxicj4KICAgICAgICAgICZndDvCoMKgwqDCoMKgwqDCoCB7ICZx
dW90O2h1YXdlaSZxdW90OyzCoMKgwqDCoCAmcXVvdDtjZGNfZXRoZXImcXVvdDsswqDCoMKgICZx
dW90OzEyZDEmcXVvdDvCoMKgwqDCoMKgwqDCoMKgwqAgfSw8YnI+CiAgICAgICAgICAmZ3Q7wqDC
oMKgwqDCoMKgwqAgeyAmcXVvdDtodWF3ZWkmcXVvdDsswqDCoMKgwqAgJnF1b3Q7cW1pX3d3YW4m
cXVvdDsswqDCoMKgwqAgJnF1b3Q7MTJkMSZxdW90O8KgwqDCoMKgwqDCoMKgwqDCoCB9LDxicj4K
ICAgICAgICAgICZndDvCoMKgwqDCoMKgwqDCoCB7ICZxdW90O2h1YXdlaSZxdW90OyzCoMKgwqDC
oCAmcXVvdDtvcHRpb24mcXVvdDsswqDCoMKgwqDCoMKgICZxdW90OzEyZDEmcXVvdDvCoMKgwqDC
oMKgwqDCoMKgwqAgfSw8L2Rpdj4KICAgICAgICA8ZGl2Pjxicj4KICAgICAgICA8L2Rpdj4KICAg
ICAgICA8ZGl2PihidHcgdGhlIG1vZGVtIGlzIDEyZDE6MTVjMSkuIE1heWJlIGl0IGlzIGJlaW5n
IGRldGVjdCBidXQKICAgICAgICAgIGRpc2NhcmRlZCBzb21ld2hlcmUgZWxzZSAoSSYjMzk7bSBq
dXN0IGd1ZXNzaW5nKS4gSXMgaXQgcG9zc2libGUKICAgICAgICAgIHRvIGluY3JlYXNlIGxvZ2dp
bmcgbGV2ZWwgdG8gc3lzdGVtIGxvZz88L2Rpdj4KICAgICAgICA8ZGl2Pjxicj4KICAgICAgICA8
L2Rpdj4KICAgICAgICA8ZGl2PkRhdmlkZTxicj4KICAgICAgICA8L2Rpdj4KICAgICAgPC9kaXY+
CiAgICAgIDxicj4KICAgICAgPGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPgogICAgICAgIDxkaXYg
ZGlyPSJsdHIiPk9uIFRodSwgSnVuIDE0LCAyMDE4IGF0IDI6MTkgUE0gUGF2ZWwgTWFjaGVrICZs
dDs8YSBocmVmPSJtYWlsdG86cGF2ZWxAdWN3LmN6IiB0YXJnZXQ9Il9ibGFuayI+cGF2ZWxAdWN3
LmN6PC9hPiZndDsKICAgICAgICAgIHdyb3RlOjxicj4KICAgICAgICA8L2Rpdj4KICAgICAgICA8
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5PbiBTYXQKICAgICAg
ICAgIDIwMTgtMDYtMDkgMTU6Mzc6MTgsIERhdmlkZSBEZXBhdSB3cm90ZTo8YnI+CiAgICAgICAg
ICAmZ3Q7IEhlbGxvLDxicj4KICAgICAgICAgICZndDsgSSBqdXN0IGJ1aWx0IG9Gb25vIG9uIEFy
Y2ggTGludXggZnJvbSBnaXQgWzFdLiBJIG1hZGUKICAgICAgICAgIHN1cmUgbm8gb3RoZXIgcHJv
Z3JhbTxicj4KICAgICAgICAgICZndDsgd2FzIHVzaW5nIHRoZSBtb2RlbSAoSHVhd2VpIE1FOTA2
cyBMVEUgTS4yIE1vZHVsZSkgYW5kCiAgICAgICAgICBzdGFydGVkIG9Gb25vLiBUaGU8YnI+CiAg
ICAgICAgICAmZ3Q7IG1vZGVtIGlzIG5vdCByZWNvZ25pemVkIGFuZCBJIGdldCBubyBvdXRwdXQg
aW4gbG9nczo8YnI+CiAgICAgICAgICAmZ3Q7IDxicj4KICAgICAgICAgICZndDsgc3lzdGVtZFsx
XTogU3RhcnRpbmcgVGVsZXBob255IHNlcnZpY2UuLi48YnI+CiAgICAgICAgICAmZ3Q7IG9mb25v
ZFszMjQ0OF06IG9Gb25vIHZlcnNpb24gMS4yMzxicj4KICAgICAgICAgICZndDsgc3lzdGVtZFsx
XTogU3RhcnRlZCBUZWxlcGhvbnkgc2VydmljZS48YnI+CiAgICAgICAgPC9ibG9ja3F1b3RlPgog
ICAgICA8L2Rpdj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj48L2Rpdj48ZGl2IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgc3lzdGVtZCB3aWxsIHN0YXJ0IG9mb25vZCB3
aXRob3V0IGV4Y2Vzc2l2ZSBsb2dnaW5nLsKgIFlvdSB3aWxsIHdhbnQKICAgIHRvIHJ1biB3aXRo
IGRlYnVnIGxvZ2dpbmcgb24gdG8gc2VlIHdoYXQmIzM5O3MgZ29pbmcgb24uwqAgU3RvcCB0aGUK
ICAgIHN5c3RlbWQgaW5zdGFuY2UgYW5kIHJ1biBvZm9ubyBtYW51YWxseSBmcm9tIHRoZSBjb21t
YW5kIGxpbmUgd2l0aDo8YnI+CiAgICA8YnI+CiAgICAjIHN5c3RlbWN0bCBzdG9wIG9mb25vPGJy
PgogICAgIyBvZm9ub2QgLWQgLW48YnI+CiAgICA8YnI+CiAgICBQb3N0IHRoZSBsb2dzIGZyb20g
dGhhdCBzbyB0aGF0IHdlIGNhbiBjaGVjayB3aGF0JiMzOTtzIGdvaW5nIG9uLjwvZGl2PjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkhlcmUgeW91IGdvOsKgPGEgaHJlZj0iaHR0cHM6
Ly9oYXN0ZWJpbi5jb20vb3JhbXVoaXhhcy5zd2lmdCI+aHR0cHM6Ly9oYXN0ZWJpbi5jb20vb3Jh
bXVoaXhhcy5zd2lmdDwvYT48L2Rpdj48ZGl2PkkgY2FuIHNlZSB0aGVyZSYjMzk7cyBzb21ldGhp
bmcgZ29pbmcgb24gd2l0aCB0aGUgbW9kZW0sIEkgZG9uJiMzOTt0IGdldCB3aGF0JiMzOTtzIHJl
YWxseSBoYXBwZW5pbmcgdGhvdWdoLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+RGF2aWRlPC9k
aXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXgiPjxkaXYgdGV4dD0iIzAwMDAwMCIgYmdjb2xvcj0iI0ZGRkZGRiI+PGJyPgogICAgPGJyPgog
ICAgL0pvbmFzPGJyPgogICAgPGJyPgogIDwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4t
LSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1h
aWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PHByZSBzdHlsZT0iY29sb3I6cmdi
KDAsMCwwKTttYXJnaW4tdG9wOjBweDttYXJnaW4tYm90dG9tOjBweDtwYWRkaW5nOjBweDt3aGl0
ZS1zcGFjZTpwcmUtd3JhcCI+PGZvbnQgc2l6ZT0iMiIgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+LS08L2ZvbnQ+PC9wcmU+PHByZSBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTttYXJnaW4tdG9w
OjBweDttYXJnaW4tYm90dG9tOjBweDtwYWRkaW5nOjBweDt3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+
PGZvbnQgc2l6ZT0iMiIgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+RGF2aWRlIERlcGF1PGJy
PjxhIGhyZWY9Imh0dHBzOi8vcG9saWVkcm8tcG9saW1pLml0LyI+PGZvbnQgY29sb3I9IiMwMDUw
OGYiPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxmb250IHN0eWxlPSJmb250LXNp
emU6MTBwdCIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQ6dHJhbnNwYXJlbnQgbm9u
ZSByZXBlYXQgc2Nyb2xsIDAlIDAlIj5Qb2xpRWRybzwvc3Bhbj48L2ZvbnQ+PC9mb250PjwvZm9u
dD48L2E+PGZvbnQgY29sb3I9IiMwMDAwMDAiPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2Vy
aWYiPjxmb250IHN0eWxlPSJmb250LXNpemU6MTBwdCIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImJh
Y2tncm91bmQ6dHJhbnNwYXJlbnQgbm9uZSByZXBlYXQgc2Nyb2xsIDAlIDAlIj4g4oCTIDwvc3Bh
bj48L2ZvbnQ+PC9mb250PjwvZm9udD48YSBocmVmPSJodHRwczovL3BvbGltaXByaWRlLml0LyI+
PGZvbnQgY29sb3I9IiMwMDUwOGYiPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxm
b250IHN0eWxlPSJmb250LXNpemU6MTBwdCIgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImJhY2tncm91
bmQ6dHJhbnNwYXJlbnQgbm9uZSByZXBlYXQgc2Nyb2xsIDAlIDAlIj5Qb2xpTWkgUHJpZGU8L3Nw
YW4+PC9mb250PjwvZm9udD48L2ZvbnQ+PC9hPgpDZWxsOiArMzkgMzI3IDc5OCA3OTYzPGJyPjwv
Zm9udD48L3ByZT48L2Rpdj48L2Rpdj4K

--===============2292784456199897649==--

