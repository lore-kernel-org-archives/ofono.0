Content-Type: multipart/mixed; boundary="===============4084895967080216115=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/3] voicecall: add long dial string support
Date: Mon, 22 Nov 2010 18:36:30 +0200
Message-ID: <90acf5b7486357d2fcf47c47eee5de3431634e08.1290436058.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1290436058.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4084895967080216115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index bd64432..4022f36 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -408,7 +408,7 @@ static DBusMessage *voicecall_deflect(DBusConnection *c=
onn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!valid_phone_number_format(number))
+	if (!valid_dial_string(number))
 		return __ofono_error_invalid_format(msg);
 =

 	vc->pending =3D dbus_message_ref(msg);
@@ -1172,7 +1172,7 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	if (!valid_phone_number_format(number))
+	if (!valid_dial_string(number))
 		return __ofono_error_invalid_format(msg);
 =

 	if (clir_string_to_clir(clirstr, &clir) =3D=3D FALSE)
@@ -2360,7 +2360,7 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 {
 	struct dial_request *req;
 =

-	if (!valid_phone_number_format(addr))
+	if (!valid_dial_string(addr))
 		return -EINVAL;
 =

 	if (!vc->driver->dial)
-- =

1.7.0.4


--===============4084895967080216115==--

