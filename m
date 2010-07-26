Content-Type: multipart/mixed; boundary="===============4061840241189288460=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: huawei: invalid APN name crashes ofono
Date: Mon, 26 Jul 2010 18:12:06 +0300
Message-ID: <8739v6l1kp.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4061840241189288460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing my Huawei E1552 with connman and noticed that ofono
crashes if I use incorrect APN name. Under gdb it didn't crash but it
busylooped instead and this was in the log:

Jul 26 16:46:02 tukki ofonod[14367]: Modem:> AT+CGDCONT=3D1,"IP","foobar"\r
Jul 26 16:46:02 tukki ofonod[14367]: Modem:< \r\nOK\r\n
Jul 26 16:46:02 tukki ofonod[14367]: Modem:> AT+CGDATA=3D"PPP",1\r
Jul 26 16:46:02 tukki ofonod[14367]: Modem:< \r\nCONNECT\r\n
Jul 26 16:46:03 tukki ofonod[14367]: Pcui:< \r\n^RSSI:22\r\n
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:ppp_dis=
connect() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0
Jul 26 16:46:04 tukki ofonod[14367]: drivers/atmodem/gprs-context.c:at_gprs=
_context_remove() =

Jul 26 16:46:04 tukki ofonod[14367]: plugins/huawei.c:huawei_disconnect() =

Jul 26 16:46:04 tukki ofonod[14367]: src/gprs.c:gprs_context_remove() atom:=
 0x6c88a0

So huawei_disconnect() is recursively in an endless loop. Any ideas how
to fix this properly?

-- =

Kalle Valo

--===============4061840241189288460==--

