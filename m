Content-Type: multipart/mixed; boundary="===============6351439534153509621=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 0/7] Clear the ground for AG card implementation
Date: Fri, 12 Apr 2013 17:40:58 -0300
Message-ID: <1365799265-19946-1-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1365621887-16940-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6351439534153509621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changelog v2:

* Now uses cb_data mechanism from atutil.h

--

[PATCH 2/7] and [PATCH 3/7]
Implements a mechanism to notify when a emulator is removed and freed.
This mechanism will be required in [PATCH 6/6].

[PATCH 4/7]
HFP 1.6 adds a new feature Codec Negotiation. This commit changes HF
feature check interval.

[PATCH 5/7], [PATCH 6/7] and [PATCH 7/7]
Stores and removes emulators from the hash. This hash is important to
recover the correct emulator and remove it in RequestDisconnection()

Paulo Borges (7):
  emulator: Copy callback mechanism from atutil.h
  include: Add ofono_emulator_set_removed_cb()
  emulator: Add removed notification mechanism
  emulator: Change feature check to attend HFP 1.6
  hfp_ag_bluez5: Create a hash to store emulators
  hfp_ag_bluez5: Store emulator when connect
  hfp_ag_bluez5: Remove emulator when disconnect

 include/emulator.h      |    5 ++++
 plugins/hfp_ag_bluez5.c |   61 +++++++++++++++++++++++++++++++++++++++++++=
+---
 src/emulator.c          |   52 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 4 deletions(-)

-- =

1.7.9.5


--===============6351439534153509621==--

