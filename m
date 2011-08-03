Content-Type: multipart/mixed; boundary="===============2069932589179958459=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 2/3] isimodem: Allow network registration automatically
Date: Wed, 03 Aug 2011 11:13:44 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB2423A@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2069932589179958459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index cc48579..ffcfab4 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -946,6 +946,84 @@ error:
 	g_free(cbd);
 }
 =

+static void cs_access_config_resp_cb(const GIsiMessage *msg, void *data)
+{
+    struct ofono_netreg *netreg =3D data;
+    struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GIsiSubBlockIter iter;
+
+    DBG("");
+    if (g_isi_msg_id(msg) !=3D NET_NW_ACCESS_CONF_RESP)
+        return;
+
+	for (g_isi_sb_iter_init(&iter, msg, 2);
+			g_isi_sb_iter_is_valid(&iter);
+			g_isi_sb_iter_next(&iter)) =

+		{
+		uint8_t id =3D g_isi_sb_iter_get_id(&iter);
+		uint8_t mode;
+		=

+		DBG("SB=3D%02X", id);
+		if ((id =3D=3D 0x55) || (id =3D=3D 0x59))
+		    {
+    		g_isi_sb_iter_get_byte(&iter, &mode, 2);
+		    DBG("Reg %X", mode);
+		    }   =

+		else if ((id =3D=3D 0x56) || (id =3D=3D 0x5A))
+		    {
+    		g_isi_sb_iter_get_byte(&iter, &mode, 2);
+		    DBG("Roam %X", mode);
+		    }   =

+		else
+		    {
+		    DBG("Unknown subblock");
+		    }
+	    }
+}
+
+static void cs_state_resp_cb(const GIsiMessage *msg, void *data)
+{
+    struct ofono_netreg *netreg =3D data;
+    struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+    uint8_t code;
+
+    DBG("");
+    if (g_isi_msg_id(msg) !=3D NET_CS_STATE_RESP)
+        return;
+
+    if (!g_isi_msg_data_get_byte(msg, 0, &code))
+        return;
+
+    if (code !=3D NET_CAUSE_OK)
+        {
+        DBG("Failed with cause=3D%X", code);
+        return;
+        }
+
+    if (!g_isi_msg_data_get_byte(msg, 1, &code))
+        return;
+    DBG("CS STATE=3D%X", code);
+
+    if (code =3D=3D NET_CS_INACTIVE)
+        {
+        DBG("CS INACTIVE - DO POWER ON NOT IMPLEMENTED!!!!!!");
+        }
+    else
+    	{
+    	/* Enable registration and roaming */
+        const uint8_t req[] =3D {
+            NET_NW_ACCESS_CONF_REQ, 0, 2,
+            /* Subblock 1 */
+            0x59, 4, 1, 0,
+            /* Subblock 2 */
+            0x5A, 4, 1, 0,
+        };
+    =

+        DBG("CS ACTIVE - Check access config");
+        g_isi_client_send(nd->client, req, sizeof(req), cs_access_config_r=
esp_cb, netreg, NULL);
+    	}
+}
+
 static void subscribe_indications(GIsiClient *cl, void *data)
 {
 	g_isi_client_ind_subscribe(cl, NET_RSSI_IND, rssi_ind_cb, data);
@@ -994,6 +1072,11 @@ static void pn_modem_network_reachable_cb(const GIsiM=
essage *msg, void *data)
 	struct ofono_netreg *netreg =3D data;
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+    const uint8_t req[] =3D {
+        NET_CS_STATE_REQ,
+    };
+
+
 	if (g_isi_msg_error(msg) < 0) {
 		DBG("PN_MODEM_NETWORK not reachable, removing client");
 		g_isi_client_destroy(nd->pn_modem_network);
@@ -1017,6 +1100,8 @@ static void pn_modem_network_reachable_cb(const GIsiM=
essage *msg, void *data)
 	subscribe_indications(nd->client, netreg);
 =

 	ofono_netreg_register(netreg);
+
+    g_isi_client_send(nd->client, req, sizeof(req), cs_state_resp_cb, netr=
eg, NULL);
 }
 =

 static int isi_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,

--===============2069932589179958459==--

