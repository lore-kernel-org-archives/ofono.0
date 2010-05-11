Content-Type: multipart/mixed; boundary="===============0862592756098937867=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Re: 
Date: Tue, 11 May 2010 10:20:00 +0200
Message-ID: <4BE91330.8000901@djdas.net>
In-Reply-To: <COL106-W364D8C11A4928E5B0ADA04F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0862592756098937867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi krishna,
> Hi Yoon,
>
> Thank very much for your guidance. I followed the same procedure ...
>
> You already did following procedure.
> 1. ofono-phonesim -p 12345 -gui ~/data/moblin.xml
> 2. sudo ofonod -nd =

>
> And then, you need to type following command to power up modem(phonesim).
> 3. dbus-send --system --print-reply --dest=3Dorg.ofono / phonesim0 org.of=
ono.Modem.SetProperty string:Powered variant:boolean:true
>   =

> I got below response....
>
> *Must use org.mydomain.Interface.Method notation, no dot in "phonesim0"*
It seems you wrote the command with a bad syntax, there shoudn't be any =

white space between / and phonesim0, the command is:

dbus-send --system --print-reply --dest=3Dorg.ofono /phonesim0 =

org.ofono.Modem.SetProperty string:'Powered' variant:boolean:true

(I suggest using quotes rounding string constants).

Bye,
Dario.


--===============0862592756098937867==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgo8aGVhZD4KICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7Y2hhcnNldD1J
U08tODg1OS0xIiBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDx0aXRsZT48L3RpdGxlPgo8
L2hlYWQ+Cjxib2R5IGJnY29sb3I9IiNmZmZmZmYiIHRleHQ9IiMwMDAwMDAiPgpIaSBrcmlzaG5h
LAo8YmxvY2txdW90ZSBjaXRlPSJtaWQ6Q09MMTA2LVczNjREOEMxMUE0OTI4RTVCMEFEQTA0RjZG
OTBAcGh4LmdibCIKIHR5cGU9ImNpdGUiPgogIDxzdHlsZT48IS0tCi5obW1lc3NhZ2UgUAp7Cm1h
cmdpbjowcHg7CnBhZGRpbmc6MHB4Cn0KYm9keS5obW1lc3NhZ2UKewpmb250LXNpemU6IDEwcHQ7
CmZvbnQtZmFtaWx5OlZlcmRhbmEKfQotLT48L3N0eWxlPkhpCllvb24sPGJyPgogIDxicj4KVGhh
bmsgdmVyeSBtdWNoIGZvciB5b3VyIGd1aWRhbmNlLiBJIGZvbGxvd2VkIHRoZSBzYW1lIHByb2Nl
ZHVyZSAuLi48YnI+CiAgPGJyPgogIDxwcmU+WW91IGFscmVhZHkgZGlkIGZvbGxvd2luZyBwcm9j
ZWR1cmUuCjEuIG9mb25vLXBob25lc2ltIC1wIDEyMzQ1IC1ndWkgfi9kYXRhL21vYmxpbi54bWwK
Mi4gc3VkbyBvZm9ub2QgLW5kIAoKQW5kIHRoZW4sIHlvdSBuZWVkIHRvIHR5cGUgZm9sbG93aW5n
IGNvbW1hbmQgdG8gcG93ZXIgdXAgbW9kZW0ocGhvbmVzaW0pLgozLiBkYnVzLXNlbmQgLS1zeXN0
ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25vIC8gcGhvbmVzaW0wIG9yZy5vZm9uby5N
b2RlbS5TZXRQcm9wZXJ0eSBzdHJpbmc6UG93ZXJlZCB2YXJpYW50OmJvb2xlYW46dHJ1ZQogIDwv
cHJlPgpJIGdvdCBiZWxvdyByZXNwb25zZS4uLi48YnI+CiAgPGJyPgogIDxmb250IHN0eWxlPSIi
IGNvbG9yPSIjYzAwMDAwIj48Yj5NdXN0IHVzZQpvcmcubXlkb21haW4uSW50ZXJmYWNlLk1ldGhv
ZCBub3RhdGlvbiwgbm8gZG90IGluICJwaG9uZXNpbTAiPC9iPjwvZm9udD48YnI+CjwvYmxvY2tx
dW90ZT4KSXQgc2VlbXMgeW91IHdyb3RlIHRoZSBjb21tYW5kIHdpdGggYSBiYWQgc3ludGF4LCB0
aGVyZSBzaG91ZG4ndCBiZSBhbnkKd2hpdGUgc3BhY2UgYmV0d2VlbiAvIGFuZCBwaG9uZXNpbTAs
IHRoZSBjb21tYW5kIGlzOjxicj4KPGJyPgpkYnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBs
eSAtLWRlc3Q9b3JnLm9mb25vIC9waG9uZXNpbTAKb3JnLm9mb25vLk1vZGVtLlNldFByb3BlcnR5
IHN0cmluZzonUG93ZXJlZCcgdmFyaWFudDpib29sZWFuOnRydWU8YnI+Cjxicj4KKEkgc3VnZ2Vz
dCB1c2luZyBxdW90ZXMgcm91bmRpbmcgc3RyaW5nIGNvbnN0YW50cykuPGJyPgo8YnI+CkJ5ZSw8
YnI+CkRhcmlvLjxicj4KPGJyPgo8L2JvZHk+CjwvaHRtbD4K

--===============0862592756098937867==--

