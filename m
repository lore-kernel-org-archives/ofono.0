Content-Type: multipart/mixed; boundary="===============3776736294862434945=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 20/24] stk: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-21-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-20-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3776736294862434945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/stk.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 01c95b5..16c7152 100644
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
@@ -3131,6 +3130,11 @@ void ofono_stk_driver_unregister(const struct ofono_=
stk_driver *d)
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

+static void free_envelope_item(gpointer pointer, gpointer user_data)
+{
+	g_free(pointer);
+}
+
 static void stk_unregister(struct ofono_atom *atom)
 {
 	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
@@ -3163,7 +3167,7 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk->main_menu =3D NULL;
 	}
 =

-	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
+	g_queue_foreach(stk->envelope_q, free_envelope_item, NULL);
 	g_queue_free(stk->envelope_q);
 =

 	ofono_modem_remove_interface(modem, OFONO_STK_INTERFACE);
-- =

1.9.1

--===============3776736294862434945==--

