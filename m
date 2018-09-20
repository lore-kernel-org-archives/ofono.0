Content-Type: multipart/mixed; boundary="===============8712061763860568502=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/4] added default values handling for gprs authentication in
 atmodem and mbimmodem
Date: Thu, 20 Sep 2018 06:23:48 +0200
Message-ID: <1537417430-10904-2-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537417430-10904-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8712061763860568502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this is needed so that with the additional methods NONE and ANY
the compilation is not broken
---
 drivers/atmodem/gprs-context.c   | 2 ++
 drivers/mbimmodem/gprs-context.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 79ac4c8..0585850 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -304,6 +304,8 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 				snprintf(buf + len, sizeof(buf) - len - 3,
 						",\"PAP:%s\"", ctx->apn);
 				break;
+			default:
+				break;
 			}
 			break;
 		default:
diff --git a/drivers/mbimmodem/gprs-context.c b/drivers/mbimmodem/gprs-cont=
ext.c
index 79793c9..ce33b92 100644
--- a/drivers/mbimmodem/gprs-context.c
+++ b/drivers/mbimmodem/gprs-context.c
@@ -75,6 +75,8 @@ static uint32_t auth_method_to_auth_protocol(enum ofono_g=
prs_auth_method method)
 		return 2; /* MBIMAuthProtocolChap */
 	case OFONO_GPRS_AUTH_METHOD_PAP:
 		return 1; /* MBIMAuthProtocolPap */
+	default:
+		return 0;
 	}
 =

 	return 0;
-- =

1.9.1


--===============8712061763860568502==--

