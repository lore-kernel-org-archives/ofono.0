Content-Type: multipart/mixed; boundary="===============3545788938219108167=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 09/14] cdmamodem: add strength to CDMA netreg atom
Date: Fri, 05 Aug 2011 15:21:10 +0200
Message-ID: <1312550475-8537-10-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3545788938219108167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-netreg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
index 126a5a5..80b0047 100644
--- a/include/cdma-netreg.h
+++ b/include/cdma-netreg.h
@@ -46,6 +46,8 @@ struct ofono_cdma_netreg_driver {
 =

 void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
 				enum cdma_netreg_status status);
+void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
+				int strength);
 =

 int ofono_cdma_netreg_driver_register(
 				const struct ofono_cdma_netreg_driver *d);
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============3545788938219108167==--

