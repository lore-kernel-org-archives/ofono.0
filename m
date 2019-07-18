Content-Type: multipart/mixed; boundary="===============8221373713056207467=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 10/10] ublox: be explicit about lack of IPv6
Date: Thu, 18 Jul 2019 12:23:14 +0200
Message-ID: <20190718102314.28094-10-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8221373713056207467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TOBY L4 has no IPv6 support whatsoever.
---
 drivers/ubloxmodem/gprs-context.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index c5b789b6..ff78a42a 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -388,6 +388,14 @@ static void ublox_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

+	if (ublox_is_toby_l4(gcd->model)) {
+		/* TOBY L4 does not support IPv6 */
+		if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
+			CALLBACK_WITH_FAILURE(cb, data);
+			return;
+		}
+	}
+
 	/* IPv6 support not implemented */
 	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
 		CALLBACK_WITH_FAILURE(cb, data);
-- =

2.20.1


--===============8221373713056207467==--

