Content-Type: multipart/mixed; boundary="===============6138590495209284643=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v3 0/3] bug fixing in send message recovery
Date: Mon, 26 Mar 2012 18:12:36 +0200
Message-ID: <1332778359-5756-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6138590495209284643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series concerns mmsd for ofono mailing list.

Patch 1 to 3 fix some leaks when a problem arises when a send request is
created.


S=C3=A9bastien Bianti (3):
  service: factorize error code
  service: NULL uuid here is an error
  service: remove orphan file

 src/service.c |   66 ++++++++++++++++++++++-------------------------------=
---
 1 files changed, 26 insertions(+), 40 deletions(-)

-- =

1.7.4.4


--===============6138590495209284643==--

