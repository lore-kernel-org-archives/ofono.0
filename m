Content-Type: multipart/mixed; boundary="===============8752553495691691671=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/2] qmimodem: set APN for LTE default bearer
Date: Thu, 04 May 2017 15:24:30 +0200
Message-ID: <20170504132430.28813-2-jonas@southpole.se>
In-Reply-To: <20170504132430.28813-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8752553495691691671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Apparently, an empty APN in an ofono context means that that the context
cannot be activated.  connman definitely interprets it this way.

This patch sets a default name of "automatic" for the default bearer if
no other LTE APN is supplied (which is currently the case as the LTE
atom is not in place yet).  Without this, connman happily ignores the
context, even though it has been activated by ofono.
---
 drivers/qmimodem/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index ac52b19..a80d55f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -83,7 +83,7 @@ static int handle_ss_info(struct qmi_result *result, stru=
ct ofono_gprs *gprs)
 			/* FIXME: query default profile number and APN
 			 * instead of assuming profile 1 and ""
 			 */
-			ofono_gprs_cid_activated(gprs, 1 , "");
+			ofono_gprs_cid_activated(gprs, 1 , "automatic");
 		}
 =

 	return status;
-- =

2.9.3


--===============8752553495691691671==--

