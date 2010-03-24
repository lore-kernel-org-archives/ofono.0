Content-Type: multipart/mixed; boundary="===============2725977640450308840=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/6] Add macro for ber-tlv more time
Date: Wed, 24 Mar 2010 17:35:43 +0800
Message-ID: <1269423347-15508-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1269423347-15508-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725977640450308840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.h b/src/stkutil.h
index 00c985a..4b7c382 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -37,8 +37,9 @@ enum stk_envelope_type {
 /* TS 102.223 Section 9.4 */
 enum stk_command_type {
 	STK_COMMAND_TYPE_REFRESH =3D			0x01,
-	STK_COMMAND_TYPE_POLL_INTERVAL =3D		0x02,
-	STK_COMMAND_TYPE_POLLING_OFF =3D			0x03,
+	STK_COMMAND_TYPE_MORE_TIME =3D			0x02,
+	STK_COMMAND_TYPE_POLL_INTERVAL =3D		0x03,
+	STK_COMMAND_TYPE_POLLING_OFF =3D			0x04,
 	STK_COMMAND_TYPE_SETUP_EVENT_LIST =3D		0x05,
 	STK_COMMAND_TYPE_SETUP_CALL =3D			0x10,
 	STK_COMMAND_TYPE_SEND_SS =3D			0x11,
-- =

1.6.3.3


--===============2725977640450308840==--

