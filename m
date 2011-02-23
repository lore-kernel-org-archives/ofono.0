Content-Type: multipart/mixed; boundary="===============1139208268135386133=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] Disable command echo for hfp emulators
Date: Wed, 23 Feb 2011 14:19:11 +0100
Message-ID: <1298467153-2426-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1139208268135386133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the default asked by HSP and HFP specifications, which
is the opposite of what v250 is asking.

Fr=C3=A9d=C3=A9ric Dalleau (2):
  gatchat: Add function to enable/disable echo
  emulator: Disable echo for hfp emulators

 gatchat/gatserver.c |   10 ++++++++++
 gatchat/gatserver.h |    1 +
 src/emulator.c      |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)


--===============1139208268135386133==--

