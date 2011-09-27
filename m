Content-Type: multipart/mixed; boundary="===============5107329041151197045=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 05/21] sap: add support to the disable the SAP client
Date: Tue, 27 Sep 2011 18:04:04 -0300
Message-ID: <1317157460-17012-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5107329041151197045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index f0965f1..abff14c 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -283,8 +283,12 @@ static int sap_enable(struct ofono_modem *modem)
 =

 static int sap_disable(struct ofono_modem *modem)
 {
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
 =

+	data->sap_driver->disable(data->hw_modem);
+
 	return 0;
 }
 =

-- =

1.7.6.2


--===============5107329041151197045==--

