Content-Type: multipart/mixed; boundary="===============8478124487124454265=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 20/20] test-stkutil: Tests for Timer Expiration envelope
 builder
Date: Mon, 07 Jun 2010 12:08:42 +0200
Message-ID: <1275905322-14768-20-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8478124487124454265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index ad66208..80f852a 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -19598,6 +19598,50 @@ static const struct envelope_test event_download_n=
etwork_rejection_data_121 =3D {
 	},
 };
 =

+static const unsigned char timer_expiration_211[] =3D {
+	0xd7, 0x0c, 0x82, 0x02, 0x82, 0x81, 0xa4, 0x01,
+	0x01, 0xa5, 0x03, 0x00, 0x00, 0x01,
+};
+
+static const struct envelope_test timer_expiration_data_211 =3D {
+	.pdu =3D timer_expiration_211,
+	.pdu_len =3D sizeof(timer_expiration_211),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_TIMER_EXPIRATION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .timer_expiration =3D {
+			.id =3D 1,
+			.value =3D {
+				.second =3D 10,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_expiration_221a[] =3D {
+	0xd7, 0x0c, 0x82, 0x02, 0x82, 0x81, 0xa4, 0x01,
+	0x01, 0xa5, 0x03, 0x00, 0x00, 0x03,
+};
+
+static const struct envelope_test timer_expiration_data_221a =3D {
+	.pdu =3D timer_expiration_221a,
+	.pdu_len =3D sizeof(timer_expiration_221a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_TIMER_EXPIRATION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .timer_expiration =3D {
+			.id =3D 1,
+			.value =3D {
+				.second =3D 30,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -21442,5 +21486,10 @@ int main(int argc, char **argv)
 			&event_download_network_rejection_data_121,
 			test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/Timer Expiration 2.1.1",
+			&timer_expiration_data_211, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Timer Expiration 2.2.1A",
+			&timer_expiration_data_221a, test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============8478124487124454265==--

