Content-Type: multipart/mixed; boundary="===============3097116846404815474=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix a typo in telephony_error_to_str
Date: Fri, 23 Apr 2010 10:01:40 +0800
Message-ID: <1271988100-3730-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3097116846404815474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/common.c b/src/common.c
index 72eaf1e..4eaff5e 100644
--- a/src/common.c
+++ b/src/common.c
@@ -273,7 +273,7 @@ const char *telephony_error_to_str(const struct ofono_e=
rror *error)
 		break;
 	case OFONO_ERROR_TYPE_CMS:
 		e =3D cms_errors;
-		maxentries =3D sizeof(cme_errors) / sizeof(struct error_entry);
+		maxentries =3D sizeof(cms_errors) / sizeof(struct error_entry);
 		break;
 	case OFONO_ERROR_TYPE_CEER:
 		e =3D ceer_errors;
-- =

1.6.3.3


--===============3097116846404815474==--

