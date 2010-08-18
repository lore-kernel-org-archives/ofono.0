Content-Type: multipart/mixed; boundary="===============4116924670956366658=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 0/6] Icon support 
Date: Wed, 18 Aug 2010 04:25:17 -0700
Message-ID: <1282130723-10488-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4116924670956366658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes from last version:
* Can now read files > 256 bytes
* Implemented cache for EFiidf file blocks
* Implemented cache for generated xpms
* bugfixes and cleanups

Kristen Carlson Accardi (6):
  simutil: add fileid for EFimg
  stkutil: change uint32_t to guint32
  sim: read EFimg
  sim: read EFiidf
  sim: implement GetIcon
  test: add get-icon script

 src/sim.c     |  464 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/simutil.h |    1 +
 src/stkutil.h |    2 +-
 test/get-icon |   25 +++
 4 files changed, 488 insertions(+), 4 deletions(-)
 create mode 100755 test/get-icon

-- =

1.7.2.1


--===============4116924670956366658==--

