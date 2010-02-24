Content-Type: multipart/mixed; boundary="===============3431063709810495170=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] doc: Add 'Name' property under 'Modem' interface.
Date: Wed, 24 Feb 2010 16:14:26 -0300
Message-ID: <1267038867-28929-2-git-send-email-jprvita@profusion.mobi>
In-Reply-To: <1267038867-28929-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3431063709810495170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 06a4ada..7cccd57 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -32,6 +32,10 @@ Properties	boolean Powered [readwrite]
 			Boolean representing the power state of the modem
 			device.
 =

+		string Name [readonly, optional]
+
+			Friendly name of the modem device.
+
 		string Manufacturer [readonly, optional]
 =

 			String representing the manufacturer of the modem
-- =

1.6.3.3


--===============3431063709810495170==--

