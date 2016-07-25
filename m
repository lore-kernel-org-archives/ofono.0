Content-Type: multipart/mixed; boundary="===============4914204661487798341=="
MIME-Version: 1.0
From: Ashida <ashidawa@gmail.com>
Subject: How to port Telit LE910V2 module
Date: Mon, 25 Jul 2016 06:57:36 +0000
Message-ID: <loom.20160725T082756-821@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4914204661487798341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Experts

How do I to extend oFono to support Telit LE910V2 module which is Intel
solution and use AT+CGDATA=3D"M-RAW_IP"...?

First, I modified plugins/udevng.c by adding driver_list[], vendor_list[]
and other related sub function. Second, I copied the gprs_context.c from
ifxmodem to telitmodem folder and also modified codes for LE910V2. However,
oFono goes to GLib-CRITICAL issue after establishing data call.

Can anyone help me?

Here comes my log:
ofonod[1571]: src/gprs.c:ofono_gprs_status_notify() /le910v2_0 status 1
ofonod[1571]:
drivers/telitmodem/gprs-context.c:telit_gprs_activate_primary() cid 1
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: >
AT+CGDCONT=3D1,"IP","internet"\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\nOK\r\n
ofonod[1571]: drivers/telitmodem/gprs-context.c:setup_cb() ok 1
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: > AT#NCM=3D1,1\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\nOK\r\n
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: > AT+CGACT=3D1,1\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\nOK\r\n
ofonod[1571]: drivers/telitmodem/gprs-context.c:activate_cb() ok 1
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: > AT+CGPADDR=3D1\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\n+CGPADDR:
1,"10.113.62.162"\r\n\r\nOK\r\n
ofonod[1571]: drivers/telitmodem/gprs-context.c:address_cb() ok 1
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: > AT#NWDNS=3D1\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\n#NWDNS:
1,"0.0.0.0","0.0.0.0"\r\n\r\nOK\r\n
ofonod[1571]: drivers/telitmodem/gprs-context.c:dns_cb() ok 1
ofonod[1571]: IP: 10.113.62.162
ofonod[1571]: DNS: 0.0.0.0, 0.0.0.0
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: >
AT+CGDATA=3D"M-RAW_IP",1\r
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\nCONNECT
ofonod[1571]: plugins/le910v2.c:le910v2_debug() Modem: < \r\n\r\nOK\r\n
ofonod[1571]: drivers/telitmodem/gprs-context.c:session_cb() ok 1
ofonod[1571]: drivers/telitmodem/gprs-context.c:setup_rawip() =

ofonod[1571]: src/gprs.c:pri_activate_callback() 0x89d47f0

(ofonod:1571): GLib-CRITICAL **: g_io_channel_write_chars: assertion
'channel !=3D NULL' failed

(ofonod:1571): GLib-CRITICAL **: g_source_remove: assertion 'tag > 0' failed

(ofonod:1571): GLib-CRITICAL **: g_io_channel_write_chars: assertion
'channel !=3D NULL' failed

(ofonod:1571): GLib-CRITICAL **: g_source_remove: assertion 'tag > 0' failed


--===============4914204661487798341==--

