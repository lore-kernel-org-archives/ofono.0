Content-Type: multipart/mixed; boundary="===============0896739865178314755=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 0/3] cdma-connman add roaming support
Date: Thu, 01 Dec 2011 17:40:31 +0100
Message-ID: <1322757634-18468-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0896739865178314755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Those 3 patches are implementing roaming property support.
It contains the cdma-netreg status watches implementation, to notify
cdma connection manager that network status has changed to disable or not
data call in case roaming is allowed or not.

Kind regards,
Guillaume

Guillaume Zajac (3):
  doc: Add RoamingAllowed property
  cdma-netreg: Add cdma-netreg status watch
  cdma-connman: Add RoamingAllowed support

 doc/cdma-connman-api.txt |    8 +++++
 src/cdma-connman.c       |   70 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/cdma-netreg.c        |   52 ++++++++++++++++++++++++++++++++++
 src/ofono.h              |   13 ++++++++
 4 files changed, 142 insertions(+), 1 deletions(-)


--===============0896739865178314755==--

