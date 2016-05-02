Content-Type: multipart/mixed; boundary="===============3085120357757961126=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: Re: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Mon, 02 May 2016 17:37:13 +0200
Message-ID: <57277429.2070608@kerlink.fr>
In-Reply-To: <57277020.8020900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3085120357757961126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/05/2016 17:20, Denis Kenzior wrote:
> Hi Martin,
>
> On 05/02/2016 09:42 AM, Martin Chaplet wrote:
>> Udevng layer is changed in order to support Sierra QMI modems like
>> MC73cxx.
>> Identically to Huawei modems, these modems are parsed by setup_sierra.
>> If QMI interface is detected, the Gobi modem driver is selected.
>> In order to keep setup function as light as possible, real interface
>> matching is done by udev rule.
>
> This is a bit unusual.  ofono.rules is now only used with the old
> plugins/udev.c detection logic.  udev.c is only really used for
> serial-based devices, not USB.
>
> Can we add the logic directly to udevng.c and not depend on ofono.rules?


Ok, I will probably need 'subsystem' udev property in this case.
I will re-send splitted patches.
>>
>> +    if (qmi !=3D NULL && net !=3D NULL) {
>> +        ofono_modem_set_driver(modem->modem, "gobi");
>> +        /* Fixup SIM interface for Sierra QMI devices */
>> +        ofono_modem_set_string(modem->modem, "Simdriver",
>> "qmimodem-legacy");
>
> Lets do something like:
>
> ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);

Ok

>
> Regards,
> -Denis
>

Thanks,

Martin


--===============3085120357757961126==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMTA2ZjljIj4KICAgIDxmb250IGZhY2U9IkNh
bGlicmkiPkhpIERlbmlzLDwvZm9udD48YnI+CiAgICA8YnI+CiAgICA8ZGl2IGNsYXNzPSJtb3ot
Y2l0ZS1wcmVmaXgiPk9uIDAyLzA1LzIwMTYgMTc6MjAsIERlbmlzIEtlbnppb3IKICAgICAgd3Jv
dGU6PGJyPgogICAgPC9kaXY+CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6NTcyNzcwMjAuODAy
MDkwMEBnbWFpbC5jb20iIHR5cGU9ImNpdGUiPkhpCiAgICAgIE1hcnRpbiwKICAgICAgPGJyPgog
ICAgICA8YnI+CiAgICAgIE9uIDA1LzAyLzIwMTYgMDk6NDIgQU0sIE1hcnRpbiBDaGFwbGV0IHdy
b3RlOgogICAgICA8YnI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPlVkZXZuZyBsYXll
ciBpcyBjaGFuZ2VkIGluIG9yZGVyIHRvCiAgICAgICAgc3VwcG9ydCBTaWVycmEgUU1JIG1vZGVt
cyBsaWtlIE1DNzNjeHguCiAgICAgICAgPGJyPgogICAgICAgIElkZW50aWNhbGx5IHRvIEh1YXdl
aSBtb2RlbXMsIHRoZXNlIG1vZGVtcyBhcmUgcGFyc2VkIGJ5CiAgICAgICAgc2V0dXBfc2llcnJh
LgogICAgICAgIDxicj4KICAgICAgICBJZiBRTUkgaW50ZXJmYWNlIGlzIGRldGVjdGVkLCB0aGUg
R29iaSBtb2RlbSBkcml2ZXIgaXMgc2VsZWN0ZWQuCiAgICAgICAgPGJyPgogICAgICAgIEluIG9y
ZGVyIHRvIGtlZXAgc2V0dXAgZnVuY3Rpb24gYXMgbGlnaHQgYXMgcG9zc2libGUsIHJlYWwKICAg
ICAgICBpbnRlcmZhY2UKICAgICAgICA8YnI+CiAgICAgICAgbWF0Y2hpbmcgaXMgZG9uZSBieSB1
ZGV2IHJ1bGUuCiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxicj4KICAg
ICAgVGhpcyBpcyBhIGJpdCB1bnVzdWFsLqAgb2Zvbm8ucnVsZXMgaXMgbm93IG9ubHkgdXNlZCB3
aXRoIHRoZSBvbGQKICAgICAgcGx1Z2lucy91ZGV2LmMgZGV0ZWN0aW9uIGxvZ2ljLqAgdWRldi5j
IGlzIG9ubHkgcmVhbGx5IHVzZWQgZm9yCiAgICAgIHNlcmlhbC1iYXNlZCBkZXZpY2VzLCBub3Qg
VVNCLgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgQ2FuIHdlIGFkZCB0aGUgbG9naWMgZGly
ZWN0bHkgdG8gdWRldm5nLmMgYW5kIG5vdCBkZXBlbmQgb24KICAgICAgb2Zvbm8ucnVsZXM/CiAg
ICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4KICAgIDxicj4KICAgIDxicj4KICAgIE9rLCBJIHdp
bGwgcHJvYmFibHkgbmVlZCAnc3Vic3lzdGVtJyB1ZGV2IHByb3BlcnR5IGluIHRoaXMgY2FzZS48
YnI+CiAgICBJIHdpbGwgcmUtc2VuZCBzcGxpdHRlZCBwYXRjaGVzLjxicj4KICAgIDxibG9ja3F1
b3RlIGNpdGU9Im1pZDo1NzI3NzAyMC44MDIwOTAwQGdtYWlsLmNvbSIgdHlwZT0iY2l0ZSI+CiAg
ICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgIDxicj4KICAgICAgICAroKCgIGlm
IChxbWkgIT0gTlVMTCAmYW1wOyZhbXA7IG5ldCAhPSBOVUxMKSB7CiAgICAgICAgPGJyPgogICAg
ICAgICugoKCgoKCgIG9mb25vX21vZGVtX3NldF9kcml2ZXIobW9kZW0tJmd0O21vZGVtLCAiZ29i
aSIpOwogICAgICAgIDxicj4KICAgICAgICAroKCgoKCgoCAvKiBGaXh1cCBTSU0gaW50ZXJmYWNl
IGZvciBTaWVycmEgUU1JIGRldmljZXMgKi8KICAgICAgICA8YnI+CiAgICAgICAgK6CgoKCgoKAg
b2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0mZ3Q7bW9kZW0sICJTaW1kcml2ZXIiLAogICAg
ICAgICJxbWltb2RlbS1sZWdhY3kiKTsKICAgICAgICA8YnI+CiAgICAgIDwvYmxvY2txdW90ZT4K
ICAgICAgPGJyPgogICAgICBMZXRzIGRvIHNvbWV0aGluZyBsaWtlOgogICAgICA8YnI+CiAgICAg
IDxicj4KICAgICAgb2Zvbm9fbW9kZW1fc2V0X2Jvb2xlYW4obW9kZW0tJmd0O21vZGVtLCAiRm9y
Y2VTaW1MZWdhY3kiLCBUUlVFKTsKICAgICAgPGJyPgogICAgPC9ibG9ja3F1b3RlPgogICAgPGJy
PgogICAgT2s8YnI+CiAgICA8YnI+CiAgICA8YmxvY2txdW90ZSBjaXRlPSJtaWQ6NTcyNzcwMjAu
ODAyMDkwMEBnbWFpbC5jb20iIHR5cGU9ImNpdGUiPjxicj4KICAgICAgUmVnYXJkcywKICAgICAg
PGJyPgogICAgICAtRGVuaXMKICAgICAgPGJyPgogICAgICA8YnI+CiAgICA8L2Jsb2NrcXVvdGU+
CiAgICA8YnI+CiAgICBUaGFua3MsPGJyPgogICAgPGJyPgogICAgTWFydGluPGJyPgogICAgPGJy
PgogIDwvYm9keT4KPC9odG1sPgo=

