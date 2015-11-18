Content-Type: multipart/mixed; boundary="===============7164676391794795927=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH] plugins: rm unecessary sleep from ril plugin
Date: Tue, 17 Nov 2015 20:48:00 -0500
Message-ID: <1447811280-12070-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7164676391794795927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/ril.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/ril.c b/plugins/ril.c
index 8ccf01a..7820be4 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -145,7 +145,6 @@ static void ril_radio_state_changed(struct ril_msg *mes=
sage, gpointer user_data)
 			if (rd->ofono_online) {
 				ofono_error("%s: radio self-powered off!",
 						__func__);
-				sleep(5);
 				exit(1);
 			}
 			break;
-- =

2.1.4


--===============7164676391794795927==--

