Content-Type: multipart/mixed; boundary="===============4323908267201558804=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] convert images to xpm 
Date: Mon, 26 Jul 2010 11:27:32 -0700
Message-ID: <1280168854-4151-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4323908267201558804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since last version:
* whitespace changes
* corrected sanity tests
* changed signature to pass clut and clut_len to function
* updated unit tests for new signature

Kristen Carlson Accardi (2):
  stkutil: convert img to xpm
  test-stkutil: unit test for img to xpm converter

 src/stkutil.c       |  147 ++++++++++++++++++++++++++++++
 src/stkutil.h       |    9 ++
 unit/test-stkutil.c |  247 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 403 insertions(+), 0 deletions(-)


--===============4323908267201558804==--

