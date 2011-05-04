Content-Type: multipart/mixed; boundary="===============7646190513770288960=="
MIME-Version: 1.0
From: rajeshkumar s.a <rajeshkumar.s.a@gmail.com>
Subject: Re: Dedug Log for Huawei EC168C
Date: Wed, 04 May 2011 21:34:14 +0530
Message-ID: <BANLkTi=a3hHpUUQ2crGgBb3WFQU40W37eg@mail.gmail.com>
In-Reply-To: <BANLkTimfiAoZZQc_GB0PYd_n0CF-v1je=w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7646190513770288960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rules
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1412",
ENV{OFONO_IFACE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1412",
ENV{OFONO_IFACE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1412",
ENV{OFONO_IFACE_NUM}=3D=3D"04", ENV{OFONO_HUAWEI_TYPE}=3D"gps"
ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1412",
ENV{OFONO_IFACE_NUM}=3D=3D"05", ENV{OFONO_HUAWEI_TYPE}=3D"pcvoice"

lsusb
Bus 003 Device 002: ID 12d1:1412 Huawei Technologies Co., Ltd.

rajesh

On Wed, May 4, 2011 at 9:31 PM, rajeshkumar s.a
<rajeshkumar.s.a@gmail.com>wrote:

> How do I get the proper ofono_interface_num ? (n00b ques)
>
> rajesh
>
>
> On Wed, May 4, 2011 at 9:26 PM, Olivier Guiter <
> olivier.guiter(a)linux.intel.com> wrote:
>
>>  On 05/04/2011 05:35 PM, rajeshkumar s.a wrote:
>>
>> PFA, the debug log with AT commands
>>
>> I am still getting a timeout on enable-modem operation
>>
>> and list-modem gives following o/p
>>
>> $ ./list-modems
>> [ /huawei0 ]
>>     Features =3D
>>     Emergency =3D 0
>>     Powered =3D 0
>>     Lockdown =3D 0
>>     Interfaces =3D
>>     Online =3D 0
>>
>> Regards,
>> Rajesh
>>
>>  As far i can see, ofono communicates using the wrong USB interface ....=
 I
>> suggest you to modify the */etc/udev/rules.d/ofono.rules *to use the
>> correct one
>> First, get the idvendor and id product of your key (e.g: lsusb)
>> Then check in the ofono.rules  a line like this one:
>> ATTRS{idVendor}=3D=3D"19d2",
>> ATTRS{idProduct}=3D=3D"0121",ENV{OFONO_IFACE_NUM}=3D=3D"04",
>> ENV{OFONO_ZTE_TYPE}=3D"modem"
>> And update the OFONO_IFACE_NUM
>> These keys publish multiple interfaces with different purposes (like mod=
em
>> diag, traces, etc...)
>> Hope this help
>> Olivier
>>
>>
>> **
>>
>
>

--===============7646190513770288960==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

cnVsZXM8YnI+QVRUUlN7aWRWZW5kb3J9PT0mcXVvdDsxMmQxJnF1b3Q7LCBBVFRSU3tpZFByb2R1
Y3R9PT0mcXVvdDsxNDEyJnF1b3Q7LCBFTlZ7T0ZPTk9fSUZBQ0VfTlVNfT09JnF1b3Q7MDAmcXVv
dDssIEVOVntPRk9OT19IVUFXRUlfVFlQRX09JnF1b3Q7TW9kZW0mcXVvdDs8YnI+QVRUUlN7aWRW
ZW5kb3J9PT0mcXVvdDsxMmQxJnF1b3Q7LCBBVFRSU3tpZFByb2R1Y3R9PT0mcXVvdDsxNDEyJnF1
b3Q7LCBFTlZ7T0ZPTk9fSUZBQ0VfTlVNfT09JnF1b3Q7MDImcXVvdDssIEVOVntPRk9OT19IVUFX
RUlfVFlQRX09JnF1b3Q7UGN1aSZxdW90Ozxicj4KQVRUUlN7aWRWZW5kb3J9PT0mcXVvdDsxMmQx
JnF1b3Q7LCBBVFRSU3tpZFByb2R1Y3R9PT0mcXVvdDsxNDEyJnF1b3Q7LCBFTlZ7T0ZPTk9fSUZB
Q0VfTlVNfT09JnF1b3Q7MDQmcXVvdDssIEVOVntPRk9OT19IVUFXRUlfVFlQRX09JnF1b3Q7Z3Bz
JnF1b3Q7PGJyPkFUVFJTe2lkVmVuZG9yfT09JnF1b3Q7MTJkMSZxdW90OywgQVRUUlN7aWRQcm9k
dWN0fT09JnF1b3Q7MTQxMiZxdW90OywgRU5We09GT05PX0lGQUNFX05VTX09PSZxdW90OzA1JnF1
b3Q7LCBFTlZ7T0ZPTk9fSFVBV0VJX1RZUEV9PSZxdW90O3Bjdm9pY2UmcXVvdDs8YnI+Cjxicj5s
c3VzYjxicj5CdXMgMDAzIERldmljZSAwMDI6IElEIDEyZDE6MTQxMiBIdWF3ZWkgVGVjaG5vbG9n
aWVzIENvLiwgTHRkLjxicj48YnI+cmFqZXNoPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+T24gV2VkLCBNYXkgNCwgMjAxMSBhdCA5OjMxIFBNLCByYWplc2hrdW1hciBzLmEgPHNwYW4g
ZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86cmFqZXNoa3VtYXIucy5hQGdtYWlsLmNvbSI+
cmFqZXNoa3VtYXIucy5hQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+CjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44
ZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxl
ZnQ6IDFleDsiPkhvdyBkbyBJIGdldCB0aGUgcHJvcGVyIG9mb25vX2ludGVyZmFjZV9udW0gPyAo
bjAwYiBxdWVzKTxicj48YnI+cmFqZXNoPGRpdj48ZGl2PjwvZGl2PjxkaXYgY2xhc3M9Img1Ij4K
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gV2VkLCBNYXkgNCwgMjAxMSBhdCA5
OjI2IFBNLCBPbGl2aWVyIEd1aXRlciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0
bzpvbGl2aWVyLmd1aXRlckBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5vbGl2aWVy
Lmd1aXRlckBsaW51eC5pbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPgo8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4
OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0
OiAxZXg7Ij4KCiAgCiAgICAKICAKICA8ZGl2IGJnY29sb3I9IiNmZmZmZmYiIHRleHQ9IiMwMDAw
MDAiPjxkaXY+PGRpdj48L2Rpdj48ZGl2PgogICAgT24gMDUvMDQvMjAxMSAwNTozNSBQTSwgcmFq
ZXNoa3VtYXIgcy5hIHdyb3RlOgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+UEZBLCB0aGUg
ZGVidWcgbG9nIHdpdGggQVQgY29tbWFuZHM8YnI+CiAgICAgIDxicj4KICAgICAgSSBhbSBzdGls
bCBnZXR0aW5nIGEgdGltZW91dCBvbiBlbmFibGUtbW9kZW0gb3BlcmF0aW9uIDxicj4KICAgICAg
PGJyPgogICAgICBhbmQgbGlzdC1tb2RlbSBnaXZlcyBmb2xsb3dpbmcgby9wPGJyPgogICAgICA8
YnI+CiAgICAgICQgLi9saXN0LW1vZGVtcyA8YnI+CiAgICAgIFsgL2h1YXdlaTAgXTxicj4KICAg
ICAgoKCgIEZlYXR1cmVzID0gPGJyPgogICAgICCgoKAgRW1lcmdlbmN5ID0gMDxicj4KICAgICAg
oKCgIFBvd2VyZWQgPSAwPGJyPgogICAgICCgoKAgTG9ja2Rvd24gPSAwPGJyPgogICAgICCgoKAg
SW50ZXJmYWNlcyA9IDxicj4KICAgICAgoKCgIE9ubGluZSA9IDA8YnI+CiAgICAgIDxicj4KICAg
ICAgUmVnYXJkcyw8YnI+CiAgICAgIFJhamVzaDxicj4KICAgICAgPGJyPgogICAgPC9ibG9ja3F1
b3RlPjwvZGl2PjwvZGl2PgogICAgQXMgZmFyIGkgY2FuIHNlZSwgb2Zvbm8gY29tbXVuaWNhdGVz
IHVzaW5nIHRoZSB3cm9uZyBVU0IgaW50ZXJmYWNlCiAgICAuLi4uIEkgc3VnZ2VzdCB5b3UgdG8g
bW9kaWZ5IHRoZSA8aT4vZXRjL3VkZXYvcnVsZXMuZC9vZm9uby5ydWxlczxpPgogICAgICA8L2k+
PC9pPnRvIHVzZSB0aGUgY29ycmVjdCBvbmU8YnI+CiAgICBGaXJzdCwgZ2V0IHRoZSBpZHZlbmRv
ciBhbmQgaWQgcHJvZHVjdCBvZiB5b3VyIGtleSAoZS5nOiBsc3VzYik8YnI+CiAgICBUaGVuIGNo
ZWNrIGluIHRoZSBvZm9uby5ydWxlc6AgYSBsaW5lIGxpa2UgdGhpcyBvbmU6PGJyPgogICAgPGNv
ZGU+QVRUUlN7aWRWZW5kb3J9PT0mcXVvdDsxOWQyJnF1b3Q7LAogICAgICBBVFRSU3tpZFByb2R1
Y3R9PT0mcXVvdDswMTIxJnF1b3Q7LEVOVntPRk9OT19JRkFDRV9OVU19PT0mcXVvdDswNCZxdW90
OyygCiAgICAgIEVOVntPRk9OT19aVEVfVFlQRX09JnF1b3Q7bW9kZW0mcXVvdDs8YnI+CiAgICA8
L2NvZGU+QW5kIHVwZGF0ZSB0aGUgT0ZPTk9fSUZBQ0VfTlVNPGJyPgogICAgVGhlc2Uga2V5cyBw
dWJsaXNoIG11bHRpcGxlIGludGVyZmFjZXMgd2l0aCBkaWZmZXJlbnQgcHVycG9zZXMgKGxpa2UK
ICAgIG1vZGVtIGRpYWcsIHRyYWNlcywgZXRjLi4uKTxicj4KICAgIEhvcGUgdGhpcyBoZWxwIDxi
cj4KICAgIE9saXZpZXI8YnI+CiAgICA8YnI+CiAgICA8YnI+CiAgICA8aT48L2k+CiAgPC9kaXY+
Cgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+
PGJyPgo=

--===============7646190513770288960==--

