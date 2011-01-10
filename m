Content-Type: multipart/mixed; boundary="===============9113690127099685337=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] Document voicecall direction
Date: Mon, 10 Jan 2011 17:26:20 +0200
Message-ID: <1294673180-12845-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294673180-12845-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9113690127099685337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 4f38e6a..682b46b 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -92,6 +92,11 @@ Properties	string LineIdentification [readonly]
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


--===============9113690127099685337==--

