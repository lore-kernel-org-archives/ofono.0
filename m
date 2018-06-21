Content-Type: multipart/mixed; boundary="===============3939722501888686876=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 08/12] cdma-voicecall: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:57 +0300
Message-ID: <1529601661-4856-8-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3939722501888686876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
index fd38dd8..90cad10 100644
--- a/src/cdma-voicecall.c
+++ b/src/cdma-voicecall.c
@@ -251,7 +251,7 @@ static void manager_dial_callback(const struct ofono_er=
ror *error, void *data)
 	}
 =

 	voicecall_set_call_lineid(vc);
-	vc->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+	vc->direction =3D OFONO_CALL_DIRECTION_MOBILE_ORIGINATED;
 	voicecall_set_call_status(vc, CDMA_CALL_STATUS_DIALING);
 =

 	reply =3D dbus_message_new_method_return(vc->pending);
-- =

1.9.1


--===============3939722501888686876==--

