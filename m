Content-Type: multipart/mixed; boundary="===============6256949890699847924=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 1/1] Fix primary context active/deactive result d-bus reply
 missing issue
Date: Wed, 27 Apr 2011 15:04:27 +0800
Message-ID: <1303887867-6467-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6256949890699847924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

If user offline modem when the gprs_context is in enabling or disabling
state(activating/disactivating), the GPRS primary context activate/disactiv=
ate
result will not be replied to the corresponding application.
---
 drivers/atmodem/gprs-context.c |    7 +++++++
 src/gprs.c                     |    5 +++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index ba95cbf..bfbd2c5 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -301,6 +301,13 @@ static void at_gprs_context_remove(struct ofono_gprs_c=
ontext *gc)
 =

 	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
 		g_at_ppp_unref(gcd->ppp);
+
+		if (gcd->state =3D=3D STATE_ENABLING)
+			CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+
+		if (gcd->state =3D=3D STATE_DISABLING)
+			CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
 		g_at_chat_resume(gcd->chat);
 	}
 =

diff --git a/src/gprs.c b/src/gprs.c
index deffeb8..99cb55d 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -351,6 +351,9 @@ static struct pri_context *gprs_context_by_path(struct =
ofono_gprs *gprs,
 =

 static void context_settings_free(struct context_settings *settings)
 {
+	if (settings =3D=3D NULL)
+		return;
+
 	if (settings->ipv4) {
 		g_free(settings->ipv4->ip);
 		g_free(settings->ipv4->netmask);
@@ -736,6 +739,8 @@ static void pri_reset_context_settings(struct pri_conte=
xt *ctx)
 		return;
 =

 	settings =3D ctx->context_driver->settings;
+	if (settings =3D=3D NULL)
+		return;
 =

 	interface =3D settings->interface;
 	settings->interface =3D NULL;
-- =

1.7.2.2


--===============6256949890699847924==--

