Content-Type: multipart/mixed; boundary="===============2014254522058127649=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 03/09] MMSD: Ensure Compatibility with Telus
Date: Fri, 19 Feb 2021 01:00:01 +0000
Message-ID: <20210219010001.2937.62339@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2014254522058127649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telus decodes in such a way to introduce unknown headers in the MMS decode.
This patch enables mmsd to handle these headers.
---
 src/mmsutil.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/mmsutil.c b/src/mmsutil.c
index 5fcf358..ef72f20 100644
--- a/src/mmsutil.c
+++ b/src/mmsutil.c
@@ -732,10 +732,9 @@ static header_handler handler_for_type(enum mms_header=
 header)
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
@@ -781,8 +780,17 @@ static gboolean mms_parse_headers(struct wsp_header_it=
er *iter,
 =

 		handler =3D handler_for_type(h);
 		if (handler =3D=3D NULL) {
-			DBG("no handler for type %u", h);
-			return FALSE;
+		    if(h =3D=3D MMS_HEADER_INVALID) {
+		      DBG("no handler for type %u", h);
+			  return FALSE;
+		    } else if (h =3D=3D __MMS_HEADER_MAX) {
+		      DBG("no handler for type %u", h);
+			  return FALSE;
+		    } else {
+		      /*  Telus has strange headers, so this handles it */
+		      DBG("type isn't a part of the standard? Skipping %u", h);
+		      continue;
+		   }
 		}
 =

 		DBG("saw header of type %u", h);
-- =

2.30.0
--===============2014254522058127649==--

