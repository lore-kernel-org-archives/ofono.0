Content-Type: multipart/mixed; boundary="===============2624992996555431546=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] html text attribute patches 
Date: Tue, 29 Jun 2010 04:22:11 -0700
Message-ID: <1277810534-25450-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2624992996555431546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modified stkutil per last review.  Added unit tests for Display Text
tests.  I will add the rest of the unit tests after this patch series
is reviewed.

Kristen Carlson Accardi (3):
  stkutil: display text attributes as html
  test-stkutil: add unit test for html text attributes
  test-stkutil: add html attribute test for Display Text tests

 src/stkutil.c       |  190 ++++++++++++++++++++++++++++++++++
 src/stkutil.h       |   23 ++++
 unit/test-stkutil.c |  280 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 493 insertions(+), 0 deletions(-)


--===============2624992996555431546==--

