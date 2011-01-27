Content-Type: multipart/mixed; boundary="===============0283225327724750599=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 0/3] EF-SPN API to sim-atom
Date: Thu, 27 Jan 2011 15:22:14 +0200
Message-ID: <1296134537-16133-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0283225327724750599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here is an asynchronous implementation of SIM Service Provider Name (EF-SPN=
) getter API.
The trick is to delay setting sim ready until spn reading is finished.

Patch to use the new API in netreg is included.

--Jukka

Jukka Saunamaki (3):
      sim: add ofono_sim_get_spn API header
      sim: add ofono_sim_get_spn API implementation
      netreg: use ofono_sim_get_spn()

 include/sim.h |    2 +
 src/network.c |   46 +++++------------------------------
 src/sim.c     |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 81 insertions(+), 40 deletions(-)


--===============0283225327724750599==--

