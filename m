Content-Type: multipart/mixed; boundary="===============4791312671961108857=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/2] common: add long dial string support
Date: Tue, 16 Nov 2010 19:39:47 +0200
Message-ID: <3db2789cb182bbe968fbd05e3e1fc9b482f8d85c.1289928966.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289928966.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4791312671961108857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    2 +-
 src/common.c    |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/types.h b/include/types.h
index ba2481f..b3d2247 100644
--- a/include/types.h
+++ b/include/types.h
@@ -76,7 +76,7 @@ struct ofono_error {
 	int error;
 };
 =

-#define OFONO_MAX_PHONE_NUMBER_LENGTH 20
+#define OFONO_MAX_PHONE_NUMBER_LENGTH 120
 =

 struct ofono_phone_number {
 	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
diff --git a/src/common.c b/src/common.c
index b5b9a6f..de5a508 100644
--- a/src/common.c
+++ b/src/common.c
@@ -253,7 +253,7 @@ gboolean valid_phone_number_format(const char *number)
 		if (number[i] >=3D '0' && number[i] <=3D '9')
 			continue;
 =

-		if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
+		if (number[i] =3D=3D '*' || number[i] =3D=3D '#' || number[i] =3D=3D 'p')
 			continue;
 =

 		return FALSE;
@@ -379,18 +379,18 @@ int mmi_service_code_to_bearer_class(int code)
 =

 const char *phone_number_to_string(const struct ofono_phone_number *ph)
 {
-	static char buffer[64];
+	static char buffer[(OFONO_MAX_PHONE_NUMBER_LENGTH + 1) + 1];
 =

 	if (ph->type =3D=3D 145 && (strlen(ph->number) > 0) &&
 			ph->number[0] !=3D '+') {
 		buffer[0] =3D '+';
-		strncpy(buffer + 1, ph->number, 62);
-		buffer[63] =3D '\0';
+		strncpy(buffer + 1, ph->number, sizeof(buffer) - 2);
 	} else {
-		strncpy(buffer, ph->number, 63);
-		buffer[63] =3D '\0';
+		strncpy(buffer, ph->number, sizeof(buffer) - 1);
 	}
 =

+	buffer[sizeof(buffer) - 1] =3D '\0';
+
 	return buffer;
 }
 =

-- =

1.7.0.4


--===============4791312671961108857==--

