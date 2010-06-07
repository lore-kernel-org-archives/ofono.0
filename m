Content-Type: multipart/mixed; boundary="===============9212132553091947000=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/20] For unitialised stk_location_info emit no data object
Date: Mon, 07 Jun 2010 12:08:38 +0200
Message-ID: <1275905322-14768-16-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9212132553091947000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use a separate function to write empty Location Information data objects.
---
 src/stkutil.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9930d0b..f8e7568 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3584,14 +3584,8 @@ static gboolean build_dataobj_location_info(struct s=
tk_tlv_builder *tlv,
 	unsigned char tag =3D STK_DATA_OBJECT_TYPE_LOCATION_INFO;
 	guint8 mccmnc[3];
 =

-	if (li->mcc[0] =3D=3D 0)
-		/*
-		 * "If no location information is available for an access
-		 * technology, the respective data object shall have
-		 * length zero."
-		 */
-		return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
-			stk_tlv_builder_close_container(tlv);
+	if (li->mcc[0] =3D=3D '\0')
+		return TRUE;
 =

 	sim_encode_mcc_mnc(mccmnc, li->mcc, li->mnc);
 =

@@ -3624,6 +3618,15 @@ static gboolean build_dataobj_location_info(struct s=
tk_tlv_builder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+static gboolean build_empty_dataobj_location_info(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_LOCATION_INFO;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.20
  *
  * See format note in parse_dataobj_imei.
@@ -4177,12 +4180,22 @@ static gboolean build_local_info(struct stk_tlv_bui=
lder *builder,
 					NULL) !=3D TRUE)
 			return FALSE;
 =

-		for (i =3D 0; i < info->location_infos.access_techs.length; i++)
+		for (i =3D 0; i < info->location_infos.access_techs.length; i++) {
+			dataobj_writer location =3D build_dataobj_location_info;
+			/*
+			 * "If no location information is available for an
+			 * access technology, the respective data object
+			 * shall have length zero."
+			 */
+			if (info->location_infos.locations[i].mcc[0] =3D=3D '\0')
+				location =3D build_empty_dataobj_location_info;
+
 			if (build_dataobj(builder,
-					build_dataobj_location_info,
+					location,
 					0, &info->location_infos.locations[i],
 					NULL) !=3D TRUE)
 				return FALSE;
+		}
 =

 		return TRUE;
 =

-- =

1.7.1.86.g0e460.dirty


--===============9212132553091947000==--

