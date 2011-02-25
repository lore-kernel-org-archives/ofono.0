Content-Type: multipart/mixed; boundary="===============8882343802613444356=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/4] doc: Update the cell broadcast properties
Date: Fri, 25 Feb 2011 08:32:22 -0800
Message-ID: <1298651543-9752-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1298651543-9752-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8882343802613444356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cell-broadcast-api.txt |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/doc/cell-broadcast-api.txt b/doc/cell-broadcast-api.txt
index 52618eb..5f6b4d6 100644
--- a/doc/cell-broadcast-api.txt
+++ b/doc/cell-broadcast-api.txt
@@ -36,19 +36,14 @@ Signals		PropertyChanged(string name, variant value)
 			Please note that base station name broadcasts are
 			handled by the NetworkRegistration interface.
 =

-		EmergencyBroadcast(string text, dict properties)
+		WarningSystemBroadcast(string text, dict properties)
 =

-			This signal is emitted whenever an ETWS cell broadcast
-			is received.  The string text contains contents of the
-			broadcast.  The dict is made up of the following
-			entries:
-				EmergencyType - string value, possible values
-						include: "Earthquake",
-							"Tsunami",
-							"Earthquake+Tsunami",
-							"Other"
+			This signal is emitted whenever an ETWS or CMAS or
+			EU-Alert cell broadcast is received. The string text
+			contains contents of the broadcast. The dict is made
+			up of the following entries:
 				EmergencyAlert - boolean value hinting whether
-						an extra emergency indicator
+						an emergency indicator
 						should be activated (e.g.
 						vibrate mode, emergency alert
 						mode.)
-- =

1.7.0.4


--===============8882343802613444356==--

