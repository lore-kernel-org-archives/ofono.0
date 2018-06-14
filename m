Content-Type: multipart/mixed; boundary="===============1994314694603201233=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Modem not detected by oFono
Date: Thu, 14 Jun 2018 19:05:08 +0200
Message-ID: <386eb57f-cd39-0f3e-b25c-3410851dab90@southpole.se>
In-Reply-To: <CAMp63jVPH5bpEm6PjWuL8YsdK7cU8mz_Hpyc6kQNqrdUqoq=UA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1994314694603201233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,


On 14/06/18 18:24, Davide Depau wrote:
> Hi Pavel,
> thank you. I checked `udevng.c` and I see the vendor ID:
>
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "huawei",=C2=A0=C2=A0=C2=A0=
=C2=A0 "cdc_wdm",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "12d1" },
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "huawei",=C2=A0=C2=A0=C2=A0=
=C2=A0 "cdc_ether",=C2=A0=C2=A0=C2=A0 "12d1"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 },
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "huawei",=C2=A0=C2=A0=C2=A0=
=C2=A0 "qmi_wwan",=C2=A0=C2=A0=C2=A0=C2=A0 "12d1"=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "huawei",=C2=A0=C2=A0=C2=A0=
=C2=A0 "option",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "12d1"=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>
> (btw the modem is 12d1:15c1). Maybe it is being detect but discarded =

