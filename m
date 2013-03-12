Content-Type: multipart/mixed; boundary="===============8791226304342588399=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 07/20] handsfree-audio: Add HFP 1.6 connect hook
Date: Tue, 12 Mar 2013 11:21:31 -0300
Message-ID: <1363098104-16467-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8791226304342588399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch treats -EINPROGRESS as success return value for HFP 1.6
Audio Connection setup. For HFP 1.6, HF sends AT+BCC and waits the AG
to establish the SCO connection.
---
 src/handsfree-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c9fed48..cb97c57 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -290,7 +290,15 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

+	/*
+	 * HFP 1.6 card driver returns in progress to inform that AT+BCC has
+	 * been sent. This command informs the AG that the audio connection
+	 * should be established.
+	 */
 	sk =3D driver->audio_connect(card->remote, card->local, card->data);
+	if (sk =3D=3D -EINPROGRESS)
+		goto done;
+
 	if (sk < 0)
 		return __ofono_error_failed(msg);
 =

@@ -301,6 +309,7 @@ static DBusMessage *card_connect(DBusConnection *conn,
 =

 	g_io_channel_unref(io);
 =

+done:
 	card->msg =3D dbus_message_ref(msg);
 =

 	return NULL;
-- =

1.7.11.7


--===============8791226304342588399==--

