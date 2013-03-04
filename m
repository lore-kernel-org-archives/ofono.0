Content-Type: multipart/mixed; boundary="===============1623528576543149668=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 0/6] handsfree-audio: Add Agent NewConnection()
Date: Mon, 04 Mar 2013 17:48:47 -0300
Message-ID: <1362430133-6870-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1623528576543149668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series moves the SCO connection handling from hfp_hf_bluez5.c
to src/handsfree-audio.c, and adds the Agent NewConnection() method call
to pass the SCO file descriptor from oFono to the Agent implementation.

Changes between v0-v1:
* Merged commits "Move SCO to handsfree-audio.c" and "Remove modem
dependency"
* Removed tracking of supported local HFP version in handsfree-audio
* Removed ofono_handsfree_get_version()

Claudio Takahasi (6):
  bluetooth: Add new Bluetooth header
  handsfree-audio: Move SCO to handsfree-audio.c
  handsfree-audio: Add NewConnection
  handsfree-audio: Check local SCO address
  handsfree-audio: Reject SCO if Card is not ready
  handsfree-audio: Reject SCO if agent is unavailable

 Makefile.am             |   2 +-
 plugins/bluez5.c        |  17 ------
 plugins/bluez5.h        |  41 --------------
 plugins/hfp_hf_bluez5.c | 103 +----------------------------------
 src/bluetooth.h         |  71 ++++++++++++++++++++++++
 src/handsfree-audio.c   | 141 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 6 files changed, 214 insertions(+), 161 deletions(-)
 create mode 100644 src/bluetooth.h

-- =

1.7.11.7


--===============1623528576543149668==--

