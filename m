Content-Type: multipart/mixed; boundary="===============7629435811393817099=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] huawei: use VENDOR_HUAWEI quirk on gprs context creation
Date: Wed, 25 Jul 2018 15:45:14 +0200
Message-ID: <1532526314-32261-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1532526314-32261-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7629435811393817099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index f02315d..817ee66 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -875,7 +875,7 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
-		data->gc =3D ofono_gprs_context_create(modem, 0,
+		data->gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->modem);
 =

 		if (data->gprs && data->gc)
-- =

2.7.4


--===============7629435811393817099==--

