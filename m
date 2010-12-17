Content-Type: multipart/mixed; boundary="===============1338921491453775936=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 2/9] types: Add CDMA Phone Number
Date: Fri, 17 Dec 2010 15:11:14 -0800
Message-ID: <1292627481-9109-3-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1338921491453775936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/types.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/types.h b/include/types.h
index de15437..a394775 100644
--- a/include/types.h
+++ b/include/types.h
@@ -84,6 +84,14 @@ struct ofono_phone_number {
 	int type;
 };
 =

+/* Length of NUM_FIELDS in 3GPP2 C.S0005-E v2.0*/
+#define OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH 256
+
+struct ofono_cdma_phone_number {
+	/*char maps to max size of CHARi (8 bit) in 3GPP2 C.S0005-E v2.0*/
+	char number[OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH];
+};
+
 struct ofono_call {
 	unsigned int id;
 	int type;
-- =

1.7.0.4


--===============1338921491453775936==--

