Content-Type: multipart/mixed; boundary="===============3332182033030225998=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/13] doc: Add STK properties relevant for icons.
Date: Wed, 13 Oct 2010 15:54:08 +0200
Message-ID: <1286978056-16600-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3332182033030225998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index e4993c1..c29872a 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -61,17 +61,27 @@ Properties	string IdleModeText
 			idle.  This text is set by the SIM and can change
 			at any time.
 =

+		byte IdleModeIcon
+
+			Contains the identifier of the icon accompanying
+			the idle mode text.
+
 		array{struct{string, byte}} MainMenu
 =

 			Contains the items that make up the main menu.  This
 			is populated by the SIM when it sends the Setup Menu
 			Proactive Command.  The main menu is always available,
-			but its contents can be changed at any time.
+			but its contents can be changed at any time.  Each
+			item contains the item label and icon identifier.
 =

 		string MainMenuTitle
 =

 			Contains the title of the main menu.
 =

+		string MainMenuIcon
+
+			Contains the identifier of the icon for the main menu.
+
 		array{byte} Icons
 =

 			Contains the identifiers of all available icons for
-- =

1.7.1.86.g0e460.dirty


--===============3332182033030225998==--

