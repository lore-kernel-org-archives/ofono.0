Content-Type: multipart/mixed; boundary="===============7760304874517815630=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 7/8] handsfree-audio: Add registered cards tracking
Date: Mon, 25 Feb 2013 11:34:20 -0300
Message-ID: <1361802861-18267-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7760304874517815630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch creates a modem list of the registed Handsfree Audio
Cards required to fill the array of cards in the GetCards method.
---
 src/handsfree-audio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 674a289..9db2a83 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -51,6 +51,7 @@ struct agent {
 	guint watch;
 };
 =

+static GSList *cards =3D NULL;
 static struct agent *agent =3D NULL;
 static unsigned int modemwatch_id;
 static int ref_count =3D 0;
@@ -266,9 +267,10 @@ static void am_emit_card_removed(const char *path, str=
uct ofono_modem *modem)
 =

 static void am_card_add(const char *path, struct ofono_modem *modem)
 {
-	g_dbus_register_interface(ofono_dbus_get_connection(), path,
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(), path,
 					HFP_AUDIO_CARD_INTERFACE, card_methods,
-					NULL, NULL, modem, NULL);
+					NULL, NULL, modem, NULL))
+		return;
 =

 	am_emit_card_added(path, modem);
 =

@@ -291,10 +293,13 @@ static void handsfree_modem_watch(struct ofono_atom *=
atom,
 	struct ofono_modem *modem =3D user_data;
 	const char *path =3D __ofono_atom_get_path(atom);
 =

-	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
 		am_card_add(path, modem);
-	else
+		cards =3D g_slist_append(cards, atom);
+	} else {
 		am_card_remove(path, modem);
+		cards =3D g_slist_remove(cards, atom);
+	}
 }
 =

 static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
-- =

1.7.11.7


--===============7760304874517815630==--

