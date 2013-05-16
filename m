Content-Type: multipart/mixed; boundary="===============1394279701757065059=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [RFC 10/22] emulator: Add HFP 1.6 AG card driver
Date: Thu, 16 May 2013 14:16:30 -0300
Message-ID: <1368724602-27781-11-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1368724602-27781-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1394279701757065059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit adds a Handsfree Audio Card driver for HFP AG 1.6.

The current connect implementation is the legacy one (direct SCO
connection without codec negotiation).
---
 src/emulator.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 8ac79d5..a2e895a 100644
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
@@ -1007,6 +1009,31 @@ struct ofono_emulator *ofono_emulator_create(struct =
ofono_modem *modem,
 	return em;
 }
 =

+static int hfp16_card_probe(struct ofono_handsfree_card *card,
+					unsigned int vendor, void *data)
+{
+	return 0;
+}
+
+static void hfp16_card_remove(struct ofono_handsfree_card *card)
+{
+}
+
+static void hfp16_card_connect(struct ofono_handsfree_card *card,
+			ofono_handsfree_card_connect_cb_t cb, void *data)
+{
+	DBG("");
+
+	ofono_handsfree_card_connect_sco(card);
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
@@ -1338,9 +1365,10 @@ void __ofono_emulator_set_indicator_forced(struct of=
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


--===============1394279701757065059==--

