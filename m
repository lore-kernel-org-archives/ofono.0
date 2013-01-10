Content-Type: multipart/mixed; boundary="===============1470844790091080720=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/6] HFP HF: External Profile
Date: Thu, 10 Jan 2013 11:44:43 -0300
Message-ID: <1357829089-16029-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1470844790091080720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the first group of the patches which introduces the Handsfree
BlueZ external profile.

The following patches contain only initial files and basic structures
for the HFP HF plugin (since files and plugins names are one of =

controversial points).

Remaining HFP HF patches:
git://git.infradead.org/users/cktakahasi/ofono.git HF-20130109

Claudio Takahasi (6):
  Makefile: Enable BlueZ 4 and BlueZ 5
  bluetooth: Add versioning information to BlueZ plugins
  bluetooth: Initial files for BlueZ 5
  hfp_hf: Add initial file for external HFP
  hfp_hf: Add hfp_driver
  hfp_hf: Add BlueZ Profile handler


Claudio Takahasi (6):
  Makefile: Enable BlueZ 4 and BlueZ 5
  bluetooth: Add versioning information to BlueZ plugins
  bluetooth: Initial files for BlueZ 5
  hfp_hf: Add initial file for external HFP
  hfp_hf: Add hfp_driver
  hfp_hf: Add BlueZ Profile handler

 Makefile.am             |  33 +-
 configure.ac            |  10 +-
 dundee/bluetooth.c      |   2 +-
 plugins/bluetooth.c     | 989 --------------------------------------------=
----
 plugins/bluetooth.h     |  84 ----
 plugins/bluez4.c        | 989 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluez4.h        |  84 ++++
 plugins/bluez5.c        | 145 +++++++
 plugins/bluez5.h        |  31 ++
 plugins/dun_gw.c        |   2 +-
 plugins/hfp_ag.c        |   2 +-
 plugins/hfp_hf.c        | 552 ---------------------------
 plugins/hfp_hf_bluez4.c | 552 +++++++++++++++++++++++++++
 plugins/hfp_hf_bluez5.c | 194 ++++++++++
 plugins/sap.c           |   2 +-
 plugins/telit.c         |   2 +-
 16 files changed, 2030 insertions(+), 1643 deletions(-)
 delete mode 100644 plugins/bluetooth.c
 delete mode 100644 plugins/bluetooth.h
 create mode 100644 plugins/bluez4.c
 create mode 100644 plugins/bluez4.h
 create mode 100644 plugins/bluez5.c
 create mode 100644 plugins/bluez5.h
 delete mode 100644 plugins/hfp_hf.c
 create mode 100644 plugins/hfp_hf_bluez4.c
 create mode 100644 plugins/hfp_hf_bluez5.c

-- =

1.7.11.7


--===============1470844790091080720==--

