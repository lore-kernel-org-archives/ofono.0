Content-Type: multipart/mixed; boundary="===============1262979414946480066=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 12/15] handsfree-audio: Return NotAvailable on "Connect"
Date: Tue, 12 Mar 2013 09:42:10 -0300
Message-ID: <1363092133-1092-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1262979414946480066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Returns "Operation currently not available" if "Connect" method of the
Handsfree Audio Card gets called and there isn't an agent registered.
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


--===============1262979414946480066==--

