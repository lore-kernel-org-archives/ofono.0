Content-Type: multipart/mixed; boundary="===============8419745653939848674=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 07/12] huaweicdma: Use pcui port for cdma_netreg
Date: Thu, 08 Dec 2011 15:49:58 +0100
Message-ID: <1323355803-22096-8-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8419745653939848674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huaweicdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..9151ba8 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -211,7 +211,7 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->modem);
+	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->pcui);
 =

 	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
 }
-- =

1.7.1


--===============8419745653939848674==--

