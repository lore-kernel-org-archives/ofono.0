Content-Type: multipart/mixed; boundary="===============4547555694826196672=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/2] Add scripts for GCF testing
Date: Fri, 03 Aug 2012 16:50:00 +0200
Message-ID: <1344005402-15253-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4547555694826196672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log from v2:
	- Replace hangup-call-state by hangup-multiparty
	- Use call path instead of index to clear a specific call

Guillaume Zajac (2):
  test: Add hangup-multiparty script for GCF testing
  test: Add hangup-call script for GCF testing

 Makefile.am            |    4 +++-
 test/hangup-call       |   36 ++++++++++++++++++++++++++++++++++++
 test/hangup-multiparty |   20 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletions(-)
 create mode 100755 test/hangup-call
 create mode 100755 test/hangup-multiparty

-- =

1.7.5.4


--===============4547555694826196672==--

