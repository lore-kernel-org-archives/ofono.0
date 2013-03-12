Content-Type: multipart/mixed; boundary="===============5559115239826148038=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 13/15] handsfree-audio: Return InProgress on Connect
Date: Tue, 12 Mar 2013 09:42:11 -0300
Message-ID: <1363092133-1092-14-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5559115239826148038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch returns "Operation already in progress" if there is a
pending Handsfree Audio Card "Connect" method call pending.
---
 src/handsfree-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 8950347..805f3b6 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -285,6 +285,9 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (agent =3D=3D NULL)
 		return __ofono_error_not_available(msg);
 =

+	if (card->msg)
+		return __ofono_error_busy(msg);
+
 	sk =3D driver->audio_connect(card->remote, card->local);
 	if (sk < 0)
 		return __ofono_error_failed(msg);
-- =

1.7.11.7


--===============5559115239826148038==--

