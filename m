Content-Type: multipart/mixed; boundary="===============0193160067303465570=="
MIME-Version: 1.0
From: Sergei Golubtsov <s.e.golubtsov@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Fri, 01 Jan 2021 17:27:02 +0100
Message-ID: <CAFiQ675t6c9sn_fiYf+4334cpY6fP0DmCaPXREQ82rV3uC15_A@mail.gmail.com>
In-Reply-To: <CAFiQ6757pigCNknJwgqj5cq7zubvv43FRBue0zMcK63XQ=AqfA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0193160067303465570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> The log gives a clear picture but I cannot understand why pppd works in
> this situation and ofono does not? Is it an ofono problem? Is there any
> documentation about the decoding process implemented in the new_bytes ()
> ofono function? Any help will be appreciated.
>
The log from my previous message clearly shows that the problem is that the
modem stopped escaping control characters (<0x20) with 0x7d when phase 2
had begun. Apparently pppd is ok with this behaviour. Am going to compare
the HLDC frame parsers in pppd and ofono. Is it a modem bug or an ofono
missing feature? Any help will be appreciated.

Regards,
Sergei.

--===============0193160067303465570==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LXNpemU6c21hbGwiPkhpIERlbmlzLDwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2IGRpcj0ibHRyIj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBzdHlsZT0iZm9udC1z
aXplOnNtYWxsIj5UaGUgbG9nIGdpdmVzIGEgY2xlYXIgcGljdHVyZSBidXQgSSBjYW5ub3QgdW5k
ZXJzdGFuZCB3aHkgcHBwZCB3b3JrcyBpbiB0aGlzIHNpdHVhdGlvbiBhbmQgb2Zvbm8gZG9lcyBu
b3Q/IElzIGl0IGFuIG9mb25vIHByb2JsZW0/IElzIHRoZXJlIGFueSBkb2N1bWVudGF0aW9uIGFi
b3V0IHRoZSBkZWNvZGluZyBwcm9jZXNzIGltcGxlbWVudGVkIGluIHRoZSBuZXdfYnl0ZXMgKCkg
b2Zvbm8gZnVuY3Rpb24/IEFueSBoZWxwIHdpbGwgYmUgYXBwcmVjaWF0ZWQuPC9kaXY+PC9kaXY+
PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250
LXNpemU6c21hbGwiPlRoZSBsb2cgZnJvbSBteSBwcmV2aW91cyBtZXNzYWdlIGNsZWFybHkgc2hv
d3MgdGhhdCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBtb2RlbSBzdG9wcGVkIGVzY2FwaW5nIGNv
bnRyb2wgY2hhcmFjdGVycyAoJmx0OzB4MjApIHdpdGggMHg3ZCB3aGVuIHBoYXNlIDIgaGFkIGJl
Z3VuLiBBcHBhcmVudGx5IHBwcGQgaXMgb2sgd2l0aCB0aGlzIGJlaGF2aW91ci4gQW0gZ29pbmcg
dG8gY29tcGFyZSB0aGUgSExEQ8KgZnJhbWUgcGFyc2Vyc8KgaW4gcHBwZCBhbmQgb2Zvbm8uIElz
IGl0IGEgbW9kZW0gYnVnIG9yIGFuIG9mb25vIG1pc3NpbmcgZmVhdHVyZT8gQW55IGhlbHAgd2ls
bCBiZSBhcHByZWNpYXRlZC48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQi
IHN0eWxlPSJmb250LXNpemU6c21hbGwiPlJlZ2FyZHMsPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+U2VyZ2VpLjwvZGl2PjwvZGl2PjwvZGl2
Pgo=

--===============0193160067303465570==--

