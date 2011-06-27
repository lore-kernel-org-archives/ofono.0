Content-Type: multipart/mixed; boundary="===============3507598350009936835=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 12:21:08 -0500
Message-ID: <4E08BC04.3030105@gmail.com>
In-Reply-To: <20110627190408.GA11941@debut.europalab.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3507598350009936835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

>> The rules seem to be OK, so the udev detection code
>> in plugins/udev.c:add_mbm is not finding your modem.
>>
>> Try starting oFono with
>>
>> ofonod -n -d 'plugins/udev*' (sorry, I messed this up earlier)
>>
>> and report the output
>>
>   meego$ /usr/sbin/ofonod -n -d 'plugins/udev*'
>   ofonod[811]: oFono version 0.48
>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.=
7/usb1/1-5/1-5:1.1/tty/ttyACM0 (mbm)
>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband =
Module Data Modem
>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.=
7/usb1/1-5/1-5:1.3/tty/ttyACM1 (mbm)
>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband =
Module Modem
>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.=
7/usb1/1-5/1-5:1.6/net/wwan0 (mbm)
>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband =
Module Network Adapter
>   ofonod[811]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.=
7/usb1/1-5/1-5:1.9/tty/ttyACM2 (mbm)
>   ofonod[811]: plugins/udev.c:add_mbm() desc: HP hs2330 Mobile Broadband =
Module NMEA
>   ofonod[811]: Exit
> =

> ...sorry I think before I mistyped the MeeGo 1.2 (current) ofono
> version 0.48 as 0.58 incorrectly.
> =

> But the output shown above is rather good, so I'm at a loss
> to what could be wrong. Any ideas? Is connman relevant here?
> =


Based on the output above, the udev plugin needed to be modified to
detect the HP version of the MBM modems.  The change can be found in
commit: 6a2847f7aba5d84b06940ee29300d4b6fd31d682.  I'm also attaching
this patch for your reference.  Please report back if this solves your
issue.

Regards,
-Denis

--===============3507598350009936835==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-udev-Tweak-detection-rules-for-HP-HS2330-cards.patch"

PkZyb20gNmEyODQ3ZjdhYmE1ZDg0YjA2OTQwZWUyOTMwMGQ0YjZmZDMxZDY4MiBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMjcgSnVuIDIwMTEgMTI6MTc6MjIgLTA1MDAKU3ViamVjdDogW1BBVENIXSB1ZGV2
OiBUd2VhayBkZXRlY3Rpb24gcnVsZXMgZm9yIEhQIEhTMjMzMCBjYXJkcwoKLS0tCiBwbHVnaW5z
L3VkZXYuYyB8ICAgIDQgKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGx1Z2lucy91ZGV2LmMgYi9wbHVnaW5zL3VkZXYu
YwppbmRleCAxNTgwYjAyLi44ZWE5MzdjIDEwMDY0NAotLS0gYS9wbHVnaW5zL3VkZXYuYworKysg
Yi9wbHVnaW5zL3VkZXYuYwpAQCAtMTIyLDYgKzEyMiw3IEBAIHN0YXRpYyB2b2lkIGFkZF9tYm0o
c3RydWN0IG9mb25vX21vZGVtICptb2RlbSwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1p
bmljYXJkIE1vZGVtIDIiKSB8fAogCQkJZ19zdHJfaGFzX3N1ZmZpeChkZXNjLCAiTWluaS1DYXJk
IE1vZGVtIikgfHwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIkJyb2FkYmFuZCBNb2RlbSIp
IHx8CisJCQlnX3N0cl9oYXNfc3VmZml4KGRlc2MsICJNb2R1bGUgTW9kZW0iKSB8fAogCQkJZ19z
dHJfaGFzX3N1ZmZpeChkZXNjLCAiQnJvYWRiYW5kIFVTQiBNb2RlbSIpKSkgewogCQlkZXZub2Rl
ID0gdWRldl9kZXZpY2VfZ2V0X2Rldm5vZGUodWRldl9kZXZpY2UpOwogCkBAIC0xMzIsMTEgKzEz
MywxMyBAQCBzdGF0aWMgdm9pZCBhZGRfbWJtKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCiAJ
fSBlbHNlIGlmIChyZWdpc3RlcmVkID09IDAgJiYKIAkJCShnX3N0cl9oYXNfc3VmZml4KGRlc2Ms
ICJNaW5pY2FyZCBEYXRhIE1vZGVtIikgfHwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1p
bmktQ2FyZCBEYXRhIE1vZGVtIikgfHwKKwkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1vZHVs
ZSBEYXRhIE1vZGVtIikgfHwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIkJyb2FkYmFuZCBE
YXRhIE1vZGVtIikpKSB7CiAJCWRldm5vZGUgPSB1ZGV2X2RldmljZV9nZXRfZGV2bm9kZSh1ZGV2
X2RldmljZSk7CiAJCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0sIERBVEFfREVWSUNFLCBk
ZXZub2RlKTsKIAl9IGVsc2UgaWYgKGdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1pbmljYXJkIEdQ
UyBQb3J0IikgfHwKIAkJCWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1pbmktQ2FyZCBHUFMgUG9y
dCIpIHx8CisJCQlnX3N0cl9oYXNfc3VmZml4KGRlc2MsICJNb2R1bGUgTk1FQSIpIHx8CiAJCQln
X3N0cl9oYXNfc3VmZml4KGRlc2MsICJCcm9hZGJhbmQgR1BTIFBvcnQiKSkgewogCQlkZXZub2Rl
ID0gdWRldl9kZXZpY2VfZ2V0X2Rldm5vZGUodWRldl9kZXZpY2UpOwogCQlvZm9ub19tb2RlbV9z
ZXRfc3RyaW5nKG1vZGVtLCBHUFNfREVWSUNFLCBkZXZub2RlKTsKQEAgLTE0NCw2ICsxNDcsNyBA
QCBzdGF0aWMgdm9pZCBhZGRfbWJtKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sCiAJCQkoZ19z
dHJfaGFzX3N1ZmZpeChkZXNjLCAiTWluaWNhcmQgTmV0d29yayBBZGFwdGVyIikgfHwKIAkJCWdf
c3RyX2hhc19zdWZmaXgoZGVzYywgIk1pbmktQ2FyZCBOZXR3b3JrIEFkYXB0ZXIiKSB8fAogCQkJ
Z19zdHJfaGFzX3N1ZmZpeChkZXNjLCAiQnJvYWRiYW5kIE5ldHdvcmsgQWRhcHRlciIpIHx8CisJ
CQlnX3N0cl9oYXNfc3VmZml4KGRlc2MsICJNb2R1bGUgTmV0d29yayBBZGFwdGVyIikgfHwKIAkJ
CWdfc3RyX2hhc19zdWZmaXgoZGVzYywgIk1pbmljYXJkIE5ldHdvcmtBZGFwdGVyIikpKSB7CiAJ
CWRldm5vZGUgPSBnZXRfcHJvcGVydHkodWRldl9kZXZpY2UsICJJTlRFUkZBQ0UiKTsKIAkJb2Zv
bm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbSwgTkVUV09SS19JTlRFUkZBQ0UsIGRldm5vZGUpOwot
LSAKMS43LjMuNAoK

--===============3507598350009936835==--

