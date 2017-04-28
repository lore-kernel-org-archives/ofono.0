Content-Type: multipart/mixed; boundary="===============7706817075191657263=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3 3/3] handsfree-audio: Add Acquire method
Date: Fri, 28 Apr 2017 12:31:08 +0300
Message-ID: <20170428093108.29461-3-luiz.dentz@gmail.com>
In-Reply-To: <20170428093108.29461-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7706817075191657263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Acquire method which can be used by agents that require
pulling the fd directly instead of waiting a NewConnection.

Note: sounds servers like PulseAudio do auto suspend stream when idle
for a certain amount of time and once anything happens it will resume
the stream, though this all happens in the so called IO thread in a
blocking fashion making it impossible to receive the fd via NewConnetion
causing the stream to fail to resume. There are other forms to work
around but this seems to be most convenient as we do want the auto
suspend feature to work properly and letting the stream to fail to
resume may create unexpected artifacts while the NewConnection is
handled in PA main thread.
---
 doc/handsfree-audio-api.txt | 16 ++++++++++++++++
 src/handsfree-audio.c       |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index d82035c..87d51cf 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -76,6 +76,22 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.NotAllowed
 =

+		fd, byte Acquire()
+
+			Attempts to establish the SCO audio connection
+			returning the filedescriptor of the connection and the
+			codec in use.
+
+			Note: Contrary to Connect this does not call
+			NewConnection so it can be called in a blocking
+			manner.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotAvailable
+					 [service].Error.NotImplemented
+					 [service].Error.NotAllowed
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
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


--===============7706817075191657263==--

