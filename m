Content-Type: multipart/mixed; boundary="===============5181202815337392479=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/2] convert img to xpm 
Date: Thu, 22 Jul 2010 17:10:13 -0700
Message-ID: <1279843815-28080-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5181202815337392479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes from last version:
* Added length parameter
* created enum for scheme
* added sanity checking for img length
* added character lookup table to keep color strings
  to no more than 2 chars per pixel.

Kristen Carlson Accardi (2):
  stkutil: convert img to xpm
  test-stkutil: unit test for img to xpm converter

 src/stkutil.c       |  148 +++++++++++++++++++++++++++++++
 src/stkutil.h       |    8 ++
 unit/test-stkutil.c |  240 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 396 insertions(+), 0 deletions(-)


--===============5181202815337392479==--

