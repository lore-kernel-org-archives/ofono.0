Content-Type: multipart/mixed; boundary="===============3167423988170799985=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v5 13/13] sap: clean up extra blank line
Date: Wed, 28 Sep 2011 18:24:21 -0300
Message-ID: <1317245061-6312-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317245061-6312-12-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3167423988170799985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/sap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index 1f760be..bad995d 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -71,7 +71,6 @@ int bluetooth_sap_client_register(struct bluetooth_sap_dr=
iver *sap,
 	return 0;
 }
 =

-
 void bluetooth_sap_client_unregister(struct ofono_modem *modem)
 {
 	GHashTableIter iter;
-- =

1.7.6.2


--===============3167423988170799985==--

