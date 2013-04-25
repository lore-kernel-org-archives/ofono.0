Content-Type: multipart/mixed; boundary="===============5370430560066028565=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 09/12] emulator: Add HFP 1.6 AG card driver
Date: Thu, 25 Apr 2013 16:09:10 -0300
Message-ID: <1366916953-12967-10-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1366916953-12967-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5370430560066028565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 8ac79d5..5027b02 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -45,6 +45,8 @@
 =

 #define RING_TIMEOUT 3
 =

+#define HFP_16_AG_DRIVER "hfp16-ag-driver"
+
 struct ofono_emulator {
 	struct ofono_atom *atom;
 	enum ofono_emulator_type type;
@@ -1007,6 +1009,32 @@ struct ofono_emulator *ofono_emulator_create(struct =
ofono_modem *modem,
 	return em;
 }
 =

+static int hfp16_card_probe(struct ofono_handsfree_card *card,
+					unsigned int vendor, void *data)
+{
+	DBG("HFP 1.6 AG card driver probe");
+
+	return 0;
+}
+
+static void hfp16_card_remove(struct ofono_handsfree_card *card)
+{
+	DBG("HFP 1.6 AG card driver remove");
+}
+
+static void hfp16_card_connect(struct ofono_handsfree_card *card,
+			ofono_handsfree_card_connect_cb_t cb, void *data)
+{
+	DBG("HFP 1.6 AG card driver connect");
+}
+
+static struct ofono_handsfree_card_driver hfp16_ag_driver =3D {
+	.name		=3D HFP_16_AG_DRIVER,
+	.probe		=3D hfp16_card_probe,
+	.remove		=3D hfp16_card_remove,
+	.connect	=3D hfp16_card_connect,
+};
+
 static int card_set_local_remote(struct ofono_handsfree_card *card, int fd)
 {
 	struct sockaddr_rc saddr;
@@ -1338,9 +1366,10 @@ void __ofono_emulator_set_indicator_forced(struct of=
ono_emulator *em,
 =

 int __ofono_emulator_init(void)
 {
-	return 0;
+	return ofono_handsfree_card_driver_register(&hfp16_ag_driver);
 }
 =

 void __ofono_emulator_cleanup(void)
 {
+	ofono_handsfree_card_driver_unregister(&hfp16_ag_driver);
 }
-- =

1.7.9.5


--===============5370430560066028565==--

