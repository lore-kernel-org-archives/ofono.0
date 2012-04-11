Content-Type: multipart/mixed; boundary="===============1812854245696074969=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] huawei: Specify vendor in creating gprs context atom
Date: Wed, 11 Apr 2012 12:08:23 +0200
Message-ID: <1334138904-2005-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1334138904-2005-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1812854245696074969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..bc72061 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -825,7 +825,7 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 		gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->pcui);
-		gc =3D ofono_gprs_context_create(modem, 0,
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_HUAWEI,
 						"atmodem", data->modem);
 =

 		if (gprs && gc)
-- =

1.7.4.1


--===============1812854245696074969==--

