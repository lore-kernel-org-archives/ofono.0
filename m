Content-Type: multipart/mixed; boundary="===============7953680578830307603=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 08/20] handsfree-audio: Add "Connect" reply for HFP 1.6
Date: Tue, 12 Mar 2013 11:21:32 -0300
Message-ID: <1363098104-16467-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7953680578830307603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For HFP 1.6, the HF sends AT+BCC to inform the AG that a SCO connection
needs to be established, and the AG initiates the connection. For this
case, the "Connect" method reply needs to be sent when the link is
established.
---
 src/handsfree-audio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index cb97c57..3a7dcee 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -156,6 +156,13 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 		return TRUE;
 	}
 =

+	if (card->msg) {
+		DBusMessage *reply =3D dbus_message_new_method_return(card->msg);
+		g_dbus_send_message(ofono_dbus_get_connection(), reply);
+		dbus_message_unref(card->msg);
+		card->msg =3D NULL;
+	}
+
 	send_new_connection(card->path, nsk);
 	close(nsk);
 =

-- =

1.7.11.7


--===============7953680578830307603==--

