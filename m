Content-Type: multipart/mixed; boundary="===============3598333852909533778=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] Remove initialisers for enum ofono_atom_type.
Date: Wed, 19 Jan 2011 09:07:53 +0100
Message-ID: <1295424478-12049-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3598333852909533778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

They have no effect, enum already ensures the values are unique.
---
 src/ofono.h |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 77567c2..badc2ee 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -103,30 +103,30 @@ void __ofono_modem_append_properties(struct ofono_mod=
em *modem,
 struct ofono_atom;
 =

 enum ofono_atom_type {
-	OFONO_ATOM_TYPE_DEVINFO =3D 0,
-	OFONO_ATOM_TYPE_CALL_BARRING =3D 1,
-	OFONO_ATOM_TYPE_CALL_FORWARDING =3D 2,
-	OFONO_ATOM_TYPE_CALL_METER =3D 3,
-	OFONO_ATOM_TYPE_CALL_SETTINGS =3D 4,
-	OFONO_ATOM_TYPE_NETREG =3D 5,
-	OFONO_ATOM_TYPE_PHONEBOOK =3D 6,
-	OFONO_ATOM_TYPE_SMS =3D 7,
-	OFONO_ATOM_TYPE_SIM =3D 8,
-	OFONO_ATOM_TYPE_USSD =3D 9,
-	OFONO_ATOM_TYPE_VOICECALL =3D 10,
-	OFONO_ATOM_TYPE_HISTORY =3D 11,
-	OFONO_ATOM_TYPE_SSN =3D 12,
-	OFONO_ATOM_TYPE_MESSAGE_WAITING =3D 13,
-	OFONO_ATOM_TYPE_CBS =3D 14,
-	OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
-	OFONO_ATOM_TYPE_GPRS =3D 16,
-	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
-	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
-	OFONO_ATOM_TYPE_AUDIO_SETTINGS =3D 19,
-	OFONO_ATOM_TYPE_STK =3D 20,
-	OFONO_ATOM_TYPE_NETTIME =3D 21,
-	OFONO_ATOM_TYPE_CTM =3D 22,
-	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_DEVINFO,
+	OFONO_ATOM_TYPE_CALL_BARRING,
+	OFONO_ATOM_TYPE_CALL_FORWARDING,
+	OFONO_ATOM_TYPE_CALL_METER,
+	OFONO_ATOM_TYPE_CALL_SETTINGS,
+	OFONO_ATOM_TYPE_NETREG,
+	OFONO_ATOM_TYPE_PHONEBOOK,
+	OFONO_ATOM_TYPE_SMS,
+	OFONO_ATOM_TYPE_SIM,
+	OFONO_ATOM_TYPE_USSD,
+	OFONO_ATOM_TYPE_VOICECALL,
+	OFONO_ATOM_TYPE_HISTORY,
+	OFONO_ATOM_TYPE_SSN,
+	OFONO_ATOM_TYPE_MESSAGE_WAITING,
+	OFONO_ATOM_TYPE_CBS,
+	OFONO_ATOM_TYPES_CALL_VOLUME,
+	OFONO_ATOM_TYPE_GPRS,
+	OFONO_ATOM_TYPE_GPRS_CONTEXT,
+	OFONO_ATOM_TYPE_RADIO_SETTINGS,
+	OFONO_ATOM_TYPE_AUDIO_SETTINGS,
+	OFONO_ATOM_TYPE_STK,
+	OFONO_ATOM_TYPE_NETTIME,
+	OFONO_ATOM_TYPE_CTM,
+	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.1.86.g0e460.dirty


--===============3598333852909533778==--

