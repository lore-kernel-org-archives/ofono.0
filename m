Content-Type: multipart/mixed; boundary="===============8783934519295192273=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH] simauth: Fixed incorrect AUTS length
Date: Fri, 20 Oct 2017 10:40:52 -0700
Message-ID: <1508521252-2690-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8783934519295192273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial SimAuth implementation incorrectly parsed
the AUTS value as 16 bytes, not 14.
---
 src/sim-auth.c | 2 +-
 src/simutil.c  | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/sim-auth.c b/src/sim-auth.c
index 9ae5574..c0b2422 100644
--- a/src/sim-auth.c
+++ b/src/sim-auth.c
@@ -272,7 +272,7 @@ static void handle_umts(struct ofono_sim_auth *sim, con=
st uint8_t *resp,
 			"{say}", &dict);
 =

 	if (auts) {
-		append_dict_byte_array(&dict, "AUTS", auts, 16);
+		append_dict_byte_array(&dict, "AUTS", auts, 14);
 	} else {
 		append_dict_byte_array(&dict, "RES", res, 8);
 		append_dict_byte_array(&dict, "CK", ck, 16);
diff --git a/src/simutil.c b/src/simutil.c
index 8fbde15..2f49500 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -1657,7 +1657,7 @@ gboolean sim_parse_umts_authenticate(const unsigned c=
har *buffer,
 		const unsigned char **ik, const unsigned char **auts,
 		const unsigned char **kc)
 {
-	if (len < 18 || !buffer)
+	if (len < 16 || !buffer)
 		return FALSE;
 =

 	switch (buffer[0]) {
@@ -1695,16 +1695,17 @@ gboolean sim_parse_umts_authenticate(const unsigned=
 char *buffer,
 =

 		break;
 	case 0xdc:
-		/* 'DB' + '10' + AUTS(16) =3D 18 */
-		if (len < 18)
+		/* 'DC' + '0E' + AUTS(14) =3D 16 */
+		if (len < 16)
 			goto umts_end;
 =

 		/* sync error */
-		if (buffer[1] !=3D 0x10)
+		if (buffer[1] !=3D 0x0e)
 			goto umts_end;
 =

 		*auts =3D buffer + 2;
 =

+
 		break;
 	default:
 		goto umts_end;
-- =

2.7.4


--===============8783934519295192273==--

