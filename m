Content-Type: multipart/mixed; boundary="===============1278215765370873358=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 1/6] Use ofono_bool_t instead of bool in modem API.
Date: Thu, 27 May 2010 19:12:43 +0300
Message-ID: <1274976768-1555-1-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <201005270748.21704.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1278215765370873358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/modem.h |    6 ++----
 src/modem.c     |   10 +++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index f192166..21709d7 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -26,8 +26,6 @@
 extern "C" {
 #endif
 =

-#include <stdbool.h>
-
 #include <ofono/types.h>
 =

 struct ofono_modem;
@@ -63,8 +61,8 @@ int ofono_modem_set_integer(struct ofono_modem *modem,
 int ofono_modem_get_integer(struct ofono_modem *modem, const char *key);
 =

 int ofono_modem_set_boolean(struct ofono_modem *modem,
-				const char *key, bool value);
-bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key);
+				const char *key, gboolean value);
+gboolean ofono_modem_get_boolean(struct ofono_modem *modem, const char *ke=
y);
 =

 typedef void (*ofono_modem_online_cb)(const struct ofono_error *error,
 					void *data);
diff --git a/src/modem.c b/src/modem.c
index a99d792..ce262cb 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1092,7 +1092,7 @@ static int set_modem_property(struct ofono_modem *mod=
em, const char *name,
 		property->value =3D g_memdup(value, sizeof(int));
 		break;
 	case PROPERTY_TYPE_BOOLEAN:
-		property->value =3D g_memdup(value, sizeof(bool));
+		property->value =3D g_memdup(value, sizeof(ofono_bool_t));
 		break;
 	default:
 		break;
@@ -1127,7 +1127,7 @@ static gboolean get_modem_property(struct ofono_modem=
 *modem, const char *name,
 		memcpy(value, property->value, sizeof(int));
 		return TRUE;
 	case PROPERTY_TYPE_BOOLEAN:
-		memcpy(value, property->value, sizeof(bool));
+		memcpy(value, property->value, sizeof(ofono_bool_t));
 		return TRUE;
 	default:
 		return FALSE;
@@ -1147,7 +1147,7 @@ int ofono_modem_set_integer(struct ofono_modem *modem,
 }
 =

 int ofono_modem_set_boolean(struct ofono_modem *modem,
-				const char *key, bool value)
+				const char *key, ofono_bool_t value)
 {
 	return set_modem_property(modem, key, PROPERTY_TYPE_BOOLEAN, &value);
 }
@@ -1174,9 +1174,9 @@ int ofono_modem_get_integer(struct ofono_modem *modem=
, const char *key)
 	return value;
 }
 =

-bool ofono_modem_get_boolean(struct ofono_modem *modem, const char *key)
+ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem, const char=
 *key)
 {
-	bool value;
+	ofono_bool_t value;
 =

 	if (get_modem_property(modem, key,
 				PROPERTY_TYPE_BOOLEAN, &value) =3D=3D FALSE)
-- =

1.6.3.3


--===============1278215765370873358==--

