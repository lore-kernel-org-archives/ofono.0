Content-Type: multipart/mixed; boundary="===============4813800580246876448=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 2/2] zte: specify the vendor to send cbs topics in split mode.
Date: Tue, 02 Aug 2011 09:35:25 +0200
Message-ID: <1312270525-14045-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312270525-14045-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4813800580246876448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 9fa9940..c572860 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -297,7 +297,7 @@ static void zte_post_online(struct ofono_modem *modem)
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_ZTE, "atmodem", data->aux);
 =

-	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+	ofono_cbs_create(modem, OFONO_VENDOR_ZTE,
 					"atmodem", data->aux);
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 					"atmodem", data->aux);
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

--===============4813800580246876448==--

