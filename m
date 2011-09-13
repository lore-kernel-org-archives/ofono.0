Content-Type: multipart/mixed; boundary="===============8734245911714458151=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 10/24] sap: add support to the disable the SAP client
Date: Tue, 13 Sep 2011 15:58:18 -0300
Message-ID: <1315940312-1238-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-9-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8734245911714458151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 043fb6c..3e8847a 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -288,8 +288,12 @@ static int sap_enable(struct ofono_modem *modem)
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


--===============8734245911714458151==--

