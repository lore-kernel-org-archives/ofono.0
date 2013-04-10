Content-Type: multipart/mixed; boundary="===============3761220316757825088=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 0/6] Clear the ground for AG implementation
Date: Wed, 10 Apr 2013 16:24:41 -0300
Message-ID: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3761220316757825088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series clear the ground for AG card implementation.

[PATCH 1/6] and [PATCH 2/6]
Implements a mechanism to notify when a emulator is removed and freed.
This mechanism will be required in [PATCH 6/6].

[PATCH 3/6]
HFP 1.6 adds a new feature Codec Negotiation. This commit changes HF
feature check interval.

[PATCH 4/6], [PATCH 5/6] and [PATCH 6/6]
Stores and removes emulators from a hash. This hash is important to
recover the correct emulator and remove it in RequestDisconnection().

Paulo Borges (6):
  include: Add ofono_emulator_set_removed_cb()
  emulator: Add removed notification mechanism
  emulator: Change feature check to attend HFP 1.6
  hfp_ag_bluez5: Create a hash to store emulators
  hfp_ag_bluez5: Store emulator when connect
  hfp_ag_bluez5: Remove emulator when disconnect

 include/emulator.h      |    5 ++++
 plugins/hfp_ag_bluez5.c |   61 +++++++++++++++++++++++++++++++++++++++++++=
+---
 src/emulator.c          |   28 +++++++++++++++++++++-
 3 files changed, 90 insertions(+), 4 deletions(-)

-- =

1.7.9.5


--===============3761220316757825088==--

