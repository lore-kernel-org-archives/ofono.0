Content-Type: multipart/mixed; boundary="===============4637378477184495569=="
MIME-Version: 1.0
From: Fabio S. Higa <fabio.higa@dataprom.com>
Subject: Re: PPP negotiation failing
Date: Wed, 18 Sep 2013 08:05:16 -0300
Message-ID: <523988EC.4030706@dataprom.com>
In-Reply-To: <52121A10.70605@dataprom.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4637378477184495569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

> oFono's PPP stack only supports CHAP. Patches are of course always =

> welcome.

I resolved this issue with the modem Telit GE910 sending the command =

"AT#GAUTH=3D2" in order to set the authentication to CHAP.

I have added this command on function telit_post_sim(), before =

ofono_gprs_create().

--===============4637378477184495569==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9SVNP
LTg4NTktMSIKICAgICAgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIj4KICA8L2hlYWQ+CiAgPGJv
ZHkgYmdjb2xvcj0iI0ZGRkZGRiIgdGV4dD0iIzAwMDAwMCI+CiAgICBIZWxsbyBhbGwsPGJyPgog
ICAgPGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+b0Zvbm8ncyBQUFAgc3RhY2sgb25s
eSBzdXBwb3J0cyBDSEFQLiZuYnNwOwogICAgICBQYXRjaGVzIGFyZSBvZiBjb3Vyc2UgYWx3YXlz
IHdlbGNvbWUuPC9ibG9ja3F1b3RlPgogICAgPGJyPgogICAgSSByZXNvbHZlZCB0aGlzIGlzc3Vl
IHdpdGggdGhlIG1vZGVtIFRlbGl0IEdFOTEwIHNlbmRpbmcgdGhlIGNvbW1hbmQKICAgICJBVCNH
QVVUSD0yIiBpbiBvcmRlciB0byBzZXQgdGhlIGF1dGhlbnRpY2F0aW9uIHRvIENIQVAuPGJyPgog
ICAgPGJyPgogICAgSSBoYXZlIGFkZGVkIHRoaXMgY29tbWFuZCBvbiBmdW5jdGlvbiB0ZWxpdF9w
b3N0X3NpbSgpLCBiZWZvcmUKICAgIG9mb25vX2dwcnNfY3JlYXRlKCkuCiAgICA8bWV0YSBodHRw
LWVxdWl2PSJjb250ZW50LXR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsKICAgICAgY2hhcnNldD1J
U08tODg1OS0xIj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============4637378477184495569==--

