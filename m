Content-Type: multipart/mixed; boundary="===============5879695653223127599=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 05/10] handsfree-audio: Check local SCO address
Date: Thu, 28 Feb 2013 15:52:47 -0300
Message-ID: <1362077572-28049-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5879695653223127599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch verifies if the local Bluetooth address of the incoming
connection also matches with one of available audio cards.
---
 src/handsfree-audio.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index a861c8f..054c454 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -70,14 +70,6 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static uint16_t local_hfp_version =3D HFP_VERSION_1_6;
 =

-static int card_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct ofono_handsfree_card *card =3D a;
-	const char *remote =3D b;
-
-	return g_strcmp0(card->remote, remote);
-}
-
 static void send_new_connection(const char *card, int fd)
 {
 	DBusMessage *msg;
@@ -97,15 +89,30 @@ static void send_new_connection(const char *card, int f=
d)
 	g_dbus_send_message(ofono_dbus_get_connection(), msg);
 }
 =

+static struct ofono_handsfree_card *card_find(const char *remote,
+							const char *local)
+{
+	GSList *list;
+
+	for (list =3D card_list; list; list =3D g_slist_next(list)) {
+		struct ofono_handsfree_card *card =3D list->data;
+
+		if (g_str_equal(card->remote, remote) &&
+				g_str_equal(card->local, local))
+			return card;
+	}
+
+	return NULL;
+}
+
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct ofono_handsfree_card *card;
 	struct sockaddr_sco saddr;
-	GSList *list;
 	socklen_t alen;
 	int sk, nsk;
-	char remote[18];
+	char local[18], remote[18];
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		return FALSE;
@@ -121,14 +128,25 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
on cond,
 =

 	bt_ba2str(&saddr.sco_bdaddr, remote);
 =

-	list =3D g_slist_find_custom(card_list, remote, card_cmp);
-	if (list =3D=3D NULL) {
+	memset(&saddr, 0, sizeof(saddr));
+	alen =3D sizeof(saddr);
+
+	if (getsockname(nsk, (struct sockaddr *) &saddr, &alen) < 0) {
+		ofono_error("SCO getsockname(): %s (%d)",
+						strerror(errno), errno);
+		close(nsk);
+		return TRUE;
+	}
+
+	bt_ba2str(&saddr.sco_bdaddr, local);
+
+	card =3D card_find(remote, local);
+	if (card =3D=3D NULL) {
 		ofono_error("Rejecting SCO: Audio Card not found!");
 		close(nsk);
 		return TRUE;
 	}
 =

-	card =3D list->data;
 	send_new_connection(card->path, nsk);
 	close(nsk);
 =

-- =

1.7.11.7


--===============5879695653223127599==--

