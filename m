Content-Type: multipart/mixed; boundary="===============5538461738032881277=="
MIME-Version: 1.0
From: Audric Schiltknecht <audric.schiltknecht@toulouse.viveris.com>
Subject: Unable to decode PDU for SMS-STATUS-REPORT
Date: Mon, 25 Jun 2012 18:10:36 +0200
Message-ID: <d075607b731e301c6ab7b10bb99a5774@toulouse.viveris.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5538461738032881277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys.

I'm having troubles with delivery reports.

When I send a message with the property "UseDeliveryReports" set to =

"true",
I can get the delivery report from the GSM modem, but ofono is unable =

to decode it:

ofonod[677]: SMS:    < \r\n+CDS: =

32\r\n07913386094000F006DB0A810011223344216052714081802160527140228000\r\n
ofonod[677]: drivers/atmodem/sms.c:at_cds_notify() Got new =

Status-Report PDU via CDS: =

07913386094000F006DB0A810011223344216052714081802160527140228000, 32
ofonod[677]: src/sms.c:ofono_sms_status_notify() len 32 tpdu len 32
ofonod[677]: Unable to decode PDU

The PDU is valid, since I can decode it using some online tool.

It seems that sms_decode does not correctly handle the SMSCC part =

(913386094000F0),
and tries to decode it as the sender address, which obviously fails.

If in decode_deliver() function, I shift the PDU of 9 bytes (ie. PDU is =

DB0A810011223344216052714081802160527140228000),
then the function still fails (more or less expected), but the sender =

address is correctly decoded.


Do any of you have an idea on this matter ?


Regards.
Audric Schiltknecht

--===============5538461738032881277==--

