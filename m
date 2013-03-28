Content-Type: multipart/mixed; boundary="===============4100389349342923423=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 6/8] hfpmodem: Add method to query if CLCC quirks are needed
Date: Thu, 28 Mar 2013 14:37:00 +0100
Message-ID: <8187c3fa8bc9ae2be0bfb06b3d8a5641afa27862.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <aac717cd780a496577d592375d4cc600a5ea0e3e.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4100389349342923423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

---
 drivers/hfpmodem/vendor.h    |  3 ++-
 drivers/hfpmodem/voicecall.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/vendor.h b/drivers/hfpmodem/vendor.h
index fca847a..597ddee 100644
--- a/drivers/hfpmodem/vendor.h
+++ b/drivers/hfpmodem/vendor.h
@@ -21,5 +21,6 @@
  */
 =

 enum ofono_vendor {
-	OFONO_VENDOR_GENERIC =3D 0
+	OFONO_VENDOR_GENERIC =3D 0,
+	OFONO_VENDOR_NOKIA_N9
 };
diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 08e13f0..b7a9ec5 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -95,6 +95,18 @@ static GSList *find_dialing(GSList *calls)
 	return c;
 }
 =

+static gboolean needs_callheld_clcc_quirk(int vendor)
+{
+	switch (vendor) {
+	case OFONO_VENDOR_NOKIA_N9:
+		return TRUE;
+	case OFONO_VENDOR_GENERIC:
+		return FALSE;
+	}
+
+	return FALSE;
+}
+
 static void voicecall_notify(gpointer value, gpointer user)
 {
 	struct ofono_call *call =3D value;
-- =

1.7.11.7


--===============4100389349342923423==--

