Content-Type: multipart/mixed; boundary="===============3267461869767816433=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] doc: remove unused GetIcon from SimToolKit
Date: Fri, 11 Feb 2011 09:13:59 -0800
Message-ID: <1297444439-8084-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3267461869767816433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 054821b..529c734 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -10,14 +10,6 @@ Methods		dict GetProperties()
 			Returns properties for the SimToolkit object.  See the
 			properties section for available properties.
 =

-		array{byte} GetIcon(byte id)
-
-			Returns the icon data for icon identified by id.
-
-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.InvalidFormat
-					 [service].Error.NotFound
-
 		void SelectItem(byte item, object agent)
 =

 			Selects an item from the main menu, thus triggering
-- =

1.7.0.4


--===============3267461869767816433==--

