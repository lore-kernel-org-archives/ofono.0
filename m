Content-Type: multipart/mixed; boundary="===============7138669791219132332=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: Issues about GPRS state
Date: Fri, 19 Aug 2011 09:46:02 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A075C85A@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7138669791219132332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I find there may be some issues about GPRS state, please help check them.

(1) gprs->driver_attached is set to TURE just according to GPRS registratio=
n state.
It may cause the following issue.

1 ofonod[619]: PCUI: < \r\n^SRVST:1\r\n\r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n\r\=
n^SRVST:2\r\n\r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n
2 ofonod[619]: src/network.c:current_operator_callback() 0xa046ea0, 0xa0476=
e8
3 ofonod[619]: src/gprs.c:netreg_status_changed() 2  		#driver_attached =3D=
 FALSE
4 ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
5 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 0, 0
6 ofonod[619]: src/gprs.c:netreg_status_changed() 2
7 ofonod[619]: src/cbs.c:cbs_location_changed() 2, -1, -1, -1, (null)(null)
8 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 2
9 ofonod[619]: src/gprs.c:netreg_status_changed() 1     =

10 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (n=
ull)(null)
11 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
12 ofonod[619]: PCUI: > AT+CSCB=3D0,"0,25,38,50,100,136,256,4352-4356"\r
13 ofonod[619]: PCUI: < \r\nOK\r\n
14 ofonod[619]: PCUI: > AT+CRSM=3D192,28437,0,0,255\r
15 ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 1, A807, =
A72B71\r\n
16 ofonod[619]: src/gprs.c:netreg_status_changed() 1
17 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (n=
ull)(null)
18 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 1    =
#driver_attached =3D TRUE
19 ofonod[619]: PCUI: < \r\n+CRSM: 106,130,""\r\n\r\nOK\r\n
20 ofonod[619]: PCUI: > AT+CGATT=3D0\r
21 ofonod[619]: PCUI: < \r\n+CREG: 1, A807, A72B71\r\n\r\n+CGREG: 0\r\n\r\n=
OK\r\n
22 ofonod[619]: src/gprs.c:netreg_status_changed() 1
23 ofonod[619]: src/cbs.c:cbs_location_changed() 1, 43015, 10955633, -1, (n=
ull)(null)
24 ofonod[619]: src/gprs.c:ofono_gprs_status_notify() /huawei0 status 0
25 ofonod[619]: src/gprs.c:gprs_attach_callback() /huawei0 error =3D 0

At line 3 gprs_netreg_update() is called, driver_attached is set to FALSE. =
Due to there
are some AT command in the queue, AT+CGATT=3D0 is not sent out immediately(=
till@line 20).
At line 18, driver_attached is set to TRUE. In fact after line 21, GPRS is =
detached.
In src/gprs.c there is only one place to attach GPRS, it is in gprs_netreg_=
update().
due to driver_attached is TRUE, gprs_netreg_update() will always return bef=
ore
gprs->driver->set_attached() invoked.

For this issue I have submit two patches, please see attached.

(2) After receive "NW DETACH"/"ME DETACH" unsolicited message, GPRS is not =
re-attached. It will
cause can not connect GPRS connection any more.

(3) In AT modem GPRS driver, the attach status query function(.attached_sta=
tus) is implememted
as query the GPRS registration status. Is it by mistake or intended? It is =
very confusable.


Thanks!

Caiwen





--===============7138669791219132332==
Content-Type: message/rfc822
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.mht"


WzxlbWFpbC5tZXNzYWdlLk1lc3NhZ2UgaW5zdGFuY2UgYXQgMHg3ZjFiMDM3Y2VkZDA+XQ==
--===============7138669791219132332==
Content-Type: message/rfc822
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.mht"


WzxlbWFpbC5tZXNzYWdlLk1lc3NhZ2UgaW5zdGFuY2UgYXQgMHg3ZjFiMDM3Y2VlYTg+XQ==
--===============7138669791219132332==--

