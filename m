Content-Type: multipart/mixed; boundary="===============1675879331823461162=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 0/9] External HFP: Add SCO
Date: Mon, 28 Jan 2013 11:44:10 -0300
Message-ID: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1675879331823461162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series adds Bluetooth SCO socket declaration and the initial =

code to manage HF audio connections.

Some Bluetooth functions and structs are being declared locally, Bluetooth
headers dependency will be removed in the future.

Claudio Takahasi (9):
  bluez5: Add SCO socket declarations
  bluez5: Add bt_bacpy()
  hfp_hf_bluez5: Add SCO listen socket
  bluez5: Add bt_ba2str()
  bluez5: Add bt_getsockpeers()
  bluez5: Add RFCOMM socket address declaration
  hfp_hf_bluez5: Add rejecting SCO connection
  hfp_hf_bluez5: Reject SCO if source doesn't match
  hfp_hf_bluez5: Fix missing fd close

 plugins/bluez5.c        |  38 ++++++++++++
 plugins/bluez5.h        |  42 +++++++++++++
 plugins/hfp_hf_bluez5.c | 162 ++++++++++++++++++++++++++++++++++++++++++++=
+---
 3 files changed, 232 insertions(+), 10 deletions(-)

-- =

1.7.11.7


--===============1675879331823461162==--

