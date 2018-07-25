Content-Type: multipart/mixed; boundary="===============4447539928489056791=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] atmodem: Add gprs-context quirk for HUAWEI vendor
Date: Wed, 25 Jul 2018 15:45:13 +0200
Message-ID: <1532526314-32261-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <8bbc3c7d-7e4b-7167-bc26-b3452466d1e3@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4447539928489056791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When ofono dies while connected using PPP, modem AT channel is not put
back to command mode (tested with HUAWEI modems E3372 and MS2372).
If ofono is restarted, it won't be able to connect as it gets no answer
to AT commands on this AT channel.
This patch adds a quirk to immediately send escape sequence on modem
channel when gprs-context atom is removed.
---
 drivers/atmodem/gprs-context.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 42ec556..79ac4c8 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -461,10 +461,19 @@ static int at_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 static void at_gprs_context_remove(struct ofono_gprs_context *gc)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtIO *io;
 =

 	DBG("");
 =

 	if (gcd->state !=3D STATE_IDLE && gcd->ppp) {
+		if ((gcd->vendor =3D=3D OFONO_VENDOR_HUAWEI) && gcd->chat) {
+			/* immediately send escape sequence */
+			io =3D g_at_chat_get_io(gcd->chat);
+
+			if (io)
+				g_at_io_write(io, "+++", 3);
+		}
+
 		g_at_ppp_unref(gcd->ppp);
 		g_at_chat_resume(gcd->chat);
 	}
-- =

2.7.4


--===============4447539928489056791==--

