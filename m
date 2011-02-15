Content-Type: multipart/mixed; boundary="===============8187054740867567708=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 0/2] Add AT commands handler in emulator
Date: Tue, 15 Feb 2011 14:19:21 +0100
Message-ID: <1297775963-3426-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8187054740867567708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
This series of patches implements a skeleton for handling AT commands.
These handlers can be local to emulator or stored in a specific atom (e.g. =
gprs).
Registration mechanism is subject to change.

Olivier Guiter (2):
  gprs:Add code to handle AT+CGDCONT
  emulator: Add +CGMI and +CGDCONT commands

 include/emulator.h |    7 +++++-
 include/gprs.h     |    2 +
 src/emulator.c     |   28 +++++++++++++++++++---
 src/gprs.c         |   63 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 95 insertions(+), 5 deletions(-)


--===============8187054740867567708==--

