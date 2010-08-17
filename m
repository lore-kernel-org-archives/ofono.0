Content-Type: multipart/mixed; boundary="===============3803161408579071154=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 8/8] plugins: Add STE sample to modem.conf
Date: Tue, 17 Aug 2010 14:22:34 +0200
Message-ID: <1282047754-15562-9-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3803161408579071154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/modem.conf |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/modem.conf b/plugins/modem.conf
index 66bf932..b577114 100644
--- a/plugins/modem.conf
+++ b/plugins/modem.conf
@@ -44,3 +44,8 @@
 #[n900]
 #Driver=3Dn900modem
 #Interface=3Dphonet0
+
+# Sample STE modem
+#[ste]
+#Interface=3DcfttyS0
+#Driver=3Dste
-- =

1.6.3.3


--===============3803161408579071154==--

