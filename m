Content-Type: multipart/mixed; boundary="===============2112785777825975052=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 04/10] handsfree-audio: Add NewConnection
Date: Thu, 28 Feb 2013 15:52:46 -0300
Message-ID: <1362077572-28049-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362077572-28049-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2112785777825975052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds Agent NewConnection call. The card object path, the SCO
file descriptor, and the codec are being passed to the agent. This
initial version supports CVSD codec only.
---
 src/handsfree-audio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 6657bc5..a861c8f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -78,10 +78,31 @@ static int card_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(card->remote, remote);
 }
 =

+static void send_new_connection(const char *card, int fd)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	uint8_t codec =3D HFP_CODEC_CVSD;
+
+	msg =3D dbus_message_new_method_call(agent->owner, agent->path,
+				HFP_AUDIO_AGENT_INTERFACE, "NewConnection");
+	if (msg =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &card);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_UNIX_FD, &fd);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &codec);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+}
+
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct ofono_handsfree_card *card;
 	struct sockaddr_sco saddr;
+	GSList *list;
 	socklen_t alen;
 	int sk, nsk;
 	char remote[18];
@@ -100,12 +121,17 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
on cond,
 =

 	bt_ba2str(&saddr.sco_bdaddr, remote);
 =

-	if (g_slist_find_custom(card_list, remote, card_cmp) =3D=3D NULL) {
+	list =3D g_slist_find_custom(card_list, remote, card_cmp);
+	if (list =3D=3D NULL) {
 		ofono_error("Rejecting SCO: Audio Card not found!");
 		close(nsk);
 		return TRUE;
 	}
 =

+	card =3D list->data;
+	send_new_connection(card->path, nsk);
+	close(nsk);
+
 	return TRUE;
 }
 =

-- =

1.7.11.7


--===============2112785777825975052==--

