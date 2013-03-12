Content-Type: multipart/mixed; boundary="===============0392591037734552670=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 15/20] handsfree-audio: Send the selected codec
Date: Tue, 12 Mar 2013 11:21:39 -0300
Message-ID: <1363098104-16467-16-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0392591037734552670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes the hard-coded CVSD codec, and adds the selected
codec in the NewConnection method call, notifying the agent the codec
previously selected for the audio connection.
---
 src/handsfree-audio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 1b0a04d..0d31712 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -74,11 +74,10 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *g_drivers =3D NULL;
 =

-static void send_new_connection(const char *card, int fd)
+static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
 	DBusMessageIter iter;
-	uint8_t codec =3D HFP_CODEC_CVSD;
 =

 	msg =3D dbus_message_new_method_call(agent->owner, agent->path,
 				HFP_AUDIO_AGENT_INTERFACE, "NewConnection");
@@ -164,7 +163,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 		card->msg =3D NULL;
 	}
 =

-	send_new_connection(card->path, nsk);
+	send_new_connection(card->path, nsk, card->selected_codec);
 	close(nsk);
 =

 	return TRUE;
@@ -261,7 +260,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 	sk =3D g_io_channel_unix_get_fd(io);
 =

 	if (agent)
-		send_new_connection(card->path, sk);
+		send_new_connection(card->path, sk, card->selected_codec);
 =

 	close(sk);
 =

-- =

1.7.11.7


--===============0392591037734552670==--