> somewhere else (I'm just guessing). Is it possible to increase logging =

> level to system log?
>
> Davide
>
> On Thu, Jun 14, 2018 at 2:19 PM Pavel Machek <pavel@ucw.cz =

> <mailto:pavel@ucw.cz>> wrote:
>
>     On Sat 2018-06-09 15:37:18, Davide Depau wrote:
>     > Hello,
>     > I just built oFono on Arch Linux from git [1]. I made sure no
>     other program
>     > was using the modem (Huawei ME906s LTE M.2 Module) and started
>     oFono. The
>     > modem is not recognized and I get no output in logs:
>     >
>     > systemd[1]: Starting Telephony service...
>     > ofonod[32448]: oFono version 1.23
>     > systemd[1]: Started Telephony service.
>

systemd will start ofonod without excessive logging.=C2=A0 You will want to =

run with debug logging on to see what's going on.=C2=A0 Stop the systemd =

instance and run ofono manually from the command line with:

# systemctl stop ofono
# ofonod -d -n

Post the logs from that so that we can check what's going on.

/Jonas


--===============1994314694603201233==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+SGkgRGF2aWRlLDxicj4KICAgIDwvcD4K
ICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMTQvMDYvMTggMTg6
MjQsIERhdmlkZSBEZXBhdSB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiCmNpdGU9Im1pZDpDQU1wNjNqVlBINWJwRW02UGpXdUw4WXNkSzdjVThtel9IcHlj
NmtRTnFyZFVxb3E9VUFAbWFpbC5nbWFpbC5jb20iPgogICAgICA8ZGl2IGRpcj0ibHRyIj4KICAg
ICAgICA8ZGl2PkhpIFBhdmVsLDwvZGl2PgogICAgICAgIDxkaXY+dGhhbmsgeW91LiBJIGNoZWNr
ZWQgYHVkZXZuZy5jYCBhbmQgSSBzZWUgdGhlIHZlbmRvciBJRDo8L2Rpdj4KICAgICAgICA8ZGl2
Pjxicj4KICAgICAgICA8L2Rpdj4KICAgICAgICA8ZGl2PiZndDvCoMKgwqDCoMKgwqDCoCB7ICJo
dWF3ZWkiLMKgwqDCoMKgICJjZGNfd2RtIizCoMKgwqDCoMKgICIxMmQxIsKgwqDCoMKgwqDCoMKg
wqDCoAogICAgICAgICAgfSw8YnI+CiAgICAgICAgICAmZ3Q7wqDCoMKgwqDCoMKgwqAgeyAiaHVh
d2VpIizCoMKgwqDCoCAiY2RjX2V0aGVyIizCoMKgwqAgIjEyZDEiwqDCoMKgwqDCoMKgwqDCoMKg
IH0sPGJyPgogICAgICAgICAgJmd0O8KgwqDCoMKgwqDCoMKgIHsgImh1YXdlaSIswqDCoMKgwqAg
InFtaV93d2FuIizCoMKgwqDCoCAiMTJkMSLCoMKgwqDCoMKgwqDCoMKgwqAgfSw8YnI+CiAgICAg
ICAgICAmZ3Q7wqDCoMKgwqDCoMKgwqAgeyAiaHVhd2VpIizCoMKgwqDCoCAib3B0aW9uIizCoMKg
wqDCoMKgwqAgIjEyZDEiwqDCoMKgwqDCoMKgwqDCoMKgIH0sPC9kaXY+CiAgICAgICAgPGRpdj48
YnI+CiAgICAgICAgPC9kaXY+CiAgICAgICAgPGRpdj4oYnR3IHRoZSBtb2RlbSBpcyAxMmQxOjE1
YzEpLiBNYXliZSBpdCBpcyBiZWluZyBkZXRlY3QgYnV0CiAgICAgICAgICBkaXNjYXJkZWQgc29t
ZXdoZXJlIGVsc2UgKEknbSBqdXN0IGd1ZXNzaW5nKS4gSXMgaXQgcG9zc2libGUKICAgICAgICAg
IHRvIGluY3JlYXNlIGxvZ2dpbmcgbGV2ZWwgdG8gc3lzdGVtIGxvZz88L2Rpdj4KICAgICAgICA8
ZGl2Pjxicj4KICAgICAgICA8L2Rpdj4KICAgICAgICA8ZGl2PkRhdmlkZTxicj4KICAgICAgICA8
L2Rpdj4KICAgICAgPC9kaXY+CiAgICAgIDxicj4KICAgICAgPGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPgogICAgICAgIDxkaXYgZGlyPSJsdHIiPk9uIFRodSwgSnVuIDE0LCAyMDE4IGF0IDI6MTkg
UE0gUGF2ZWwgTWFjaGVrICZsdDs8YQogICAgICAgICAgICBocmVmPSJtYWlsdG86cGF2ZWxAdWN3
LmN6IiBtb3otZG8tbm90LXNlbmQ9InRydWUiPnBhdmVsQHVjdy5jejwvYT4mZ3Q7CiAgICAgICAg
ICB3cm90ZTo8YnI+CiAgICAgICAgPC9kaXY+CiAgICAgICAgPGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwCiAgICAgICAgICAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPk9uIFNhdAogICAgICAgICAgMjAxOC0w
Ni0wOSAxNTozNzoxOCwgRGF2aWRlIERlcGF1IHdyb3RlOjxicj4KICAgICAgICAgICZndDsgSGVs
bG8sPGJyPgogICAgICAgICAgJmd0OyBJIGp1c3QgYnVpbHQgb0Zvbm8gb24gQXJjaCBMaW51eCBm
cm9tIGdpdCBbMV0uIEkgbWFkZQogICAgICAgICAgc3VyZSBubyBvdGhlciBwcm9ncmFtPGJyPgog
ICAgICAgICAgJmd0OyB3YXMgdXNpbmcgdGhlIG1vZGVtIChIdWF3ZWkgTUU5MDZzIExURSBNLjIg
TW9kdWxlKSBhbmQKICAgICAgICAgIHN0YXJ0ZWQgb0Zvbm8uIFRoZTxicj4KICAgICAgICAgICZn
dDsgbW9kZW0gaXMgbm90IHJlY29nbml6ZWQgYW5kIEkgZ2V0IG5vIG91dHB1dCBpbiBsb2dzOjxi
cj4KICAgICAgICAgICZndDsgPGJyPgogICAgICAgICAgJmd0OyBzeXN0ZW1kWzFdOiBTdGFydGlu
ZyBUZWxlcGhvbnkgc2VydmljZS4uLjxicj4KICAgICAgICAgICZndDsgb2Zvbm9kWzMyNDQ4XTog
b0Zvbm8gdmVyc2lvbiAxLjIzPGJyPgogICAgICAgICAgJmd0OyBzeXN0ZW1kWzFdOiBTdGFydGVk
IFRlbGVwaG9ueSBzZXJ2aWNlLjxicj4KICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDwvZGl2
PgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgc3lzdGVtZCB3aWxsIHN0YXJ0IG9mb25v
ZCB3aXRob3V0IGV4Y2Vzc2l2ZSBsb2dnaW5nLsKgIFlvdSB3aWxsIHdhbnQKICAgIHRvIHJ1biB3
aXRoIGRlYnVnIGxvZ2dpbmcgb24gdG8gc2VlIHdoYXQncyBnb2luZyBvbi7CoCBTdG9wIHRoZQog
ICAgc3lzdGVtZCBpbnN0YW5jZSBhbmQgcnVuIG9mb25vIG1hbnVhbGx5IGZyb20gdGhlIGNvbW1h
bmQgbGluZSB3aXRoOjxicj4KICAgIDxicj4KICAgICMgc3lzdGVtY3RsIHN0b3Agb2Zvbm88YnI+
CiAgICAjIG9mb25vZCAtZCAtbjxicj4KICAgIDxicj4KICAgIFBvc3QgdGhlIGxvZ3MgZnJvbSB0
aGF0IHNvIHRoYXQgd2UgY2FuIGNoZWNrIHdoYXQncyBnb2luZyBvbi48YnI+CiAgICA8YnI+CiAg
ICAvSm9uYXM8YnI+CiAgICA8YnI+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============1994314694603201233==--

