Content-Type: multipart/mixed; boundary="===============0384766487514630522=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/3] Unify SPN reading logic in src/gprs.c
Date: Wed, 28 Dec 2011 15:18:41 +0200
Message-ID: <1325078324-30548-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0384766487514630522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order not to duplicate SPN reading logic in src/=
grps.c.

Regards,
Oleg

Oleg Zhurakivskyy (3):
  gprs: Minor whitespace and style fixes
  network: Add SPN watch capability
  gprs: Use netreg SPN watch API

 src/gprs.c    |   91 +++++++++++++++++++++++++++++-------------------------
 src/network.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 src/ofono.h   |    7 ++++
 3 files changed, 146 insertions(+), 47 deletions(-)

-- =

1.7.5.4


--===============0384766487514630522==--

