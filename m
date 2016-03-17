Content-Type: multipart/mixed; boundary="===============0931429492228473519=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 5/9] gprs: pri_set_apn: make reply msg optional
Date: Thu, 17 Mar 2016 18:02:16 +0100
Message-ID: <1458234140-7936-6-git-send-email-dragos@endocode.com>
In-Reply-To: <1458234140-7936-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0931429492228473519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Automatic context activation will set the apn by itself. No
dbus message to reply to.
---
 src/gprs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 233ab1a..664c377 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -957,7 +957,8 @@ static DBusMessage *pri_set_apn(struct pri_context *ctx=
, DBusConnection *conn,
 		storage_sync(ctx->gprs->imsi, SETTINGS_STORE, settings);
 	}
 =

-	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+	if (msg)
+		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
 =

 	ofono_dbus_signal_property_changed(conn, ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
-- =

2.5.0


--===============0931429492228473519==--

