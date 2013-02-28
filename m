Content-Type: multipart/mixed; boundary="===============6355822032459009418=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 00/10] handsfree-audio: Add Agent NewConnection()
Date: Thu, 28 Feb 2013 15:52:42 -0300
Message-ID: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6355822032459009418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series moves the SCO connection handling from hfp_hf_bluez5.c
to src/handsfree-audio.c, and adds the Agent NewConnection() method call
to pass the SCO file descriptor from oFono to the Agent implementation.

Claudio Takahasi (10):
  bluetooth: Add new Bluetooth header
  handsfree-audio: Move SCO to handsfree-audio.c
  handsfree-audio: Remove modem dependency
  handsfree-audio: Add NewConnection
  handsfree-audio: Check local SCO address
  handsfree-audio: Reject SCO if Card is not ready
  handsfree-audio: Reject SCO if agent is unavailable
  handsfree-audio: Check CVSD when registering agent
  handsfree-audio: Add function to get hfp version
  hfp_hf_bluez5: Fix hard-coded hfp version

 Makefile.am               |   2 +-
 include/handsfree-audio.h |   1 +
 plugins/bluez5.c          |  17 -----
 plugins/bluez5.h          |  41 ------------
 plugins/hfp_hf_bluez5.c   | 105 +-----------------------------
 src/bluetooth.h           |  71 ++++++++++++++++++++
 src/handsfree-audio.c     | 162 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 7 files changed, 235 insertions(+), 164 deletions(-)
 create mode 100644 src/bluetooth.h

-- =

1.7.11.7


--===============6355822032459009418==--

