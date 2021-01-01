Content-Type: multipart/mixed; boundary="===============3348625826003463936=="
MIME-Version: 1.0
From: s.e.golubtsov@gmail.com
Subject: [PATCH ppp] ppp: Apply configuration options from a DCE request if
 ACK it
Date: Sat, 02 Jan 2021 00:04:12 +0300
Message-ID: <20210101210412.23976-1-s.e.golubtsov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3348625826003463936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergei Golubtsov <s.e.golubtsov@gmail.com>

Apply configuration options if the DCE sends a PPP LCP configure request
and the DTE is going to ACK the request. Otherwise some options such as
the ACCM may not correspond to the configuration negotiated with the
DCE.
---
 gatchat/ppp_cp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index f3f2cc4f..371055e4 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -660,9 +660,12 @@ static void pppcp_generate_event(struct pppcp_data *da=
ta,
 	if (actions & SCR)
 		pppcp_send_configure_request(data);
 =

-	if (actions & SCA)
+	if (actions & SCA) {
+		/* Apply local options */
+		if (data->driver->rca)
+			data->driver->rca(data, packet);
 		pppcp_send_configure_ack(data, packet);
-	else if (actions & SCN)
+	} else if (actions & SCN)
 		pppcp_send_configure_nak(data, packet);
 =

 	if (actions & STR)
-- =

2.17.1

--===============3348625826003463936==--

