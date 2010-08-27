Content-Type: multipart/mixed; boundary="===============5981534960306948178=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] icon support 
Date: Fri, 27 Aug 2010 09:19:23 -0700
Message-ID: <1282925966-14419-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5981534960306948178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes from last version:

* changed caching algorithm for EFiidf files - now store all 256 byte
	blocks in a single file
* made ofono_sim_read_bytes a public function
* various bug fixes

Kristen Carlson Accardi (3):
  sim: read EFiidf
  sim: Implement GetIcon
  test: add get-icon script

 include/sim.h |    4 +
 src/sim.c     |  525 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 test/get-icon |   25 +++
 3 files changed, 542 insertions(+), 12 deletions(-)
 create mode 100755 test/get-icon

-- =

1.7.2.1


--===============5981534960306948178==--

