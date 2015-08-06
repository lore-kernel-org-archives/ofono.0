Content-Type: multipart/mixed; boundary="===============1956223349228434731=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 0/3] Driver specific dial string validation
Date: Thu, 06 Aug 2015 18:56:58 +0200
Message-ID: <1438880221-23834-2-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1438880221-23834-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1956223349228434731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dial() method is generic for all modems but hfpmodem may not support some d=
ial
strings. HFP 1.6 SPEC for ATD says: "Only voice calls are covered in this
specification."
Problem is with dialling USSD codes. Request is accepted and a call object
is state dialling is created. USSD code is completed, result displays on
the phone, but there are no events that would allow oFono to remove this fa=
ke =

call object. =

We may end up in such situation (Samsung S3 4.3):
ofonod[292]: > ATD*132#;\r
ofonod[292]: < \r\nOK\r\n
ofonod[292]: src/voicecall.c:dial_handle_result() Registering new call: 1
ofonod[292]: > AT+CHUP\r
ofonod[292]: < \r\nOK\r\n
ofonod[292]: > AT+CHUP\r
ofonod[292]: < \r\nOK\r\n
ofonod[292]: > AT+CHUP\r
ofonod[292]: < \r\nOK\r\n

This call cannot be ended and no more calls can be done as there can only be
one call in state 'Dialling'.
Proposed workaround is to have a validation string also in the driver, where
a USSD request can be stopped.

Kuba Pawlak (3):
  voicecall.h: add dial string validation to driver
  voicecall.c: call driver's dial string validation
  hfp: define driver specific dial string validation

 drivers/hfpmodem/voicecall.c | 37 ++++++++++++++++++++++++++++++++++++-
 include/voicecall.h          |  6 ++++++
 src/voicecall.c              |  7 ++++++-
 3 files changed, 48 insertions(+), 2 deletions(-)

-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============1956223349228434731==--

