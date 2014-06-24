Content-Type: multipart/mixed; boundary="===============0005831822971683847=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 1/3] include: add auth method to the provisioning API
Date: Tue, 24 Jun 2014 11:57:04 +0200
Message-ID: <1403603826-17021-2-git-send-email-philip@paeps.cx>
In-Reply-To: <1403603826-17021-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0005831822971683847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-provision.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/gprs-provision.h b/include/gprs-provision.h
index e9eec61..2dd792b 100644
--- a/include/gprs-provision.h
+++ b/include/gprs-provision.h
@@ -35,6 +35,7 @@ struct ofono_gprs_provision_data {
 	char *apn;
 	char *username;
 	char *password;
+	enum ofono_gprs_auth_method auth_method;
 	char *message_proxy;
 	char *message_center;
 };
-- =

1.7.10.4


--===============0005831822971683847==--

