Content-Type: multipart/mixed; boundary="===============0627419637288833698=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issues about GPRS state
Date: Thu, 18 Aug 2011 14:29:26 -0500
Message-ID: <4E4D6816.4010805@gmail.com>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A075C85A@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0627419637288833698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 08/19/2011 04:46 AM, Zhang, Caiwen wrote:
> Hi,
> =

> I find there may be some issues about GPRS state, please help check them.
> =

> (1) gprs->driver_attached is set to TURE just according to GPRS registrat=
ion state.
> It may cause the following issue.
> =

> 1 ofonod[619]: PCUI: < \r\n^SRVST:1\r\n\r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n\=
r\n^SRVST:2\r\n\r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n
> 2 ofonod[619]: src/network.c:current_operator_callback() 0xa046ea0, 0xa04=
76e8
> 3 ofonod[619]: src/gprs.c:netreg_status_changed() 2  		#driver_attached =
=3D FALSE
> 4 ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(nul=
l)
> 5 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 0, 0
> 6 ofonod[619]: src/gprs.c:netreg_status_changed() 2
> 7 ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(nul=
l)
> 8 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 2
> 9 ofonod[619]: src/gprs.c:netreg_status_changed() 1     =

> 10 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, =
(null)(null)
> 11 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
> 12 ofonod[619]: PCUI: > AT+CSCB=3D0,"0,25,38,50,100,136,256,4352-4356"\r
> 13 ofonod[619]: PCUI: < \r\nOK\r\n
> 14 ofonod[619]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
> 15 ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1, A807=
, A72B71\r\n
> 16 ofonod[619]: src/gprs.c:netreg_status_changed() 1
> 17 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, =
(null)(null)
> 18 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1  =
  #driver_attached =3D TRUE
> 19 ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
> 20 ofonod[619]: PCUI: > AT+CGATT=3D0\r
> 21 ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n\r=
\nOK\r\n
> 22 ofonod[619]: src/gprs.c:netreg_status_changed() 1
> 23 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, =
(null)(null)
> 24 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
> 25 ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0
> =

> At line 3 gprs_netreg_update() is called, driver_attached is set to FALSE=
. Due to there
> are some AT command in the queue, AT+CGATT=3D0 is not sent out immediatel=
y(till at line 20).
> At line 18, driver_attached is set to TRUE. In fact after line 21, GPRS i=
s detached.
> In src/gprs.c there is only one place to attach GPRS, it is in gprs_netre=
g_update().
> due to driver_attached is TRUE, gprs_netreg_update() will always return b=
efore
> gprs->driver->set_attached() invoked.
>

It seems to me the issue is that we do not check the FLAG_ATTACHING
properly inside ofono_gprs_status_notify.  I've already proposed a fix
for this a while ago, please see it again (attached).

> For this issue I have submit two patches, please see attached.
> =

> (2) After receive "NW DETACH"/"ME DETACH" unsolicited message, GPRS is no=
t re-attached. It will
> cause can not connect GPRS connection any more.
> =

> (3) In AT modem GPRS driver, the attach status query function(.attached_s=
tatus) is implememted
> as query the GPRS registration status. Is it by mistake or intended? It i=
s very confusable.
> =


Attached means whether we're actually attached to PS service.  The
reason the driver method is called attached_status is that some modems
(e.g. isi) do not have (and rightfully so) a concept of 'PS registration
status' as returned by CGREG.  So yes, it is on purpose and it is not a
mistake.

Regards,
-Denis

--===============0627419637288833698==
Content-Type: text/plain
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gprs-Experimental-fix-for-twitchy-Huawei-firmware.patch"

PkZyb20gZGRiYWNjMmRkYThkYjQ3NjkyNDE4MWJmZjQ5MzU2MDg3YzhjY2M3MCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMjUgSnVsIDIwMTEgMjE6NDI6MzUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBncHJz
OiBFeHBlcmltZW50YWwgZml4IGZvciB0d2l0Y2h5IEh1YXdlaSBmaXJtd2FyZQoKLS0tCiBzcmMv
Z3Bycy5jIHwgICAgOCArKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2dwcnMuYyBiL3NyYy9ncHJzLmMKaW5k
ZXggYWNiZmE1Ni4uYjllMzEwNSAxMDA2NDQKLS0tIGEvc3JjL2dwcnMuYworKysgYi9zcmMvZ3By
cy5jCkBAIC0yMTA4LDYgKzIxMDgsMTQgQEAgdm9pZCBvZm9ub19ncHJzX3N0YXR1c19ub3RpZnko
c3RydWN0IG9mb25vX2dwcnMgKmdwcnMsIGludCBzdGF0dXMpCiAJCXJldHVybjsKIAl9CiAKKwkv
KgorCSAqIElmIHdlJ3JlIGFscmVhZHkgdGFraW5nIGFjdGlvbiwgZS5nLiBhdHRhY2hpbmcgb3Ig
ZGV0YWNoaW5nLCB0aGVuCisJICogaWdub3JlIHRoaXMgbm90aWZpY2F0aW9uIGZvciBub3csIHdl
IHdpbGwgdGFrZSBhcHByb3ByaWF0ZSBhY3Rpb24KKwkgKiBhZnRlciB0aGUgc2V0X2F0dGFjaCBv
cGVyYXRpb24gaGFzIGNvbXBsZXRlZAorCSAqLworCWlmIChncHJzLT5mbGFncyAmIEdQUlNfRkxB
R19BVFRBQ0hJTkcpCisJCXJldHVybjsKKwogCS8qIFdlIHJlZ2lzdGVyZWQgd2l0aG91dCBiZWlu
ZyBwb3dlcmVkICovCiAJaWYgKGdwcnMtPnBvd2VyZWQgPT0gRkFMU0UpCiAJCWdvdG8gZGV0YWNo
OwotLSAKMS43LjMuNAoK

--===============0627419637288833698==--

