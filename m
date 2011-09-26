Content-Type: multipart/mixed; boundary="===============8884993814446337082=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 10/23] sap: add support to the disable the SAP client
Date: Mon, 26 Sep 2011 14:27:03 -0300
Message-ID: <1317058036-32641-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-9-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8884993814446337082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 6181ac7..92e1a5e 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -289,8 +289,12 @@ static int sap_enable(struct ofono_modem *modem)
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


--===============8884993814446337082==--

