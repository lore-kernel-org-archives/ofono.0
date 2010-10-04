Content-Type: multipart/mixed; boundary="===============4076965160418941357=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/4] Icon patches (rebased) 
Date: Mon, 04 Oct 2010 15:33:18 -0700
Message-ID: <1286231602-18692-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4076965160418941357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rebased old patch.  Found some errors that had been introduced into the
simfs code.  Added file type to simutil, although I couldn't test it
on any real hardware.

Kristen Carlson Accardi (4):
  simfs: cache images
  sim: implement GetIcon
  simfs: fix incorrect math when calculating length to copy
  simutil: add file type for EFimg

 src/sim.c     |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/simfs.c   |   83 ++++++++++++++++++++++---
 src/simfs.h   |    4 +
 src/simutil.c |    1 +
 4 files changed, 266 insertions(+), 9 deletions(-)

-- =

1.7.2.1


--===============4076965160418941357==--

