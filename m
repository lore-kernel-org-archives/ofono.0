Content-Type: multipart/mixed; boundary="===============2121924456047241887=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 0/1] mmsd
Date: Fri, 09 Mar 2012 15:51:42 +0100
Message-ID: <1331304703-25244-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2121924456047241887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch concerns mmsd (for ofono mailing list) and fixes a double free.

S=C3=A9bastien Bianti (1):
  service: mms_request_destroy shouldn't free msg

 src/service.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

-- =

1.7.4.4


--===============2121924456047241887==--

