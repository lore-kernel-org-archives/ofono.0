Content-Type: multipart/mixed; boundary="===============2502847981888240497=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 3/4] MC7430: fix get signal strength
Date: Wed, 28 Dec 2016 16:04:01 +0100
Message-ID: <20161228150402.15660-4-c.ronco@kerlink.fr>
In-Reply-To: <20161228150402.15660-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2502847981888240497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

drivers/qmimodem/nas.h
 Get current signal strength (type: 0x01), not list of other signals streng=
th (0x10)
 Without this fix:
  - I can't get a signal strength on MC7430 because list does not exist (on=
ly one signal strength).
  - On MC7304, result is wrong
---
 drivers/qmimodem/nas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index efc28735..dee9d701 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -63,7 +63,7 @@ struct qmi_nas_rf_info {
 } __attribute__((__packed__));
 =

 /* Get the signal strength */
-#define QMI_NAS_RESULT_SIGNAL_STRENGTH		0x10
+#define QMI_NAS_RESULT_SIGNAL_STRENGTH		0x01
 =

 /* Scan for visible network */
 #define QMI_NAS_PARAM_NETWORK_MASK		0x10	/* uint8 bitmask */
-- =

2.11.0


--===============2502847981888240497==--

