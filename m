Content-Type: multipart/mixed; boundary="===============2445200436629597003=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Re: [PATCH 0/3] Telit plugin rework for HE910
Date: Fri, 05 Apr 2013 10:58:35 +0200
Message-ID: <CAMtf1D9w2fT2X=3dxACJEtiJDN4Q6tx_0RhrE=Y=xbkMHEoXsw@mail.gmail.com>
In-Reply-To: <1365063652-24286-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2445200436629597003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thank you, I tested this series of patches on the HE910 yesterday and now
it works just fine.

Etienne Mabille



2013/4/4 Jonas Bonn <jonas@southpole.se>

> This series provides functional support for the Telit HE910 modem
> by reworking the initialization sequence.  Though this series has
> been tested only on an HE910 device, it seems that this control flow
> should work fine for older devices as well given that they share the
> same documentation and, presumably, use essentially the same firmware.
>
> Best regards,
> Jonas Bonn
> South Pole AB
>
> Christopher Vogl (1):
>   udevng: support telit modems using cdc-acm driver
>
> Jonas Bonn (2):
>   telit: allow plugin to be compiled without BT support
>   telit: rework for HE910
>
>  Makefile.am      |   9 ++--
>  configure.ac     |   3 ++
>  plugins/telit.c  | 156
> ++++++++++++++++++++++++++++++++++++++++++++++---------
>  plugins/udevng.c |  14 +++--
>  4 files changed, 152 insertions(+), 30 deletions(-)
>
> --
> 1.8.1.2
>
>

--===============2445200436629597003==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+PC9kaXY+PC9kaXY+
VGhhbmsgeW91LCBJIHRlc3RlZCB0aGlzIHNlcmllcyBvZiBwYXRjaGVzIG9uIHRoZSBIRTkxMCB5
ZXN0ZXJkYXkgYW5kIG5vdyBpdCB3b3JrcyBqdXN0IGZpbmUuPGJyPgo8L2Rpdj48L2Rpdj48YnI+
CjwvZGl2PkV0aWVubmUgTWFiaWxsZTxicj48L2Rpdj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiPjxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjIwMTMvNC80IEpvbmFz
IEJvbm4gPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86am9uYXNAc291dGhwb2xl
LnNlIiB0YXJnZXQ9Il9ibGFuayI+am9uYXNAc291dGhwb2xlLnNlPC9hPiZndDs8L3NwYW4+PGJy
Pgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhl
eDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5UaGlzIHNlcmll
cyBwcm92aWRlcyBmdW5jdGlvbmFsIHN1cHBvcnQgZm9yIHRoZSBUZWxpdCBIRTkxMCBtb2RlbTxi
cj4KYnkgcmV3b3JraW5nIHRoZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZS4goFRob3VnaCB0aGlz
IHNlcmllcyBoYXM8YnI+CmJlZW4gdGVzdGVkIG9ubHkgb24gYW4gSEU5MTAgZGV2aWNlLCBpdCBz
ZWVtcyB0aGF0IHRoaXMgY29udHJvbCBmbG93PGJyPgpzaG91bGQgd29yayBmaW5lIGZvciBvbGRl
ciBkZXZpY2VzIGFzIHdlbGwgZ2l2ZW4gdGhhdCB0aGV5IHNoYXJlIHRoZTxicj4Kc2FtZSBkb2N1
bWVudGF0aW9uIGFuZCwgcHJlc3VtYWJseSwgdXNlIGVzc2VudGlhbGx5IHRoZSBzYW1lIGZpcm13
YXJlLjxicj4KPGJyPgpCZXN0IHJlZ2FyZHMsPGJyPgpKb25hcyBCb25uPGJyPgpTb3V0aCBQb2xl
IEFCPGJyPgo8YnI+CkNocmlzdG9waGVyIFZvZ2wgKDEpOjxicj4KoCB1ZGV2bmc6IHN1cHBvcnQg
dGVsaXQgbW9kZW1zIHVzaW5nIGNkYy1hY20gZHJpdmVyPGJyPgo8YnI+CkpvbmFzIEJvbm4gKDIp
Ojxicj4KoCB0ZWxpdDogYWxsb3cgcGx1Z2luIHRvIGJlIGNvbXBpbGVkIHdpdGhvdXQgQlQgc3Vw
cG9ydDxicj4KoCB0ZWxpdDogcmV3b3JrIGZvciBIRTkxMDxicj4KPGJyPgqgTWFrZWZpbGUuYW0g
oCCgIKB8IKAgOSArKy0tPGJyPgqgPGEgaHJlZj0iaHR0cDovL2NvbmZpZ3VyZS5hYyIgdGFyZ2V0
PSJfYmxhbmsiPmNvbmZpZ3VyZS5hYzwvYT4goCCgIHwgoCAzICsrPGJyPgqgcGx1Z2lucy90ZWxp
dC5jIKB8IDE1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tPGJyPgqgcGx1Z2lucy91ZGV2bmcuYyB8IKAxNCArKystLTxicj4KoDQgZmlsZXMg
Y2hhbmdlZCwgMTUyIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKTxicj4KPHNwYW4gY2xh
c3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxicj4KLS08YnI+CjEuOC4xLjI8YnI+
Cjxicj4KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2Pgo=

--===============2445200436629597003==--

