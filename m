Content-Type: multipart/mixed; boundary="===============2732243764875813200=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 0/5] udev rules update
Date: Wed, 31 Aug 2011 11:26:30 +0200
Message-ID: <1314782795-9816-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2732243764875813200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The modification I did in udevng.c to prevent overiding of the OFONO_LABEL =
based assignment, could break the default assignment.
I fixed this with this new patch. =


Philippe Nunes (5):
  udev: Add rules to support ZTE MF668 dongle
  udev: Add rules to support ZTE MF190 dongle
  udevng.c: tty assignment according OFONO_LABEL should take precedence
  udev: Add rules to support Speedup 7300 dongle
  udev: Add rules to support SpeedUp 9800 dongle

 plugins/ofono.rules |   20 ++++++++++++++++
 plugins/udevng.c    |   61 +++++++++++++++++++++++++++++++----------------=
---
 2 files changed, 58 insertions(+), 23 deletions(-)


--===============2732243764875813200==--

