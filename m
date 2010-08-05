Content-Type: multipart/mixed; boundary="===============3068457868164577455=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/7] add support for icons 
Date: Thu, 05 Aug 2010 14:32:33 -0700
Message-ID: <1281043960-9616-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3068457868164577455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is still a wip, but I wanted to get your feedback on what I've
got so far.  The patch "allow partial reads of files" is still
pretty much what I had before, so I haven't addressed any of your
issues with it.  It still doesn't do files > 256, and I'm just
using the existing read functions with a couple modifications.
I've got some outstanding questions that I noted in comments in
the patches.  =


These patches do work with phonesim - so you can play with the
test script if you feel like it.

Kristen Carlson Accardi (7):
  simutil: add fileid for EFimg
  stkutil: change uint32_t to guint32
  sim: read EFimg
  sim: allow partial reads of files
  sim: read an image from an EFiidf
  sim: implement GetIcon dbus interface
  test: add get-icon script

 include/sim.h |   11 +++
 src/sim.c     |  274 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+--
 src/simutil.h |    1 +
 src/stkutil.h |    2 +-
 test/get-icon |   25 +++++
 5 files changed, 302 insertions(+), 11 deletions(-)
 create mode 100755 test/get-icon


--===============3068457868164577455==--

