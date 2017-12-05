Content-Type: multipart/mixed; boundary="===============0223222486549124247=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/4] network: allow drivers to generate more specific error
 codes
Date: Tue, 05 Dec 2017 19:20:14 +0100
Message-ID: <20171205182017.462-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0223222486549124247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For certain modems it's not clear if they support all actions or not.
In such cases use CME errors which allows generate NotSupported
messages.
---
 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 6e69b078495f..ae3175d4a7e9 100644
--- a/src/network.c
+++ b/src/network.c
@@ -222,7 +222,7 @@ static void register_callback(const struct ofono_error =
*error, void *data)
 	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D dbus_message_new_method_return(netreg->pending);
 	else
-		reply =3D __ofono_error_failed(netreg->pending);
+		reply =3D __ofono_error_from_error(error, netreg->pending);
 =

 	__ofono_dbus_pending_reply(&netreg->pending, reply);
 =

-- =

2.15.1


--===============0223222486549124247==--