--===============3085120357757961126==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAoR05V
L0xpbnV4KQoKaVFJY0JBRUJBZ0FHQlFKWEozUXBBQW9KRU1KT2oxZU15ZGkvR1dNUUFKUU1BcHQ1
dXM1VUhmeVRBMVI3cU1hegpFOUdjRENFYzlnbnc2TUNQWE5RWG1SdXRlVzNrOW1wbGUrc1dwUzZo
REZGT0NKUVFhYW1ORVRqQ2d3RlBXTUxOCjR5QURmRVd2ZHpmQ2tKWXI5ODN4RVN1Z3hHdFFVZm9V
Vm01dUFQUVZvMEs0ZzErT1MxeDN2VzJ6RVpSNzdxSjkKTTE4akU0WmpBbk5CTVZieDc5WW0yN3Fk
UkU0VlQ0TEFVT1owWStpRkFKSk1nUFpIZkp1S2RKOWx6bUNnMlZsZQpKVTlSaVhkWHlrZmlpOEwy
MWM0WC9CTDl6MmIrYnUyT3VRVkNRdW51VWM3ckZSZzlZMVVzbzlOaUhjdlRsOGVOCnM4YmxUZ3A1
ck92OTZvQkcwQjlmb0pJN2JYcU43bVpuR0lOUEptTFVTRlZFNG5QSGYwcWlYb3lDZWRhMk43MEQK
aWpCb2pWWnRQVFZZMHlJSDJYdkEya3cwSnY0N3pkeHhOVUlZeHdIbnRibGJseWJaWHh4OEw5N01P
MFo1dktDdwpKbExlRmVKQnV0NlVSSERaTGJ5a0tTY2wxcXdtdUNzK0pwcER3UTJod2dNT2FFdVdq
aVJnaHk4ekN0bUVzcjNTClRvMXpPREJaMUlIOHBwTjEwWm1OcFh5ZFZ6Q3dDbE5NTlV4L2JQWG5a
bzdpTmxSbENKZXJiN0tRZGZMVGFXZEgKOVdITWRNM0tJT3Q5ZWJQRUJkMVFXUGFuUms3NGJEM2ht
L1RWMHpOdVNXZWF3eWZCZjRkQ0ZHVzFJbWNwQVRuMAoyT2FXM2wzcUdvalBBOWM0U3BaWjBvdGEr
d3VRbUt3d1VjdmkwTVJ0cy9VTkZRNndyaDhiakMwQkR4RW9xc0FhCmxlbjlJbFZocFhXQnJtQWRt
MGNPCj1YVzBCCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============3085120357757961126==--

