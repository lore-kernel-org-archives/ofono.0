Content-Type: multipart/mixed; boundary="===============9167837414338585059=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 0/6] mmsd : Add delivery report support
Date: Tue, 12 Jun 2012 16:04:09 +0200
Message-ID: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9167837414338585059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches concerns mmsd and implements the first task listed in t=
he
MMS Delivery Report section of TODO.

Ronald Tessier (6):
  mmsutil: Add delivery report to send_req struct
  doc: Modify SendMessage D-Bus API
  service: Retrieve delivery-report parameter
  mmsutil: Encode delivery-report in send_req msg
  unit: Add delivery_report to send_req testing
  test: Support delivery_report in Send-Message script

 doc/service-api.txt |    3 ++-
 src/mmsutil.c       |    9 ++++++++-
 src/mmsutil.h       |    6 ++++++
 src/service.c       |   12 +++++++++++-
 test/send-message   |   19 +++++++++++++------
 unit/test-mmsutil.c |    3 ++-
 6 files changed, 42 insertions(+), 10 deletions(-)

--
1.7.4.1


--===============9167837414338585059==--

