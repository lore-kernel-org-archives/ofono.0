Content-Type: multipart/mixed; boundary="===============1341874137439643524=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] CDMA network registration
Date: Thu, 20 Oct 2011 17:41:30 +0200
Message-ID: <1319125292-6204-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1341874137439643524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

First patch is adding cdma-netreg atom watch and status watch.
Second one is using them to check if CDMA modem is registered to the networ=
k to activate datacall.

TODO: Manage romaing case whenever it is allowed.

Kind regards,
Guillaume

Guillaume Zajac (2):
  cdma-netreg: Add various cdma-netreg watches
  cdma-connman: Add cdma-netreg status watch to activate data call

 include/cdma-netreg.h |    1 +
 src/cdma-connman.c    |   74 +++++++++++++++++++++++++++++++++++++++++++++=
++-
 src/cdma-netreg.c     |   58 ++++++++++++++++++++++++++++++++++++++
 src/ofono.h           |   13 ++++++++
 4 files changed, 144 insertions(+), 2 deletions(-)


--===============1341874137439643524==--

