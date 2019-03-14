Content-Type: multipart/mixed; boundary="===============3201080827698662885=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 3/5] ublox: TOBY L4 supports only router mode
Date: Thu, 14 Mar 2019 23:28:41 +0100
Message-ID: <20190314222843.9232-3-jonas@norrbonn.se>
In-Reply-To: <20190314222843.9232-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3201080827698662885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The TOBY L4 supports only "router mode" where the modem presents a
network interface that one can run a DHCP client against.  Behind this
interface, the modem takes care of routing packets via NAT by:

i)  selecting the relevant context based on destination IP
ii) using the first activated context as the default route

In order to have the connection manager, thus, do the right thing, the
context only needs to report itself as being active and with the IP
settings set to method "dhcp".  There's no need for the connection manager
to know details like what IP address the context was assigned.

Tested with connman that does the right thing when it finds an active
"dhcp" context.
---
 drivers/ubloxmodem/gprs-context.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index bbf8627a..389868c1 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -240,6 +240,15 @@ static void ublox_gprs_read_settings(struct ofono_gprs=
_context *gc,
 =

 	DBG("cid %u", cid);
 =

+	if (ublox_is_toby_l4(gcd->model)) {
+		/* Use DHCP */
+		gcd->active_context =3D cid;
+		set_gprs_context_interface(gc);
+		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
+		CALLBACK_WITH_SUCCESS(cb, data);
+		return;
+	}
+
 	gcd->active_context =3D cid;
 	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
-- =

2.19.1


--===============3201080827698662885==--

