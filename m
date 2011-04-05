Content-Type: multipart/mixed; boundary="===============2060279452325873901=="
MIME-Version: 1.0
From: Claudio Degioanni <claudio.degioanni@zirak.it>
Subject: Re: Trouble using Huwei E160G
Date: Tue, 05 Apr 2011 12:34:00 +0200
Message-ID: <4D9AF018.6070206@zirak.it>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75BFECF816@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2060279452325873901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Il 05/04/2011 12.09, Aygon, Bertrand ha scritto:
> Hi,
>
>>> From what I can see when you do the 'list-modem', your modem is already=
 enabled and online, so you do not have to do the >>./enable_modem and ./on=
line-modem.
>>>
>>> The PS context is also created (looking at ./list-contexts answer).
>>>
>>> So just the ./activate-context should be fine.
>>>
>>> But there is an error ... From what I can see in the source code, it sh=
ould be enable 'post sim'. And still according to source code, >>the Huawei=
 modem seems to skip some SIM status during warm start.
>>>
>>> So, can you please unplug replug the USB key, wait a few, just execute =
./list-modems and ./list-contexts (nothing else).
>>> You should see the modem enabled and online, and your context created. =

>>> If so, just execute ./activate-context
>> I have made the test proposed, I still recive the same error :)
>>
>> I have attacched the new log of test. Ofono create the connection contex=
t, but on activation it repond with not implemented.
> Sorry, I have no idea, I have try all I have in mind, but now, we need th=
e help of someone else.
>
> Huawei modem should support data call. The AT log looks correct. Why ther=
e is a not implemented error, I don't know...
Thanks very much for help, I have made some search on target and on
ubuntu 11.04. There is a difference in product id of device, after usb
modem swicth.

Target:

Bus 001 Device 001: ID 1d6b:0002 =

Bus 002 Device 001: ID 1d6b:0002 =

Bus 002 Device 002: ID 05e3:0608 =

Bus 002 Device 003: ID 0951:1653 =

Bus 002 Device 004: ID 2001:3c05 =

*Bus 002 Device 005: ID 12d1:1436  *
Bus 003 Device 001: ID 1d6b:0002

Ubuntu:

Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 003: ID 0a5c:2110 Broadcom Corp. Bluetooth Controller
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 004: ID 050d:5055 Belkin Components F5D5055 Gigabit
Network Adapter [AX88xxx]
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
*Bus 001 Device 007: ID 12d1:140c Huawei Technologies Co., Ltd. *
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Can be helpful ?
> Sorry again,
>
> Bertrand.
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, =

> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============2060279452325873901==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PUlTTy04ODU5LTEiCiAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgICA8dGl0
bGU+PC90aXRsZT4KICA8L2hlYWQ+CiAgPGJvZHkgdGV4dD0iIzAwMDAwMCIgYmdjb2xvcj0iI2Zm
ZmZmZiI+CiAgICBJbCAwNS8wNC8yMDExIDEyLjA5LCBBeWdvbiwgQmVydHJhbmQgaGEgc2NyaXR0
bzoKICAgIDxibG9ja3F1b3RlCmNpdGU9Im1pZDpBNzgyQzM3MkI5NTI3RDQ0QUIyMEJGNDVGRUVC
QjE0Rjc1QkZFQ0Y4MTZAaXJzbXN4NTAzLmdlci5jb3JwLmludGVsLmNvbSIKICAgICAgdHlwZT0i
Y2l0ZSI+CiAgICAgIDxwcmUgd3JhcD0iIj5IaSwKCjwvcHJlPgogICAgICA8YmxvY2txdW90ZSB0
eXBlPSJjaXRlIj4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgIDxw
cmUgd3JhcD0iIj5Gcm9tIHdoYXQgSSBjYW4gc2VlIHdoZW4geW91IGRvIHRoZSAnbGlzdC1tb2Rl
bScsIHlvdXIgbW9kZW0gaXMgYWxyZWFkeSBlbmFibGVkIGFuZCBvbmxpbmUsIHNvIHlvdSBkbyBu
b3QgaGF2ZSB0byBkbyB0aGUgJmd0OyZndDsuL2VuYWJsZV9tb2RlbSBhbmQgLi9vbmxpbmUtbW9k
ZW0uCgpUaGUgUFMgY29udGV4dCBpcyBhbHNvIGNyZWF0ZWQgKGxvb2tpbmcgYXQgLi9saXN0LWNv
bnRleHRzIGFuc3dlcikuCgpTbyBqdXN0IHRoZSAuL2FjdGl2YXRlLWNvbnRleHQgc2hvdWxkIGJl
IGZpbmUuCgpCdXQgdGhlcmUgaXMgYW4gZXJyb3IgLi4uIEZyb20gd2hhdCBJIGNhbiBzZWUgaW4g
dGhlIHNvdXJjZSBjb2RlLCBpdCBzaG91bGQgYmUgZW5hYmxlICdwb3N0IHNpbScuIEFuZCBzdGls
bCBhY2NvcmRpbmcgdG8gc291cmNlIGNvZGUsICZndDsmZ3Q7dGhlIEh1YXdlaSBtb2RlbSBzZWVt
cyB0byBza2lwIHNvbWUgU0lNIHN0YXR1cyBkdXJpbmcgd2FybSBzdGFydC4KClNvLCBjYW4geW91
IHBsZWFzZSB1bnBsdWcgcmVwbHVnIHRoZSBVU0Iga2V5LCB3YWl0IGEgZmV3LCBqdXN0IGV4ZWN1
dGUgLi9saXN0LW1vZGVtcyBhbmQgLi9saXN0LWNvbnRleHRzIChub3RoaW5nIGVsc2UpLgpZb3Ug
c2hvdWxkIHNlZSB0aGUgbW9kZW0gZW5hYmxlZCBhbmQgb25saW5lLCBhbmQgeW91ciBjb250ZXh0
IGNyZWF0ZWQuIApJZiBzbywganVzdCBleGVjdXRlIC4vYWN0aXZhdGUtY29udGV4dAo8L3ByZT4K
ICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgPHByZSB3cmFwPSIiPgpJIGhhdmUgbWFkZSB0
aGUgdGVzdCBwcm9wb3NlZCwgSSBzdGlsbCByZWNpdmUgdGhlIHNhbWUgZXJyb3IgOikKCkkgaGF2
ZSBhdHRhY2NoZWQgdGhlIG5ldyBsb2cgb2YgdGVzdC4gT2Zvbm8gY3JlYXRlIHRoZSBjb25uZWN0
aW9uIGNvbnRleHQsIGJ1dCBvbiBhY3RpdmF0aW9uIGl0IHJlcG9uZCB3aXRoIG5vdCBpbXBsZW1l
bnRlZC4KPC9wcmU+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPHByZSB3cmFwPSIiPgpTb3Jy
eSwgSSBoYXZlIG5vIGlkZWEsIEkgaGF2ZSB0cnkgYWxsIEkgaGF2ZSBpbiBtaW5kLCBidXQgbm93
LCB3ZSBuZWVkIHRoZSBoZWxwIG9mIHNvbWVvbmUgZWxzZS4KCkh1YXdlaSBtb2RlbSBzaG91bGQg
c3VwcG9ydCBkYXRhIGNhbGwuIFRoZSBBVCBsb2cgbG9va3MgY29ycmVjdC4gV2h5IHRoZXJlIGlz
IGEgbm90IGltcGxlbWVudGVkIGVycm9yLCBJIGRvbid0IGtub3cuLi4KPC9wcmU+CiAgICA8L2Js
b2NrcXVvdGU+CiAgICBUaGFua3MgdmVyeSBtdWNoIGZvciBoZWxwLCBJIGhhdmUgbWFkZSBzb21l
IHNlYXJjaCBvbiB0YXJnZXQgYW5kIG9uCiAgICB1YnVudHUgMTEuMDQuIFRoZXJlIGlzIGEgZGlm
ZmVyZW5jZSBpbiBwcm9kdWN0IGlkIG9mIGRldmljZSwgYWZ0ZXIKICAgIHVzYiBtb2RlbSBzd2lj
dGguPGJyPgogICAgPGJyPgogICAgVGFyZ2V0OiA8YnI+CiAgICA8YnI+CiAgICBCdXMgMDAxIERl
dmljZSAwMDE6IElEIDFkNmI6MDAwMiZuYnNwOyA8YnI+CiAgICBCdXMgMDAyIERldmljZSAwMDE6
IElEIDFkNmI6MDAwMiZuYnNwOyA8YnI+CiAgICBCdXMgMDAyIERldmljZSAwMDI6IElEIDA1ZTM6
MDYwOCZuYnNwOyA8YnI+CiAgICBCdXMgMDAyIERldmljZSAwMDM6IElEIDA5NTE6MTY1MyZuYnNw
OyA8YnI+CiAgICBCdXMgMDAyIERldmljZSAwMDQ6IElEIDIwMDE6M2MwNSZuYnNwOyA8YnI+CiAg
ICA8Yj5CdXMgMDAyIERldmljZSAwMDU6IElEIDEyZDE6MTQzNiZuYnNwOyA8L2I+PGJyPgogICAg
QnVzIDAwMyBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDIgPGJyPgogICAgPGJyPgogICAgVWJ1bnR1
Ojxicj4KICAgIDxicj4KICAgIEJ1cyAwMDcgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAxIExpbnV4
IEZvdW5kYXRpb24gMS4xIHJvb3QgaHViPGJyPgogICAgQnVzIDAwNiBEZXZpY2UgMDAxOiBJRCAx
ZDZiOjAwMDEgTGludXggRm91bmRhdGlvbiAxLjEgcm9vdCBodWI8YnI+CiAgICBCdXMgMDA1IERl
dmljZSAwMDE6IElEIDFkNmI6MDAwMSBMaW51eCBGb3VuZGF0aW9uIDEuMSByb290IGh1Yjxicj4K
ICAgIEJ1cyAwMDQgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAxIExpbnV4IEZvdW5kYXRpb24gMS4x
IHJvb3QgaHViPGJyPgogICAgQnVzIDAwMyBEZXZpY2UgMDAzOiBJRCAwYTVjOjIxMTAgQnJvYWRj
b20gQ29ycC4gQmx1ZXRvb3RoIENvbnRyb2xsZXI8YnI+CiAgICBCdXMgMDAzIERldmljZSAwMDE6
IElEIDFkNmI6MDAwMSBMaW51eCBGb3VuZGF0aW9uIDEuMSByb290IGh1Yjxicj4KICAgIEJ1cyAw
MDIgRGV2aWNlIDAwNDogSUQgMDUwZDo1MDU1IEJlbGtpbiBDb21wb25lbnRzIEY1RDUwNTUgR2ln
YWJpdAogICAgTmV0d29yayBBZGFwdGVyIFtBWDg4eHh4XTxicj4KICAgIEJ1cyAwMDIgRGV2aWNl
IDAwMTogSUQgMWQ2YjowMDAyIExpbnV4IEZvdW5kYXRpb24gMi4wIHJvb3QgaHViPGJyPgogICAg
PGI+QnVzIDAwMSBEZXZpY2UgMDA3OiBJRCAxMmQxOjE0MGMgSHVhd2VpIFRlY2hub2xvZ2llcyBD
by4sIEx0ZC4gPC9iPjxicj4KICAgIEJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAyIExp
bnV4IEZvdW5kYXRpb24gMi4wIHJvb3QgaHViPGJyPgogICAgPGJyPgogICAgQ2FuIGJlIGhlbHBm
dWwgPzxicj4KICAgIDxibG9ja3F1b3RlCmNpdGU9Im1pZDpBNzgyQzM3MkI5NTI3RDQ0QUIyMEJG
NDVGRUVCQjE0Rjc1QkZFQ0Y4MTZAaXJzbXN4NTAzLmdlci5jb3JwLmludGVsLmNvbSIKICAgICAg
dHlwZT0iY2l0ZSI+CiAgICAgIDxwcmUgd3JhcD0iIj4KU29ycnkgYWdhaW4sCgpCZXJ0cmFuZC4K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCkludGVsIENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZpZWQgam9p
bnQgc3RvY2sgY29tcGFueSkKUmVnaXN0ZXJlZCBoZWFkcXVhcnRlcnM6ICJMZXMgTW9udGFsZXRz
Ii0gMiwgcnVlIGRlIFBhcmlzLCAKOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2UKUmVnaXN0cmF0
aW9uIE51bWJlcjogIDMwMiA0NTYgMTk5IFIuQy5TLiBOQU5URVJSRQpDYXBpdGFsOiA0LDU3Miww
MDAgRXVyb3MKClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29u
ZmlkZW50aWFsIG1hdGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKS4gQW55IHJldmlldyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5
IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFz
ZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Kb2Zvbm8gbWFpbGluZyBsaXN0Cjxh
IGNsYXNzPSJtb3otdHh0LWxpbmstYWJicmV2aWF0ZWQiIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9u
by5vcmciPm9mb25vQG9mb25vLm9yZzwvYT4KPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4
dCIgaHJlZj0iaHR0cDovL2xpc3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubyI+aHR0cDovL2xp
c3RzLm9mb25vLm9yZy9saXN0aW5mby9vZm9ubzwvYT4KPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+
CiAgICA8YnI+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============2060279452325873901==--

