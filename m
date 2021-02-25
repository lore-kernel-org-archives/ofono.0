Content-Type: multipart/mixed; boundary="===============3665183511880451874=="
MIME-Version: 1.0
From: Christopher Talbot <chris@talbothome.com>
Subject: [PATCH 2/9] Ensure Compatibility with Telus Canada
Date: Wed, 24 Feb 2021 19:43:50 -0500
Message-ID: <612b64129ae7385497475897653d566868b73de3.camel@talbothome.com>
In-Reply-To: <20210225003933.2871.63570@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3665183511880451874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


mmsd decodes a header that is not in the standard.
This patch allows this header to be decoded
---
 src/mmsutil.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index 5fcf358..9430bf1 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -732,10 +732,9 @@ static header_handler handler_for_type(enum
mms_header header)
 		return extract_text;
 	case MMS_HEADER_INVALID:
 	case __MMS_HEADER_MAX:
+	default:
 		return NULL;
 	}
-
-	return NULL;
 }
 =

 struct header_handler_entry {
@@ -781,8 +780,17 @@ static gboolean mms_parse_headers(struct
wsp_header_iter *iter,
 =

 		handler =3D handler_for_type(h);
 		if (handler =3D=3D NULL) {
-			DBG("no handler for type %u", h);
-			return FALSE;
+			if(h =3D=3D MMS_HEADER_INVALID) {
+				DBG("no handler for type %u", h);
+				return FALSE;
+			} else if (h =3D=3D __MMS_HEADER_MAX) {
+				DBG("no handler for type %u", h);
+				return FALSE;
+			} else {
+				/*  Telus has strange headers, so this
handles it */
+				DBG("type isn't a part of the standard?
Skipping %u", h);
+				continue;
+			}
 		}
 =

 		DBG("saw header of type %u", h);
-- =

2.30.0

--===============3665183511880451874==--

