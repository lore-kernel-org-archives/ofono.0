Content-Type: multipart/mixed; boundary="===============6758284159029590064=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] voicecall: Limit tone string length per request.
Date: Mon, 25 Oct 2010 07:51:25 +0200
Message-ID: <1287985887-15181-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6758284159029590064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also change to avoid memcpying into a buffer.
---
 src/voicecall.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 26cfb9a..bd64432 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2472,7 +2472,7 @@ static gboolean tone_request_run(gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct tone_queue_entry *entry =3D g_queue_peek_head(vc->toneq);
-	char buf[256];
+	char final;
 	unsigned len;
 =

 	vc->tone_source =3D 0;
@@ -2483,14 +2483,17 @@ static gboolean tone_request_run(gpointer user_data)
 	len =3D strcspn(entry->left, "pP");
 =

 	if (len) {
-		if (len >=3D sizeof(buf))
-			len =3D sizeof(buf) - 1;
+		if (len > 8) /* Arbitrary length limit per request */
+			len =3D 8;
 =

-		memcpy(buf, entry->left, len);
-		buf[len] =3D '\0';
-		entry->left +=3D len;
+		/* Temporarily move the end of the string */
+		final =3D entry->left[len];
+		entry->left[len] =3D '\0';
+
+		vc->driver->send_tones(vc, entry->left, tone_request_cb, vc);
 =

-		vc->driver->send_tones(vc, buf, tone_request_cb, vc);
+		entry->left +=3D len;
+		entry->left[0] =3D final;
 	} else
 		tone_request_cb(NULL, vc);
 =

-- =

1.7.1.86.g0e460.dirty


--===============6758284159029590064==--

