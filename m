Content-Type: multipart/mixed; boundary="===============2650191605909680052=="
MIME-Version: 1.0
From: Alexey Andreyev <aa13q@ya.ru>
Subject: Re: [PATCH] qmimodem: Add USSD indication support
Date: Fri, 19 Feb 2021 18:30:32 +0300
Message-ID: <8fe191b9-0c3b-45ad-8701-d5311b64b3a6@ya.ru>
In-Reply-To: <187961613747980@mail.yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2650191605909680052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry for a noob html format, retrying from a custom client as plaintext:

Hello! My first patch, feel free to criticize :) This is to handle the USSD =

Indication messages with the qmimodem driver.
Higher-level KDE Plasma Mobile issue: =

https://invent.kde.org/plasma-mobile/plasma-dialer/-/merge_requests/33
Tested with Quectel EG25-G (Pinephone BH), looks like working, I'm able to =

receive the expected QMI USSD Indication messages.

---
From 2f041e6ba183a2f2a3309e139adef3d114bdc85b Mon Sep 17 00:00:00 2001
From: Alexey Andreyev <aa13q@ya.ru>
Date: Fri, 19 Feb 2021 15:47:42 +0300
Subject: [PATCH] qmimodem: Add USSD indication support

Handle USSD QMI indication messages.
Add support for UCS2 USS Data coding scheme.
Check for User Action TLV type.
---
 drivers/qmimodem/ussd.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 1e613032..189de5bc 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -67,6 +67,12 @@ static int convert_qmi_dcs_gsm_dcs(int qmi_dcs, int =

*gsm_dcs)
 	case QMI_USSD_DCS_ASCII:
 		*gsm_dcs =3D USSD_DCS_8BIT;
 		break;
+	case QMI_USSD_DCS_8BIT:
+			*gsm_dcs =3D USSD_DCS_8BIT;
+			break;
+	case QMI_USSD_DCS_UCS2:
+			*gsm_dcs =3D USSD_DCS_UCS2;
+			break;
 	default:
 		return 1;
 	}
@@ -74,6 +80,42 @@ static int convert_qmi_dcs_gsm_dcs(int qmi_dcs, int =

*gsm_dcs)
 	return 0;
 }
 =

+static void async_ind(struct qmi_result *result, void *user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	const struct qmi_ussd_data *qmi_ussd;
+	uint8_t user_action_required =3D 0;
+	int notify_status =3D OFONO_USSD_STATUS_NOTIFY;
+	uint16_t len;
+	int gsm_dcs;
+
+	DBG("");
+
+	qmi_ussd =3D qmi_result_get(result, QMI_VOICE_PARAM_USSD_IND_DATA, &len);
+	if (qmi_ussd =3D=3D NULL)
+			return;
+
+	if (validate_ussd_data(qmi_ussd, len))
+			goto error;
+
+	if (convert_qmi_dcs_gsm_dcs(qmi_ussd->dcs, &gsm_dcs))
+			goto error;
+
+	if (qmi_result_get_uint8(result, QMI_VOICE_PARAM_USSD_IND_USER_ACTION,
+			&user_action_required)) {
+		if (user_action_required =3D=3D QMI_USSD_USER_ACTION_REQUIRED) {
+			notify_status =3D OFONO_USSD_STATUS_ACTION_REQUIRED;
+		}
+	}
+
+	ofono_ussd_notify(ussd, notify_status, gsm_dcs,
+			qmi_ussd->data, qmi_ussd->length);
+	return;
+
+error:
+	ofono_ussd_notify(ussd, OFONO_USSD_STATUS_TERMINATED, 0, NULL, 0);
+}
+
 static void async_orig_ind(struct qmi_result *result, void *user_data)
 {
 	struct ofono_ussd *ussd =3D user_data;
@@ -141,6 +183,9 @@ static void create_voice_cb(struct qmi_service =

*service, void *user_data)
 =

 	data->voice =3D qmi_service_ref(service);
 =

+	qmi_service_register(data->voice, QMI_VOICE_USSD_IND,
+					async_ind, ussd, NULL);
+
 	qmi_service_register(data->voice, QMI_VOICE_ASYNC_ORIG_USSD,
 					async_orig_ind, ussd, NULL);
 =

-- =

2.30.0


--===============2650191605909680052==--

