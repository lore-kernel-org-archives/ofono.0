Content-Type: multipart/mixed; boundary="===============3032315935373455348=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/2] gprs: use a new var env to active PPP dump.
Date: Fri, 05 Aug 2011 10:34:04 +0200
Message-ID: <1312533244-28622-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312533244-28622-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3032315935373455348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index ae6f06a..5b2491b 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -134,6 +134,7 @@ static gboolean setup_ppp(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtIO *io;
+	char *dumpfile;
 =

 	DBG("");
 =

@@ -152,6 +153,10 @@ static gboolean setup_ppp(struct ofono_gprs_context *g=
c)
 	if (getenv("OFONO_PPP_DEBUG"))
 		g_at_ppp_set_debug(gcd->ppp, ppp_debug, "PPP");
 =

+	dumpfile =3D getenv("OFONO_PPP_DUMP");
+	if (dumpfile)
+		g_at_ppp_set_recording(gcd->ppp, dumpfile);
+
 	g_at_ppp_set_credentials(gcd->ppp, gcd->username, gcd->password);
 =

 	/* set connect and disconnect callbacks */
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3032315935373455348==--

