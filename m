Content-Type: multipart/mixed; boundary="===============2950767372868099678=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/9] mbim: remove unused modem data
Date: Fri, 26 Oct 2018 12:13:12 +0200
Message-ID: <20181026101319.27709-3-jonas@norrbonn.se>
In-Reply-To: <20181026101319.27709-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2950767372868099678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Neither the Vendor nor Model strings are used by the mbim plugin.
---
 plugins/udevng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3c39e681..11338f78 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -962,8 +962,6 @@ static gboolean setup_mbim(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Device", ctl);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 	ofono_modem_set_string(modem->modem, "DescriptorFile", descriptors);
-	ofono_modem_set_string(modem->modem, "Vendor", modem->vendor);
-	ofono_modem_set_string(modem->modem, "Model", modem->model);
 =

 	return TRUE;
 }
-- =

2.17.1


--===============2950767372868099678==--

