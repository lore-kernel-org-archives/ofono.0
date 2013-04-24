Content-Type: multipart/mixed; boundary="===============6844313860528936380=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 6/6] hfp_ag_bluez5: Send fd to card creation
Date: Wed, 24 Apr 2013 14:13:51 -0300
Message-ID: <1366823631-26262-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366823631-26262-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6844313860528936380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag_bluez5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index e971a22..b3017a9 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -123,7 +123,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 =

 	ofono_emulator_register(em, fd);
 =

-	if (ofono_emulator_create_card(em, 0, 0) < 0) {
+	if (ofono_emulator_create_card(em, fd, 0) < 0) {
 		close(fd);
 		ofono_emulator_remove(em);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-- =

1.7.9.5


--===============6844313860528936380==--

