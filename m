Content-Type: multipart/mixed; boundary="===============8769755498645825464=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 6/9] infineon: Definitions for infineon modem
Date: Tue, 13 Oct 2015 18:07:55 +0200
Message-ID: <1444752478-18198-7-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8769755498645825464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/infineonmodem/infineon_constants.h | 77 ++++++++++++++++++++++++++=
++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/infineonmodem/infineon_constants.h

diff --git a/drivers/infineonmodem/infineon_constants.h b/drivers/infineonm=
odem/infineon_constants.h
new file mode 100644
index 0000000..b0ca7ed
--- /dev/null
+++ b/drivers/infineonmodem/infineon_constants.h
@@ -0,0 +1,77 @@
+/*
+ *
+ *  RIL constants for infineon modem
+ *
+ *  Copyright (C) 2014 Canonical Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifndef INFINEON_CONSTANTS_H
+#define INFINEON_CONSTANTS_H
+
+/* Messages encapsulated in RIL_REQUEST_OEM_HOOK_RAW requests */
+#define INF_RIL_REQUEST_OEM_QUERY_SELECT_BAND 1
+#define INF_RIL_REQUEST_OEM_SET_SELECT_BAND 2
+#define INF_RIL_REQUEST_OEM_SET_CIRCUIT_SWITCHING_PAGING 3
+#define INF_RIL_REQUEST_OEM_GET_LAST_FAILURE_REPORT_FOR_CS_REGISTRATION 4
+#define INF_RIL_REQUEST_OEM_GET_SELECT_BEARER_SERVICE_TYPE 5
+#define INF_RIL_REQUEST_OEM_GET_XPROGRESS_STATUS 6
+#define INF_RIL_REQUEST_OEM_SET_SS_NOTIFY 7
+#define INF_RIL_REQUEST_OEM_GET_SS_NOTIFY 8
+#define INF_RIL_REQUEST_OEM_SET_AUTHENTICATION_TYPE 9
+#define INF_RIL_REQUEST_OEM_SWITCH_OFF_MS 10
+#define INF_RIL_REQUEST_OEM_SET_AUTO_TIMEZONE_UPDATE 11
+#define INF_RIL_REQUEST_OEM_SET_TIMEZONE_RESPORTING 12
+#define INF_RIL_REQUEST_OEM_SET_DISPLAY_SIM_AND_PB_STATUS 13
+#define INF_RIL_REQUEST_OEM_GET_REMAIN_SIM_PIN_ATTEMPTS 14
+#define INF_RIL_REQUEST_OEM_SET_AUTO_REDIAL 15
+#define INF_RIL_REQUEST_OEM_QUERY_CALL_STATUS_REPORTING 16
+#define INF_RIL_REQUEST_OEM_SET_AUTO_ANSWER 17
+#define INF_RIL_REQUEST_OEM_SET_LINE 18
+#define INF_RIL_REQUEST_OEM_PDP_ACTIVATE_OR_DEACTIVATE 19
+#define INF_RIL_REQUEST_OEM_QUERY_GPRS_MS_CLASS 20
+#define INF_RIL_REQUEST_OEM_SET_TRACE_AND_AT_INTERFACES 21
+#define INF_RIL_REQUEST_OEM_QUERY_TRACE_AND_AT_INTERFACES_CONFIGURE 22
+#define INF_RIL_REQUEST_OEM_SWITCH_TRACE_ON_OR_OFF 23
+#define INF_RIL_REQUEST_OEM_READ_EXCEPTION_LOG 24
+#define INF_RIL_REQUEST_OEM_GET_PHONE_ACTIVITY_STATUS 25
+#define INF_RIL_REQUEST_OEM_INITIATE_RESEND_SMS_IF_GPRS_FAILS 26
+#define INF_RIL_REQUEST_OEM_GET_DEVICE_NUMBER 27
+#define INF_RIL_REQUEST_OEM_ENABLE_STK 28
+#define INF_RIL_REQUEST_OEM_GET_SUBSCRIBER_NUMBER 29
+#define INF_RIL_REQUEST_OEM_SELECT_PHONE_BOOK  30
+#define INF_RIL_REQUEST_OEM_READ_PHONE_BOOK    31
+#define INF_RIL_REQUEST_OEM_INSERT_RECORD_TO_PHONE_BOOK 32
+#define INF_RIL_REQUEST_OEM_DELECT_RECORD_IN_PHONE_BOOK  33
+#define INF_RIL_REQUEST_OEM_GET_RECORD_FIELDS_MAX_LEN   34
+#define INF_RIL_REQUEST_OEM_SET_SERIAL_PORT 35
+#define INF_RIL_REQUEST_OEM_SET_DATA_PREFERED 36
+#define INF_RIL_REQUEST_OEM_SET_MODEM_ROUTING 37
+#define INF_RIL_REQUEST_OEM_CLEAR_MISS_NUMBER 38
+#define INF_RIL_REQUEST_OEM_ATH 39
+#define INF_RIL_REQUEST_OEM_NOSIG_MODE_TEST  40
+#define INF_RIL_REQUEST_OEM_SELECT_3G_BAND   41
+#define INF_RIL_REQUEST_OEM_QUERY_3G_BAND    42
+#define INF_RIL_REQUEST_OEM_HW_RESET_MODEM   43
+#define INF_RIL_REQUEST_OEM_QUERY_DIRECT     44
+#define INF_RIL_REQUEST_OEM_USER_PLMN_QUERY  45
+#define INF_RIL_REQUEST_OEM_USER_PLMN_SET    46
+#define INF_RIL_REQUEST_OEM_USER_PLMN_DELTE  47
+#define INF_RIL_REQUEST_OEM_SET_USB_LOG      48
+#define INF_RIL_REQUEST_OEM_UPDATE_CSQ       49
+#define INF_RIL_REQUEST_OEM_DUMP_CELL_ENV    50
+
+#endif /* INFINEON_CONSTANTS_H */
-- =

2.1.4


--===============8769755498645825464==--

