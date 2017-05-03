Content-Type: multipart/mixed; boundary="===============2542084913488024016=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v4 5/5] handsfree-audio: Add Acquire implementation
Date: Wed, 03 May 2017 16:10:55 +0300
Message-ID: <20170503131055.9652-5-luiz.dentz@gmail.com>
In-Reply-To: <20170503131055.9652-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2542084913488024016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Acquire method which can be used by agents that require
pulling the fd directly instead of waiting a NewConnection.
---
 src/handsfree-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index dab16da..f2c323d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -326,6 +326,12 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCond=
ition cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

+	if (card->msg && dbus_message_has_member(card->msg, "Acquire")) {
+		reply =3D g_dbus_create_reply(card->msg, DBUS_TYPE_UNIX_FD, &sk,
+					DBUS_TYPE_BYTE, &card->selected_codec);
+		goto done;
+	}
+
 	send_new_connection(card->path, sk, card->selected_codec);
 =

 	close(sk);
@@ -403,6 +409,9 @@ static const GDBusMethodTable card_methods[] =3D {
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			card_get_properties) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, card_connect) },
+	{ GDBUS_ASYNC_METHOD("Acquire", NULL,
+			GDBUS_ARGS({"sco", "h"}, {"codec", "y"}),
+			card_connect) },
 	{ }
 };
 =

-- =

2.9.3


--===============2542084913488024016==--

