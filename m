Content-Type: multipart/mixed; boundary="===============8681341038533535459=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 7/8] common: Add new NB-IoT technologies
Date: Fri, 15 Feb 2019 14:11:41 +0200
Message-ID: <20190215121142.28163-8-philippedeswert@gmail.com>
In-Reply-To: <20190215121142.28163-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8681341038533535459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippe.deswert@digitalistgroup.com>

Add lte-cat-m1 and lte-cat-nb1 technology identifiers.
---
 src/common.c | 4 ++++
 src/common.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/src/common.c b/src/common.c
index ea7842cc..4dcbc835 100644
--- a/src/common.c
+++ b/src/common.c
@@ -697,6 +697,10 @@ const char *registration_tech_to_string(int tech)
 		return "hspa";
 	case ACCESS_TECHNOLOGY_EUTRAN:
 		return "lte";
+	case ACCESS_TECHNOLOGY_NB_IOT_M1:
+		return "lte-cat-m1";
+	case ACCESS_TECHNOLOGY_NB_IOT_NB1:
+		return "lte-cat-nb1";
 	default:
 		return "";
 	}
diff --git a/src/common.h b/src/common.h
index dc618942..8fef4432 100644
--- a/src/common.h
+++ b/src/common.h
@@ -33,6 +33,8 @@ enum access_technology {
 	ACCESS_TECHNOLOGY_UTRAN_HSUPA =3D		5,
 	ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA =3D	6,
 	ACCESS_TECHNOLOGY_EUTRAN =3D		7,
+	ACCESS_TECHNOLOGY_NB_IOT_M1 =3D		8,
+	ACCESS_TECHNOLOGY_NB_IOT_NB1 =3D		9,
 };
 =

 /* 27.007 Section 7.2 <stat> */
-- =

2.20.1


--===============8681341038533535459==--

