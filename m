Content-Type: multipart/mixed; boundary="===============4111674075183304367=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [RFC 1/1] doc: Add modem technology type property
Date: Thu, 20 Jan 2011 13:08:44 -0800
Message-ID: <1295557724-10185-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4111674075183304367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/modem-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 45043b0..fe03833 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -82,6 +82,17 @@ Properties	boolean Powered [readwrite]
 =

 			This is usually obtained by using the +CGSN AT command.
 =

+		string TechnologyType [readonly, optional, experimental]
+
+			String representing the technology type of the current
+			modem device.
+
+			The possible values are:
+				"gsm" 	The 3GPP family of technologies
+					including gsm, edge, umts, hspa, lte.
+				"cdma"  The 3GPP2 family of technologies
+					including cdma 1x, evdo.
+
 		array{string} Features [readonly]
 =

 			List of currently enabled features. It uses simple
-- =

1.7.0.4


--===============4111674075183304367==--

