Content-Type: multipart/mixed; boundary="===============9137723558338893849=="
MIME-Version: 1.0
From: Chris Talbot <chris@talbothome.com>
Subject: [PATCH 2/9] Ensure Compatibility with Telus Canada
Date: Sat, 10 Apr 2021 10:20:19 -0400
Message-ID: <df512b811ee2df6b8f55dd2a9fb0178e6e5c490f.camel@talbothome.com>
In-Reply-To: <b23ba0656ea0d58fdbd8c83072e017f63629f934.camel@talbothome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9137723558338893849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telus Canada makes mmsd decode a header that is not in the standard.
This patch allows this header to be decoded and allows for MMS support
in Telus Canada.
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
+				DBG("type isn't a part of the
standard? Skipping %u", h);
+				continue;
+			}
 		}
 =

 		DBG("saw header of type %u", h);
-- =

2.30.2

--===============9137723558338893849==--

