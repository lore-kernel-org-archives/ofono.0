Content-Type: multipart/mixed; boundary="===============2837480372467533679=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: Re: Dedug Log for Huawei EC168C
Date: Wed, 04 May 2011 17:56:24 +0200
Message-ID: <4DC17728.5090406@linux.intel.com>
In-Reply-To: <BANLkTim06sHWdPREx_nbvpJku+GZMxTVfg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2837480372467533679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/04/2011 05:35 PM, rajeshkumar s.a wrote:
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
As far i can see, ofono communicates using the wrong USB interface .... =

I suggest you to modify the //etc/udev/rules.d/ofono.rules///to use the =

correct one
First, get the idvendor and id product of your key (e.g: lsusb)
Then check in the ofono.rules  a line like this one:
|ATTRS{idVendor}=3D=3D"19d2", =

ATTRS{idProduct}=3D=3D"0121",ENV{OFONO_IFACE_NUM}=3D=3D"04",  =

ENV{OFONO_ZTE_TYPE}=3D"modem"
|And update the OFONO_IFACE_NUM
These keys publish multiple interfaces with different purposes (like =

modem diag, traces, etc...)
Hope this help
Olivier


//

--===============2837480372467533679==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFs
Ly9FTiI+CjxodG1sPgogIDxoZWFkPgogICAgPG1ldGEgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PUlTTy04ODU5LTEiCiAgICAgIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSI+CiAgPC9oZWFk
PgogIDxib2R5IGJnY29sb3I9IiNmZmZmZmYiIHRleHQ9IiMwMDAwMDAiPgogICAgT24gMDUvMDQv
MjAxMSAwNTozNSBQTSwgcmFqZXNoa3VtYXIgcy5hIHdyb3RlOgogICAgPGJsb2NrcXVvdGUKICAg
ICAgY2l0ZT0ibWlkOkJBTkxrVGltMDZzSFdkUFJFeF9uYnZwSmt1K0daTXhUVmZnQG1haWwuZ21h
aWwuY29tIgogICAgICB0eXBlPSJjaXRlIj5QRkEsIHRoZSBkZWJ1ZyBsb2cgd2l0aCBBVCBjb21t
YW5kczxicj4KICAgICAgPGJyPgogICAgICBJIGFtIHN0aWxsIGdldHRpbmcgYSB0aW1lb3V0IG9u
IGVuYWJsZS1tb2RlbSBvcGVyYXRpb24gPGJyPgogICAgICA8YnI+CiAgICAgIGFuZCBsaXN0LW1v
ZGVtIGdpdmVzIGZvbGxvd2luZyBvL3A8YnI+CiAgICAgIDxicj4KICAgICAgJCAuL2xpc3QtbW9k
ZW1zIDxicj4KICAgICAgWyAvaHVhd2VpMCBdPGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsg
RmVhdHVyZXMgPSA8YnI+CiAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyBFbWVyZ2VuY3kgPSAwPGJy
PgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgUG93ZXJlZCA9IDA8YnI+CiAgICAgICZuYnNwOyZu
YnNwOyZuYnNwOyBMb2NrZG93biA9IDA8YnI+CiAgICAgICZuYnNwOyZuYnNwOyZuYnNwOyBJbnRl
cmZhY2VzID0gPGJyPgogICAgICAmbmJzcDsmbmJzcDsmbmJzcDsgT25saW5lID0gMDxicj4KICAg
ICAgPGJyPgogICAgICBSZWdhcmRzLDxicj4KICAgICAgUmFqZXNoPGJyPgogICAgICA8YnI+CiAg
ICA8L2Jsb2NrcXVvdGU+CiAgICBBcyBmYXIgaSBjYW4gc2VlLCBvZm9ubyBjb21tdW5pY2F0ZXMg
dXNpbmcgdGhlIHdyb25nIFVTQiBpbnRlcmZhY2UKICAgIC4uLi4gSSBzdWdnZXN0IHlvdSB0byBt
b2RpZnkgdGhlIDxlbT4vZXRjL3VkZXYvcnVsZXMuZC9vZm9uby5ydWxlczxpPgogICAgICA8L2k+
PC9lbT50byB1c2UgdGhlIGNvcnJlY3Qgb25lPGJyPgogICAgRmlyc3QsIGdldCB0aGUgaWR2ZW5k
b3IgYW5kIGlkIHByb2R1Y3Qgb2YgeW91ciBrZXkgKGUuZzogbHN1c2IpPGJyPgogICAgVGhlbiBj
aGVjayBpbiB0aGUgb2Zvbm8ucnVsZXMmbmJzcDsgYSBsaW5lIGxpa2UgdGhpcyBvbmU6PGJyPgog
ICAgPGNvZGU+QVRUUlN7aWRWZW5kb3J9PT0iMTlkMiIsCiAgICAgIEFUVFJTe2lkUHJvZHVjdH09
PSIwMTIxIixFTlZ7T0ZPTk9fSUZBQ0VfTlVNfT09IjA0IiwmbmJzcDsKICAgICAgRU5We09GT05P
X1pURV9UWVBFfT0ibW9kZW0iPGJyPgogICAgPC9jb2RlPkFuZCB1cGRhdGUgdGhlIE9GT05PX0lG
QUNFX05VTTxicj4KICAgIFRoZXNlIGtleXMgcHVibGlzaCBtdWx0aXBsZSBpbnRlcmZhY2VzIHdp
dGggZGlmZmVyZW50IHB1cnBvc2VzIChsaWtlCiAgICBtb2RlbSBkaWFnLCB0cmFjZXMsIGV0Yy4u
Lik8YnI+CiAgICBIb3BlIHRoaXMgaGVscCA8YnI+CiAgICBPbGl2aWVyPGJyPgogICAgPGJyPgog
ICAgPGJyPgogICAgPGVtPjwvZW0+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============2837480372467533679==--

