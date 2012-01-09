Content-Type: multipart/mixed; boundary="===============6545453712873694549=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 0/4] Unify SPN reading logic
Date: Mon, 09 Jan 2012 12:30:40 +0200
Message-ID: <1326105044-26408-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6545453712873694549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order not to duplicate the SPN reading logic in =
src/grps.c and src/network.c.

Changes from v1:

- SPN reading logic has been moved into the sim atom in order to avoid the =
asymmetry in the API.
- netreg and gprs atoms are simple consumers.
- Added display condition to the SPN watch callback.

Regards,
Oleg

Oleg Zhurakivskyy (4):
  sim: Minor style fixes
  sim: Add SPN watch capability
  gprs: Use sim SPN watch API
  network: Use sim SPN watch API

 include/sim.h |    8 ++
 src/gprs.c    |  105 ++++++++++++++---------
 src/network.c |  163 +++++-------------------------------
 src/sim.c     |  264 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 4 files changed, 345 insertions(+), 195 deletions(-)

-- =

1.7.5.4


--===============6545453712873694549==--

