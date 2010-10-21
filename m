Content-Type: multipart/mixed; boundary="===============5932174588316991499=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Beno=C3=AEt?= Monin <benoit.monin@gmx.fr>
Subject: [PATCH] common : bring back some details about technology
Date: Thu, 21 Oct 2010 16:07:20 +0200
Message-ID: <20101021140720.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5932174588316991499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Our application require some more details about network technology
in use. This patch might be a bit controversial because commit
1e783b3 actively simplified the technology field.

Maybe adding a 'Generation' field ('2G', '2.5G', '3G'...) would
be =C2=A0more end-user friendly ?
---
 src/common.c | =C2=A0 =C2=A06 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/common.c b/src/common.c
index b5b9a6f..d571d81 100644
--- a/src/common.c
+++ b/src/common.c
@@ -655,15 +655,15 @@ const char *registration_tech_to_string(int tech)
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "gsm";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_COMPACT:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gsm";
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "gprs";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "umts";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_GSM_EGPRS:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "edge";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsdpa";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hspa";
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "hsupa";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return "hspa";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACCESS_TECHNOLOGY_EUTRAN:
--

--===============5932174588316991499==--

