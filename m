Content-Type: multipart/mixed; boundary="===============5480595088540934962=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: sms segment fault with 160 char
Date: Thu, 30 Jul 2009 11:35:07 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C5096@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5480595088540934962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
There was segment fault during send 160 char sms.
The content is 160 char like: abcdefghijklmnopqrstuvwxyz0123456789][=3D+...=
.......

ofonod[12988]: Response line: +CSCA: "+8613800210500",145
ofonod[12988]: csca_query_cb: 8613800210500, 145
ofonod[12988]: Got 1 recipients
ofonod[12988]: ref: 1, offset: 3
ofonod[12988]: pdu_len: 155, tpdu_len: 154
ofonod[12988]: pdu_len: 36, tpdu_len: 35
ofonod[12988]: tx_next: 0x82660f0
ofonod[12988]: at_cmgs_cb got result: 1
ofonod[12988]: Final response: OK
ofonod[12988]: Response line: +CMGS: 31
ofonod[12988]: Got MR: 31
ofonod[12988]: tx_finished
ofonod[12988]: Peeking in the queue
ofonod[12988]: Scheduling next
Segmentation fault

Basically the "[ ]' will be encoded as UCS2, but it is 7bit according messa=
ge head in fact.
So there were two problem:
1, tpdu_len was wrong: the problem was in sms encode
2, send more segment had issue.
 =

Thanks
Zhigang




--===============5480595088540934962==--

