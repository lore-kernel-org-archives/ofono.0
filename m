Content-Type: multipart/mixed; boundary="===============4940657924987630660=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 0/3] mmsd: Add GetProperties method
Date: Thu, 09 Aug 2012 17:51:40 +0200
Message-ID: <1344527503-9965-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4940657924987630660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch concerns mmsd and is related to delivery-report flag setting.
Describe and implement the GetProperties DBus api.
Add a test script to retrieve service properties.

Ronald Tessier (3):
  service: Add DBus method to get service properties
  doc: Describe GetProperties in service-api
  test: Add a test script to get service properties

 doc/service-api.txt |    7 +++++++
 src/service.c       |   29 +++++++++++++++++++++++++++++
 test/get-properties |   26 ++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100755 test/get-properties

--
1.7.9.5


--===============4940657924987630660==--

