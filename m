Content-Type: multipart/mixed; boundary="===============8247290473476681949=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] modem: only unref pending if it is a powered pending
Date: Fri, 03 Dec 2010 19:40:22 -0200
Message-ID: <1291412422-16976-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291402377-9211-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8247290473476681949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 52e647b..ae427b3 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -804,7 +804,8 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 		modem->timeout =3D 0;
 	}
 =

-	if (modem->pending !=3D NULL) {
+	if (modem->powered_pending !=3D modem->powered &&
+						modem->pending !=3D NULL) {
 		DBusMessage *reply;
 =

 		if (powered =3D=3D modem->powered_pending)
-- =

1.7.3.2


--===============8247290473476681949==--

