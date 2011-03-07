Content-Type: multipart/mixed; boundary="===============2418859571879498025=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/5] isimodem: new enums declared for cell info
Date: Mon, 07 Mar 2011 12:24:30 +0200
Message-ID: <1299493474-12982-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2418859571879498025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/debug.c   |    5 +++++
 drivers/isimodem/network.h |    8 ++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 38f97f9..b6d6f75 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -979,6 +979,9 @@ const char *net_message_id_name(enum net_message_id val=
ue)
 		_(NET_OPER_NAME_READ_REQ);
 		_(NET_OPER_NAME_READ_RESP);
 		_(NET_COMMON_MESSAGE);
+		_(NET_NEIGHBOUR_CELLS_REQ);
+		_(NET_NEIGHBOUR_CELLS_RESP);
+
 	}
 	return "NET_<UNKNOWN>";
 }
@@ -1002,6 +1005,8 @@ const char *net_subblock_name(enum net_subblock value)
 		_(NET_SHORT_NITZ_NAME);
 		_(NET_AVAIL_NETWORK_INFO_COMMON);
 		_(NET_OPER_NAME_INFO);
+		_(NET_ECID_GERAN_INFO);
+		_(NET_ECID_UTRAN_FDD_INFO);
 	}
 	return "NET_<UNKNOWN>";
 }
diff --git a/drivers/isimodem/network.h b/drivers/isimodem/network.h
index ee1fbf2..9f7d5e8 100644
--- a/drivers/isimodem/network.h
+++ b/drivers/isimodem/network.h
@@ -61,6 +61,8 @@ enum net_message_id {
 	NET_OPER_NAME_READ_REQ =3D			0xE5,
 	NET_OPER_NAME_READ_RESP =3D			0xE6,
 	NET_COMMON_MESSAGE =3D				0xF0,
+	NET_NEIGHBOUR_CELLS_REQ =3D			0x1A,
+	NET_NEIGHBOUR_CELLS_RESP =3D			0x1B
 };
 =

 enum net_subblock {
@@ -81,6 +83,8 @@ enum net_subblock {
 	NET_SHORT_NITZ_NAME =3D				0x49,
 	NET_AVAIL_NETWORK_INFO_COMMON =3D			0xE1,
 	NET_OPER_NAME_INFO =3D				0xE7,
+	NET_ECID_GERAN_INFO =3D				0x3E,
+	NET_ECID_UTRAN_FDD_INFO =3D			0x3F,
 };
 =

 enum net_reg_status {
@@ -222,6 +226,10 @@ enum net_isi_cause {
 	NET_CAUSE_NOT_SUPPORTED_IN_TECH =3D		0x17,
 };
 =

+enum net_neighbour_cell_info_type {
+	NET_ECID_INFORMATION =3D				0x05,
+};
+
 #ifdef __cplusplus
 };
 #endif
-- =

1.7.1


--===============2418859571879498025==--

