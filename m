Content-Type: multipart/mixed; boundary="===============5234509165314890549=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: Can't send second message in v0.3
Date: Wed, 19 Aug 2009 17:35:40 +0800
Message-ID: <B94C62E7C2870743865418621F040C130206BE7BBC@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5234509165314890549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
Can't send second message in v0.3 version and latest version, but it's ok i=
n v0.2.
In phonesim can't reproduce this issue.

Ofonod log: V0.3
ofonod[9884]: csca_query_cb: 8613800210500, 145
ofonod[9884]: Got 1 recipients
ofonod[9884]: ref: 1, offset: 0
ofonod[9884]: pdu_len: 20, tpdu_len: 19
ofonod[9884]: tx_next: 0x9bee070
ofonod[9884]: Got 1 recipients
ofonod[9884]: ref: 2, offset: 0
ofonod[9884]: pdu_len: 20, tpdu_len: 19

ofonod log V0.2:
ofonod[14114]: Response line: +CSCA: "+8613800210500",145
ofonod[14114]: csca_query_cb: 8613800210500, 145
ofonod[14114]: Got 1 recipients
ofonod[14114]: ref: 1, offset: 0
ofonod[14114]: pdu_len: 19, tpdu_len: 18
ofonod[14114]: tx_next: 0x8c14508
ofonod[14114]: at_cmgs_cb got result: 1
ofonod[14114]: Final response: OK
ofonod[14114]: Response line: +CMGS: 119
ofonod[14114]: Got MR: 119
ofonod[14114]: tx_finished
ofonod[14114]: Peeking in the queue
ofonod[14114]: Got 1 recipients
ofonod[14114]: ref: 2, offset: 0
ofonod[14114]: pdu_len: 19, tpdu_len: 18
ofonod[14114]: tx_next: 0x8c14508
ofonod[14114]: at_cmgs_cb got result: 1
ofonod[14114]: Final response: OK
ofonod[14114]: Response line: +CMGS: 120
ofonod[14114]: Got MR: 120
ofonod[14114]: tx_finished

Some useful information:
ofonod[9884]: MessageWaiting interface for modem: /modem1 created
ofonod[9884]: SmsManager interface for modem: /modem1 created
ofonod[9884]: at_crsm_info_cb got result: 1
ofonod[9884]: Final response: OK
ofonod[9884]: Response line: +CRSM: 148,4
ofonod[9884]: Unable to read waiting messages numbers from SIM
ofonod[9884]: at_crsm_info_cb got result: 1
ofonod[9884]: Final response: OK
ofonod[9884]: Response line: +CRSM: 148,4
ofonod[9884]: Unable to read mailbox identifies from SIM

Anything else?

Thanks


--===============5234509165314890549==--

