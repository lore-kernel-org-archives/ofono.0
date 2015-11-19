Content-Type: multipart/mixed; boundary="===============1216326405552773071=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH v2] plugins: rm unneeded exits/sleeps from ril plugin
Date: Thu, 19 Nov 2015 17:16:30 -0500
Message-ID: <1447971390-22545-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1216326405552773071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index 8ccf01a..9bf86c5 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -142,13 +142,9 @@ static void ril_radio_state_changed(struct ril_msg *me=
ssage, gpointer user_data)
 			 * too fast re-spawns, then exit with error to make
 			 * upstart re-start ofono.
 			 */
-			if (rd->ofono_online) {
+			if (rd->ofono_online)
 				ofono_error("%s: radio self-powered off!",
 						__func__);
-				sleep(5);
-				exit(1);
-			}
-			break;
 		}
 	}
 }
@@ -398,8 +394,8 @@ static gboolean connect_rild(gpointer user_data)
 		if (create_gril(modem) < 0)
 			return TRUE;
 	} else {
-		ofono_error("Exiting, can't connect to rild.");
-		exit(0);
+		ofono_error("Failed to connect to rild.");
+		return TRUE;
 	}
 =

 	return FALSE;
-- =

2.1.4


--===============1216326405552773071==--

