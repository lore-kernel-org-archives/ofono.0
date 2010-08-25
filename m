Content-Type: multipart/mixed; boundary="===============0907205837349056889=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 0/6] icon support patches 
Date: Wed, 25 Aug 2010 04:00:19 -0700
Message-ID: <1282734025-3375-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0907205837349056889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes from last version:

* bugfix in patch 3, read EFimg, sim_efimg_read_cb.
	Don't calculate num_records without first checking for ok

* bugfix in patch 5, implement GetIcon, ofono_sim_get_image
	When calling back with error, use 0 as error code, not -1

Kristen Carlson Accardi (6):
  simutil: add fileid for EFimg
  stkutil: change uint32_t to guint32
  sim: read EFimg
  sim: read EFiidf
  sim: implement GetIcon
  test: add get-icon script

 src/sim.c     |  466 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/simutil.h |    1 +
 src/stkutil.h |    2 +-
 test/get-icon |   25 +++
 4 files changed, 490 insertions(+), 4 deletions(-)
 create mode 100755 test/get-icon

-- =

1.7.2.1


--===============0907205837349056889==--

