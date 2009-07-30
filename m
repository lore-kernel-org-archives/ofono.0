Content-Type: multipart/mixed; boundary="===============3554700088001312385=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: sms segment fault with 160 char
Date: Thu, 30 Jul 2009 15:00:03 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302053C514F@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200907292305.58924.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3554700088001312385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
Great, the segment fault was solved in latest version.
But there was problem for more recipients
Please see the log of phonesim:
 AT+CMGS=3D18 : =

> =

0011000B815128010272F40000A70461F1980C : =

+CMGS: 0
OK
AT+CMGS=3D18 : =

> =

0011000B813118567873F20000A704B2D88C06 : =

+CMGS: 0
OK
The content is different, and it should be abcd

In real network:
Because I use phone as modem so maybe something wrong in at response.
Whatever it was wrong behavior:
The number1 target device received two message:
 1, content: abcd
 2, content: number1

ofonod[21782]: csca_query_cb: 8613800210500, 145
ofonod[21782]: Got 2 recipients
ofonod[21782]: ref: 1, offset: 0
ofonod[21782]: pdu_len: 20, tpdu_len: 19
ofonod[21782]: ref: 2, offset: 0
ofonod[21782]: pdu_len: 20, tpdu_len: 19
ofonod[21782]: tx_next: 0x8c1eac0
ofonod[21782]: Got 1 recipients
ofonod[21782]: ref: 3, offset: 0
ofonod[21782]: pdu_len: 25, tpdu_len: 24
ofonod[21782]: at_cmgs_cb got result: 1
ofonod[21782]: Final response: OK
ofonod[21782]: Response line: +CMGS: 81
ofonod[21782]: Got MR: 81
ofonod[21782]: tx_finished
ofonod[21782]: Peeking in the queue
ofonod[21782]: Scheduling next
ofonod[21782]: tx_next: 0x8c1ebf8
ofonod[21782]: at_cmgs_cb got result: 0
ofonod[21782]: Final response: +CMS ERROR: 500
ofonod[21782]: tx_finished
ofonod[21782]: Sending failed, retrying in 5 seconds...
ofonod[21782]: tx_next: 0x8c1ebf8
ofonod[21782]: at_cmgs_cb got result: 1
ofonod[21782]: Final response: OK
ofonod[21782]: Response line: +CMGS: 83
ofonod[21782]: Got MR: 83
ofonod[21782]: tx_finished
ofonod[21782]: Peeking in the queue
ofonod[21782]: Scheduling next
ofonod[21782]: tx_next: 0x8c1ecb8
ofonod[21782]: at_cmgs_cb got result: 1
ofonod[21782]: Final response: OK
ofonod[21782]: Response line: +CMGS: 84
ofonod[21782]: Got MR: 84
ofonod[21782]: tx_finished
ofonod[21782]: Peeking in the queue

Thanks
Zhigang
>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: 2009=E5=B9=B47=E6=9C=8830=E6=97=A5 12:06
>To: ofono(a)ofono.org
>Subject: Re: sms segment fault with 160 char
>
>Hi,
>
>> Basically the "[ ]' will be encoded as UCS2, but it is 7bit according
>> message head in fact. So there were two problem:
>> 1, tpdu_len was wrong: the problem was in sms encode
>
>You're wrong.  '[' and ']' are defined in GSM extension table.  And can th=
us
>still be encoded in GSM 7bit alphabet.
>
>> 2, send more segment had issue.
>
>Please fetch the latest version, this was fixed earlier today.
>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============3554700088001312385==--

