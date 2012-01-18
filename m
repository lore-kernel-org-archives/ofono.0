Content-Type: multipart/mixed; boundary="===============2598521448303691280=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 0/4] Unify SPN reading logic
Date: Wed, 18 Jan 2012 13:56:25 +0200
Message-ID: <1326887789-16478-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2598521448303691280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order not to duplicate the SPN reading logic in =
src/grps.c and src/network.c.

Changes from v2:

- Removed sim_watch() capability from gprs.c
- Corrected the operator name emission logic.
- In order to save some memory, netreg accesses the spn directly
  from the sim atom.

Regards,
Oleg

Oleg Zhurakivskyy (4):
  gprs: Use sim SPN watch API
  network: Use sim SPN watch API
  sim: Add ofono_sim_get_spn()
  network: Access SPN directly from the sim atom

 include/sim.h |    1 +
 src/gprs.c    |   71 ++++++++++-------------
 src/network.c |  171 ++++++-----------------------------------------------=
----
 src/sim.c     |    8 +++
 4 files changed, 58 insertions(+), 193 deletions(-)

-- =

1.7.5.4


--===============2598521448303691280==--

