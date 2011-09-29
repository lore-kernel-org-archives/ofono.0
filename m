Content-Type: multipart/mixed; boundary="===============5713168678322510678=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/6] sap: add sap modem disable() support
Date: Thu, 29 Sep 2011 14:54:21 -0300
Message-ID: <1317318866-9027-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5713168678322510678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index ab658a5..102abc9 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -191,9 +191,11 @@ static int sap_enable(struct ofono_modem *modem)
 =

 static int sap_disable(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
 =

-	return 0;
+	return data->sap_driver->disable(data->hw_modem);
 }
 =

 static void sap_pre_sim(struct ofono_modem *modem)
-- =

1.7.6.2


--===============5713168678322510678==--

