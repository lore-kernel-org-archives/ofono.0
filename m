Content-Type: multipart/mixed; boundary="===============6162518890739686527=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] Document voicecall direction
Date: Mon, 24 Jan 2011 13:02:03 +0200
Message-ID: <1295866923-3924-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1295866923-3924-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6162518890739686527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 047b8cb..2feb215 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -102,6 +102,11 @@ Properties	string LineIdentification [readonly]
 			Contains the Name Identification information returned
 			by the network, if present.
 =

+		boolean Originated [readonly]
+
+			Indicates whether the call was mobile-originated
+			(true) or mobile-terminated (false).
+
 		boolean Multiparty [readonly]
 =

 			Contains the indication if the voice call is part
-- =

1.7.1


--===============6162518890739686527==--

