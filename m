Content-Type: multipart/mixed; boundary="===============3358738422252023905=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH 0/3] SIM900 GPRS fixes
Date: Wed, 17 Jul 2013 09:14:12 +0200
Message-ID: <1374045255-26600-1-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3358738422252023905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I need patches 1 and 2 in order to have a functional ppp connection to the =
SIM900 module.
Renat Zaripov has on the mailing list also reported the need to use the ATD=
*99# command.

The 3rd patch is just a fix for debug output.

Jesper Larsen (3):
  sim900: Enable serial receiver
  atmodem: Add gprs-context quirk for SIM900
  sim900: Fix order of dlc prefixes

 drivers/atmodem/gprs-context.c |    8 ++++++--
 drivers/atmodem/vendor.h       |    1 +
 plugins/sim900.c               |   13 +++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

-- =

1.7.10.4


--===============3358738422252023905==--

