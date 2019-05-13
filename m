Content-Type: multipart/mixed; boundary="===============1486506185868360188=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/3] radio-settings: adding UE dual mode operation property
Date: Mon, 13 May 2019 14:19:15 +0530
Message-ID: <1557737355-25408-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1486506185868360188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added two new values for TechnologyPreference property
as follows:
"umts,gsm"	Dual mode operation with UMTS
		and GSM radio access whith preference
		for UMTS.
"lte,umts"	Dual mode operation with LTE
		and UMTS radio access with preference
		for LTE.
---
 doc/radio-settings-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
index 03868a9..9663b07 100644
--- a/doc/radio-settings-api.txt
+++ b/doc/radio-settings-api.txt
@@ -44,6 +44,12 @@ Properties	string TechnologyPreference [readwrite]
 				"gsm"	Only GSM used for radio access.
 				"umts"	Only UMTS used for radio access.
 				"lte"	Only LTE used for radio access.
+				"umts,gsm"	Dual mode operation with UMTS
+					and GSM radio access whith preference
+					for UMTS.
+				"lte,umts"	Dual mode operation with LTE
+					and UMTS radio access with preference
+					for LTE.
 =

 		array{string} AvailableTechnologies [readonly, optional]
 =

-- =

1.9.1


--===============1486506185868360188==--

