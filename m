Content-Type: multipart/mixed; boundary="===============0448079247792070609=="
MIME-Version: 1.0
From: Tonny Tzeng <tonny.tzeng@gmail.com>
Subject: [PATCH] Skip unsolicited CREG/CGREG correctly
Date: Thu, 02 Dec 2010 22:23:08 +0800
Message-ID: <1291299788.2038.2.camel@Twins.TonnyLab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0448079247792070609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch skip unsolicited CREG/CGREG correctly.

Signed-off-by: Tonny Tzeng <tonny.tzeng@gmail.com>
---
 drivers/atmodem/atutil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index b6f0d92..2ca7b44 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -244,8 +244,9 @@ gboolean at_util_parse_reg(GAtResult *result, const
char *prefix,
 			continue;
 =

 		/* Some firmware will report bogus lac/ci when unregistered */
+		/* in this case, we should skip it                          */
 		if (s !=3D 1 && s !=3D 5)
-			goto out;
+			continue;
 =

 		switch (vendor) {
 		case OFONO_VENDOR_HUAWEI:
-- =

1.7.2.2



--===============0448079247792070609==--

