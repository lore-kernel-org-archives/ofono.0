Content-Type: multipart/mixed; boundary="===============3074448199685830981=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [PATCH 0/3] sim: add getters for mcc and mnc
Date: Wed, 19 Jan 2011 09:21:25 +0200
Message-ID: <1295421688-19291-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3074448199685830981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches add getter functions for home PLMN MCC and MCC values to SIM =
atom.

Jukka Saunamaki (3):
      sim: store mcc and mnc separate from imsi
      sim: getters for mcc and mnc definition
      sim: getters for mcc and mnc implementation

 include/sim.h |    2 ++
 src/sim.c     |   50 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 19 deletions(-)


--===============3074448199685830981==--

