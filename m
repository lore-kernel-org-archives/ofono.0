Content-Type: multipart/mixed; boundary="===============1464040509692084745=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 06/10] rilmodem: Remove asserts
Date: Thu, 15 Oct 2015 18:46:59 +0200
Message-ID: <1444927623-31141-7-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1464040509692084745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/gprs-context.c | 3 ---
 drivers/rilmodem/rilreply.c     | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
index ad2499c..1c642e8 100644
--- a/drivers/rilmodem/gprs-context.c
+++ b/drivers/rilmodem/gprs-context.c
@@ -247,11 +247,8 @@ static void ril_gprs_context_activate_primary(struct o=
fono_gprs_context *gc,
 	struct ofono_error error;
 	int ret =3D 0;
 =

-	g_assert(gprs_atom !=3D NULL);
 	gprs =3D __ofono_atom_get_data(gprs_atom);
-	g_assert(gprs !=3D NULL);
 	gd =3D ofono_gprs_get_data(gprs);
-	g_assert(gd !=3D NULL);
 =

 	/*
 	 * 0: CDMA 1: GSM/UMTS, 2...
diff --git a/drivers/rilmodem/rilreply.c b/drivers/rilmodem/rilreply.c
index 9ac9ea6..471991c 100644
--- a/drivers/rilmodem/rilreply.c
+++ b/drivers/rilmodem/rilreply.c
@@ -1351,7 +1351,6 @@ int *g_ril_reply_parse_retries(GRil *gril, const stru=
ct ril_msg *message,
 	case OFONO_RIL_VENDOR_INFINEON:
 		ofono_error("%s: infineon type should not arrive here",
 				__func__);
-		g_assert(FALSE);
 		break;
 	}
 =

-- =

2.1.4


--===============1464040509692084745==--

