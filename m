Content-Type: multipart/mixed; boundary="===============0972396463110330808=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] Remove unneeded code to disable the modem on hfp
Date: Thu, 28 Jan 2010 11:32:42 -0200
Message-ID: <1264685563-13042-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0972396463110330808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ofono_modem_remove() already disables the modem.
---
 plugins/hfp.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 867b194..2d0faa8 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -397,9 +397,6 @@ static DBusMessage *hfp_agent_release(DBusConnection *c=
onn, DBusMessage *msg, vo
 {
 	struct ofono_modem *modem =3D data;
 =

-	if (ofono_modem_get_powered(modem))
-		hfp_disable(modem);
-
 	ofono_modem_remove(modem);
 =

 	return dbus_message_new_method_return(msg);
-- =

1.6.4.4


--===============0972396463110330808==--

