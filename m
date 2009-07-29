Content-Type: multipart/mixed; boundary="===============2725779385244441274=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: Segment fault in sending sms to  more reciptent
Date: Wed, 29 Jul 2009 17:14:32 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C4F25@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725779385244441274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI
Current sms should support more recipients, right?
And base on the interface the parameter should be: [number1, number2], cont=
ent

But there was segment fault:
ofonod[11097]: Got 2 recipients
ofonod[11097]: ref: 2, offset: 0
ofonod[11097]: pdu_len: 19, tpdu_len: 18
ofonod[11097]: ref: 3, offset: 0
ofonod[11097]: pdu_len: 19, tpdu_len: 18
ofonod[11097]: tx_next: 0x9d04c78
ofonod[11097]: at_cmgs_cb got result: 1
ofonod[11097]: Final response: OK
ofonod[11097]: Response line: +CMGS: 30
ofonod[11097]: Got MR: 30
ofonod[11097]: tx_finished
ofonod[11097]: Peeking in the queue
ofonod[11097]: Scheduling next
Segmentation fault

Thanks


--===============2725779385244441274==--

