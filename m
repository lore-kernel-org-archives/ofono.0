Content-Type: multipart/mixed; boundary="===============2860749260760227295=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/6] stkutil.h: Enumerate the additional information for
 Bearer Independent Protocol
Date: Fri, 08 Apr 2011 18:33:28 +0200
Message-ID: <1302280411-20762-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2860749260760227295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index dd45bc2..bc795d4 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -285,6 +285,23 @@ enum stk_result_addnl_ss_pb {
 	STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE =3D	0x00
 };
 =

+/* Defined according to TS 31.111 Section 8.12.4 */
+enum stk_result_addnl_bip_pb {
+	STK_RESULT_ADDNL_BIP_PB_NO_SPECIFIC_CAUSE =3D		0x00,
+	STK_RESULT_ADDNL_BIP_PB_NO_CHANNEL_AVAIL =3D		0x01,
+	STK_RESULT_ADDNL_BIP_PB_CHANNEL_CLOSED =3D		0x02,
+	STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID =3D		0x03,
+	STK_RESULT_ADDNL_BIP_PB_BUFFER_SIZE_NOT_AVAIL =3D		0x04,
+	STK_RESULT_ADDNL_BIP_PB_SECURITY_ERROR =3D		0x05,
+	STK_RESULT_ADDNL_BIP_PB_INTERFACE_NOT_AVAIL =3D		0x06,
+	STK_RESULT_ADDNL_BIP_PB_DEVICE_NOT_REACHABLE =3D		0x07,
+	STK_RESULT_ADDNL_BIP_PB_SERVICE_ERROR =3D			0x08,
+	STK_RESULT_ADDNL_BIP_PB_SERVICE_ID_UNKNOWN =3D		0x09,
+	STK_RESULT_ADDNL_BIP_PB_PORT_NOT_AVAIL =3D		0x10,
+	STK_RESULT_ADDNL_BIP_PB_LAUNCH_PARAMETERS_MISSING =3D	0x11,
+	STK_RESULT_ADDNL_BIP_PB_APPLICATION_LAUNCH_FAILED =3D	0x12
+};
+
 enum stk_tone_type {
 	STK_TONE_TYPE_DIAL_TONE =3D	0x01,
 	STK_TONE_TYPE_BUSY_TONE =3D	0x02,
-- =

1.7.1


--===============2860749260760227295==--

