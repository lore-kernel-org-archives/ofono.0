Content-Type: multipart/mixed; boundary="===============8374121704031942985=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 3/3] Use specific vendor for phonesim stk
Date: Tue, 13 Jul 2010 18:30:01 +0800
Message-ID: <1279017001-23915-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1279017001-23915-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8374121704031942985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..9c5b2cb 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -289,7 +289,7 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

-	ofono_stk_create(modem, 0, "atmodem", data->chat);
+	ofono_stk_create(modem, OFONO_VENDOR_PHONESIM, "atmodem", data->chat);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.0.4


--===============8374121704031942985==--

