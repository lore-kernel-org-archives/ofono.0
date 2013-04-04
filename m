Content-Type: multipart/mixed; boundary="===============4366761427540298374=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 0/3] Telit plugin rework for HE910
Date: Thu, 04 Apr 2013 10:20:49 +0200
Message-ID: <1365063652-24286-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4366761427540298374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series provides functional support for the Telit HE910 modem
by reworking the initialization sequence.  Though this series has
been tested only on an HE910 device, it seems that this control flow
should work fine for older devices as well given that they share the
same documentation and, presumably, use essentially the same firmware.

Best regards,
Jonas Bonn
South Pole AB

Christopher Vogl (1):
  udevng: support telit modems using cdc-acm driver

Jonas Bonn (2):
  telit: allow plugin to be compiled without BT support
  telit: rework for HE910

 Makefile.am      |   9 ++--
 configure.ac     |   3 ++
 plugins/telit.c  | 156 ++++++++++++++++++++++++++++++++++++++++++++++-----=
----
 plugins/udevng.c |  14 +++--
 4 files changed, 152 insertions(+), 30 deletions(-)

-- =

1.8.1.2


--===============4366761427540298374==--

