Content-Type: multipart/mixed; boundary="===============4840411407067751340=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 0/4] mmsd: delivery-report flag
Date: Mon, 06 Aug 2012 17:30:56 +0200
Message-ID: <1344267060-5541-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4840411407067751340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch concerns mmsd and is related to delivery-report flag setting.
A specific delivery-report flag is defined for mmsd, it is managed via a DB=
us
api (SetProperty, described in the doc section) and stored in a setting fil=
e.

Ronald Tessier (4):
  store: Add utilities for mms settings file access
  service: Load delivery-report from mms settings
  service: Add DBus method to set delivery-report
  test: Add a script to set the delivery-report flag

 doc/service-api.txt |    6 ++++
 src/service.c       |   88 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/store.c         |   56 ++++++++++++++++++++++++++++++++
 src/store.h         |    4 +++
 test/set-dr         |   25 +++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100755 test/set-dr

-- =

1.7.9.5


--===============4840411407067751340==--

