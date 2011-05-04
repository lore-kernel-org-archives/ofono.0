Content-Type: multipart/mixed; boundary="===============8672659270623198304=="
MIME-Version: 1.0
From: rajeshkumar s.a <rajeshkumar.s.a@gmail.com>
Subject: Re: Dedug Log for Huawei EC168C
Date: Wed, 04 May 2011 21:31:01 +0530
Message-ID: <BANLkTimfiAoZZQc_GB0PYd_n0CF-v1je=w@mail.gmail.com>
In-Reply-To: <4DC17728.5090406@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8672659270623198304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

How do I get the proper ofono_interface_num ? (n00b ques)

rajesh

On Wed, May 4, 2011 at 9:26 PM, Olivier Guiter <
olivier.guiter@linux.intel.com> wrote:

>  On 05/04/2011 05:35 PM, rajeshkumar s.a wrote:
>
> PFA, the debug log with AT commands
>
> I am still getting a timeout on enable-modem operation
>
> and list-modem gives following o/p
>
> $ ./list-modems
> [ /huawei0 ]
>     Features =3D
>     Emergency =3D 0
>     Powered =3D 0
>     Lockdown =3D 0
>     Interfaces =3D
>     Online =3D 0
>
> Regards,
> Rajesh
>
>  As far i can see, ofono communicates using the wrong USB interface .... I
> suggest you to modify the */etc/udev/rules.d/ofono.rules *to use the
> correct one
> First, get the idvendor and id product of your key (e.g: lsusb)
> Then check in the ofono.rules  a line like this one:
> ATTRS{idVendor}=3D=3D"19d2",
> ATTRS{idProduct}=3D=3D"0121",ENV{OFONO_IFACE_NUM}=3D=3D"04",
> ENV{OFONO_ZTE_TYPE}=3D"modem"
> And update the OFONO_IFACE_NUM
> These keys publish multiple interfaces with different purposes (like modem
> diag, traces, etc...)
> Hope this help
> Olivier
>
>
> **
>

--===============8672659270623198304==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SG93IGRvIEkgZ2V0IHRoZSBwcm9wZXIgb2Zvbm9faW50ZXJmYWNlX251bSA/IChuMDBiIHF1ZXMp
PGJyPjxicj5yYWplc2g8YnI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBXZWQsIE1h
eSA0LCAyMDExIGF0IDk6MjYgUE0sIE9saXZpZXIgR3VpdGVyIDxzcGFuIGRpcj0ibHRyIj4mbHQ7
PGEgaHJlZj0ibWFpbHRvOm9saXZpZXIuZ3VpdGVyQGxpbnV4LmludGVsLmNvbSI+b2xpdmllci5n
dWl0ZXJAbGludXguaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj4KPGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOiAwcHQgMHB0IDBwdCAwLjhleDsg
Ym9yZGVyLWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IHBhZGRpbmctbGVmdDog
MWV4OyI+CgogIAogICAgCiAgCiAgPGRpdiBiZ2NvbG9yPSIjZmZmZmZmIiB0ZXh0PSIjMDAwMDAw
Ij48ZGl2PjxkaXY+PC9kaXY+PGRpdiBjbGFzcz0iaDUiPgogICAgT24gMDUvMDQvMjAxMSAwNToz
NSBQTSwgcmFqZXNoa3VtYXIgcy5hIHdyb3RlOgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
UEZBLCB0aGUgZGVidWcgbG9nIHdpdGggQVQgY29tbWFuZHM8YnI+CiAgICAgIDxicj4KICAgICAg
SSBhbSBzdGlsbCBnZXR0aW5nIGEgdGltZW91dCBvbiBlbmFibGUtbW9kZW0gb3BlcmF0aW9uIDxi
cj4KICAgICAgPGJyPgogICAgICBhbmQgbGlzdC1tb2RlbSBnaXZlcyBmb2xsb3dpbmcgby9wPGJy
PgogICAgICA8YnI+CiAgICAgICQgLi9saXN0LW1vZGVtcyA8YnI+CiAgICAgIFsgL2h1YXdlaTAg
XTxicj4KICAgICAgoKCgIEZlYXR1cmVzID0gPGJyPgogICAgICCgoKAgRW1lcmdlbmN5ID0gMDxi
cj4KICAgICAgoKCgIFBvd2VyZWQgPSAwPGJyPgogICAgICCgoKAgTG9ja2Rvd24gPSAwPGJyPgog
ICAgICCgoKAgSW50ZXJmYWNlcyA9IDxicj4KICAgICAgoKCgIE9ubGluZSA9IDA8YnI+CiAgICAg
IDxicj4KICAgICAgUmVnYXJkcyw8YnI+CiAgICAgIFJhamVzaDxicj4KICAgICAgPGJyPgogICAg
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PgogICAgQXMgZmFyIGkgY2FuIHNlZSwgb2Zvbm8gY29t
bXVuaWNhdGVzIHVzaW5nIHRoZSB3cm9uZyBVU0IgaW50ZXJmYWNlCiAgICAuLi4uIEkgc3VnZ2Vz
dCB5b3UgdG8gbW9kaWZ5IHRoZSA8aT4vZXRjL3VkZXYvcnVsZXMuZC9vZm9uby5ydWxlczxpPgog
ICAgICA8L2k+PC9pPnRvIHVzZSB0aGUgY29ycmVjdCBvbmU8YnI+CiAgICBGaXJzdCwgZ2V0IHRo
ZSBpZHZlbmRvciBhbmQgaWQgcHJvZHVjdCBvZiB5b3VyIGtleSAoZS5nOiBsc3VzYik8YnI+CiAg
ICBUaGVuIGNoZWNrIGluIHRoZSBvZm9uby5ydWxlc6AgYSBsaW5lIGxpa2UgdGhpcyBvbmU6PGJy
PgogICAgPGNvZGU+QVRUUlN7aWRWZW5kb3J9PT0mcXVvdDsxOWQyJnF1b3Q7LAogICAgICBBVFRS
U3tpZFByb2R1Y3R9PT0mcXVvdDswMTIxJnF1b3Q7LEVOVntPRk9OT19JRkFDRV9OVU19PT0mcXVv
dDswNCZxdW90OyygCiAgICAgIEVOVntPRk9OT19aVEVfVFlQRX09JnF1b3Q7bW9kZW0mcXVvdDs8
YnI+CiAgICA8L2NvZGU+QW5kIHVwZGF0ZSB0aGUgT0ZPTk9fSUZBQ0VfTlVNPGJyPgogICAgVGhl
c2Uga2V5cyBwdWJsaXNoIG11bHRpcGxlIGludGVyZmFjZXMgd2l0aCBkaWZmZXJlbnQgcHVycG9z
ZXMgKGxpa2UKICAgIG1vZGVtIGRpYWcsIHRyYWNlcywgZXRjLi4uKTxicj4KICAgIEhvcGUgdGhp
cyBoZWxwIDxicj4KICAgIE9saXZpZXI8YnI+CiAgICA8YnI+CiAgICA8YnI+CiAgICA8aT48L2k+
CiAgPC9kaXY+Cgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============8672659270623198304==--

