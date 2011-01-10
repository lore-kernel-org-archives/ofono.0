Content-Type: multipart/mixed; boundary="===============4560344049117314508=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 2/6] huawei: use VENDOR_HUAWEI quirk on sim creation
Date: Mon, 10 Jan 2011 19:02:27 -0200
Message-ID: <1294693351-25475-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294693351-25475-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4560344049117314508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 0b958ec..d6a9d68 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -618,7 +618,7 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
-	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
+	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
 					"atmodem", data->pcui);
 =

 	data->sim_poll_count =3D 0;
-- =

1.7.3.5


--===============4560344049117314508==--

