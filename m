Content-Type: multipart/mixed; boundary="===============7641862094089309694=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [RFC PATCH 3/3] huawei: Set property "AlwaysOnline" for CDMA modems
Date: Thu, 28 Mar 2013 10:22:45 -0400
Message-ID: <20130328142245.GI29445@alittletooquiet.net>
In-Reply-To: <20130328142112.GF29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7641862094089309694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

---
 plugins/huawei.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..0621d5b 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -377,6 +377,9 @@ static void cfun_offline(gboolean ok, GAtResult *result=
, gpointer user_data)
 		return;
 	}
 =

+	if (data->have_gsm =3D=3D FALSE && data->have_cdma =3D=3D TRUE)
+		ofono_modem_set_boolean(modem, "AlwaysOnline", TRUE);
+
 	ofono_modem_set_powered(modem, TRUE);
 }
 =

-- =

1.7.0.4

--===============7641862094089309694==--

