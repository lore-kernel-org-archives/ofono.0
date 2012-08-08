Content-Type: multipart/mixed; boundary="===============6555857484962143393=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 0/3] mmsd: delivery-report flag
Date: Wed, 08 Aug 2012 15:21:43 +0200
Message-ID: <1344432106-23105-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6555857484962143393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch concerns mmsd and is related to delivery-report flag setting.
Describe and implement the SetProperty DBus api.
Add a test script to set/unset the delivery-report flag.

Ronald Tessier (3):
  service: Add DBus method to set delivery-report
  doc: Describe DBus method to set delivery-report
  test: Add a script to set the delivery-report flag

 Makefile.am         |    2 +-
 doc/service-api.txt |   13 +++++++++++++
 src/service.c       |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 test/set-dr         |   25 +++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100755 test/set-dr

--
1.7.9.5


--===============6555857484962143393==--

