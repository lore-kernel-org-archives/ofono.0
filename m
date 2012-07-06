Content-Type: multipart/mixed; boundary="===============2608809074037329629=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 0/3] mmsd: get delivery_report setting
Date: Fri, 06 Jul 2012 11:32:24 +0200
Message-ID: <1341567147-18467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2608809074037329629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches concerns mmsd and is related to delivery_report.
Add delivery report flag and API (to set its value) to service.
Get and track the delivery report setting used by oFono in the message mana=
ger
and use it in mmsd.

Ronald Tessier (3):
  service: manage delivery report setting
  ofono: Add support for message_manager tracking
  service: use delivery_report in send_req message

 plugins/ofono.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/service.c   |   15 +++++++
 src/service.h   |    2 +
 3 files changed, 152 insertions(+)

--
1.7.9.5


--===============2608809074037329629==--

