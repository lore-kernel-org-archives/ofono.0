Content-Type: multipart/mixed; boundary="===============6893542185696827971=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 12/13] handsfree-audio: Return an error on Card Connect
Date: Fri, 08 Mar 2013 20:11:24 -0300
Message-ID: <1362784285-22731-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6893542185696827971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Returns NotAvailable error if "Connect" method of the Handsfree Audio
Card gets called and there isn't an agent registered.
---
 src/handsfree-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 6fa8b67..8950347 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -282,6 +282,9 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (driver =3D=3D NULL)
 		return __ofono_error_not_implemented(msg);
 =

+	if (agent =3D=3D NULL)
+		return __ofono_error_not_available(msg);
+
 	sk =3D driver->audio_connect(card->remote, card->local);
 	if (sk < 0)
 		return __ofono_error_failed(msg);
-- =

1.7.11.7


--===============6893542185696827971==--

