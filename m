Content-Type: multipart/mixed; boundary="===============9021783388236005253=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH] qmi: Fix Secondary DNS overwriting Primary DNS
Date: Tue, 11 Dec 2018 20:58:27 +0100
Message-ID: <20181211195827.11907-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9021783388236005253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

inet_ntoa was called twice in a row and as a result both primay and
secondary DNS were pointing to same static buffer containing last
value (secondary DNS).

As a result, ofono always advertised the secondary DNS twice through
DBus ConnectionContext.GetProperties 'DomainNameServers'.

Related: https://osmocom.org/issues/3031
---
 drivers/qmimodem/gprs-context.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index dcdf8ae1..f1fd1f12 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -88,6 +88,7 @@ static void get_settings_cb(struct qmi_result *result, vo=
id *user_data)
 	char* straddr;
 	char* apn;
 	const char *dns[3] =3D { NULL, NULL, NULL };
+	char dns_buf[2][INET_ADDRSTRLEN];
 =

 	DBG("");
 =

@@ -131,14 +132,14 @@ static void get_settings_cb(struct qmi_result *result=
, void *user_data)
 	if (qmi_result_get_uint32(result,
 				QMI_WDS_RESULT_PRIMARY_DNS, &ip_addr)) {
 		addr.s_addr =3D htonl(ip_addr);
-		dns[0] =3D inet_ntoa(addr);
+		dns[0] =3D inet_ntop(AF_INET, &addr, dns_buf[0], sizeof(dns_buf[0]));
 		DBG("Primary DNS: %s", dns[0]);
 	}
 =

 	if (qmi_result_get_uint32(result,
 				QMI_WDS_RESULT_SECONDARY_DNS, &ip_addr)) {
 		addr.s_addr =3D htonl(ip_addr);
-		dns[1] =3D inet_ntoa(addr);
+		dns[1] =3D inet_ntop(AF_INET, &addr, dns_buf[1], sizeof(dns_buf[1]));
 		DBG("Secondary DNS: %s", dns[1]);
 	}
 =

-- =

2.19.2


--===============9021783388236005253==--

