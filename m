Content-Type: multipart/mixed; boundary="===============5560164882279117035=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 4/6] handsfree-audio: Send the selected codec
Date: Mon, 15 Apr 2013 10:54:51 -0300
Message-ID: <1366034093-24084-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5560164882279117035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch removes the hard-coded CVSD codec, and adds the selected
codec in the NewConnection method call, notifying the agent the codec
previously selected for the audio connection.
---
 src/handsfree-audio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 8e8d460..7f5b33c 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -67,11 +67,10 @@ static guint sco_watch =3D 0;
 static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
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
@@ -150,7 +149,7 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 		return TRUE;
 	}
 =

-	send_new_connection(card->path, nsk);
+	send_new_connection(card->path, nsk, card->selected_codec);
 	close(nsk);
 =

 	return TRUE;
@@ -252,7 +251,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

-	send_new_connection(card->path, sk);
+	send_new_connection(card->path, sk, card->selected_codec);
 =

 	close(sk);
 =

-- =

1.8.2


--===============5560164882279117035==--

