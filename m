Content-Type: multipart/mixed; boundary="===============1644947566656523474=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 0/2] Make test-rilmodem-cs use new server functions
Date: Wed, 18 Nov 2015 19:17:41 -0500
Message-ID: <1447892263-18947-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1644947566656523474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series updates test-rilmodem-cs to use the new
rilmodem-test-server functions.

Tony Espy (2):
  unit: re-factor test-rilmodem-cs server logic
  build: update for test-rilmodem-cs changes

 Makefile.am             |   2 +
 unit/test-rilmodem-cs.c | 377 ++++++++++++++++----------------------------=
----
 2 files changed, 125 insertions(+), 254 deletions(-)

-- =

2.1.4


--===============1644947566656523474==--

