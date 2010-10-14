Content-Type: multipart/mixed; boundary="===============0209573893132797917=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 8/8] doc: update sim-api
Date: Fri, 15 Oct 2010 00:02:55 +0300
Message-ID: <1287090175-3018-9-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287090175-3018-8-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0209573893132797917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixed Dialing is not supported. New property added
to indicate FD-enable status in the SIM-card.
---
 doc/sim-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 237e296..adf7c38 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -131,3 +131,13 @@ Properties	boolean Present [readonly]
 =

 			Contains the Intergrated Circuit Card Identifer (ICCID)
 			which is read directly from the SIM.
+
+		boolean FixedDialing [readonly]
+
+			True if a Fixed Dialing is enabled in SIM card.
+
+			Fixed Dialing is not supported, so status of FD is
+			checked during initialization after receiving PIN-code
+			(if PIN is required). If FD is enabled, initialization
+			procedure is halt. Then only emergency calls are
+			allowed.
-- =

1.6.3.3



--===============0209573893132797917==--

