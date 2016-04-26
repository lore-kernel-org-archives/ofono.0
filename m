Content-Type: multipart/mixed; boundary="===============0570277203453564405=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2 2/2] stk: clean up undefined function pointer casts
Date: Tue, 26 Apr 2016 06:19:38 +0000
Message-ID: <1461651574-31530-3-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461651574-31530-2-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0570277203453564405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/stk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 01c95b5..373f696 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2315,8 +2315,7 @@ static gboolean handle_command_refresh(const struct s=
tk_command *cmd,
 			break;
 		}
 =

-		g_slist_foreach(file_list, (GFunc) g_free, NULL);
-		g_slist_free(file_list);
+		g_slist_free_full(file_list, g_free);
 =

 		return FALSE;
 	}
@@ -3163,8 +3162,7 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk->main_menu =3D NULL;
 	}
 =

-	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
-	g_queue_free(stk->envelope_q);
+	g_queue_free_full(stk->envelope_q, g_free);
 =

 	ofono_modem_remove_interface(modem, OFONO_STK_INTERFACE);
 	g_dbus_unregister_interface(conn, path, OFONO_STK_INTERFACE);
-- =

1.9.1

--===============0570277203453564405==--

