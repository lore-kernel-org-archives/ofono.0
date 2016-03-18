Content-Type: multipart/mixed; boundary="===============6436885160881733383=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 4/9] gprs: pri_activate_callback: optional msg reply
Date: Fri, 18 Mar 2016 12:53:12 +0100
Message-ID: <1458301994-5567-7-git-send-email-dragos@endocode.com>
In-Reply-To: <1458301994-5567-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6436885160881733383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For automatic context activation there's no initial message to send a
reply to.
---
 src/gprs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 9192e68..233ab1a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -887,8 +887,10 @@ static void pri_activate_callback(const struct ofono_e=
rror *error, void *data)
 	}
 =

 	ctx->active =3D TRUE;
-	__ofono_dbus_pending_reply(&ctx->pending,
-				dbus_message_new_method_return(ctx->pending));
+
+	if (ctx->pending)
+		__ofono_dbus_pending_reply(&ctx->pending,
+				bus_message_new_method_return(ctx->pending));
 =

 	if (gc->settings->interface !=3D NULL) {
 		pri_ifupdown(gc->settings->interface, TRUE);
-- =

2.5.0


--===============6436885160881733383==--

