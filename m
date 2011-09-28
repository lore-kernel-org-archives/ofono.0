Content-Type: multipart/mixed; boundary="===============7825397758402208553=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 06/13] sap: add sap modem disable() support
Date: Wed, 28 Sep 2011 18:24:14 -0300
Message-ID: <1317245061-6312-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-5-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7825397758402208553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 850ed2f..7bb776a 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -192,8 +192,12 @@ static int sap_enable(struct ofono_modem *modem)
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


--===============7825397758402208553==--

