Content-Type: multipart/mixed; boundary="===============3293655770066701032=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 4/7] handsfree-audio: Do not allow cards to be registered if
 no defer_setup
Date: Tue, 10 Sep 2013 21:09:43 -0300
Message-ID: <1378858186-683-4-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3293655770066701032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the kernel doesn't support defer_setup for SCO, we shouldn't allow
cards to be registered, because in that case we won't be able to
properly send the file descriptor to the Agent.
---
 src/handsfree-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 5cfc939..4d2c21f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -816,6 +816,9 @@ int ofono_handsfree_card_driver_register(
 {
 	DBG("driver: %p", d);
 =

+	if (defer_setup =3D=3D 0)
+		return -ENOSYS;
+
 	if (d->probe =3D=3D NULL)
 		return -EINVAL;
 =

-- =

1.8.4


--===============3293655770066701032==--

