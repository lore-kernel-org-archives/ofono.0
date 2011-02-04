Content-Type: multipart/mixed; boundary="===============5119798804579829761=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v5 0/2] bluetooth: Add bluetooth server support
Date: Fri, 04 Feb 2011 15:44:02 +0100
Message-ID: <1296830644-15768-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5119798804579829761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It watches Bluetooth adapter property changes and adds SDP record to
listen client connection request.
It supports multiple adapters, servers and client connections.

Fr=C3=A9d=C3=A9ric Danis (2):
  bluetooth: Add bluetooth server support
  bluetooth: Add Bluetooth service authorization support

 Makefile.am         |    1 +
 plugins/bluetooth.c |  386 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/bluetooth.h |    9 ++
 3 files changed, 393 insertions(+), 3 deletions(-)


--===============5119798804579829761==--

