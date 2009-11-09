Content-Type: multipart/mixed; boundary="===============1089923945151491812=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/4] add interface property to primary context
Date: Mon, 09 Nov 2009 15:37:58 +0800
Message-ID: <1257752281-22251-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1089923945151491812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |    1 +
 src/gprs.c             |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index c4ebd23..adb0820 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -37,6 +37,7 @@ struct ofono_gprs_context;
 struct ofono_gprs_primary_context {
 	unsigned int cid;
 	int direction;
+	char *interface;
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
diff --git a/src/gprs.c b/src/gprs.c
index 0253109..18ae82a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -185,6 +185,10 @@ static DBusMessage *pri_get_properties(DBusConnection =
*conn,
 	ofono_dbus_dict_append(&dict, "Password", DBUS_TYPE_STRING,
 				&strvalue);
 =

+	strvalue =3D ctx->context.interface;
+	ofono_dbus_dict_append(&dict, "Interface", DBUS_TYPE_STRING,
+				&strvalue);
+ =

 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
-- =

1.6.1.3


--===============1089923945151491812==--

