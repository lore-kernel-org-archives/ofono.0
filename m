Content-Type: multipart/mixed; boundary="===============7060763927826329691=="
MIME-Version: 1.0
From: Hannu Lyytinen <hannu.lyytinen@nomovok.com>
Subject: [PATCH 1/2] Fixes segfault when removing Nokia Datacard.
Date: Sat, 06 Nov 2010 21:48:47 +0200
Message-ID: <1289072928-11812-1-git-send-email-hannu.lyytinen@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7060763927826329691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/nokia.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/nokia.c b/plugins/nokia.c
index f65617b..bb8e2f3 100644
--- a/plugins/nokia.c
+++ b/plugins/nokia.c
@@ -130,7 +130,8 @@ static void nokia_disconnect(gpointer user_data)
 =

 	DBG("");
 =

-	ofono_gprs_context_remove(data->gc);
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
-- =

1.7.0.4


--===============7060763927826329691==--

