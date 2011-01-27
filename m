Content-Type: multipart/mixed; boundary="===============7581902808301374692=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 0/2] bluetooth: Add bluetooth server support
Date: Thu, 27 Jan 2011 21:20:21 +0100
Message-ID: <1296159623-24155-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7581902808301374692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It watches Bluetooth adapter property changes and adds SDP record to
listen client connection request.
It supports multiple adapters, servers and client connections.

Fr=C3=A9d=C3=A9ric Danis (2):
  bluetooth: Add bluetooth server support
  bluetooth: add Bluetooth service authorization support

 Makefile.am         |    1 +
 plugins/bluetooth.c |  432 +++++++++++++++++++++++++++++++++++++++++++++++=
++--
 plugins/bluetooth.h |    9 +
 3 files changed, 431 insertions(+), 11 deletions(-)


--===============7581902808301374692==--

