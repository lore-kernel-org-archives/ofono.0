Content-Type: multipart/mixed; boundary="===============7075964304106471993=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix return empty currency for huawei EM770W
Date: Tue, 08 Jun 2010 09:28:55 +0800
Message-ID: <1275960535-17596-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7075964304106471993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei EM770W responses empty "+CPUC: \r\n". So return empty currency
and zero ppuval.
---
 drivers/atmodem/call-meter.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 0553d78..74528ee 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -253,11 +253,19 @@ static void cpuc_query_cb(gboolean ok,
 	}
 =

 	g_at_result_iter_next_string(&iter, &currency);
+
+	if (currency =3D=3D NULL) {
+		memset(currency_buf, 0, sizeof(currency_buf));
+		ppuval =3D 0;
+		goto done;
+	}
+
 	strncpy(currency_buf, currency, sizeof(currency_buf));
 =

 	g_at_result_iter_next_string(&iter, &ppu);
 	ppuval =3D strtod(ppu, NULL);
 =

+done:
 	cb(&error, currency_buf, ppuval, cbd->data);
 }
 =

-- =

1.6.3.3


--===============7075964304106471993==--

