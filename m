Content-Type: multipart/mixed; boundary="===============7438448536068581337=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 1/8] plugins/ste: SIM - STE registers as MBM to utilize mbm
 quirks.
Date: Tue, 17 Aug 2010 14:22:27 +0200
Message-ID: <1282047754-15562-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7438448536068581337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Change: This time the right line is hopefully being edited.

 plugins/ste.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ste.c b/plugins/ste.c
index 5b34704..ef375ea 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -213,7 +213,7 @@ static void ste_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_MBM, "atmodem", data->chat);
 	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
 =

 	if (sim)
-- =

1.6.3.3


--===============7438448536068581337==--

