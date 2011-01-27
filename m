Content-Type: multipart/mixed; boundary="===============3620096265172291949=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/4] bluetooth: Add bluetooth server support
Date: Thu, 27 Jan 2011 16:05:36 +0100
Message-ID: <1296140740-11486-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3620096265172291949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It watches Bluetooth adapter property changes and adds SDP record to
listen client connection request.
It supports multiple adapters, servers and client connections.

Use of GSList instead of GHashTable to store adapter path and address
as we need to get address from adapter or vice-versa (during
authorization phase).

Fr=C3=A9d=C3=A9ric Danis (4):
  bluetooth: only use bluetooth_refcount in
    bluetooth_ref/bluetooth_unref
  bluetooth: use GSList instead of GHashTable to store adapter
    path/address
  bluetooth: Add bluetooth server support
  bluetooth: add Bluetooth service authorization support

 Makefile.am         |    1 +
 plugins/bluetooth.c |  558 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 plugins/bluetooth.h |    9 +
 3 files changed, 551 insertions(+), 17 deletions(-)


--===============3620096265172291949==--

