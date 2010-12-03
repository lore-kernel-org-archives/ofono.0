Content-Type: multipart/mixed; boundary="===============7460781055412915938=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 1/5] modem: only unref pending if it is a powered pending
Date: Fri, 03 Dec 2010 16:52:53 -0200
Message-ID: <1291402377-9211-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7460781055412915938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 52e647b..d6ab316 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -804,7 +804,7 @@ void ofono_modem_set_powered(struct ofono_modem *modem,=
 ofono_bool_t powered)
 		modem->timeout =3D 0;
 	}
 =

-	if (modem->pending !=3D NULL) {
+	if (modem->powered_pending !=3D powered && modem->pending !=3D NULL) {
 		DBusMessage *reply;
 =

 		if (powered =3D=3D modem->powered_pending)
-- =

1.7.3.2


--===============7460781055412915938==--

