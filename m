Content-Type: multipart/mixed; boundary="===============0686821476984851384=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/9] rilmodem: driver for Android modems
Date: Tue, 13 Oct 2015 18:07:53 +0200
Message-ID: <1444752478-18198-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0686821476984851384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tony Espy <espy@canonical.com>

Driver for modems that are accessed through the Android Radio Interface
Layer (RIL) for telephony, using the gril library. The driver is almost
feature complete with some exceptions, being CBS and SAT the most
prominent.

Co-authored-by: Tony Espy <espy@canonical.com>
Co-authored-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Co-authored-by: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.co=
m>
Co-authored-by: Islam Amer <islam.amer@jollamobile.com>
Co-authored-by: Jussi Kangas <jussi.kangas@tieto.com>
Co-authored-by: Juho H=C3=A4m=C3=A4l=C3=A4inen <juho.hamalainen@tieto.com>
Co-authored-by: Petri Takalokastari <petri.takalokastari@oss.tieto.com>
Co-authored-by: Jarko Poutiainen <Jarko.Poutiainen@oss.tieto.com>
Co-authored-by: Tommi Kenakkala <tommi.kenakkala@oss.tieto.com>
Co-authored-by: Miia Leinonen <miia.leinonen@oss.tieto.com>
Co-authored-by: Martti Piirainen <martti.piirainen@canonical.com>
Co-authored-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 drivers/rilmodem/call-barring.c         |  245 +++++++
 drivers/rilmodem/call-forwarding.c      |  327 +++++++++
 drivers/rilmodem/call-settings.c        |  286 ++++++++
 drivers/rilmodem/call-volume.c          |  182 +++++
 drivers/rilmodem/devinfo.c              |  218 ++++++
 drivers/rilmodem/gprs-context.c         |  585 +++++++++++++++
 drivers/rilmodem/gprs.c                 |  487 +++++++++++++
 drivers/rilmodem/gprs.h                 |   46 ++
 drivers/rilmodem/network-registration.c |  566 +++++++++++++++
 drivers/rilmodem/phonebook.c            | 1055 +++++++++++++++++++++++++++
 drivers/rilmodem/radio-settings.c       |  300 ++++++++
 drivers/rilmodem/radio-settings.h       |   47 ++
 drivers/rilmodem/rilmodem.c             |   78 ++
 drivers/rilmodem/rilmodem.h             |   71 ++
 drivers/rilmodem/rilutil.c              |  194 +++++
 drivers/rilmodem/rilutil.h              |  165 +++++
 drivers/rilmodem/sim.c                  | 1200 +++++++++++++++++++++++++++=
++++
 drivers/rilmodem/sms.c                  |  315 ++++++++
 drivers/rilmodem/ussd.c                 |  264 +++++++
 drivers/rilmodem/vendor.h               |   32 +
 drivers/rilmodem/voicecall.c            |  824 +++++++++++++++++++++
 drivers/rilmodem/voicecall.h            |   71 ++
 22 files changed, 7558 insertions(+)
 create mode 100644 drivers/rilmodem/call-barring.c
 create mode 100644 drivers/rilmodem/call-forwarding.c
 create mode 100644 drivers/rilmodem/call-settings.c
 create mode 100644 drivers/rilmodem/call-volume.c
 create mode 100644 drivers/rilmodem/devinfo.c
 create mode 100644 drivers/rilmodem/gprs-context.c
 create mode 100644 drivers/rilmodem/gprs.c
 create mode 100644 drivers/rilmodem/gprs.h
 create mode 100644 drivers/rilmodem/network-registration.c
 create mode 100644 drivers/rilmodem/phonebook.c
 create mode 100644 drivers/rilmodem/radio-settings.c
 create mode 100644 drivers/rilmodem/radio-settings.h
 create mode 100644 drivers/rilmodem/rilmodem.c
 create mode 100644 drivers/rilmodem/rilmodem.h
 create mode 100644 drivers/rilmodem/rilutil.c
 create mode 100644 drivers/rilmodem/rilutil.h
 create mode 100644 drivers/rilmodem/sim.c
 create mode 100644 drivers/rilmodem/sms.c
 create mode 100644 drivers/rilmodem/ussd.c
 create mode 100644 drivers/rilmodem/vendor.h
 create mode 100644 drivers/rilmodem/voicecall.c
 create mode 100644 drivers/rilmodem/voicecall.h

diff --git a/drivers/rilmodem/call-barring.c b/drivers/rilmodem/call-barrin=
g.c
new file mode 100644
index 0000000..6a19556
--- /dev/null
+++ b/drivers/rilmodem/call-barring.c
@@ -0,0 +1,245 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014 Jolla Ltd
+ *  Contact: Miia Leinonen
+ *  Copyright (C) 2014  Canonical Ltd
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
+#include <errno.h>
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include "common.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+#include "call-barring.h"
+#include "rilmodem.h"
+#include "ril_constants.h"
+
+struct barring_data {
+	GRil *ril;
+};
+
+static void ril_call_barring_query_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_barring_query_cb_t cb =3D cbd->cb;
+	struct barring_data *bd =3D cbd->user;
+	int bearer_class;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: query failed, err: %s", __func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	bearer_class =3D g_ril_reply_parse_query_facility_lock(bd->ril, message);
+	if (bearer_class < 0)
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, bearer_class, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void ril_call_barring_query(struct ofono_call_barring *cb,
+					const char *lock, int cls,
+					ofono_call_barring_query_cb_t callback,
+					void *data)
+{
+	struct barring_data *bd =3D ofono_call_barring_get_data(cb);
+	struct cb_data *cbd =3D cb_data_new(callback, data, bd);
+	struct parcel rilp;
+
+	DBG("lock: %s, services to query: %d", lock, cls);
+
+	/*
+	 * RIL modems do not support 7 as default bearer class. According to
+	 * TS 22.030 Annex C: When service code is not given it corresponds to
+	 * "All tele and bearer services"
+	 */
+	if (cls =3D=3D BEARER_CLASS_DEFAULT)
+		cls =3D SERVICE_CLASS_NONE;
+
+	/* ril.h: password should be empty string "" when not needed */
+	g_ril_request_query_facility_lock(bd->ril, lock, "", cls, &rilp);
+
+	if (g_ril_send(bd->ril, RIL_REQUEST_QUERY_FACILITY_LOCK, &rilp,
+				ril_call_barring_query_cb, cbd, g_free) <=3D 0) {
+		ofono_error("%s: sending failed", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(callback, -1, data);
+	}
+}
+
+static void ril_call_barring_set_cb(struct ril_msg *message, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_barring_set_cb_t cb =3D cbd->cb;
+	struct barring_data *bd =3D cbd->user;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: set failed, err: %s", __func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	/* Just for printing return value */
+	g_ril_reply_parse_set_facility_lock(bd->ril, message);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ril_call_barring_set(struct ofono_call_barring *cb,
+				const char *lock, int enable,
+				const char *passwd, int cls,
+				ofono_call_barring_set_cb_t callback,
+				void *data)
+{
+	struct barring_data *bd =3D ofono_call_barring_get_data(cb);
+	struct cb_data *cbd =3D cb_data_new(callback, data, bd);
+	struct parcel rilp;
+
+	DBG("lock: %s, enable: %d, bearer class: %d", lock, enable, cls);
+
+	/*
+	 * RIL modem does not support 7 as default bearer class. According to
+	 * the 22.030 Annex C: When service code is not given it corresponds to
+	 * "All tele and bearer services"
+	 */
+	if (cls =3D=3D BEARER_CLASS_DEFAULT)
+		cls =3D SERVICE_CLASS_NONE;
+
+	g_ril_request_set_facility_lock(bd->ril, lock, enable,
+					passwd, cls, &rilp);
+
+	if (g_ril_send(bd->ril, RIL_REQUEST_SET_FACILITY_LOCK, &rilp,
+			ril_call_barring_set_cb, cbd, g_free) <=3D 0) {
+		ofono_error("%s: sending failed", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(callback, data);
+	}
+}
+
+static void ril_call_barring_set_passwd_cb(struct ril_msg *message,
+						gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_barring_set_cb_t cb =3D cbd->cb;
+	struct barring_data *bd =3D cbd->user;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: set password failed, err: %s", __func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	g_ril_print_response_no_args(bd->ril, message);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ril_call_barring_set_passwd(struct ofono_call_barring *barr,
+					const char *lock,
+					const char *old_passwd,
+					const char *new_passwd,
+					ofono_call_barring_set_cb_t cb,
+					void *data)
+{
+	struct barring_data *bd =3D ofono_call_barring_get_data(barr);
+	struct cb_data *cbd =3D cb_data_new(cb, data, bd);
+	struct parcel rilp;
+
+	DBG("lock %s old %s new %s", lock, old_passwd, new_passwd);
+
+	g_ril_request_change_barring_password(bd->ril, lock, old_passwd,
+						new_passwd, &rilp);
+
+	if (g_ril_send(bd->ril, RIL_REQUEST_CHANGE_BARRING_PASSWORD, &rilp,
+			ril_call_barring_set_passwd_cb, cbd, g_free) <=3D 0) {
+		ofono_error("%s: sending failed", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_call_barring *cb =3D user_data;
+
+	ofono_call_barring_register(cb);
+	return FALSE;
+}
+
+static int ril_call_barring_probe(struct ofono_call_barring *cb,
+					unsigned int vendor, void *user)
+{
+	GRil *ril =3D user;
+	struct barring_data *bd =3D g_try_new0(struct barring_data, 1);
+	if (bd =3D=3D NULL)
+		return -ENOMEM;
+
+	bd->ril =3D g_ril_clone(ril);
+	ofono_call_barring_set_data(cb, bd);
+
+	g_idle_add(ril_delayed_register, cb);
+
+	return 0;
+}
+
+static void ril_call_barring_remove(struct ofono_call_barring *cb)
+{
+	struct barring_data *data =3D ofono_call_barring_get_data(cb);
+	ofono_call_barring_set_data(cb, NULL);
+
+	g_ril_unref(data->ril);
+	g_free(data);
+}
+
+static struct ofono_call_barring_driver driver =3D {
+	.name			=3D "rilmodem",
+	.probe			=3D ril_call_barring_probe,
+	.remove			=3D ril_call_barring_remove,
+	.query			=3D ril_call_barring_query,
+	.set			=3D ril_call_barring_set,
+	.set_passwd		=3D ril_call_barring_set_passwd
+};
+
+void ril_call_barring_init(void)
+{
+	ofono_call_barring_driver_register(&driver);
+}
+
+void ril_call_barring_exit(void)
+{
+	ofono_call_barring_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
new file mode 100644
index 0000000..7965e7d
--- /dev/null
+++ b/drivers/rilmodem/call-forwarding.c
@@ -0,0 +1,327 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Contact: Jussi Kangas <jussi.kangas@tieto.com>
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-forwarding.h>
+
+#include "gril.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+#include "grilunsol.h"
+
+#include "rilmodem.h"
+
+#include "common.h"
+
+enum cf_action {
+	CF_ACTION_DISABLE,
+	CF_ACTION_ENABLE,
+	CF_ACTION_INTERROGATE,
+	CF_ACTION_REGISTRATION,
+	CF_ACTION_ERASURE,
+};
+
+struct forw_data {
+	GRil *ril;
+	enum cf_action last_action;
+	int last_cls;
+};
+
+static const char *cf_action_to_string(enum cf_action action)
+{
+	switch (action) {
+	case CF_ACTION_DISABLE:
+		return "DISABLE";
+	case CF_ACTION_ENABLE:
+		return "ENABLE";
+	case CF_ACTION_INTERROGATE:
+		return "INTERROGATE";
+	case CF_ACTION_REGISTRATION:
+		return "REGISTRATION";
+	case CF_ACTION_ERASURE:
+		return "ERASURE";
+	}
+
+	return NULL;
+}
+
+static void ril_query_call_fwd_cb(struct ril_msg *message, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cbd->user);
+	ofono_call_forwarding_query_cb_t cb =3D cbd->cb;
+	struct ofono_call_forwarding_condition *list;
+	unsigned int list_size;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: rild error: %s", __func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	list =3D g_ril_reply_parse_query_call_fwd(fd->ril, message, &list_size);
+	/*
+	 * From atmodem:
+	 *
+	 * Specification is really unclear about this
+	 * generate status=3D0 for all classes just in case
+	 */
+	if (list_size =3D=3D 0) {
+		list =3D g_new0(struct ofono_call_forwarding_condition, 1);
+		list_size =3D 1;
+
+		list->status =3D 0;
+		list->cls =3D fd->last_cls;
+	} else if (list =3D=3D NULL) {
+		goto error;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, (int) list_size, list, cbd->data);
+	g_free(list);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+}
+
+static void ril_set_forward_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_forwarding_set_cb_t cb =3D cbd->cb;
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cbd->user);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(fd->ril, message);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s: CF %s failed; rild error: %s", __func__,
+				cf_action_to_string(fd->last_action),
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static int ril_send_forward_cmd(int type, int cls,
+				const struct ofono_phone_number *number,
+				int time,
+				struct cb_data *cbd,
+				enum cf_action action)
+{
+	struct ofono_call_forwarding *cf =3D cbd->user;
+	struct forw_data *fd =3D ofono_call_forwarding_get_data(cf);
+	struct parcel rilp;
+	struct req_call_fwd fwd_req;
+	int ret =3D 0, request;
+	GRilResponseFunc response_func;
+
+	if (action =3D=3D CF_ACTION_INTERROGATE) {
+		request =3D RIL_REQUEST_QUERY_CALL_FORWARD_STATUS;
+		response_func =3D ril_query_call_fwd_cb;
+	} else {
+		request =3D RIL_REQUEST_SET_CALL_FORWARD;
+		response_func =3D ril_set_forward_cb;
+	}
+
+	DBG("%s - %s", ril_request_id_to_string(request),
+		cf_action_to_string(action));
+
+	/*
+	 * Modem seems to respond with error to all queries
+	 * or settings made with bearer class
+	 * BEARER_CLASS_DEFAULT. Design decision: If given
+	 * class is BEARER_CLASS_DEFAULT let's map it to
+	 * SERVICE_CLASS_NONE as with it e.g. ./send-ussd '*21*<phone_number>#'
+	 * returns cls:53 i.e. 1+4+16+32 as service class.
+	*/
+	if (cls =3D=3D BEARER_CLASS_DEFAULT)
+		cls =3D SERVICE_CLASS_NONE;
+
+	fd->last_action =3D action;
+	fd->last_cls =3D cls;
+
+	fwd_req.action =3D (int) action;
+	fwd_req.type =3D type;
+	fwd_req.cls =3D cls;
+	fwd_req.number =3D number;
+
+	/*
+	 * time has no real meaing for action commands other
+	 * then registration, so if not needed, set arbitrary
+	 * 60s time so rild doesn't return an error.
+	 */
+	if (time =3D=3D -1)
+		fwd_req.time =3D 60;
+	else
+		fwd_req.time =3D time;
+
+	g_ril_request_call_fwd(fd->ril, &fwd_req, &rilp);
+
+	ret =3D g_ril_send(fd->ril, request, &rilp, response_func, cbd, g_free);
+	if (ret =3D=3D 0)
+		ofono_error("%s: CF action %s failed", __func__,
+				cf_action_to_string(action));
+	return ret;
+}
+
+static void ril_activate(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, cf);
+
+	if (ril_send_forward_cmd(type, cls, NULL, -1, cbd,
+					CF_ACTION_ENABLE) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
+static void ril_erasure(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, cf);
+
+	if (ril_send_forward_cmd(type, cls, NULL, -1, cbd,
+					CF_ACTION_ERASURE) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
+static void ril_deactivate(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, cf);
+
+	if (ril_send_forward_cmd(type, cls, NULL, -1, cbd,
+					CF_ACTION_DISABLE) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
+static void ril_registration(struct ofono_call_forwarding *cf, int type,
+				int cls,
+				const struct ofono_phone_number *number,
+				int time, ofono_call_forwarding_set_cb_t cb,
+				void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, cf);
+
+	if (ril_send_forward_cmd(type, cls, number, time, cbd,
+					CF_ACTION_REGISTRATION) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
+static void ril_query(struct ofono_call_forwarding *cf, int type, int cls,
+				ofono_call_forwarding_query_cb_t cb,
+				void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, cf);
+
+	if (ril_send_forward_cmd(type, cls, NULL, -1, cbd,
+					CF_ACTION_INTERROGATE) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+		g_free(cbd);
+	}
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_call_forwarding *cf =3D user_data;
+
+	ofono_call_forwarding_register(cf);
+	return FALSE;
+}
+
+static int ril_call_forwarding_probe(struct ofono_call_forwarding *cf,
+					unsigned int vendor, void *user)
+{
+	GRil *ril =3D user;
+	struct forw_data *fd;
+
+	fd =3D g_try_new0(struct forw_data, 1);
+	if (fd =3D=3D NULL)
+		return -ENOMEM;
+
+	fd->ril =3D g_ril_clone(ril);
+	ofono_call_forwarding_set_data(cf, fd);
+
+	/*
+	 * ofono_call_forwarding_register() needs to be called after
+	 * the driver has been set in ofono_call_forwarding_create(),
+	 * which calls this function.  Most other drivers make
+	 * some kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle event instead.
+	 */
+	g_idle_add(ril_delayed_register, cf);
+
+	return 0;
+}
+
+static void ril_call_forwarding_remove(struct ofono_call_forwarding *cf)
+{
+	struct forw_data *data =3D ofono_call_forwarding_get_data(cf);
+	ofono_call_forwarding_set_data(cf, NULL);
+
+	g_ril_unref(data->ril);
+	g_free(data);
+}
+
+static struct ofono_call_forwarding_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_call_forwarding_probe,
+	.remove			=3D ril_call_forwarding_remove,
+	.erasure		=3D ril_erasure,
+	.deactivation		=3D ril_deactivate,
+	.query			=3D ril_query,
+	.registration		=3D ril_registration,
+	.activation		=3D ril_activate
+};
+
+void ril_call_forwarding_init(void)
+{
+	ofono_call_forwarding_driver_register(&driver);
+}
+
+void ril_call_forwarding_exit(void)
+{
+	ofono_call_forwarding_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/call-settings.c b/drivers/rilmodem/call-setti=
ngs.c
new file mode 100644
index 0000000..5603fbd
--- /dev/null
+++ b/drivers/rilmodem/call-settings.c
@@ -0,0 +1,286 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Copyright (C) 2013 Canonical Ltd
+ *  Contact: Jussi Kangas <jussi.kangas@tieto.com>
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-settings.h>
+
+#include "gril.h"
+#include "grilutil.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+
+#include "rilmodem.h"
+#include "ril_constants.h"
+#include "common.h"
+
+struct settings_data {
+	GRil *ril;
+};
+
+static void ril_set_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_call_settings *cs =3D cbd->user;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	ofono_call_settings_set_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(sd->ril, message);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_cw_set(struct ofono_call_settings *cs, int mode, int cls,
+			ofono_call_settings_set_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cs);
+	int ret;
+	struct parcel rilp;
+
+	g_ril_request_set_call_waiting(sd->ril, mode, cls, &rilp);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SET_CALL_WAITING, &rilp,
+				ril_set_cb, cbd, g_free);
+
+	/* In case of error free cbd and return the cb with failure */
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_cw_query_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_call_settings *cs =3D cbd->user;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		int res;
+
+		res =3D g_ril_reply_parse_query_call_waiting(sd->ril, message);
+
+		CALLBACK_WITH_SUCCESS(cb, res, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	}
+}
+
+static void ril_cw_query(struct ofono_call_settings *cs, int cls,
+				ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cs);
+	int ret;
+	struct parcel rilp;
+
+	g_ril_request_query_call_waiting(sd->ril, cls, &rilp);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_QUERY_CALL_WAITING, &rilp,
+				ril_cw_query_cb, cbd, g_free);
+
+	/* In case of error free cbd and return the cb with failure */
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static void ril_clip_query_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_call_settings *cs =3D cbd->user;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	ofono_call_settings_status_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		int res;
+
+		res =3D g_ril_reply_parse_query_clip(sd->ril, message);
+
+		CALLBACK_WITH_SUCCESS(cb, res, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	}
+}
+
+static void ril_clip_query(struct ofono_call_settings *cs,
+			ofono_call_settings_status_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cs);
+	int ret;
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_QUERY_CLIP, NULL,
+				ril_clip_query_cb, cbd, g_free);
+
+	/* In case of error free cbd and return the cb with failure */
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static void ril_clir_query_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_call_settings *cs =3D cbd->user;
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	ofono_call_settings_clir_cb_t cb =3D cbd->cb;
+	struct reply_clir *rclir;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: Reply failure: %s", __func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	rclir =3D g_ril_reply_parse_get_clir(sd->ril, message);
+	if (rclir =3D=3D NULL) {
+		ofono_error("%s: parse error", __func__);
+		goto error;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, rclir->status, rclir->provisioned, cbd->data);
+
+	g_ril_reply_free_get_clir(rclir);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
+}
+
+static void ril_clir_query(struct ofono_call_settings *cs,
+			ofono_call_settings_clir_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cs);
+	int ret;
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_GET_CLIR, NULL,
+				ril_clir_query_cb, cbd, g_free);
+
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, -1, data);
+	}
+}
+
+
+static void ril_clir_set(struct ofono_call_settings *cs, int mode,
+			ofono_call_settings_set_cb_t cb, void *data)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cs);
+	struct parcel rilp;
+	int ret;
+
+	g_ril_request_set_clir(sd->ril, mode, &rilp);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SET_CLIR, &rilp,
+				ril_set_cb, cbd, g_free);
+
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_call_settings *cs =3D user_data;
+
+	ofono_call_settings_register(cs);
+
+	return FALSE;
+}
+
+static int ril_call_settings_probe(struct ofono_call_settings *cs,
+					unsigned int vendor, void *user)
+{
+	GRil *ril =3D user;
+	struct settings_data *sd =3D g_new0(struct settings_data, 1);
+
+	sd->ril =3D g_ril_clone(ril);
+
+	ofono_call_settings_set_data(cs, sd);
+
+	g_idle_add(ril_delayed_register, cs);
+
+	return 0;
+}
+
+static void ril_call_settings_remove(struct ofono_call_settings *cs)
+{
+	struct settings_data *sd =3D ofono_call_settings_get_data(cs);
+	ofono_call_settings_set_data(cs, NULL);
+
+	g_ril_unref(sd->ril);
+	g_free(sd);
+}
+
+static struct ofono_call_settings_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_call_settings_probe,
+	.remove			=3D ril_call_settings_remove,
+	.clip_query		=3D ril_clip_query,
+	.cw_query		=3D ril_cw_query,
+	.cw_set			=3D ril_cw_set,
+	.clir_query		=3D ril_clir_query,
+	.clir_set		=3D ril_clir_set
+
+	/*
+	 * Not supported in RIL API
+	 * .colp_query		=3D ril_colp_query,
+	 * .colr_query		=3D ril_colr_query
+	 */
+};
+
+void ril_call_settings_init(void)
+{
+	ofono_call_settings_driver_register(&driver);
+}
+
+void ril_call_settings_exit(void)
+{
+	ofono_call_settings_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/call-volume.c b/drivers/rilmodem/call-volume.c
new file mode 100644
index 0000000..4e88772
--- /dev/null
+++ b/drivers/rilmodem/call-volume.c
@@ -0,0 +1,182 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013 Canonical Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/call-volume.h>
+
+#include "gril.h"
+#include "grilutil.h"
+
+#include "common.h"
+
+#include "rilmodem.h"
+#include "parcel.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+
+struct cv_data {
+	GRil *ril;
+	unsigned int vendor;
+};
+
+static void volume_mute_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_call_volume_cb_t cb =3D cbd->cb;
+	struct cv_data *cvd =3D cbd->user;
+	struct ofono_error error;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+
+		g_ril_print_response_no_args(cvd->ril, message);
+
+	} else {
+		ofono_error("Could not set the ril mute state");
+		decode_ril_error(&error, "FAIL");
+	}
+
+	cb(&error, cbd->data);
+}
+
+static void ril_call_volume_mute(struct ofono_call_volume *cv, int muted,
+					ofono_call_volume_cb_t cb, void *data)
+{
+	struct cv_data *cvd =3D ofono_call_volume_get_data(cv);
+	struct cb_data *cbd =3D cb_data_new(cb, data, cvd);
+	struct parcel rilp;
+
+	DBG("Initial ril muted state: %d", muted);
+
+	g_ril_request_set_mute(cvd->ril, muted, &rilp);
+
+	if (g_ril_send(cvd->ril, RIL_REQUEST_SET_MUTE, &rilp,
+			volume_mute_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("Send RIL_REQUEST_SET_MUTE failed.");
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void probe_mute_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	struct cv_data *cvd =3D ofono_call_volume_get_data(cv);
+	int muted;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("Could not retrieve the ril mute state");
+		return;
+	}
+
+	muted =3D g_ril_reply_parse_get_mute(cvd->ril, message);
+
+	ofono_call_volume_set_muted(cv, muted);
+}
+
+static void call_probe_mute(gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	struct cv_data *cvd =3D ofono_call_volume_get_data(cv);
+
+	g_ril_send(cvd->ril, RIL_REQUEST_GET_MUTE, NULL,
+			probe_mute_cb, cv, NULL);
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_call_volume *cv =3D user_data;
+	DBG("");
+	ofono_call_volume_register(cv);
+
+	/* Probe the mute state */
+	call_probe_mute(user_data);
+
+	/* This makes the timeout a single-shot */
+	return FALSE;
+}
+
+static int ril_call_volume_probe(struct ofono_call_volume *cv,
+					unsigned int vendor, void *data)
+{
+	GRil *ril =3D data;
+	struct cv_data *cvd;
+
+	cvd =3D g_new0(struct cv_data, 1);
+	if (cvd =3D=3D NULL)
+		return -ENOMEM;
+
+	cvd->ril =3D g_ril_clone(ril);
+	cvd->vendor =3D vendor;
+
+	ofono_call_volume_set_data(cv, cvd);
+
+	/*
+	 * ofono_call_volume_register() needs to be called after
+	 * the driver has been set in ofono_call_volume_create(),
+	 * which calls this function.  Most other drivers make
+	 * some kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle event instead.
+	 */
+	g_idle_add(ril_delayed_register, cv);
+
+	return 0;
+}
+
+static void ril_call_volume_remove(struct ofono_call_volume *cv)
+{
+	struct cv_data *cvd =3D ofono_call_volume_get_data(cv);
+
+	ofono_call_volume_set_data(cv, NULL);
+
+	g_ril_unref(cvd->ril);
+	g_free(cvd);
+}
+
+static struct ofono_call_volume_driver driver =3D {
+	.name =3D RILMODEM,
+	.probe =3D ril_call_volume_probe,
+	.remove =3D ril_call_volume_remove,
+	.mute =3D ril_call_volume_mute,
+};
+
+void ril_call_volume_init(void)
+{
+	ofono_call_volume_driver_register(&driver);
+}
+
+void ril_call_volume_exit(void)
+{
+	ofono_call_volume_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/devinfo.c b/drivers/rilmodem/devinfo.c
new file mode 100644
index 0000000..2811837
--- /dev/null
+++ b/drivers/rilmodem/devinfo.c
@@ -0,0 +1,218 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013 Canonical Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include "gril.h"
+
+#include "rilmodem.h"
+#include "grilreply.h"
+
+/*
+ * TODO: The functions in this file are stubbed out, and
+ * will need to be re-worked to talk to the /gril layer
+ * in order to get real values from RILD.
+ */
+
+static void ril_query_manufacturer(struct ofono_devinfo *info,
+					ofono_devinfo_query_cb_t cb,
+					void *data)
+{
+	const char *attr =3D "Fake Manufacturer";
+	struct cb_data *cbd =3D cb_data_new(cb, data, NULL);
+	struct ofono_error error;
+	decode_ril_error(&error, "OK");
+
+	cb(&error, attr, cbd->data);
+
+	/* Note: this will need to change if cbd passed to gril layer */
+	g_free(cbd);
+}
+
+static void ril_query_model(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	const char *attr =3D "Fake Modem Model";
+	struct cb_data *cbd =3D cb_data_new(cb, data, NULL);
+	struct ofono_error error;
+	decode_ril_error(&error, "OK");
+
+	cb(&error, attr, cbd->data);
+
+	/* Note: this will need to change if cbd passed to gril layer */
+	g_free(cbd);
+}
+
+static void query_revision_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	GRil *ril =3D cbd->user;
+	struct ofono_error error;
+	char *revision;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		decode_ril_error(&error, "FAIL");
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	revision =3D g_ril_reply_parse_baseband_version(ril, message);
+
+	cb(&error, revision, cbd->data);
+
+	g_free(revision);
+}
+
+static void ril_query_revision(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	GRil *ril =3D ofono_devinfo_get_data(info);
+	struct cb_data *cbd =3D cb_data_new(cb, data, ril);
+
+	if (g_ril_send(ril, RIL_REQUEST_BASEBAND_VERSION, NULL,
+			query_revision_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+}
+
+static void query_serial_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	GRil *ril =3D cbd->user;
+	struct ofono_error error;
+	gchar *imei;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		decode_ril_error(&error, "FAIL");
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	imei =3D g_ril_reply_parse_baseband_version(ril, message);
+
+	cb(&error, imei, cbd->data);
+
+	g_free(imei);
+}
+
+static void ril_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	GRil *ril =3D ofono_devinfo_get_data(info);
+	struct cb_data *cbd =3D cb_data_new(cb, data, ril);
+
+	/*
+	 * TODO: make it support both RIL_REQUEST_GET_IMEI (deprecated) and
+	 * RIL_REQUEST_DEVICE_IDENTITY depending on the rild version used
+	 */
+
+	if (g_ril_send(ril, RIL_REQUEST_GET_IMEI, NULL,
+			query_serial_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+	DBG("");
+	ofono_devinfo_register(info);
+
+	/* This makes the timeout a single-shot */
+	return FALSE;
+}
+
+static int ril_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
+				void *data)
+{
+	GRil *ril =3D NULL;
+
+	if (data !=3D NULL)
+		ril =3D g_ril_clone(data);
+
+	ofono_devinfo_set_data(info, ril);
+
+	/*
+	 * ofono_devinfo_register() needs to be called after
+	 * the driver has been set in ofono_devinfo_create(),
+	 * which calls this function.  Most other drivers make
+	 * some kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle event instead.
+	 */
+	g_idle_add(ril_delayed_register, info);
+
+	return 0;
+}
+
+static void ril_devinfo_remove(struct ofono_devinfo *info)
+{
+	GRil *ril =3D ofono_devinfo_get_data(info);
+
+	ofono_devinfo_set_data(info, NULL);
+
+	g_ril_unref(ril);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_devinfo_probe,
+	.remove			=3D ril_devinfo_remove,
+	.query_manufacturer	=3D ril_query_manufacturer,
+	.query_model		=3D ril_query_model,
+	.query_revision		=3D ril_query_revision,
+	.query_serial		=3D ril_query_serial
+};
+
+void ril_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void ril_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/gprs-context.c b/drivers/rilmodem/gprs-contex=
t.c
new file mode 100644
index 0000000..2021533
--- /dev/null
+++ b/drivers/rilmodem/gprs-context.c
@@ -0,0 +1,585 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Canonical Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/types.h>
+
+#include "ofono.h"
+
+#include "grilreply.h"
+#include "grilrequest.h"
+#include "grilunsol.h"
+
+#include "gprs.h"
+#include "rilmodem.h"
+
+#define NUM_DEACTIVATION_RETRIES 4
+#define TIME_BETWEEN_DEACT_RETRIES_S 2
+
+enum state {
+	STATE_IDLE,
+	STATE_ENABLING,
+	STATE_DISABLING,
+	STATE_ACTIVE,
+};
+
+struct gprs_context_data {
+	GRil *ril;
+	struct ofono_modem *modem;
+	unsigned vendor;
+	gint active_ctx_cid;
+	gint active_rild_cid;
+	enum state state;
+	guint call_list_id;
+	char *apn;
+	enum ofono_gprs_context_type type;
+	int deact_retries;
+	guint retry_ev_id;
+	struct cb_data *retry_cbd;
+	guint reset_ev_id;
+};
+
+static void ril_gprs_context_deactivate_primary(struct ofono_gprs_context =
*gc,
+						unsigned int id,
+						ofono_gprs_context_cb_t cb,
+						void *data);
+static void ril_deactivate_data_call_cb(struct ril_msg *message,
+					gpointer user_data);
+
+static void set_context_disconnected(struct gprs_context_data *gcd)
+{
+	DBG("");
+
+	gcd->active_ctx_cid =3D -1;
+	gcd->active_rild_cid =3D -1;
+	gcd->state =3D STATE_IDLE;
+	g_free(gcd->apn);
+	gcd->apn =3D NULL;
+}
+
+static void disconnect_context(struct ofono_gprs_context *gc)
+{
+	ril_gprs_context_deactivate_primary(gc, 0, NULL, NULL);
+}
+
+static void ril_gprs_context_call_list_changed(struct ril_msg *message,
+						gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ril_data_call *call =3D NULL;
+	struct ril_data_call_list *call_list;
+	gboolean active_cid_found =3D FALSE;
+	gboolean disconnect =3D FALSE;
+	GSList *iterator =3D NULL;
+
+	call_list =3D g_ril_unsol_parse_data_call_list(gcd->ril, message);
+	if (call_list =3D=3D NULL)
+		return;
+
+	DBG("*gc: %p num calls: %d", gc, g_slist_length(call_list->calls));
+
+	for (iterator =3D call_list->calls; iterator; iterator =3D iterator->next=
) {
+		call =3D (struct ril_data_call *) iterator->data;
+
+		if (call->cid =3D=3D gcd->active_rild_cid) {
+			active_cid_found =3D TRUE;
+			DBG("found call - cid: %d", call->cid);
+
+			if (call->active =3D=3D 0) {
+				DBG("call !active; notify disconnect: %d",
+					call->cid);
+				disconnect =3D TRUE;
+			}
+
+			break;
+		}
+	}
+
+	if ((disconnect =3D=3D TRUE || active_cid_found =3D=3D FALSE)
+		&& gcd->state !=3D STATE_IDLE) {
+		ofono_info("Clearing active context; disconnect: %d"
+			" active_cid_found: %d active_ctx_cid: %d",
+			disconnect, active_cid_found, gcd->active_ctx_cid);
+
+		ofono_gprs_context_deactivated(gc, gcd->active_ctx_cid);
+		set_context_disconnected(gcd);
+	}
+
+	g_ril_unsol_free_data_call_list(call_list);
+}
+
+static void ril_setup_data_call_cb(struct ril_msg *message, gpointer user_=
data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ril_data_call *call =3D NULL;
+	struct ril_data_call_list *call_list =3D NULL;
+
+	DBG("*gc: %p", gc);
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: setup data call failed for apn: %s - %s",
+				__func__, gcd->apn,
+				ril_error_to_string(message->error));
+
+		set_context_disconnected(gcd);
+		goto error;
+	}
+
+	call_list =3D g_ril_unsol_parse_data_call_list(gcd->ril, message);
+	if (call_list =3D=3D NULL) {
+		/* parsing failed, need to actually disconnect */
+		disconnect_context(gc);
+		goto error;
+	}
+
+	if (g_slist_length(call_list->calls) !=3D 1) {
+		ofono_error("%s: setup_data_call reply for apn: %s,"
+				" includes %d calls",
+				__func__, gcd->apn,
+				g_slist_length(call_list->calls));
+
+		disconnect_context(gc);
+		goto error;
+	}
+
+	call =3D (struct ril_data_call *) call_list->calls->data;
+
+	/* Check for valid DNS settings, except for MMS contexts */
+	if (gcd->type !=3D OFONO_GPRS_CONTEXT_TYPE_MMS
+				&& (call->dns_addrs =3D=3D NULL
+				|| g_strv_length(call->dns_addrs) =3D=3D 0)) {
+		ofono_error("%s: no DNS in context of type %d",
+				__func__, gcd->type);
+		disconnect_context(gc);
+		goto error;
+	}
+
+	if (call->status !=3D PDP_FAIL_NONE) {
+		ofono_error("%s: reply->status for apn: %s, is non-zero: %s",
+				__func__, gcd->apn,
+				ril_pdp_fail_to_string(call->status));
+
+		set_context_disconnected(gcd);
+		goto error;
+	}
+
+	gcd->active_rild_cid =3D call->cid;
+	gcd->state =3D STATE_ACTIVE;
+
+	ofono_gprs_context_set_interface(gc, call->ifname);
+	ofono_gprs_context_set_ipv4_netmask(gc,
+					ril_util_get_netmask(call->ip_addr));
+
+	ofono_gprs_context_set_ipv4_address(gc, call->ip_addr, TRUE);
+	ofono_gprs_context_set_ipv4_gateway(gc, call->gateways[0]);
+
+	ofono_gprs_context_set_ipv4_dns_servers(gc,
+					(const char **) call->dns_addrs);
+
+	g_ril_unsol_free_data_call_list(call_list);
+
+	/* activate listener for data call changed events.... */
+	gcd->call_list_id =3D
+		g_ril_register(gcd->ril,
+				RIL_UNSOL_DATA_CALL_LIST_CHANGED,
+				ril_gprs_context_call_list_changed, gc);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	g_ril_unsol_free_data_call_list(call_list);
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ril_gprs_context_activate_primary(struct ofono_gprs_context *g=
c,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+	struct ofono_atom *gprs_atom =3D
+		__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	struct ofono_gprs *gprs =3D NULL;
+	struct ril_gprs_data *gd =3D NULL;
+	struct cb_data *cbd =3D cb_data_new(cb, data, gc);
+	struct req_setup_data_call request;
+	struct parcel rilp;
+	struct ofono_error error;
+	int ret =3D 0;
+
+	g_assert(gprs_atom !=3D NULL);
+	gprs =3D __ofono_atom_get_data(gprs_atom);
+	g_assert(gprs !=3D NULL);
+	gd =3D ofono_gprs_get_data(gprs);
+	g_assert(gd !=3D NULL);
+
+	/*
+	 * 0: CDMA 1: GSM/UMTS, 2...
+	 * anything 2+ is a RadioTechnology value +2
+	 */
+	DBG("*gc: %p activating cid: %d; curr_tech: %d", gc, ctx->cid,
+		gd->tech);
+
+	if (gd->tech =3D=3D RADIO_TECH_UNKNOWN) {
+		ofono_error("%s: radio tech for apn: %s UNKNOWN!", __func__,
+				gcd->apn);
+		request.tech =3D 1;
+	} else {
+		request.tech =3D gd->tech + 2;
+	}
+
+	/*
+	 * TODO: add comments about tethering, other non-public
+	 * profiles...
+	 */
+	if (g_ril_vendor(gcd->ril) =3D=3D OFONO_RIL_VENDOR_MTK &&
+			gcd->type =3D=3D OFONO_GPRS_CONTEXT_TYPE_MMS)
+		request.data_profile =3D RIL_DATA_PROFILE_MTK_MMS;
+	else
+		request.data_profile =3D RIL_DATA_PROFILE_DEFAULT;
+
+	request.apn =3D g_strdup(ctx->apn);
+	request.username =3D g_strdup(ctx->username);
+	request.password =3D g_strdup(ctx->password);
+
+	/*
+	 * We do the same as in $AOSP/frameworks/opt/telephony/src/java/com/
+	 * android/internal/telephony/dataconnection/DataConnection.java,
+	 * onConnect(), and use authentication or not depending on whether
+	 * the user field is empty or not.
+	 */
+	if (request.username !=3D NULL && request.username[0] !=3D '\0')
+		request.auth_type =3D RIL_AUTH_BOTH;
+	else
+		request.auth_type =3D RIL_AUTH_NONE;
+
+	request.protocol =3D ctx->proto;
+	request.req_cid =3D ctx->cid;
+
+	if (g_ril_request_setup_data_call(gcd->ril,
+						&request,
+						&rilp,
+						&error) =3D=3D FALSE) {
+		ofono_error("%s: couldn't build SETUP_DATA_CALL"
+				" request for apn: %s.",
+				__func__, request.apn);
+		goto error;
+	}
+
+	gcd->active_ctx_cid =3D ctx->cid;
+	gcd->state =3D STATE_ENABLING;
+	gcd->apn =3D g_strdup(ctx->apn);
+
+	ret =3D g_ril_send(gcd->ril, RIL_REQUEST_SETUP_DATA_CALL, &rilp,
+				ril_setup_data_call_cb, cbd, g_free);
+
+error:
+	g_free(request.apn);
+	g_free(request.username);
+	g_free(request.password);
+
+	if (ret =3D=3D 0) {
+		ofono_error("%s: send SETUP_DATA_CALL failed for apn: %s.",
+				__func__, gcd->apn);
+
+		set_context_disconnected(gcd);
+
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static gboolean reset_modem(gpointer data)
+{
+	/* TODO call mtk_reset_modem when driver is upstreamed */
+	return FALSE;
+}
+
+static gboolean retry_deactivate(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct req_deactivate_data_call request;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	gcd->retry_ev_id =3D 0;
+
+	/* We might have received a call list update while waiting */
+	if (gcd->state =3D=3D STATE_IDLE) {
+		if (cb)
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+		g_free(cbd);
+
+		return FALSE;
+	}
+
+	request.cid =3D gcd->active_rild_cid;
+	request.reason =3D RIL_DEACTIVATE_DATA_CALL_NO_REASON;
+
+	g_ril_request_deactivate_data_call(gcd->ril, &request, &rilp, &error);
+
+	if (g_ril_send(gcd->ril, RIL_REQUEST_DEACTIVATE_DATA_CALL, &rilp,
+			ril_deactivate_data_call_cb, cbd, g_free) =3D=3D 0) {
+
+		ofono_error("%s: send DEACTIVATE_DATA_CALL failed for apn: %s",
+				__func__, gcd->apn);
+		if (cb)
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+		g_free(cbd);
+	}
+
+	return FALSE;
+}
+
+static void ril_deactivate_data_call_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	gint active_ctx_cid;
+
+	DBG("*gc: %p", gc);
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+
+		g_ril_print_response_no_args(gcd->ril, message);
+
+		active_ctx_cid =3D gcd->active_ctx_cid;
+		set_context_disconnected(gcd);
+
+		/*
+		 * If the deactivate was a result of a data network detach or of
+		 * an error in data call establishment, there won't be call
+		 * back, so _deactivated() needs to be called directly.
+		 */
+		if (cb)
+			CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		else
+			ofono_gprs_context_deactivated(gc, active_ctx_cid);
+
+	} else {
+		ofono_error("%s: reply failure for apn: %s - %s",
+				__func__, gcd->apn,
+				ril_error_to_string(message->error));
+
+		/*
+		 * It has been detected that some modems fail the deactivation
+		 * temporarily. We do retries to handle that case.
+		 */
+		if (--(gcd->deact_retries) > 0) {
+			gcd->retry_cbd =3D cb_data_new(cb, cbd->data, gc);
+			gcd->retry_ev_id =3D
+				g_timeout_add_seconds(
+					TIME_BETWEEN_DEACT_RETRIES_S,
+					retry_deactivate, gcd->retry_cbd);
+		} else {
+			ofono_error("%s: retry limit hit", __func__);
+
+			if (cb)
+				CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+			/*
+			 * Reset modem if MTK. TODO Failures deactivating a
+			 * context have not been reported for other modems, but
+			 * it would be good to have a generic method to force an
+			 * internal reset nonetheless.
+			 */
+			if (gcd->vendor =3D=3D OFONO_RIL_VENDOR_MTK)
+				gcd->reset_ev_id =3D g_idle_add(reset_modem, gcd);
+		}
+	}
+}
+
+static void ril_gprs_context_deactivate_primary(struct ofono_gprs_context =
*gc,
+					unsigned int id,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct cb_data *cbd =3D NULL;
+	struct parcel rilp;
+	struct req_deactivate_data_call request;
+	struct ofono_error error;
+	int ret =3D 0;
+
+	DBG("*gc: %p cid: %d active_rild_cid: %d", gc, id,
+		gcd->active_rild_cid);
+
+	if (gcd->state =3D=3D STATE_IDLE || gcd->state =3D=3D STATE_DISABLING) {
+		/* nothing to do */
+
+		if (cb) {
+			CALLBACK_WITH_SUCCESS(cb, data);
+			g_free(cbd);
+		}
+
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data, gc);
+
+	gcd->state =3D STATE_DISABLING;
+	if (g_ril_unregister(gcd->ril, gcd->call_list_id) =3D=3D FALSE) {
+		ofono_warn("%s: couldn't remove call_list listener"
+				" for apn: %s.",
+				__func__, gcd->apn);
+	}
+
+	request.cid =3D gcd->active_rild_cid;
+	request.reason =3D RIL_DEACTIVATE_DATA_CALL_NO_REASON;
+
+	if (g_ril_request_deactivate_data_call(gcd->ril, &request,
+						&rilp, &error) =3D=3D FALSE) {
+
+		ofono_error("%s: couldn't build DEACTIVATE_DATA_CALL"
+				" request for apn: %s.",
+				__func__, gcd->apn);
+		goto error;
+	}
+
+	gcd->deact_retries =3D NUM_DEACTIVATION_RETRIES;
+	ret =3D g_ril_send(gcd->ril, RIL_REQUEST_DEACTIVATE_DATA_CALL, &rilp,
+				ril_deactivate_data_call_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		/* TODO: should we force state to disconnected here? */
+
+		ofono_error("%s: send DEACTIVATE_DATA_CALL failed for apn: %s",
+				__func__, gcd->apn);
+		g_free(cbd);
+		if (cb)
+			CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
+						unsigned int id)
+{
+	DBG("*gc: %p cid: %d", gc, id);
+
+	ril_gprs_context_deactivate_primary(gc, 0, NULL, NULL);
+}
+
+static int ril_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	struct ril_gprs_context_data *ril_data =3D data;
+	struct gprs_context_data *gcd;
+
+	DBG("*gc: %p", gc);
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	gcd->ril =3D g_ril_clone(ril_data->gril);
+	gcd->modem =3D ril_data->modem;
+	gcd->vendor =3D vendor;
+	set_context_disconnected(gcd);
+	gcd->call_list_id =3D -1;
+	gcd->type =3D ril_data->type;
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	return 0;
+}
+
+static void ril_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("*gc: %p", gc);
+
+	if (gcd->state !=3D STATE_IDLE && gcd->state !=3D STATE_DISABLING) {
+		struct req_deactivate_data_call request;
+		struct parcel rilp;
+		struct ofono_error error;
+
+		request.cid =3D gcd->active_rild_cid;
+		request.reason =3D RIL_DEACTIVATE_DATA_CALL_NO_REASON;
+		g_ril_request_deactivate_data_call(gcd->ril, &request,
+								&rilp, &error);
+
+		g_ril_send(gcd->ril, RIL_REQUEST_DEACTIVATE_DATA_CALL,
+						&rilp, NULL, NULL, NULL);
+	}
+
+	if (gcd->retry_ev_id > 0) {
+		g_source_remove(gcd->retry_ev_id);
+		g_free(gcd->retry_cbd);
+	}
+
+	if (gcd->reset_ev_id > 0)
+		g_source_remove(gcd->reset_ev_id);
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_ril_unref(gcd->ril);
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_gprs_context_probe,
+	.remove			=3D ril_gprs_context_remove,
+	.activate_primary       =3D ril_gprs_context_activate_primary,
+	.deactivate_primary     =3D ril_gprs_context_deactivate_primary,
+	.detach_shutdown        =3D ril_gprs_context_detach_shutdown,
+};
+
+void ril_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void ril_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/gprs.c b/drivers/rilmodem/gprs.c
new file mode 100644
index 0000000..75dcfcc
--- /dev/null
+++ b/drivers/rilmodem/gprs.c
@@ -0,0 +1,487 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2013 Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs.h>
+#include <ofono/types.h>
+
+#include "gril.h"
+#include "grilutil.h"
+#include "common.h"
+#include "rilmodem.h"
+
+#include "grilreply.h"
+#include "grilrequest.h"
+#include "grilunsol.h"
+#include "gprs.h"
+
+/* Time between get data status retries */
+#define GET_STATUS_TIMER_MS 5000
+
+/*
+ * This module is the ofono_gprs_driver implementation for rilmodem.
+ *
+ * Notes:
+ *
+ * 1. ofono_gprs_suspend/resume() are not used by this module, as
+ *    the concept of suspended GPRS is not exposed by RILD.
+ */
+
+static int ril_tech_to_bearer_tech(int ril_tech)
+{
+	/*
+	 * This code handles the mapping between the RIL_RadioTechnology
+	 * and packet bearer values ( see <curr_bearer> values - 27.007
+	 * Section 7.29 ).
+	 */
+
+	switch (ril_tech) {
+	case RADIO_TECH_GSM:
+	case RADIO_TECH_UNKNOWN:
+		return PACKET_BEARER_NONE;
+	case RADIO_TECH_GPRS:
+		return PACKET_BEARER_GPRS;
+	case RADIO_TECH_EDGE:
+		return PACKET_BEARER_EGPRS;
+	case RADIO_TECH_UMTS:
+		return PACKET_BEARER_UMTS;
+	case RADIO_TECH_HSDPA:
+		return PACKET_BEARER_HSDPA;
+	case RADIO_TECH_HSUPA:
+		return PACKET_BEARER_HSUPA;
+	case RADIO_TECH_HSPAP:
+	case RADIO_TECH_HSPA:
+		/*
+		 * HSPAP is HSPA+; which ofono doesn't define;
+		 * so, if differentiating HSPA and HSPA+ is
+		 * important, then ofono needs to be patched,
+		 * and we probably also need to introduce a
+		 * new indicator icon.
+		 */
+		return PACKET_BEARER_HSUPA_HSDPA;
+	case RADIO_TECH_LTE:
+		return PACKET_BEARER_EPS;
+	default:
+		return PACKET_BEARER_NONE;
+	}
+}
+
+static void ril_gprs_state_change(struct ril_msg *message, gpointer user_d=
ata)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	g_ril_print_unsol_no_args(gd->ril, message);
+
+	/*
+	 * We just want to track network data status if ofono
+	 * itself is attached, so we avoid unnecessary data state requests.
+	 */
+	if (gd->ofono_attached =3D=3D TRUE)
+		ril_gprs_registration_status(gprs, NULL, NULL);
+}
+
+gboolean ril_gprs_set_attached_cb(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	g_free(cbd);
+
+	/* Run once per g_idle_add() call */
+	return FALSE;
+}
+
+static void ril_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+					ofono_gprs_cb_t cb, void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, NULL);
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	DBG("attached: %d", attached);
+
+	/*
+	 * As RIL offers no actual control over the GPRS 'attached'
+	 * state, we save the desired state, and use it to override
+	 * the actual modem's state in the 'attached_status' function.
+	 * This is similar to the way the core ofono gprs code handles
+	 * data roaming ( see src/gprs.c gprs_netreg_update().
+	 *
+	 * The core gprs code calls driver->set_attached() when a netreg
+	 * notificaiton is received and any configured roaming conditions
+	 * are met.
+	 */
+	gd->ofono_attached =3D attached;
+
+	/*
+	 * Call from idle loop, so core can set driver_attached before
+	 * the callback is invoked.
+	 */
+	g_idle_add(ril_gprs_set_attached_cb, cbd);
+}
+
+static gboolean ril_get_status_retry(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	gd->status_retry_cb_id =3D 0;
+
+	ril_gprs_registration_status(gprs, NULL, NULL);
+
+	return FALSE;
+}
+
+static void ril_data_reg_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
+	struct ofono_gprs *gprs =3D cbd->user;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct reply_data_reg_state *reply;
+	gboolean attached =3D FALSE;
+	gboolean notify_status =3D FALSE;
+	int old_status;
+
+	old_status =3D gd->rild_status;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: DATA_REGISTRATION_STATE reply failure: %s",
+				__func__,
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_data_reg_state(gd->ril, message);
+	if (reply =3D=3D NULL)
+		goto error;
+
+	/*
+	 * There are three cases that can result in this callback
+	 * running:
+	 *
+	 * 1) The driver's probe() method was called, and thus an
+	 *    internal call to ril_gprs_registration_status() is
+	 *    generated.  No ofono cb exists.
+	 *
+	 * 2) ril_gprs_state_change() is called due to an unsolicited
+	 *    event from RILD.  No ofono cb exists.
+	 *
+	 * 3) The ofono code code calls the driver's attached_status()
+	 *    function.  A valid ofono cb exists.
+	 */
+
+	if (gd->rild_status !=3D reply->reg_state.status) {
+		gd->rild_status =3D reply->reg_state.status;
+
+		if (cb =3D=3D NULL)
+			notify_status =3D TRUE;
+	}
+
+	/*
+	 * Override the actual status based upon the desired
+	 * attached status set by the core GPRS code ( controlled
+	 * by the ConnnectionManager's 'Powered' property ).
+	 */
+	attached =3D (reply->reg_state.status =3D=3D
+				NETWORK_REGISTRATION_STATUS_REGISTERED ||
+			reply->reg_state.status =3D=3D
+				NETWORK_REGISTRATION_STATUS_ROAMING);
+
+	if (attached && gd->ofono_attached =3D=3D FALSE) {
+		DBG("attached=3Dtrue; ofono_attached=3Dfalse; return !REGISTERED");
+		reply->reg_state.status =3D
+			NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+		/*
+		 * Further optimization so that if ril_status =3D=3D
+		 * NOT_REGISTERED, ofono_attached =3D=3D false, and status =3D=3D
+		 * ROAMING | REGISTERED, then notify gets cleared...
+		 *
+		 * As is, this results in unecessary status notify calls
+		 * when nothing has changed.
+		 */
+		if (notify_status && reply->reg_state.status =3D=3D old_status)
+			notify_status =3D FALSE;
+	}
+
+	if (old_status =3D=3D -1) {
+		ofono_gprs_register(gprs);
+
+		/* Different rild implementations use different events here */
+		g_ril_register(gd->ril,
+				gd->state_changed_unsol,
+				ril_gprs_state_change, gprs);
+
+		if (reply->max_cids =3D=3D 0)
+			gd->max_cids =3D RIL_MAX_NUM_ACTIVE_DATA_CALLS;
+		else if (reply->max_cids < RIL_MAX_NUM_ACTIVE_DATA_CALLS)
+			gd->max_cids =3D reply->max_cids;
+		else
+			gd->max_cids =3D RIL_MAX_NUM_ACTIVE_DATA_CALLS;
+
+		DBG("Setting max cids to %d", gd->max_cids);
+		ofono_gprs_set_cid_range(gprs, 1, gd->max_cids);
+
+		/*
+		 * This callback is a result of the inital call
+		 * to probe(), so should return after registration.
+		 */
+		g_free(reply);
+
+		return;
+	}
+
+	/* Just need to notify ofono if it's already attached */
+	if (notify_status) {
+
+		/*
+		 * If network disconnect has occurred, call detached_notify()
+		 * instead of status_notify().
+		 */
+		if (!attached &&
+			(old_status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
+				old_status =3D=3D
+					NETWORK_REGISTRATION_STATUS_ROAMING)) {
+			DBG("calling ofono_gprs_detached_notify()");
+			ofono_gprs_detached_notify(gprs);
+			reply->reg_state.tech =3D RADIO_TECH_UNKNOWN;
+		} else {
+			DBG("calling ofono_gprs_status_notify()");
+			ofono_gprs_status_notify(gprs, reply->reg_state.status);
+		}
+	}
+
+	if (gd->tech !=3D reply->reg_state.tech) {
+		gd->tech =3D reply->reg_state.tech;
+
+		ofono_gprs_bearer_notify(gprs,
+				ril_tech_to_bearer_tech(reply->reg_state.tech));
+	}
+
+	if (cb)
+		CALLBACK_WITH_SUCCESS(cb, reply->reg_state.status, cbd->data);
+
+	g_free(reply);
+
+	return;
+error:
+
+	/*
+	 * For some modems DATA_REGISTRATION_STATE will return an error until we
+	 * are registered in the voice network.
+	 */
+	if (old_status =3D=3D -1 && message->error =3D=3D RIL_E_GENERIC_FAILURE)
+		gd->status_retry_cb_id =3D
+			g_timeout_add(GET_STATUS_TIMER_MS,
+					ril_get_status_retry, gprs);
+
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+void ril_gprs_registration_status(struct ofono_gprs *gprs,
+					ofono_gprs_status_cb_t cb, void *data)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, gprs);
+
+	DBG("");
+
+	if (g_ril_send(gd->ril, RIL_REQUEST_DATA_REGISTRATION_STATE, NULL,
+			ril_data_reg_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("%s: send "
+				"RIL_REQUEST_DATA_REGISTRATION_STATE failed",
+				__func__);
+		g_free(cbd);
+
+		if (cb !=3D NULL)
+			CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static void drop_data_call_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (message->error =3D=3D RIL_E_SUCCESS)
+		g_ril_print_response_no_args(gd->ril, message);
+	else
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+
+	if (--(gd->pending_deact_req) =3D=3D 0)
+		ril_gprs_registration_status(gprs, NULL, NULL);
+}
+
+static int drop_data_call(struct ofono_gprs *gprs, int cid)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct req_deactivate_data_call request;
+	struct parcel rilp;
+	struct ofono_error error;
+
+	request.cid =3D cid;
+	request.reason =3D RIL_DEACTIVATE_DATA_CALL_NO_REASON;
+
+	g_ril_request_deactivate_data_call(gd->ril, &request, &rilp, &error);
+
+	if (g_ril_send(gd->ril, RIL_REQUEST_DEACTIVATE_DATA_CALL,
+			&rilp, drop_data_call_cb, gprs, NULL) =3D=3D 0) {
+		ofono_error("%s: send failed", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void get_active_data_calls_cb(struct ril_msg *message,
+					gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+	struct ril_data_call_list *call_list =3D NULL;
+	GSList *iterator;
+	struct ril_data_call *call;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: RIL error %s", __func__,
+				ril_error_to_string(message->error));
+		goto end;
+	}
+
+	/* reply can be NULL when there are no existing data calls */
+	call_list =3D g_ril_unsol_parse_data_call_list(gd->ril, message);
+	if (call_list =3D=3D NULL)
+		goto end;
+
+	/*
+	 * We disconnect from previous calls here, which might be needed
+	 * because of a previous ofono abort, as some rild implementations do
+	 * not disconnect the calls even after the ril socket is closed.
+	 */
+	for (iterator =3D call_list->calls; iterator; iterator =3D iterator->next=
) {
+		call =3D iterator->data;
+		DBG("Standing data call with cid %d", call->cid);
+		if (drop_data_call(gprs, call->cid) =3D=3D 0)
+			++(gd->pending_deact_req);
+	}
+
+	g_ril_unsol_free_data_call_list(call_list);
+
+end:
+	if (gd->pending_deact_req =3D=3D 0)
+		ril_gprs_registration_status(gprs, NULL, NULL);
+}
+
+static void get_active_data_calls(struct ofono_gprs *gprs)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	if (g_ril_send(gd->ril, RIL_REQUEST_DATA_CALL_LIST, NULL,
+			get_active_data_calls_cb, gprs, NULL) =3D=3D 0)
+		ofono_error("%s: send failed", __func__);
+}
+
+void ril_gprs_start(struct ril_gprs_driver_data *driver_data,
+			struct ofono_gprs *gprs, struct ril_gprs_data *gd)
+{
+	gd->ril =3D g_ril_clone(driver_data->gril);
+	gd->modem =3D driver_data->modem;
+	gd->ofono_attached =3D FALSE;
+	gd->max_cids =3D 0;
+	gd->rild_status =3D -1;
+	gd->tech =3D RADIO_TECH_UNKNOWN;
+	/* AOSP RILD tracks data network state together with voice */
+	gd->state_changed_unsol =3D
+		RIL_UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED;
+
+	ofono_gprs_set_data(gprs, gd);
+
+	get_active_data_calls(gprs);
+}
+
+int ril_gprs_probe(struct ofono_gprs *gprs, unsigned int vendor, void *dat=
a)
+{
+	struct ril_gprs_driver_data *driver_data =3D data;
+	struct ril_gprs_data *gd;
+
+	gd =3D g_try_new0(struct ril_gprs_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	ril_gprs_start(driver_data, gprs, gd);
+
+	return 0;
+}
+
+void ril_gprs_remove(struct ofono_gprs *gprs)
+{
+	struct ril_gprs_data *gd =3D ofono_gprs_get_data(gprs);
+
+	DBG("");
+
+	if (gd->status_retry_cb_id !=3D 0)
+		g_source_remove(gd->status_retry_cb_id);
+
+	ofono_gprs_set_data(gprs, NULL);
+
+	g_ril_unref(gd->ril);
+	g_free(gd);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_gprs_probe,
+	.remove			=3D ril_gprs_remove,
+	.set_attached		=3D ril_gprs_set_attached,
+	.attached_status	=3D ril_gprs_registration_status,
+};
+
+void ril_gprs_init(void)
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void ril_gprs_exit(void)
+{
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/gprs.h b/drivers/rilmodem/gprs.h
new file mode 100644
index 0000000..78bb14c
--- /dev/null
+++ b/drivers/rilmodem/gprs.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#include "drivers/rilmodem/rilutil.h"
+
+struct ril_gprs_data {
+	GRil *ril;
+	struct ofono_modem *modem;
+	gboolean ofono_attached;
+	unsigned int max_cids;
+	int rild_status;
+	int tech;
+	int state_changed_unsol;
+	int pending_deact_req;
+	guint status_retry_cb_id;
+};
+
+int ril_gprs_probe(struct ofono_gprs *gprs, unsigned int vendor, void *dat=
a);
+void ril_gprs_remove(struct ofono_gprs *gprs);
+void ril_gprs_start(struct ril_gprs_driver_data *driver_data,
+			struct ofono_gprs *gprs, struct ril_gprs_data *gd);
+gboolean ril_gprs_set_attached_cb(gpointer user_data);
+void ril_gprs_registration_status(struct ofono_gprs *gprs,
+					ofono_gprs_status_cb_t cb, void *data);
+void ril_gprs_set_ia_apn(struct ofono_gprs *gprs, const char *apn,
+				enum ofono_gprs_proto proto, const char *user,
+				const char *passwd, const char *mccmnc,
+				ofono_gprs_cb_t cb, void *data);
diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
new file mode 100644
index 0000000..6808a29
--- /dev/null
+++ b/drivers/rilmodem/network-registration.c
@@ -0,0 +1,566 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ST-Ericsson AB.
+ *  Copyright (C) 2012-2013  Canonical Ltd.
+ *  Copyright (C) 2013  Jolla Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "common.h"
+#include "gril.h"
+#include "rilmodem.h"
+
+#include "grilreply.h"
+#include "grilrequest.h"
+#include "grilunsol.h"
+
+struct netreg_data {
+	GRil *ril;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	int signal_index; /* If strength is reported via CIND */
+	int signal_min; /* min strength reported via CIND */
+	int signal_max; /* max strength reported via CIND */
+	int signal_invalid; /* invalid strength reported via CIND */
+	int tech;
+	struct ofono_network_time time;
+	guint nitz_timeout;
+	unsigned int vendor;
+};
+
+static void ril_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data);
+
+static int ril_tech_to_access_tech(int ril_tech)
+{
+	/*
+	 * This code handles the mapping between the RIL_RadioTechnology
+	 * and ofono's access technology values ( see <Act> values - 27.007
+	 * Section 7.3 ).
+	 */
+
+	switch (ril_tech) {
+	case RADIO_TECH_UNKNOWN:
+		return -1;
+	case RADIO_TECH_GSM:
+	case RADIO_TECH_GPRS:
+		return ACCESS_TECHNOLOGY_GSM;
+	case RADIO_TECH_EDGE:
+		return ACCESS_TECHNOLOGY_GSM_EGPRS;
+	case RADIO_TECH_UMTS:
+		return ACCESS_TECHNOLOGY_UTRAN;
+	case RADIO_TECH_HSDPA:
+		return ACCESS_TECHNOLOGY_UTRAN_HSDPA;
+	case RADIO_TECH_HSUPA:
+		return ACCESS_TECHNOLOGY_UTRAN_HSUPA;
+	case RADIO_TECH_HSPAP:
+	case RADIO_TECH_HSPA:
+		/* HSPAP is HSPA+; which ofono doesn't define;
+		 * so, if differentiating HSPA and HSPA+ is
+		 * important, then ofono needs to be patched,
+		 * and we probably also need to introduce a
+		 * new indicator icon.
+		 */
+
+		return ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
+	case RADIO_TECH_LTE:
+		return ACCESS_TECHNOLOGY_EUTRAN;
+	default:
+		return -1;
+	}
+}
+
+static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
+{
+	/* Three digit country code */
+	strncpy(mcc, str, OFONO_MAX_MCC_LENGTH);
+	mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+
+	/* Usually a 2 but sometimes 3 digit network code */
+	strncpy(mnc, str + OFONO_MAX_MCC_LENGTH, OFONO_MAX_MNC_LENGTH);
+	mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
+}
+
+static void ril_creg_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D cbd->user;
+	struct reply_reg_state *reply;
+
+	DBG("");
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: failed to pull registration state",
+				__func__);
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_voice_reg_state(nd->ril, message);
+	if (reply =3D=3D NULL)
+		goto error;
+
+	nd->tech =3D reply->tech;
+
+	CALLBACK_WITH_SUCCESS(cb,
+				reply->status,
+				reply->lac,
+				reply->ci,
+				ril_tech_to_access_tech(reply->tech),
+				cbd->data);
+
+	g_free(reply);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
+}
+
+static void ril_creg_notify(struct ofono_error *error, int status, int lac,
+					int ci, int tech, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during status notification");
+		return;
+	}
+
+	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
+}
+
+static void ril_network_state_change(struct ril_msg *message,
+							gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	g_ril_print_unsol_no_args(nd->ril, message);
+
+	ril_registration_status(netreg, NULL, NULL);
+}
+
+static void ril_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd;
+
+	/*
+	 * If no cb specified, setup internal callback to
+	 * handle unsolicited VOICE_NET_STATE_CHANGE events.
+	 */
+	if (cb =3D=3D NULL)
+		cbd =3D cb_data_new(ril_creg_notify, netreg, nd);
+	else
+		cbd =3D cb_data_new(cb, data, nd);
+
+	if (g_ril_send(nd->ril, RIL_REQUEST_VOICE_REGISTRATION_STATE, NULL,
+			ril_creg_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, data);
+	}
+}
+
+static void set_oper_name(const struct reply_operator *reply,
+				struct ofono_network_operator *op)
+{
+	/* Try to use long by default */
+	if (reply->lalpha)
+		strncpy(op->name, reply->lalpha,
+			OFONO_MAX_OPERATOR_NAME_LENGTH);
+	else if (reply->salpha)
+		strncpy(op->name, reply->salpha,
+			OFONO_MAX_OPERATOR_NAME_LENGTH);
+}
+
+static void ril_cops_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_operator_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D cbd->user;
+	struct reply_operator *reply;
+	struct ofono_network_operator op;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: failed to retrive the current operator",
+				__func__);
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_operator(nd->ril, message);
+	if (reply =3D=3D NULL)
+		goto error;
+
+	set_oper_name(reply, &op);
+
+	extract_mcc_mnc(reply->numeric, op.mcc, op.mnc);
+
+	/* Set to current */
+	op.status =3D OPERATOR_STATUS_CURRENT;
+	op.tech =3D ril_tech_to_access_tech(nd->tech);
+
+	CALLBACK_WITH_SUCCESS(cb, &op, cbd->data);
+
+	g_ril_reply_free_operator(reply);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void ril_current_operator(struct ofono_netreg *netreg,
+				ofono_netreg_operator_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nd);
+
+	if (g_ril_send(nd->ril, RIL_REQUEST_OPERATOR, NULL,
+			ril_cops_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+}
+
+static void ril_cops_list_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_operator_list_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D cbd->user;
+	struct reply_avail_ops *reply =3D NULL;
+	struct ofono_network_operator *ops;
+	struct reply_operator *operator;
+	GSList *l;
+	unsigned int i =3D 0;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: failed to retrive the list of operators",
+				__func__);
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_avail_ops(nd->ril, message);
+	if (reply =3D=3D NULL)
+		goto error;
+
+	ops =3D g_try_new0(struct ofono_network_operator, reply->num_ops);
+	if (ops =3D=3D NULL) {
+		ofono_error("%s: can't allocate ofono_network_operator",
+				__func__);
+
+		goto error;
+	}
+
+	for (l =3D reply->list; l; l =3D l->next) {
+		operator =3D l->data;
+
+		set_oper_name(operator, &ops[i]);
+
+		extract_mcc_mnc(operator->numeric, ops[i].mcc, ops[i].mnc);
+
+		ops[i].tech =3D ril_tech_to_access_tech(operator->tech);
+
+		/* Set the proper status  */
+		if (!strcmp(operator->status, "unknown"))
+			ops[i].status =3D OPERATOR_STATUS_UNKNOWN;
+		else if (!strcmp(operator->status, "available"))
+			ops[i].status =3D OPERATOR_STATUS_AVAILABLE;
+		else if (!strcmp(operator->status, "current"))
+			ops[i].status =3D OPERATOR_STATUS_CURRENT;
+		else if (!strcmp(operator->status, "forbidden"))
+			ops[i].status =3D OPERATOR_STATUS_FORBIDDEN;
+
+		i++;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, reply->num_ops, ops, cbd->data);
+	g_ril_reply_free_avail_ops(reply);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+	g_ril_reply_free_avail_ops(reply);
+}
+
+static void ril_list_operators(struct ofono_netreg *netreg,
+				ofono_netreg_operator_list_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nd);
+
+	if (g_ril_send(nd->ril, RIL_REQUEST_QUERY_AVAILABLE_NETWORKS, NULL,
+			ril_cops_list_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, 0, NULL, data);
+	}
+}
+
+static void ril_register_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_register_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D cbd->user;
+	struct ofono_error error;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+
+		g_ril_print_response_no_args(nd->ril, message);
+
+	} else {
+		decode_ril_error(&error, "FAIL");
+	}
+
+	cb(&error, cbd->data);
+}
+
+static void ril_register_auto(struct ofono_netreg *netreg,
+				ofono_netreg_register_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nd);
+
+	if (g_ril_send(nd->ril, RIL_REQUEST_SET_NETWORK_SELECTION_AUTOMATIC,
+			NULL, ril_register_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_register_manual(struct ofono_netreg *netreg,
+				const char *mcc, const char *mnc,
+				ofono_netreg_register_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nd);
+	char buf[OFONO_MAX_MCC_LENGTH + OFONO_MAX_MNC_LENGTH + 1];
+	struct parcel rilp;
+
+	/* RIL expects a char * specifying MCCMNC of network to select */
+	snprintf(buf, sizeof(buf), "%s%s", mcc, mnc);
+
+	g_ril_request_set_net_select_manual(nd->ril, buf, &rilp);
+
+	/* In case of error free cbd and return the cb with failure */
+	if (g_ril_send(nd->ril, RIL_REQUEST_SET_NETWORK_SELECTION_MANUAL, &rilp,
+			ril_register_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_strength_notify(struct ril_msg *message, gpointer user_dat=
a)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int strength =3D g_ril_unsol_parse_signal_strength(nd->ril, message,
+								nd->tech);
+
+	ofono_netreg_strength_notify(netreg, strength);
+}
+
+static void ril_strength_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_strength_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D cbd->user;
+	struct ofono_error error;
+	int strength;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		ofono_error("Failed to retrive the signal strength");
+		goto error;
+	}
+
+	/* The g_ril_unsol* function handles both reply & unsolicited */
+	strength =3D g_ril_unsol_parse_signal_strength(nd->ril, message,
+							nd->tech);
+	cb(&error, strength, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void ril_signal_strength(struct ofono_netreg *netreg,
+				ofono_netreg_strength_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nd);
+
+	if (g_ril_send(nd->ril, RIL_REQUEST_SIGNAL_STRENGTH, NULL,
+			ril_strength_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("Send RIL_REQUEST_SIGNAL_STRENGTH failed.");
+
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+static void ril_nitz_notify(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	int year, mon, mday, hour, min, sec, dst, tzi, n_match;
+	char tzs, tz[4];
+	gchar *nitz;
+
+	nitz =3D g_ril_unsol_parse_nitz(nd->ril, message);
+	if (nitz =3D=3D NULL)
+		goto error;
+
+	n_match =3D sscanf(nitz, "%u/%u/%u,%u:%u:%u%c%u,%u", &year, &mon,
+				&mday, &hour, &min, &sec, &tzs, &tzi, &dst);
+	if (n_match !=3D 9)
+		goto error;
+
+	sprintf(tz, "%c%d", tzs, tzi);
+
+	nd->time.utcoff =3D atoi(tz) * 15 * 60;
+	nd->time.dst =3D dst;
+	nd->time.sec =3D sec;
+	nd->time.min =3D min;
+	nd->time.hour =3D hour;
+	nd->time.mday =3D mday;
+	nd->time.mon =3D mon;
+	nd->time.year =3D 2000 + year;
+
+	ofono_netreg_time_notify(netreg, &nd->time);
+
+	g_free(nitz);
+
+	return;
+
+error:
+	ofono_error("%s: unable to notify ofono about NITZ (%s)",
+						__func__, nitz ? nitz : "null");
+	g_free(nitz);
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	ofono_netreg_register(netreg);
+
+	/* Register for network state changes */
+	g_ril_register(nd->ril, RIL_UNSOL_RESPONSE_VOICE_NETWORK_STATE_CHANGED,
+			ril_network_state_change, netreg);
+
+	/* Register for network time update reports */
+	g_ril_register(nd->ril, RIL_UNSOL_NITZ_TIME_RECEIVED,
+			ril_nitz_notify, netreg);
+
+	/* Register for signal strength changes */
+	g_ril_register(nd->ril, RIL_UNSOL_SIGNAL_STRENGTH,
+			ril_strength_notify, netreg);
+
+	/* This makes the timeout a single-shot */
+	return FALSE;
+}
+
+static int ril_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *data)
+{
+	GRil *ril =3D data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+
+	nd->ril =3D g_ril_clone(ril);
+	nd->vendor =3D vendor;
+	nd->tech =3D RADIO_TECH_UNKNOWN;
+	nd->time.sec =3D -1;
+	nd->time.min =3D -1;
+	nd->time.hour =3D -1;
+	nd->time.mday =3D -1;
+	nd->time.mon =3D -1;
+	nd->time.year =3D -1;
+	nd->time.dst =3D 0;
+	nd->time.utcoff =3D 0;
+	ofono_netreg_set_data(netreg, nd);
+
+	/*
+	 * ofono_netreg_register() needs to be called after
+	 * the driver has been set in ofono_netreg_create(),
+	 * which calls this function.  Most other drivers make
+	 * some kind of capabilities query to the modem, and then
+	 * call register in the callback; we use the idle loop here.
+	 */
+	g_idle_add(ril_delayed_register, netreg);
+
+	return 0;
+}
+
+static void ril_netreg_remove(struct ofono_netreg *netreg)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	if (nd->nitz_timeout)
+		g_source_remove(nd->nitz_timeout);
+
+	ofono_netreg_set_data(netreg, NULL);
+
+	g_ril_unref(nd->ril);
+	g_free(nd);
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D RILMODEM,
+	.probe				=3D ril_netreg_probe,
+	.remove				=3D ril_netreg_remove,
+	.registration_status		=3D ril_registration_status,
+	.current_operator		=3D ril_current_operator,
+	.list_operators			=3D ril_list_operators,
+	.register_auto			=3D ril_register_auto,
+	.register_manual		=3D ril_register_manual,
+	.strength			=3D ril_signal_strength,
+};
+
+void ril_netreg_init(void)
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void ril_netreg_exit(void)
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/phonebook.c b/drivers/rilmodem/phonebook.c
new file mode 100644
index 0000000..c3f1c0b
--- /dev/null
+++ b/drivers/rilmodem/phonebook.c
@@ -0,0 +1,1055 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) ST-Ericsson SA 2010.
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Contact: Jussi Kangas <jussi.kangas@tieto.com>
+ *  Copyright (C) 2014  Canonical Ltd
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include <glib.h>
+
+#include <ofono.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/phonebook.h>
+#include <sim.h>
+#include <simfs.h>
+#include <util.h>
+
+#include "gril.h"
+#include "simutil.h"
+#include "common.h"
+
+#include "rilmodem.h"
+
+#define UNUSED	0xFF
+
+#define EXT1_CP_SUBADDRESS	1
+#define EXT1_ADDITIONAL_DATA	2
+
+/* TON (Type Of Number) See TS 24.008 */
+#define TON_MASK		0x70
+#define TON_INTERNATIONAL	0x10
+
+enum constructed_tag {
+	TYPE_1_TAG =3D 0xA8,
+	TYPE_2_TAG =3D 0xA9,
+	TYPE_3_TAG =3D 0xAA
+};
+
+enum file_type_tag {
+	TYPE_ADN =3D 0xC0,
+	TYPE_IAP =3D 0xC1,
+	TYPE_EXT1 =3D 0xC2,
+	TYPE_SNE =3D 0xC3,
+	TYPE_ANR =3D 0xC4,
+	TYPE_PBC =3D 0xC5,
+	TYPE_GPR =3D 0xC6,
+	TYPE_AAS =3D 0xC7,
+	TYPE_GAS =3D 0xC8,
+	TYPE_UID =3D 0xC9,
+	TYPE_EMAIL =3D 0xCA,
+	TYPE_CCP1 =3D 0xCB
+};
+
+struct pb_file_info {
+	enum constructed_tag pbr_type;
+	int file_id;
+	enum file_type_tag file_type;
+	int file_length;
+	int record_length;
+};
+
+struct record_to_read {
+	int file_id;
+	enum file_type_tag type_tag;
+	int record_length;
+	int record;
+	int adn_idx;
+	gboolean anr_ext;	/* Is it an EXT1 record for ANR? */
+	gboolean set_by_iap;	/* Type 2 file? */
+};
+
+struct phonebook_entry {
+	int entry;
+	char *name;
+	char *number;
+	char *email;
+	char *anr;
+	char *sne;
+};
+
+unsigned char sim_path[] =3D { 0x3F, 0x00, 0x7F, 0x10 };
+unsigned char usim_path[] =3D { 0x3F, 0x00, 0x7F, 0x10, 0x5F, 0x3A };
+
+/*
+ * Table for BCD to utf8 conversion. See table 4.4 in TS 31.102.
+ * BCD 0x0C indicates pause before sending following digits as DTMF tones.
+ * BCD 0x0D is a wildcard that means "any digit". These values are mapped =
to
+ * ',' and '?', following the Android/iPhone convention for the first and =
Nokia
+ * convention for the second (only OEM that I have seen that supports this
+ * feature). BCD 0x0E is reserved, we convert it to 'r'.
+ */
+static const char digit_to_utf8[] =3D "0123456789*#,?r\0";
+
+/* One of these for each record in EF_PBR */
+struct pb_ref_rec {
+	GSList *pb_files;	/* File ids to read (pb_file_info nodes) */
+	GSList *pb_next;	/* Next file info to read */
+	GSList *pending_records;	/* List of record_to_read */
+	GSList *next_record;	/* Next record_to_read to process */
+	GTree *phonebook;	/* Container of phonebook_entry structures */
+};
+
+struct pb_data {
+	GSList *pb_refs;
+	GSList *pb_ref_next;
+	struct ofono_sim *sim;
+	struct ofono_sim_context *sim_context;
+	const unsigned char *df_path;
+	size_t df_size;
+};
+
+static void read_info_cb(int ok, unsigned char file_status,
+				int total_length, int record_length,
+				void *userdata);
+
+static gint comp_int(gconstpointer a, gconstpointer b)
+{
+	int a_val =3D GPOINTER_TO_INT(a);
+	int b_val =3D GPOINTER_TO_INT(b);
+
+	return a_val - b_val;
+}
+
+static const struct pb_file_info *
+ext1_info(const GSList *pb_files)
+{
+	const GSList *l;
+	for (l =3D pb_files; l; l =3D l->next) {
+		const struct pb_file_info *f_info =3D l->data;
+		if (f_info->file_type =3D=3D TYPE_EXT1)
+			return f_info;
+	}
+
+	return NULL;
+}
+
+static struct phonebook_entry *handle_adn(size_t len, const unsigned char =
*msg,
+					struct pb_ref_rec *ref, int adn_idx)
+{
+	unsigned name_length =3D len - 14;
+	unsigned number_start =3D name_length;
+	unsigned number_length;
+	unsigned extension_record =3D UNUSED;
+	unsigned i, prefix;
+	char *number =3D NULL;
+	char *name =3D sim_string_to_utf8(msg, name_length);
+	struct phonebook_entry *new_entry;
+
+	/* Length contains also TON & NPI */
+	number_length =3D msg[number_start];
+
+	if (number_length !=3D UNUSED && number_length !=3D 0) {
+		number_length--;
+		/* '+' + number + terminator */
+		number =3D g_try_malloc0(2 * number_length + 2);
+
+		if (number) {
+			prefix =3D 0;
+
+			if ((msg[number_start + 1] & TON_MASK)
+					=3D=3D TON_INTERNATIONAL) {
+				number[0] =3D '+';
+				prefix =3D 1;
+			}
+
+			for (i =3D 0; i < number_length; i++) {
+
+				number[2 * i + prefix] =3D
+					digit_to_utf8[msg[number_start + 2 + i]
+							& 0x0f];
+				number[2 * i + 1 + prefix] =3D
+					digit_to_utf8[msg[number_start + 2 + i]
+							>> 4];
+			}
+
+			extension_record =3D msg[len - 1];
+		}
+	}
+
+	DBG("ADN name %s, number %s ", name, number);
+	DBG("number length %d extension_record %d",
+		2 * number_length, extension_record);
+
+	if ((name =3D=3D NULL || *name =3D=3D '\0') && number =3D=3D NULL)
+		goto end;
+
+	new_entry =3D g_try_malloc0(sizeof(*new_entry));
+	if (new_entry =3D=3D NULL) {
+		ofono_error("%s: out of memory", __func__);
+		goto end;
+	}
+
+	new_entry->name =3D name;
+	new_entry->number =3D number;
+
+	DBG("Creating PB entry %d with", adn_idx);
+	DBG("name %s and number %s", new_entry->name, new_entry->number);
+
+	g_tree_insert(ref->phonebook, GINT_TO_POINTER(adn_idx), new_entry);
+
+	if (extension_record !=3D UNUSED) {
+		struct record_to_read *ext_rec =3D
+			g_try_malloc0(sizeof(*ext_rec));
+		const struct pb_file_info *f_info =3D ext1_info(ref->pb_files);
+
+		if (ext_rec && f_info) {
+			ext_rec->file_id =3D f_info->file_id;
+			ext_rec->type_tag =3D TYPE_EXT1;
+			ext_rec->record_length =3D f_info->record_length;
+			ext_rec->record =3D extension_record;
+			ext_rec->adn_idx =3D adn_idx;
+
+			ref->pending_records =3D
+				g_slist_prepend(ref->pending_records, ext_rec);
+		}
+	}
+
+	return new_entry;
+
+end:
+	g_free(name);
+	g_free(number);
+
+	return NULL;
+}
+
+static void handle_iap(size_t len, const unsigned char *msg,
+			struct pb_ref_rec *ref,
+			const struct record_to_read *rec_data)
+{
+	GSList *l;
+	size_t i =3D 0;
+
+	for (l =3D ref->pb_files; l; l =3D l->next) {
+		struct pb_file_info *f_info =3D l->data;
+		if (f_info->pbr_type =3D=3D TYPE_2_TAG) {
+			if (i >=3D len) {
+				ofono_error("%s: EF_IAP record too small",
+						__func__);
+				return;
+			}
+			if (msg[i] !=3D UNUSED) {
+				struct record_to_read *new_rec =3D
+					g_try_malloc0(sizeof(*new_rec));
+				if (new_rec =3D=3D NULL) {
+					ofono_error("%s: OOM", __func__);
+					return;
+				}
+				DBG("type 0x%X record %d",
+					f_info->file_type, msg[i]);
+
+				new_rec->file_id =3D f_info->file_id;
+				new_rec->type_tag =3D f_info->file_type;
+				new_rec->record_length =3D f_info->record_length;
+				new_rec->record =3D msg[i];
+				new_rec->adn_idx =3D rec_data->adn_idx;
+				new_rec->anr_ext =3D FALSE;
+				new_rec->set_by_iap =3D TRUE;
+
+				ref->pending_records =3D
+					g_slist_prepend(ref->pending_records,
+							new_rec);
+			}
+			++i;
+		}
+	}
+}
+
+static void handle_sne(size_t len, const unsigned char *msg,
+			struct pb_ref_rec *ref,
+			const struct record_to_read *rec_data)
+{
+	char *sne;
+
+	/* There are additional fields for type 2 files */
+	if (rec_data->set_by_iap)
+		len -=3D 2;
+
+	sne =3D sim_string_to_utf8(msg, len);
+
+	if (sne && *sne !=3D '\0') {
+		struct phonebook_entry *entry;
+
+		entry =3D g_tree_lookup(ref->phonebook,
+				GINT_TO_POINTER(rec_data->adn_idx));
+		if (entry) {
+			/* If one already exists, delete it */
+			if (entry->sne)
+				g_free(entry->sne);
+
+			DBG("Adding SNE %s to %d", sne, rec_data->adn_idx);
+			DBG("name %s", entry->name);
+
+			entry->sne =3D sne;
+		} else {
+			g_free(sne);
+		}
+	} else {
+		g_free(sne);
+	}
+}
+
+static void handle_anr(size_t len,
+			const unsigned char *msg,
+			struct pb_ref_rec *ref,
+			const struct record_to_read *rec_data)
+{
+	unsigned number_length;
+	unsigned extension_record;
+	unsigned aas_record;
+	unsigned i, prefix;
+	char *anr;
+	struct phonebook_entry *entry;
+
+	if (len < 15) {
+		ofono_error("%s: bad EF_ANR record size", __func__);
+		return;
+	}
+
+	aas_record =3D msg[0];
+	if (aas_record =3D=3D UNUSED)
+		return;
+
+	DBG("ANR %d", aas_record);
+
+	/* Length contains also TON & NPI */
+	number_length =3D msg[1];
+	if (number_length < 2)
+		return;
+
+	number_length--;
+	/* '+' + number + terminator */
+	anr =3D g_try_malloc0(2 * number_length + 2);
+	if (anr =3D=3D NULL)
+		return;
+
+	prefix =3D 0;
+	if ((msg[2] & TON_MASK) =3D=3D TON_INTERNATIONAL) {
+		anr[0] =3D '+';
+		prefix =3D 1;
+	}
+
+	for (i =3D 0; i < number_length; i++) {
+		anr[2 * i + prefix] =3D digit_to_utf8[msg[3 + i] & 0x0f];
+		anr[2 * i + 1 + prefix] =3D digit_to_utf8[msg[3 + i] >> 4];
+	}
+
+	entry =3D g_tree_lookup(ref->phonebook,
+				GINT_TO_POINTER(rec_data->adn_idx));
+	if (entry =3D=3D NULL) {
+		g_free(anr);
+		return;
+	}
+
+	/* If one already exists, delete it */
+	if (entry->anr)
+		g_free(entry->anr);
+
+	DBG("Adding ANR %s to %d", anr, rec_data->adn_idx);
+	DBG("name %s", entry->name);
+
+	entry->anr =3D anr;
+
+	extension_record =3D msg[14];
+
+	DBG("ANR to entry %d number %s number length %d",
+		rec_data->adn_idx, anr, number_length);
+	DBG("extension_record %d aas %d", extension_record, aas_record);
+
+	if (extension_record !=3D UNUSED) {
+		struct record_to_read *ext_rec =3D
+			g_try_malloc0(sizeof(*ext_rec));
+		const struct pb_file_info *f_info =3D ext1_info(ref->pb_files);
+
+		if (ext_rec && f_info) {
+			ext_rec->file_id =3D f_info->file_id;
+			ext_rec->type_tag =3D TYPE_EXT1;
+			ext_rec->record_length =3D f_info->record_length;
+			ext_rec->record =3D extension_record;
+			ext_rec->adn_idx =3D rec_data->adn_idx;
+			ext_rec->anr_ext =3D TRUE;
+
+			ref->pending_records =3D
+				g_slist_prepend(ref->pending_records, ext_rec);
+		}
+	}
+}
+
+static void handle_email(size_t len, const unsigned char *msg,
+			struct pb_ref_rec *ref,
+			const struct record_to_read *rec_data)
+{
+	char *email;
+	struct phonebook_entry *entry;
+
+	/* There are additional fields for type 2 files */
+	if (rec_data->set_by_iap)
+		len -=3D 2;
+
+	email =3D sim_string_to_utf8(msg, len);
+	if (email =3D=3D NULL || *email =3D=3D '\0') {
+		g_free(email);
+		return;
+	}
+
+	entry =3D g_tree_lookup(ref->phonebook,
+				GINT_TO_POINTER(rec_data->adn_idx));
+	if (entry =3D=3D NULL) {
+		g_free(email);
+		return;
+	}
+
+	/* if one already exists, delete it */
+	if (entry->email)
+		g_free(entry->email);
+
+	DBG("Adding email to entry %d", rec_data->adn_idx);
+	DBG("name %s", entry->name);
+
+	entry->email =3D email;
+}
+
+static void handle_ext1(size_t len, const unsigned char *msg,
+			struct pb_ref_rec *ref,
+			const struct record_to_read *rec_data)
+{
+	unsigned number_length, i, next_extension_record;
+	struct phonebook_entry *entry;
+	char *ext_number;
+
+	if (len < 13) {
+		ofono_error("%s: bad EF_EXT1 record size", __func__);
+		return;
+	}
+
+	/* Check if there is more extension data */
+	next_extension_record =3D msg[12];
+	if (next_extension_record !=3D UNUSED) {
+		struct record_to_read *ext_rec =3D
+			g_try_malloc0(sizeof(*ext_rec));
+		const struct pb_file_info *f_info =3D ext1_info(ref->pb_files);
+
+		if (ext_rec && f_info) {
+			DBG("next_extension_record %d", next_extension_record);
+
+			ext_rec->file_id =3D f_info->file_id;
+			ext_rec->record_length =3D f_info->record_length;
+			ext_rec->type_tag =3D TYPE_EXT1;
+			ext_rec->record =3D next_extension_record;
+			ext_rec->adn_idx =3D rec_data->adn_idx;
+			ext_rec->anr_ext =3D rec_data->anr_ext;
+
+			ref->pending_records =3D
+				g_slist_prepend(ref->pending_records, ext_rec);
+		}
+	}
+
+	if (msg[0] !=3D EXT1_ADDITIONAL_DATA) {
+		DBG("EXT1 record with subaddress ignored");
+		return;
+	}
+
+	number_length =3D msg[1];
+	ext_number =3D g_try_malloc0(2 * number_length + 1);
+	if (ext_number =3D=3D NULL)
+		return;
+
+	for (i =3D 0; i < number_length; i++) {
+		ext_number[2 * i] =3D digit_to_utf8[msg[2 + i] & 0x0f];
+		ext_number[2 * i + 1] =3D digit_to_utf8[msg[2 + i] >> 4];
+	}
+
+	DBG("Number extension %s", ext_number);
+	DBG("number length %d", number_length);
+
+	DBG("Looking for ADN entry %d", rec_data->adn_idx);
+	entry =3D g_tree_lookup(ref->phonebook,
+				GINT_TO_POINTER(rec_data->adn_idx));
+	if (entry =3D=3D NULL) {
+		g_free(ext_number);
+		return;
+	}
+
+	if (rec_data->anr_ext) {
+		char *anr =3D entry->anr;
+		entry->anr =3D g_strconcat(anr, ext_number, NULL);
+		g_free(anr);
+	} else {
+		char *number =3D entry->number;
+		entry->number =3D g_strconcat(number, ext_number, NULL);
+		g_free(number);
+	}
+
+	g_free(ext_number);
+}
+
+static const char *file_tag_to_string(enum file_type_tag tag)
+{
+	switch (tag) {
+	case TYPE_ADN: return "ADN";
+	case TYPE_IAP: return "IAP";
+	case TYPE_EXT1: return "EXT1";
+	case TYPE_SNE: return "SNE";
+	case TYPE_ANR: return "ANR";
+	case TYPE_PBC: return "PBC";
+	case TYPE_GPR: return "GPR";
+	case TYPE_AAS: return "AAS";
+	case TYPE_GAS: return "GAS";
+	case TYPE_UID: return "UID";
+	case TYPE_EMAIL: return "EMAIL";
+	case TYPE_CCP1: return "CCP1";
+	default: return "<UNKNOWN>";
+	}
+}
+
+static void decode_read_response(const struct record_to_read *rec_data,
+					const unsigned char *msg, size_t len,
+					struct pb_ref_rec *ref)
+{
+	DBG("Decoding %s type record", file_tag_to_string(rec_data->type_tag));
+	switch (rec_data->type_tag) {
+	case TYPE_IAP:
+		handle_iap(len, msg, ref, rec_data);
+		break;
+	case TYPE_SNE:
+		handle_sne(len, msg, ref, rec_data);
+		break;
+	case TYPE_ANR:
+		handle_anr(len, msg, ref, rec_data);
+		break;
+	case TYPE_EMAIL:
+		handle_email(len, msg, ref, rec_data);
+		break;
+	case TYPE_EXT1:
+		handle_ext1(len, msg, ref, rec_data);
+		break;
+	default:
+		DBG("Skipping type");
+		break;
+	}
+}
+
+static gboolean export_entry(gpointer key, gpointer value, gpointer data)
+{
+	struct ofono_phonebook *pb =3D data;
+	struct phonebook_entry *entry =3D value;
+
+	ofono_phonebook_entry(pb, -1,
+				entry->number, -1,
+				entry->name, -1,
+				NULL,
+				entry->anr, -1,
+				entry->sne,
+				entry->email,
+				NULL, NULL);
+
+	g_free(entry->name);
+	g_free(entry->number);
+	g_free(entry->email);
+	g_free(entry->anr);
+	g_free(entry->sne);
+	g_free(entry);
+
+	return FALSE;
+}
+
+static void export_and_return(gboolean ok, struct cb_data *cbd)
+{
+	struct ofono_phonebook *pb =3D cbd->user;
+	ofono_phonebook_cb_t cb =3D cbd->cb;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	GSList *l;
+
+	DBG("phonebook fully read");
+
+	for (l =3D pbd->pb_refs; l !=3D NULL; l =3D l->next) {
+		struct pb_ref_rec *ref =3D l->data;
+
+		g_tree_foreach(ref->phonebook, export_entry, pb);
+		g_tree_destroy(ref->phonebook);
+		g_slist_free_full(ref->pending_records, g_free);
+		g_slist_free_full(ref->pb_files, g_free);
+	}
+
+	g_slist_free_full(pbd->pb_refs, g_free);
+	pbd->pb_refs =3D NULL;
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void read_record_cb(int ok, int total_length, int record,
+			const unsigned char *data,
+			int record_length, void *userdata)
+{
+	struct cb_data *cbd =3D userdata;
+	struct ofono_phonebook *pb =3D cbd->user;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_ref_rec *ref =3D pbd->pb_ref_next->data;
+	struct record_to_read *rec;
+
+	if (!ok) {
+		ofono_error("%s: error %d", __func__, ok);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	DBG("ok %d; total_length %d; record %d; record_length %d",
+		ok, total_length, record, record_length);
+
+	rec =3D ref->next_record->data;
+
+	/* This call might add elements to pending_records */
+	decode_read_response(rec, data, record_length, ref);
+
+	ref->pending_records =3D g_slist_remove(ref->pending_records, rec);
+	g_free(rec);
+
+	if (ref->pending_records) {
+		struct record_to_read *rec;
+
+		ref->next_record =3D ref->pending_records;
+		rec =3D ref->next_record->data;
+
+		ofono_sim_read_record(pbd->sim_context, rec->file_id,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					rec->record,
+					rec->record_length,
+					pbd->df_path, pbd->df_size,
+					read_record_cb, cbd);
+	} else {
+		/* Read files from next EF_PBR record, if any */
+
+		pbd->pb_ref_next =3D pbd->pb_ref_next->next;
+		if (pbd->pb_ref_next =3D=3D NULL) {
+			export_and_return(TRUE, cbd);
+		} else {
+			struct pb_ref_rec *ref;
+
+			DBG("Next EFpbr record");
+
+			ref =3D pbd->pb_ref_next->data;
+
+			if (!ref->pb_files) {
+				export_and_return(TRUE, cbd);
+			} else {
+				struct pb_file_info *file_info;
+
+				ref->pb_next =3D ref->pb_files;
+				file_info =3D ref->pb_files->data;
+
+				ofono_sim_read_info(pbd->sim_context,
+						file_info->file_id,
+						OFONO_SIM_FILE_STRUCTURE_FIXED,
+						pbd->df_path, pbd->df_size,
+						read_info_cb, cbd);
+			}
+		}
+	}
+}
+
+static void pb_adn_cb(int ok, int total_length, int record,
+			const unsigned char *data,
+			int record_length, void *userdata)
+{
+	struct cb_data *cbd =3D userdata;
+	struct ofono_phonebook *pb =3D cbd->user;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_ref_rec *ref =3D pbd->pb_ref_next->data;
+	GSList *l;
+
+	if (!ok) {
+		ofono_error("%s: error %d", __func__, ok);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	DBG("ok %d; total_length %d; record %d; record_length %d",
+		ok, total_length, record, record_length);
+
+	if (handle_adn(record_length, data, ref, record) !=3D NULL) {
+		/* Add type 1 records */
+		for (l =3D ref->pb_files; l; l =3D l->next) {
+			const struct pb_file_info *f_info =3D l->data;
+			struct record_to_read *ext_rec;
+
+			if (f_info->pbr_type =3D=3D TYPE_1_TAG &&
+					f_info->file_type !=3D TYPE_ADN) {
+				ext_rec =3D g_try_malloc0(sizeof(*ext_rec));
+				if (ext_rec =3D=3D NULL)
+					break;
+
+				ext_rec->file_id =3D f_info->file_id;
+				ext_rec->type_tag =3D f_info->file_type;
+				ext_rec->record_length =3D f_info->record_length;
+				ext_rec->record =3D record;
+				ext_rec->adn_idx =3D record;
+
+				ref->pending_records =3D
+					g_slist_prepend(ref->pending_records,
+							ext_rec);
+			}
+		}
+	}
+
+	if (record*record_length >=3D total_length) {
+		DBG("All ADN records read: reading additional files");
+
+		if (ref->pending_records) {
+			struct record_to_read *rec;
+
+			ref->next_record =3D ref->pending_records;
+			rec =3D ref->next_record->data;
+
+			ofono_sim_read_record(pbd->sim_context, rec->file_id,
+						OFONO_SIM_FILE_STRUCTURE_FIXED,
+						rec->record,
+						rec->record_length,
+						pbd->df_path, pbd->df_size,
+						read_record_cb, cbd);
+		} else {
+			export_and_return(TRUE, cbd);
+		}
+	}
+}
+
+static void read_info_cb(int ok, unsigned char file_status,
+				int total_length, int record_length,
+				void *userdata)
+{
+	struct cb_data *cbd =3D userdata;
+	struct ofono_phonebook *pb =3D cbd->user;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_file_info *file_info;
+	struct pb_ref_rec *ref =3D pbd->pb_ref_next->data;
+
+	file_info =3D ref->pb_next->data;
+	ref->pb_next =3D ref->pb_next->next;
+
+	if (ok) {
+		file_info->record_length =3D record_length;
+		file_info->file_length =3D total_length;
+
+		DBG("file id %x record length %d total_length %d",
+			file_info->file_id, record_length, total_length);
+	} else {
+		ofono_warn("%s: %x not found", __func__, file_info->file_id);
+		ref->pb_files =3D g_slist_remove(ref->pb_files, file_info);
+		g_free(file_info);
+	}
+
+	if (ref->pb_next =3D=3D NULL) {
+		if (ref->pb_files =3D=3D NULL) {
+			ofono_warn("%s: no phonebook on SIM", __func__);
+			export_and_return(FALSE, cbd);
+			return;
+		}
+
+		/* Read full contents of the master file */
+		file_info =3D ref->pb_files->data;
+
+		ofono_sim_read_path(pbd->sim_context, file_info->file_id,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					pbd->df_path, pbd->df_size,
+					pb_adn_cb, cbd);
+	} else {
+		file_info =3D ref->pb_next->data;
+
+		ofono_sim_read_info(pbd->sim_context, file_info->file_id,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					pbd->df_path, pbd->df_size,
+					read_info_cb, cbd);
+	}
+}
+
+static void start_sim_app_read(struct cb_data *cbd)
+{
+	struct ofono_phonebook *pb =3D cbd->user;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct pb_ref_rec *ref_rec;
+	struct pb_file_info *f_info;
+	struct pb_file_info *f_ext1;
+
+	pbd->df_path =3D sim_path;
+	pbd->df_size =3D sizeof(sim_path);
+
+	ref_rec =3D g_try_malloc0(sizeof(*ref_rec));
+	if (ref_rec =3D=3D NULL) {
+		ofono_error("%s: OOM", __func__);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	ref_rec->phonebook =3D g_tree_new(comp_int);
+
+	/* Only EF_ADN and EF_EXT1 read for SIM */
+
+	f_info =3D g_try_malloc0(sizeof(*f_info));
+	if (f_info =3D=3D NULL) {
+		ofono_error("%s: OOM", __func__);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	f_info->file_id =3D SIM_EFADN_FILEID;
+	f_info->pbr_type =3D TYPE_1_TAG;
+	f_info->file_type =3D TYPE_ADN;
+	ref_rec->pb_files =3D g_slist_append(ref_rec->pb_files, f_info);
+
+	f_ext1 =3D g_try_malloc0(sizeof(*f_ext1));
+	if (f_ext1 =3D=3D NULL) {
+		ofono_error("%s: OOM", __func__);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	f_ext1->file_id =3D SIM_EFEXT1_FILEID;
+	f_ext1->pbr_type =3D TYPE_3_TAG;
+	f_ext1->file_type =3D TYPE_EXT1;
+	ref_rec->pb_files =3D g_slist_append(ref_rec->pb_files, f_ext1);
+
+	pbd->pb_refs =3D g_slist_append(pbd->pb_refs, ref_rec);
+	pbd->pb_ref_next =3D pbd->pb_refs;
+
+	ref_rec->pb_next =3D ref_rec->pb_files;
+
+	/* Start reading process for MF */
+	ofono_sim_read_info(pbd->sim_context, f_info->file_id,
+				OFONO_SIM_FILE_STRUCTURE_FIXED,
+				pbd->df_path, pbd->df_size,
+				read_info_cb, cbd);
+}
+
+static void pb_reference_data_cb(int ok, int total_length, int record,
+					const unsigned char *sdata,
+					int record_length, void *userdata)
+{
+	struct cb_data *cbd =3D userdata;
+	struct ofono_phonebook *pb =3D cbd->user;
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	const unsigned char *ptr =3D sdata;
+	gboolean finished =3D FALSE;
+	struct pb_ref_rec *ref_rec;
+
+	DBG("total_length %d record %d record_length %d",
+		total_length, record, record_length);
+
+	if (!ok) {
+		/* We migh have a SIM instead of USIM application: try that */
+		DBG("%s: error %d, trying SIM files", __func__, ok);
+		start_sim_app_read(cbd);
+		return;
+	}
+
+	ref_rec =3D g_try_malloc0(sizeof(*ref_rec));
+	if (ref_rec =3D=3D NULL) {
+		ofono_error("%s: OOM", __func__);
+		export_and_return(FALSE, cbd);
+		return;
+	}
+
+	ref_rec->phonebook =3D g_tree_new(comp_int);
+
+	while (ptr < sdata + record_length && finished =3D=3D FALSE) {
+		int typelen, file_id, i;
+		enum constructed_tag pbr_type =3D *ptr;
+
+		switch (pbr_type) {
+		case TYPE_1_TAG:
+		case TYPE_2_TAG:
+		case TYPE_3_TAG:
+			typelen =3D *(ptr + 1);
+			DBG("File type=3D%02X, len=3D%d", *ptr, typelen);
+			ptr +=3D 2;
+			i =3D 0;
+
+			while (i < typelen) {
+				struct pb_file_info *file_info =3D
+					g_try_new0(struct pb_file_info, 1);
+				if (!file_info) {
+					ofono_error("%s: OOM", __func__);
+					export_and_return(FALSE, cbd);
+					return;
+				}
+
+				file_id =3D (ptr[i + 2] << 8) + ptr[i + 3];
+
+				DBG("creating file info for File type=3D%02X",
+					ptr[i]);
+				DBG("File ID=3D%04X", file_id);
+
+				file_info->pbr_type =3D pbr_type;
+				file_info->file_type =3D ptr[i];
+				file_info->file_id =3D file_id;
+				/* Keep order, important for type 2 files */
+				ref_rec->pb_files =3D
+					g_slist_append(ref_rec->pb_files,
+							file_info);
+				i +=3D ptr[i + 1] + 2;
+			}
+
+			ptr +=3D typelen;
+			break;
+		default:
+			DBG("All handled %02x", *ptr);
+			finished =3D TRUE;
+			break;
+		}
+	}
+
+	pbd->pb_refs =3D g_slist_append(pbd->pb_refs, ref_rec);
+
+	if (record*record_length >=3D total_length) {
+		struct pb_ref_rec *ref;
+		struct pb_file_info *file_info;
+
+		DBG("All EFpbr records read");
+
+		pbd->pb_ref_next =3D pbd->pb_refs;
+		ref =3D pbd->pb_ref_next->data;
+
+		if (ref->pb_files =3D=3D NULL) {
+			ofono_error("%s: no files to read", __func__);
+			export_and_return(FALSE, cbd);
+			return;
+		}
+
+		ref->pb_next =3D ref->pb_files;
+		file_info =3D ref->pb_files->data;
+
+		/* Start reading process for first EF_PBR entry */
+
+		ofono_sim_read_info(pbd->sim_context, file_info->file_id,
+					OFONO_SIM_FILE_STRUCTURE_FIXED,
+					pbd->df_path, pbd->df_size,
+					read_info_cb, cbd);
+	}
+}
+
+static void ril_export_entries(struct ofono_phonebook *pb,
+				const char *storage,
+				ofono_phonebook_cb_t cb, void *data)
+{
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+	struct cb_data *cbd;
+
+	DBG("Storage %s", storage);
+
+	/* Only for SIM memory */
+	if (strcmp(storage, "SM") !=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data, pb);
+
+	/* Assume USIM, change in case EF_PBR is not present */
+	pbd->df_path =3D usim_path;
+	pbd->df_size =3D sizeof(usim_path);
+
+	ofono_sim_read(pbd->sim_context, SIM_EFPBR_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			pb_reference_data_cb, cbd);
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_phonebook *pb =3D user_data;
+
+	ofono_phonebook_register(pb);
+	return FALSE;
+}
+
+static int ril_phonebook_probe(struct ofono_phonebook *pb,
+				unsigned int vendor, void *user)
+{
+	struct ofono_modem *modem =3D user;
+	struct pb_data *pd =3D g_try_new0(struct pb_data, 1);
+	if (pd =3D=3D NULL)
+		return -ENOMEM;
+
+	pd->sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	if (pd->sim =3D=3D NULL)
+		return -ENOENT;
+
+	pd->sim_context =3D ofono_sim_context_create(pd->sim);
+	if (pd->sim_context =3D=3D NULL)
+		return -ENOENT;
+
+	ofono_phonebook_set_data(pb, pd);
+
+	g_idle_add(ril_delayed_register, pb);
+
+	return 0;
+}
+
+static void ril_phonebook_remove(struct ofono_phonebook *pb)
+{
+	struct pb_data *pbd =3D ofono_phonebook_get_data(pb);
+
+	ofono_phonebook_set_data(pb, NULL);
+	ofono_sim_context_free(pbd->sim_context);
+
+	g_free(pbd);
+}
+
+static struct ofono_phonebook_driver driver =3D {
+	.name		=3D RILMODEM,
+	.probe		=3D ril_phonebook_probe,
+	.remove		=3D ril_phonebook_remove,
+	.export_entries	=3D ril_export_entries
+};
+
+void ril_phonebook_init(void)
+{
+	ofono_phonebook_driver_register(&driver);
+}
+
+void ril_phonebook_exit(void)
+{
+	ofono_phonebook_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
new file mode 100644
index 0000000..9153e5b
--- /dev/null
+++ b/drivers/rilmodem/radio-settings.c
@@ -0,0 +1,300 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Contact: Jussi Kangas <jussi.kangas@tieto.com>
+ *  Copyright (C) 2014 Canonical Ltd
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/radio-settings.h>
+
+#include "gril.h"
+
+#include "rilmodem.h"
+
+#include "grilrequest.h"
+#include "grilreply.h"
+#include "radio-settings.h"
+
+static void ril_set_rat_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(rd->ril, message);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s: rat mode setting failed", __func__);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+void ril_set_rat_mode(struct ofono_radio_settings *rs,
+			enum ofono_radio_access_mode mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+	struct parcel rilp;
+	int pref =3D PREF_NET_TYPE_GSM_WCDMA;
+
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		pref =3D PREF_NET_TYPE_LTE_GSM_WCDMA;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		pref =3D PREF_NET_TYPE_GSM_ONLY;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		pref =3D PREF_NET_TYPE_GSM_WCDMA;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		pref =3D PREF_NET_TYPE_LTE_GSM_WCDMA;
+		break;
+	}
+
+	g_ril_request_set_preferred_network_type(rd->ril, pref, &rilp);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_SET_PREFERRED_NETWORK_TYPE,
+				&rilp, ril_set_rat_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("%s: unable to set rat mode", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_rat_mode_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	int mode, pref;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: error %s", __func__,
+				ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	pref =3D g_ril_reply_parse_get_preferred_network_type(rd->ril, message);
+	if (pref < 0) {
+		ofono_error("%s: parse error", __func__);
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	/*
+	 * GSM_WCDMA_AUTO -> ril.h: GSM/WCDMA (auto mode, according to PRL)
+	 * PRL: preferred roaming list.
+	 * This value is returned when selecting the slot as having 3G
+	 * capabilities, so it is sort of the default for MTK modems.
+	 */
+
+	switch (pref) {
+	case PREF_NET_TYPE_GSM_WCDMA:
+	case PREF_NET_TYPE_GSM_WCDMA_AUTO:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case PREF_NET_TYPE_GSM_ONLY:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case PREF_NET_TYPE_LTE_GSM_WCDMA:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	default:
+		ofono_error("%s: Unexpected preferred network type (%d)",
+				__func__, pref);
+		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
+}
+
+void ril_query_rat_mode(struct ofono_radio_settings *rs,
+			ofono_radio_settings_rat_mode_query_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_GET_PREFERRED_NETWORK_TYPE,
+				NULL, ril_rat_mode_cb, cbd, g_free) =3D=3D 0) {
+		ofono_error("%s: unable to send rat mode query", __func__);
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	}
+}
+
+void ril_query_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+
+	CALLBACK_WITH_SUCCESS(cb, rd->fast_dormancy, data);
+}
+
+static void ril_display_state_cb(struct ril_msg *message, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_fast_dormancy_set_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(rd->ril, message);
+
+		rd->fast_dormancy =3D rd->pending_fd;
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+void ril_set_fast_dormancy(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+	struct parcel rilp;
+
+	g_ril_request_screen_state(rd->ril, enable ? 0 : 1, &rilp);
+
+	rd->pending_fd =3D enable;
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_SCREEN_STATE, &rilp,
+			ril_display_state_cb, cbd, g_free) <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static ofono_bool_t query_available_rats_cb(gpointer user_data)
+{
+	unsigned int available_rats;
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_available_rats_query_cb_t cb =3D cbd->cb;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+
+	available_rats =3D OFONO_RADIO_ACCESS_MODE_GSM
+				| OFONO_RADIO_ACCESS_MODE_UMTS;
+
+	if (ofono_modem_get_boolean(rd->modem, MODEM_PROP_LTE_CAPABLE))
+		available_rats |=3D OFONO_RADIO_ACCESS_MODE_LTE;
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, cbd->data);
+
+	g_free(cbd);
+
+	return FALSE;
+}
+
+void ril_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data)
+{
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+
+	g_idle_add(query_available_rats_cb, cbd);
+}
+
+void ril_delayed_register(const struct ofono_error *error, void *user_data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_radio_settings_register(rs);
+	else
+		ofono_error("%s: cannot set default fast dormancy", __func__);
+}
+
+static int ril_radio_settings_probe(struct ofono_radio_settings *rs,
+					unsigned int vendor, void *user)
+{
+	struct ril_radio_settings_driver_data *rs_init_data =3D user;
+	struct radio_data *rsd =3D g_try_new0(struct radio_data, 1);
+
+	if (rsd =3D=3D NULL) {
+		ofono_error("%s: cannot allocate memory", __func__);
+		return -ENOMEM;
+	}
+
+	rsd->ril =3D g_ril_clone(rs_init_data->gril);
+	rsd->modem =3D rs_init_data->modem;
+
+	ofono_radio_settings_set_data(rs, rsd);
+
+	ril_set_fast_dormancy(rs, FALSE, ril_delayed_register, rs);
+
+	return 0;
+}
+
+void ril_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_set_data(rs, NULL);
+
+	g_ril_unref(rd->ril);
+	g_free(rd);
+}
+
+static struct ofono_radio_settings_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_radio_settings_probe,
+	.remove			=3D ril_radio_settings_remove,
+	.query_rat_mode		=3D ril_query_rat_mode,
+	.set_rat_mode		=3D ril_set_rat_mode,
+	.query_fast_dormancy	=3D ril_query_fast_dormancy,
+	.set_fast_dormancy	=3D ril_set_fast_dormancy,
+	.query_available_rats	=3D ril_query_available_rats
+};
+
+void ril_radio_settings_init(void)
+{
+	ofono_radio_settings_driver_register(&driver);
+}
+
+void ril_radio_settings_exit(void)
+{
+	ofono_radio_settings_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/radio-settings.h b/drivers/rilmodem/radio-set=
tings.h
new file mode 100644
index 0000000..727d538
--- /dev/null
+++ b/drivers/rilmodem/radio-settings.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+struct radio_data {
+	GRil *ril;
+	struct ofono_modem *modem;
+	gboolean fast_dormancy;
+	gboolean pending_fd;
+};
+
+void ril_delayed_register(const struct ofono_error *error, void *user_data=
);
+void ril_radio_settings_remove(struct ofono_radio_settings *rs);
+void ril_query_rat_mode(struct ofono_radio_settings *rs,
+			ofono_radio_settings_rat_mode_query_cb_t cb,
+			void *data);
+void ril_set_rat_mode(struct ofono_radio_settings *rs,
+			enum ofono_radio_access_mode mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *data);
+void ril_query_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data);
+void ril_set_fast_dormancy(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data);
+void ril_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data);
diff --git a/drivers/rilmodem/rilmodem.c b/drivers/rilmodem/rilmodem.c
new file mode 100644
index 0000000..e693563
--- /dev/null
+++ b/drivers/rilmodem/rilmodem.c
@@ -0,0 +1,78 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012 Canonical, Ltd. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gril.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#include "rilmodem.h"
+
+static int rilmodem_init(void)
+{
+	DBG("");
+
+	ril_devinfo_init();
+	ril_sim_init();
+	ril_voicecall_init();
+	ril_sms_init();
+	ril_netreg_init();
+	ril_call_volume_init();
+	ril_gprs_init();
+	ril_gprs_context_init();
+	ril_ussd_init();
+	ril_call_settings_init();
+	ril_call_forwarding_init();
+	ril_radio_settings_init();
+	ril_call_barring_init();
+
+	return 0;
+}
+
+static void rilmodem_exit(void)
+{
+	DBG("");
+
+	ril_devinfo_exit();
+	ril_sim_exit();
+	ril_voicecall_exit();
+	ril_sms_exit();
+	ril_netreg_exit();
+	ril_call_volume_exit();
+	ril_gprs_exit();
+	ril_gprs_context_exit();
+	ril_ussd_exit();
+	ril_call_settings_exit();
+	ril_call_forwarding_exit();
+	ril_radio_settings_exit();
+	ril_call_barring_exit();
+}
+
+OFONO_PLUGIN_DEFINE(rilmodem, "RIL modem driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, rilmodem_init, rilmodem_exit)
diff --git a/drivers/rilmodem/rilmodem.h b/drivers/rilmodem/rilmodem.h
new file mode 100644
index 0000000..987ce3c
--- /dev/null
+++ b/drivers/rilmodem/rilmodem.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012 Canonical Ltd.
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
+#include "rilutil.h"
+
+#define RILMODEM "rilmodem"
+
+/* Shared constants */
+#define EF_STATUS_INVALIDATED 0
+#define EF_STATUS_VALID 1
+
+extern void ril_devinfo_init(void);
+extern void ril_devinfo_exit(void);
+
+extern void ril_call_volume_init(void);
+extern void ril_call_volume_exit(void);
+
+extern void ril_voicecall_init(void);
+extern void ril_voicecall_exit(void);
+
+extern void ril_sim_init(void);
+extern void ril_sim_exit(void);
+
+extern void ril_sms_init(void);
+extern void ril_sms_exit(void);
+
+extern void ril_netreg_init(void);
+extern void ril_netreg_exit(void);
+
+extern void ril_gprs_init(void);
+extern void ril_gprs_exit(void);
+
+extern void ril_gprs_context_init(void);
+extern void ril_gprs_context_exit(void);
+
+extern void ril_ussd_init(void);
+extern void ril_ussd_exit(void);
+
+extern void ril_call_settings_init(void);
+extern void ril_call_settings_exit(void);
+
+extern void ril_call_forwarding_init(void);
+extern void ril_call_forwarding_exit(void);
+
+extern void ril_radio_settings_init(void);
+extern void ril_radio_settings_exit(void);
+
+extern void ril_call_barring_init(void);
+extern void ril_call_barring_exit(void);
+
+extern void ril_phonebook_init(void);
+extern void ril_phonebook_exit(void);
diff --git a/drivers/rilmodem/rilutil.c b/drivers/rilmodem/rilutil.c
new file mode 100644
index 0000000..c173940
--- /dev/null
+++ b/drivers/rilmodem/rilutil.c
@@ -0,0 +1,194 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gril.h>
+#include <string.h>
+#include <stdlib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#include "common.h"
+#include "rilutil.h"
+#include "simutil.h"
+#include "util.h"
+#include "ril_constants.h"
+
+struct ril_util_sim_state_query {
+	GRil *ril;
+	guint cpin_poll_source;
+	guint cpin_poll_count;
+	guint interval;
+	guint num_times;
+	ril_util_sim_inserted_cb_t cb;
+	void *userdata;
+	GDestroyNotify destroy;
+};
+
+static gboolean cpin_check(gpointer userdata);
+
+void decode_ril_error(struct ofono_error *error, const char *final)
+{
+	if (!strcmp(final, "OK")) {
+		error->type =3D OFONO_ERROR_TYPE_NO_ERROR;
+		error->error =3D 0;
+	} else {
+		error->type =3D OFONO_ERROR_TYPE_FAILURE;
+		error->error =3D 0;
+	}
+}
+
+gint ril_util_call_compare_by_status(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	int status =3D GPOINTER_TO_INT(b);
+
+	if (status !=3D call->status)
+		return 1;
+
+	return 0;
+}
+
+gint ril_util_call_compare_by_phone_number(gconstpointer a, gconstpointer =
b)
+{
+	const struct ofono_call *call =3D a;
+	const struct ofono_phone_number *pb =3D b;
+
+	return memcmp(&call->phone_number, pb,
+				sizeof(struct ofono_phone_number));
+}
+
+gint ril_util_call_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *call =3D a;
+	unsigned int id =3D GPOINTER_TO_UINT(b);
+
+	if (id < call->id)
+		return -1;
+
+	if (id > call->id)
+		return 1;
+
+	return 0;
+}
+
+gint ril_util_call_compare(gconstpointer a, gconstpointer b)
+{
+	const struct ofono_call *ca =3D a;
+	const struct ofono_call *cb =3D b;
+
+	if (ca->id < cb->id)
+		return -1;
+
+	if (ca->id > cb->id)
+		return 1;
+
+	return 0;
+}
+
+static gboolean cpin_check(gpointer userdata)
+{
+	struct ril_util_sim_state_query *req =3D userdata;
+
+	req->cpin_poll_source =3D 0;
+
+	return FALSE;
+}
+
+gchar *ril_util_get_netmask(const gchar *address)
+{
+	char *result;
+
+	if (g_str_has_suffix(address, "/30")) {
+		result =3D PREFIX_30_NETMASK;
+	} else if (g_str_has_suffix(address, "/29")) {
+		result =3D PREFIX_29_NETMASK;
+	} else if (g_str_has_suffix(address, "/28")) {
+		result =3D PREFIX_28_NETMASK;
+	} else if (g_str_has_suffix(address, "/27")) {
+		result =3D PREFIX_27_NETMASK;
+	} else if (g_str_has_suffix(address, "/26")) {
+		result =3D PREFIX_26_NETMASK;
+	} else if (g_str_has_suffix(address, "/25")) {
+		result =3D PREFIX_25_NETMASK;
+	} else if (g_str_has_suffix(address, "/24")) {
+		result =3D PREFIX_24_NETMASK;
+	} else {
+		/*
+		 * This handles the case where the
+		 * Samsung RILD returns an address without
+		 * a prefix, however it explicitly sets a
+		 * /24 netmask ( which isn't returned as
+		 * an attribute of the DATA_CALL.
+		 *
+		 * TODO/OEM: this might need to be quirked
+		 * for specific devices.
+		 */
+		result =3D PREFIX_24_NETMASK;
+	}
+
+	DBG("address: %s netmask: %s", address, result);
+
+	return result;
+}
+
+struct ril_util_sim_state_query *ril_util_sim_state_query_new(GRil *ril,
+						guint interval, guint num_times,
+						ril_util_sim_inserted_cb_t cb,
+						void *userdata,
+						GDestroyNotify destroy)
+{
+	struct ril_util_sim_state_query *req;
+
+	req =3D g_new0(struct ril_util_sim_state_query, 1);
+
+	req->ril =3D ril;
+	req->interval =3D interval;
+	req->num_times =3D num_times;
+	req->cb =3D cb;
+	req->userdata =3D userdata;
+	req->destroy =3D destroy;
+
+	cpin_check(req);
+
+	return req;
+}
+
+void ril_util_sim_state_query_free(struct ril_util_sim_state_query *req)
+{
+	if (req =3D=3D NULL)
+		return;
+
+	if (req->cpin_poll_source > 0)
+		g_source_remove(req->cpin_poll_source);
+
+	if (req->destroy)
+		req->destroy(req->userdata);
+
+	g_free(req);
+}
diff --git a/drivers/rilmodem/rilutil.h b/drivers/rilmodem/rilutil.h
new file mode 100644
index 0000000..25aed2e
--- /dev/null
+++ b/drivers/rilmodem/rilutil.h
@@ -0,0 +1,165 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  Canonical Ltd.
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
+#ifndef RILUTIL_H
+#define RILUTIL_H
+
+#include <stdio.h>
+#include <modem.h>
+#include <sim.h>
+#include <gprs-context.h>
+
+/* TODO: create a table lookup*/
+#define PREFIX_30_NETMASK "255.255.255.252"
+#define PREFIX_29_NETMASK "255.255.255.248"
+#define PREFIX_28_NETMASK "255.255.255.240"
+#define PREFIX_27_NETMASK "255.255.255.224"
+#define PREFIX_26_NETMASK "255.255.255.192"
+#define PREFIX_25_NETMASK "255.255.255.128"
+#define PREFIX_24_NETMASK "255.255.255.0"
+
+#define MODEM_PROP_LTE_CAPABLE "lte-capable"
+
+enum ril_util_sms_store {
+	RIL_UTIL_SMS_STORE_SM =3D	0,
+	RIL_UTIL_SMS_STORE_ME =3D	1,
+	RIL_UTIL_SMS_STORE_MT =3D	2,
+	RIL_UTIL_SMS_STORE_SR =3D	3,
+	RIL_UTIL_SMS_STORE_BM =3D	4,
+};
+
+/* 3GPP TS 27.007 Release 8 Section 5.5 */
+enum at_util_charset {
+	RIL_UTIL_CHARSET_GSM =3D		0x1,
+	RIL_UTIL_CHARSET_HEX =3D		0x2,
+	RIL_UTIL_CHARSET_IRA =3D		0x4,
+	RIL_UTIL_CHARSET_PCCP437 =3D	0x8,
+	RIL_UTIL_CHARSET_PCDN =3D		0x10,
+	RIL_UTIL_CHARSET_UCS2 =3D		0x20,
+	RIL_UTIL_CHARSET_UTF8 =3D		0x40,
+	RIL_UTIL_CHARSET_8859_1 =3D	0x80,
+	RIL_UTIL_CHARSET_8859_2 =3D	0x100,
+	RIL_UTIL_CHARSET_8859_3 =3D	0x200,
+	RIL_UTIL_CHARSET_8859_4 =3D	0x400,
+	RIL_UTIL_CHARSET_8859_5 =3D	0x800,
+	RIL_UTIL_CHARSET_8859_6 =3D	0x1000,
+	RIL_UTIL_CHARSET_8859_C =3D	0x2000,
+	RIL_UTIL_CHARSET_8859_A =3D	0x4000,
+	RIL_UTIL_CHARSET_8859_G =3D	0x8000,
+	RIL_UTIL_CHARSET_8859_H =3D	0x10000,
+};
+
+struct ril_sim_data {
+	struct ofono_modem *modem;
+	GRil *gril;
+	ofono_sim_state_event_cb_t ril_state_watch;
+};
+
+struct ril_gprs_context_data {
+	GRil *gril;
+	struct ofono_modem *modem;
+	enum ofono_gprs_context_type type;
+};
+
+struct ril_voicecall_driver_data {
+	GRil *gril;
+	struct ofono_modem *modem;
+};
+
+struct ril_gprs_driver_data {
+	GRil *gril;
+	struct ofono_modem *modem;
+};
+
+struct ril_radio_settings_driver_data {
+	GRil *gril;
+	struct ofono_modem *modem;
+};
+
+typedef void (*ril_util_sim_inserted_cb_t)(gboolean present, void *userdat=
a);
+
+void decode_ril_error(struct ofono_error *error, const char *final);
+gint ril_util_call_compare_by_status(gconstpointer a, gconstpointer b);
+gint ril_util_call_compare_by_phone_number(gconstpointer a, gconstpointer =
b);
+gint ril_util_call_compare_by_id(gconstpointer a, gconstpointer b);
+gint ril_util_call_compare(gconstpointer a, gconstpointer b);
+gchar *ril_util_get_netmask(const char *address);
+
+struct ril_util_sim_state_query *ril_util_sim_state_query_new(GRil *ril,
+						guint interval, guint num_times,
+						ril_util_sim_inserted_cb_t cb,
+						void *userdata,
+						GDestroyNotify destroy);
+void ril_util_sim_state_query_free(struct ril_util_sim_state_query *req);
+
+struct cb_data {
+	void *cb;
+	void *data;
+	void *user;
+};
+
+static inline struct cb_data *cb_data_new(void *cb, void *data, void *user)
+{
+	struct cb_data *ret;
+
+	ret =3D g_new0(struct cb_data, 1);
+	ret->cb =3D cb;
+	ret->data =3D data;
+	ret->user =3D user;
+
+	return ret;
+}
+
+static inline int ril_util_convert_signal_strength(int strength)
+{
+	int result;
+
+	if (strength =3D=3D 99)
+		result =3D -1;
+	else
+		result =3D (strength * 100) / 31;
+
+	return result;
+}
+
+#define DECLARE_FAILURE(e)			\
+	struct ofono_error e;			\
+	e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
+	e.error =3D 0				\
+
+#define CALLBACK_WITH_FAILURE(cb, args...)		\
+	do {						\
+		struct ofono_error cb_e;		\
+		cb_e.type =3D OFONO_ERROR_TYPE_FAILURE;	\
+		cb_e.error =3D 0;				\
+							\
+		cb(&cb_e, ##args);			\
+	} while (0)					\
+
+#define CALLBACK_WITH_SUCCESS(f, args...)		\
+	do {						\
+		struct ofono_error e;			\
+		e.type =3D OFONO_ERROR_TYPE_NO_ERROR;	\
+		e.error =3D 0;				\
+		f(&e, ##args);				\
+	} while (0)
+
+#endif /* RILUTIL_H */
diff --git a/drivers/rilmodem/sim.c b/drivers/rilmodem/sim.c
new file mode 100644
index 0000000..178cb97
--- /dev/null
+++ b/drivers/rilmodem/sim.c
@@ -0,0 +1,1200 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Canonical, Ltd. All rights reserved.
+ *  Copyright (C) 2015 Ratchanan Srirattanamet.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+
+#include "ofono.h"
+
+#include "simutil.h"
+#include "util.h"
+
+#include "gril.h"
+#include "grilutil.h"
+#include "parcel.h"
+#include "ril_constants.h"
+#include "rilmodem.h"
+
+#include "grilreply.h"
+#include "grilrequest.h"
+#include "grilunsol.h"
+
+#include "drivers/infineonmodem/infineon_constants.h"
+
+/* Number of passwords in EPINC response */
+#define MTK_EPINC_NUM_PASSWD 4
+
+/*
+ * Based on ../drivers/atmodem/sim.c.
+ *
+ * TODO:
+ * 1. Defines constants for hex literals
+ * 2. Document P1-P3 usage (+CSRM)
+ */
+
+/*
+ * TODO: CDMA/IMS
+ *
+ * This code currently only grabs the AID/application ID from
+ * the gsm_umts application on the SIM card.  This code will
+ * need to be modified for CDMA support, and possibly IMS-based
+ * applications.  In this case, app_id should be changed to an
+ * array or HashTable of app_status structures.
+ *
+ * The same applies to the app_type.
+ */
+
+static void ril_pin_change_state(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data);
+
+struct sim_data {
+	GRil *ril;
+	enum ofono_ril_vendor vendor;
+	gchar *aid_str;
+	guint app_type;
+	gchar *app_str;
+	guint app_index;
+	enum ofono_sim_password_type passwd_type;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	enum ofono_sim_password_type passwd_state;
+	struct ofono_modem *modem;
+	ofono_sim_state_event_cb_t ril_state_watch;
+	ofono_bool_t unlock_pending;
+};
+
+struct change_state_cbd {
+	struct ofono_sim *sim;
+	enum ofono_sim_password_type passwd_type;
+	int enable;
+	const char *passwd;
+	ofono_sim_lock_unlock_cb_t cb;
+	void *data;
+};
+
+static void send_get_sim_status(struct ofono_sim *sim);
+
+static void ril_file_info_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_file_info_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct ofono_error error;
+	gboolean ok =3D FALSE;
+	int sw1, sw2;
+	int flen =3D 0, rlen =3D 0, str =3D 0;
+	guchar access[3] =3D { 0x00, 0x00, 0x00 };
+	guchar file_status =3D EF_STATUS_VALID;
+	struct reply_sim_io *reply =3D NULL;
+
+	/* Error, and no data */
+	if (message->error !=3D RIL_E_SUCCESS && message->buf_len =3D=3D 0) {
+		ofono_error("%s: Reply failure: %s", __func__,
+				ril_error_to_string(message->error));
+		decode_ril_error(&error, "FAIL");
+		goto error;
+	}
+
+	/*
+	 * The reply can have event data even when message->error is not zero
+	 * in mako.
+	 */
+	reply =3D g_ril_reply_parse_sim_io(sd->ril, message);
+	if (reply =3D=3D NULL) {
+		decode_ril_error(&error, "FAIL");
+		goto error;
+	}
+
+	sw1 =3D reply->sw1;
+	sw2 =3D reply->sw2;
+
+	/*
+	 * SIM app file not found || USIM app file not found
+	 * See 3gpp TS 51.011, 9.4.4, and ETSI TS 102 221, 10.2.1.5.3
+	 * This can happen with result SUCCESS (maguro) or GENERIC_FAILURE
+	 * (mako)
+	 */
+	if ((sw1 =3D=3D 0x94 && sw2 =3D=3D 0x04) || (sw1 =3D=3D 0x6A && sw2 =3D=
=3D 0x82)) {
+		DBG("File not found. Error %s",
+			ril_error_to_string(message->error));
+		decode_ril_error(&error, "FAIL");
+		goto error;
+	}
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		ofono_error("%s: Reply failure: %s, %02x, %02x", __func__,
+				ril_error_to_string(message->error), sw1, sw2);
+		decode_ril_error(&error, "FAIL");
+		goto error;
+	}
+
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		ofono_error("Error reply, invalid values: sw1: %02x sw2: %02x",
+				sw1, sw2);
+
+		/* TODO: fix decode_ril_error to take type & error */
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		goto error;
+	}
+
+	if (reply->hex_len) {
+		if (reply->hex_response[0] =3D=3D 0x62) {
+			ok =3D sim_parse_3g_get_response(reply->hex_response,
+							reply->hex_len,
+							&flen, &rlen, &str,
+							access, NULL);
+		} else {
+			ok =3D sim_parse_2g_get_response(reply->hex_response,
+							reply->hex_len,
+							&flen, &rlen, &str,
+							access, &file_status);
+		}
+	}
+
+	if (!ok) {
+		ofono_error("%s: parse response failed", __func__);
+		decode_ril_error(&error, "FAIL");
+		goto error;
+	}
+
+	cb(&error, flen, str, rlen, access, file_status, cbd->data);
+
+	g_ril_reply_free_sim_io(reply);
+
+	return;
+
+error:
+	g_ril_reply_free_sim_io(reply);
+
+	cb(&error, -1, -1, -1, NULL, EF_STATUS_INVALIDATED, cbd->data);
+}
+
+static void ril_sim_read_info(struct ofono_sim *sim, int fileid,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_file_info_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+	struct req_sim_read_info req;
+	guint ret =3D 0;
+
+	DBG("file %04x", fileid);
+
+	req.app_type =3D sd->app_type;
+	req.aid_str =3D sd->aid_str;
+	req.fileid =3D fileid;
+	req.path =3D path;
+	req.path_len =3D path_len;
+
+	if (!g_ril_request_sim_read_info(sd->ril,
+					&req,
+					&rilp)) {
+		ofono_error("Couldn't build SIM read info request");
+		goto error;
+	}
+
+	g_ril_append_print_buf(sd->ril,
+				"%s0,0,15,(null),pin2=3D(null),aid=3D%s)",
+				print_buf,
+				sd->aid_str);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SIM_IO, &rilp,
+				ril_file_info_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
+				EF_STATUS_INVALIDATED, data);
+	}
+}
+
+static void ril_file_io_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct ofono_error error;
+	struct reply_sim_io *reply;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		ofono_error("RILD reply failure: %s",
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_sim_io(sd->ril, message);
+	if (reply =3D=3D NULL) {
+		ofono_error("Can't parse SIM IO response from RILD");
+		goto error;
+	}
+
+	if (reply->hex_len =3D=3D 0) {
+		ofono_error("Null SIM IO response from RILD");
+		g_ril_reply_free_sim_io(reply);
+		goto error;
+	}
+
+	cb(&error, reply->hex_response, reply->hex_len, cbd->data);
+
+	g_ril_reply_free_sim_io(reply);
+
+	return;
+
+error:
+	decode_ril_error(&error, "FAIL");
+	cb(&error, NULL, 0, cbd->data);
+}
+
+static void ril_file_write_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_write_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct reply_sim_io *reply;
+	int sw1, sw2;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s: RILD reply failure: %s",
+				__func__, ril_error_to_string(message->error));
+		goto error;
+	}
+
+	reply =3D g_ril_reply_parse_sim_io(sd->ril, message);
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: Can't parse SIM IO response", __func__);
+		goto error;
+	}
+
+	sw1 =3D reply->sw1;
+	sw2 =3D reply->sw2;
+
+	g_ril_reply_free_sim_io(reply);
+
+	if ((sw1 !=3D 0x90 && sw1 !=3D 0x91 && sw1 !=3D 0x92 && sw1 !=3D 0x9f) ||
+			(sw1 =3D=3D 0x90 && sw2 !=3D 0x00)) {
+		struct ofono_error error;
+
+		ofono_error("%s: error sw1 %02x sw2 %02x", __func__, sw1, sw2);
+
+		error.type =3D OFONO_ERROR_TYPE_SIM;
+		error.error =3D (sw1 << 8) | sw2;
+
+		cb(&error, cbd->data);
+
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void ril_sim_read_binary(struct ofono_sim *sim, int fileid,
+				int start, int length,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+	struct req_sim_read_binary req;
+	gint ret =3D 0;
+
+	DBG("file %04x", fileid);
+
+	req.app_type =3D sd->app_type;
+	req.aid_str =3D sd->aid_str;
+	req.fileid =3D fileid;
+	req.path =3D path;
+	req.path_len =3D path_len;
+	req.start =3D start;
+	req.length =3D length;
+
+	if (!g_ril_request_sim_read_binary(sd->ril,
+						&req,
+						&rilp)) {
+		ofono_error("Couldn't build SIM read binary request");
+		goto error;
+	}
+
+	g_ril_append_print_buf(sd->ril,
+				"%s%d,%d,%d,(null),pin2=3D(null),aid=3D%s)",
+				print_buf,
+				(start >> 8),
+				(start & 0xff),
+				length,
+				sd->aid_str);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SIM_IO, &rilp,
+				ril_file_io_cb, cbd, g_free);
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	}
+}
+
+static void ril_sim_read_record(struct ofono_sim *sim, int fileid,
+				int record, int length,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_read_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+	struct req_sim_read_record req;
+	guint ret =3D 0;
+
+	DBG("file %04x", fileid);
+
+	req.app_type =3D sd->app_type;
+	req.aid_str =3D sd->aid_str;
+	req.fileid =3D fileid;
+	req.path =3D path;
+	req.path_len =3D path_len;
+	req.record =3D record;
+	req.length =3D length;
+
+	if (!g_ril_request_sim_read_record(sd->ril,
+						&req,
+						&rilp)) {
+		ofono_error("Couldn't build SIM read record request");
+		goto error;
+	}
+
+	g_ril_append_print_buf(sd->ril,
+				"%s%d,%d,%d,(null),pin2=3D(null),aid=3D%s)",
+				print_buf,
+				record,
+				4,
+				length,
+				sd->aid_str);
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SIM_IO, &rilp,
+				ril_file_io_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
+	}
+}
+
+static void ril_sim_update_binary(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					const unsigned char *value,
+					const unsigned char *path,
+					unsigned int path_len,
+					ofono_sim_write_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+	struct req_sim_write_binary req;
+	guint ret =3D 0;
+
+	DBG("file 0x%04x", fileid);
+
+	req.app_type =3D sd->app_type;
+	req.aid_str =3D sd->aid_str;
+	req.fileid =3D fileid;
+	req.path =3D path;
+	req.path_len =3D path_len;
+	req.start =3D start;
+	req.length =3D length;
+	req.data =3D value;
+
+	if (!g_ril_request_sim_write_binary(sd->ril, &req, &rilp)) {
+		ofono_error("%s: Couldn't build SIM write request", __func__);
+		goto error;
+	}
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SIM_IO, &rilp,
+				ril_file_write_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void update_record(struct ofono_sim *sim, int fileid,
+				enum req_record_access_mode mode,
+				int record, int length,
+				const unsigned char *value,
+				const unsigned char *path,
+				unsigned int path_len,
+				ofono_sim_write_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+	struct req_sim_write_record req;
+	guint ret =3D 0;
+
+	DBG("file 0x%04x", fileid);
+
+	req.app_type =3D sd->app_type;
+	req.aid_str =3D sd->aid_str;
+	req.fileid =3D fileid;
+	req.path =3D path;
+	req.path_len =3D path_len;
+	req.mode =3D mode;
+	req.record =3D record;
+	req.length =3D length;
+	req.data =3D value;
+
+	if (!g_ril_request_sim_write_record(sd->ril, &req, &rilp)) {
+		ofono_error("%s: Couldn't build SIM write request", __func__);
+		goto error;
+	}
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SIM_IO, &rilp,
+				ril_file_write_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_sim_update_record(struct ofono_sim *sim, int fileid,
+					int record, int length,
+					const unsigned char *value,
+					const unsigned char *path,
+					unsigned int path_len,
+					ofono_sim_write_cb_t cb, void *data)
+{
+	update_record(sim, fileid, GRIL_REC_ACCESS_MODE_ABSOLUTE, record,
+			length, value, path, path_len, cb, data);
+}
+
+static void ril_sim_update_cyclic(struct ofono_sim *sim, int fileid,
+					int length, const unsigned char *value,
+					const unsigned char *path,
+					unsigned int path_len,
+					ofono_sim_write_cb_t cb, void *data)
+{
+	/* Only mode valid for cyclic files is PREVIOUS */
+	update_record(sim, fileid, GRIL_REC_ACCESS_MODE_PREVIOUS, 0,
+			length, value, path, path_len, cb, data);
+}
+
+static void ril_imsi_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct ofono_error error;
+	gchar *imsi;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		DBG("GET IMSI reply - OK");
+		decode_ril_error(&error, "OK");
+	} else {
+		ofono_error("Reply failure: %s",
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	imsi =3D g_ril_reply_parse_imsi(sd->ril, message);
+	if (imsi =3D=3D NULL) {
+		ofono_error("Error empty IMSI");
+		goto error;
+	}
+
+	cb(&error, imsi, cbd->data);
+	g_free(imsi);
+
+	return;
+
+error:
+	decode_ril_error(&error, "FAIL");
+	cb(&error, NULL, cbd->data);
+}
+
+static void ril_read_imsi(struct ofono_sim *sim, ofono_sim_imsi_cb_t cb,
+				void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+	struct parcel rilp;
+
+	g_ril_request_read_imsi(sd->ril, sd->aid_str, &rilp);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_GET_IMSI, &rilp,
+			ril_imsi_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+	}
+}
+
+static void configure_active_app(struct sim_data *sd,
+					struct reply_sim_app *app,
+					guint index)
+{
+	g_free(sd->aid_str);
+	g_free(sd->app_str);
+	sd->app_type =3D app->app_type;
+	sd->aid_str =3D g_strdup(app->aid_str);
+	sd->app_str =3D g_strdup(app->app_str);
+	sd->app_index =3D index;
+
+	DBG("setting aid_str (AID) to: %s", sd->aid_str);
+	switch (app->app_state) {
+	case RIL_APPSTATE_PIN:
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		break;
+	case RIL_APPSTATE_PUK:
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		break;
+	case RIL_APPSTATE_SUBSCRIPTION_PERSO:
+		switch (app->perso_substate) {
+		case RIL_PERSOSUBSTATE_SIM_NETWORK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHNET_PIN;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_NETWORK_SUBSET:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHNETSUB_PIN;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_CORPORATE:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHCORP_PIN;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_SERVICE_PROVIDER:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHSP_PIN;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_SIM:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHSIM_PIN;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_NETWORK_PUK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHNET_PUK;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_NETWORK_SUBSET_PUK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHNETSUB_PUK;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_CORPORATE_PUK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHCORP_PUK;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_SERVICE_PROVIDER_PUK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHSP_PUK;
+			break;
+		case RIL_PERSOSUBSTATE_SIM_SIM_PUK:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_PHFSIM_PUK;
+			break;
+		default:
+			sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+			break;
+		};
+		break;
+	case RIL_APPSTATE_READY:
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+		break;
+	case RIL_APPSTATE_UNKNOWN:
+	case RIL_APPSTATE_DETECTED:
+	default:
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+		break;
+	}
+}
+
+static void sim_status_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct reply_sim_status *status;
+	guint search_index;
+
+	status =3D g_ril_reply_parse_sim_status(sd->ril, message);
+	if (status =3D=3D NULL) {
+		ofono_error("%s: Cannot parse SIM status reply", __func__);
+		return;
+	}
+
+	DBG("SIM status is %u", status->card_state);
+
+	if (status->card_state =3D=3D RIL_CARDSTATE_PRESENT)
+		ofono_sim_inserted_notify(sim, TRUE);
+	else if (status && status->card_state =3D=3D RIL_CARDSTATE_ABSENT)
+		ofono_sim_inserted_notify(sim, FALSE);
+	else
+		ofono_error("%s: bad SIM state (%u)",
+				__func__, status->card_state);
+
+	if (status->card_state =3D=3D RIL_CARDSTATE_PRESENT) {
+		/*
+		 * TODO(CDMA): need some kind of logic
+		 * to set the correct app_index
+		 */
+		search_index =3D status->gsm_umts_index;
+		if (search_index < status->num_apps) {
+			struct reply_sim_app *app =3D status->apps[search_index];
+
+			if (app->app_type !=3D RIL_APPTYPE_UNKNOWN) {
+				/*
+				 * We cache the current password state. Ideally
+				 * this should be done by issuing a
+				 * GET_SIM_STATUS request from
+				 * ril_query_passwd_state, which is called by
+				 * the core after sending a password, but
+				 * unfortunately the response to GET_SIM_STATUS
+				 * is not reliable in mako when sent just after
+				 * sending the password. Some time is needed
+				 * before the modem refreshes its internal
+				 * state, and when it does it sends a
+				 * SIM_STATUS_CHANGED event. In that moment we
+				 * retrieve the status and this function is
+				 * executed. We call __ofono_sim_recheck_pin as
+				 * it is the only way to indicate the core to
+				 * call query_passwd_state again. An option
+				 * that can be explored in the future is wait
+				 * before invoking core callback for send_passwd
+				 * until we know the real password state.
+				 */
+				configure_active_app(sd, app, search_index);
+				DBG("passwd_state: %d", sd->passwd_state);
+
+				/*
+				 * Note: There doesn't seem to be any other way
+				 * to force the core SIM code to recheck the
+				 * PIN. This call causes the core to call this
+				 * atom's query_passwd() function.
+				 */
+				__ofono_sim_recheck_pin(sim);
+			}
+		}
+	}
+
+	g_ril_reply_free_sim_status(status);
+}
+
+static void send_get_sim_status(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	g_ril_send(sd->ril, RIL_REQUEST_GET_SIM_STATUS, NULL,
+			sim_status_cb, sim, NULL);
+}
+
+static void ril_sim_status_changed(struct ril_msg *message, gpointer user_=
data)
+{
+	struct ofono_sim *sim =3D (struct ofono_sim *) user_data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	g_ril_print_unsol_no_args(sd->ril, message);
+
+	send_get_sim_status(sim);
+}
+
+static void inf_pin_retries_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct reply_oem_hook *reply =3D NULL;
+	int32_t *ret_data;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("Reply failure: %s",
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	reply =3D g_ril_reply_oem_hook_raw(sd->ril, message);
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: parse error", __func__);
+		goto error;
+	}
+
+	if (reply->length < 5 * (int) sizeof(int32_t)) {
+		ofono_error("%s: reply too small", __func__);
+		goto error;
+	}
+
+	/* First integer is INF_RIL_REQUEST_OEM_GET_REMAIN_SIM_PIN_ATTEMPTS */
+	ret_data =3D reply->data;
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D *(++ret_data);
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D *(++ret_data);
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D *(++ret_data);
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D *(++ret_data);
+
+	g_ril_reply_free_oem_hook(reply);
+	CALLBACK_WITH_SUCCESS(cb, sd->retries, cbd->data);
+
+	return;
+
+error:
+	g_ril_reply_free_oem_hook(reply);
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void mtk_pin_retries_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct parcel_str_array *str_arr =3D NULL;
+	int pin[MTK_EPINC_NUM_PASSWD];
+	int num_pin;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("Reply failure: %s",
+				ril_error_to_string(message->error));
+		goto error;
+	}
+
+	str_arr =3D g_ril_reply_oem_hook_strings(sd->ril, message);
+	if (str_arr =3D=3D NULL || str_arr->num_str < 1) {
+		ofono_error("%s: parse error", __func__);
+		goto error;
+	}
+
+	num_pin =3D sscanf(str_arr->str[0], "+EPINC:%d,%d,%d,%d",
+					&pin[0], &pin[1], &pin[2], &pin[3]);
+
+	if (num_pin !=3D MTK_EPINC_NUM_PASSWD) {
+		ofono_error("%s: failed parsing %s", __func__, str_arr->str[0]);
+		goto error;
+	}
+
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PIN] =3D pin[0];
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D pin[1];
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PUK] =3D pin[2];
+	sd->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D pin[3];
+
+	parcel_free_str_array(str_arr);
+	CALLBACK_WITH_SUCCESS(cb, sd->retries, cbd->data);
+	return;
+
+error:
+	parcel_free_str_array(str_arr);
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void ril_query_pin_retries(struct ofono_sim *sim,
+					ofono_sim_pin_retries_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (sd->vendor =3D=3D OFONO_RIL_VENDOR_INFINEON) {
+		struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+		struct parcel rilp;
+		int32_t oem_req =3D
+			INF_RIL_REQUEST_OEM_GET_REMAIN_SIM_PIN_ATTEMPTS;
+
+		g_ril_request_oem_hook_raw(sd->ril, &oem_req,
+						sizeof(oem_req), &rilp);
+
+		/* Send request to RIL */
+		if (g_ril_send(sd->ril, RIL_REQUEST_OEM_HOOK_RAW, &rilp,
+				inf_pin_retries_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, NULL, data);
+		}
+	} else if (sd->vendor =3D=3D OFONO_RIL_VENDOR_MTK) {
+		struct cb_data *cbd =3D cb_data_new(cb, data, sd);
+		struct parcel rilp;
+		const char *at_epinc[] =3D { "AT+EPINC", "+EPINC:" };
+
+		g_ril_request_oem_hook_strings(sd->ril, at_epinc,
+						G_N_ELEMENTS(at_epinc), &rilp);
+
+		if (g_ril_send(sd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+				mtk_pin_retries_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, NULL, data);
+		}
+	} else {
+		CALLBACK_WITH_SUCCESS(cb, sd->retries, data);
+	}
+}
+
+static void ril_query_passwd_state(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	DBG("passwd_state %u", sd->passwd_state);
+
+	if (sd->passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID)
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+	else
+		CALLBACK_WITH_SUCCESS(cb, sd->passwd_state, data);
+}
+
+static void ril_pin_change_state_cb(struct ril_msg *message, gpointer user=
_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	int *retries;
+	/*
+	 * There is no reason to ask SIM status until
+	 * unsolicited sim status change indication
+	 * Looks like state does not change before that.
+	 */
+
+	DBG("Enter password: type %d, result %d",
+		sd->passwd_type, message->error);
+
+	retries =3D g_ril_reply_parse_retries(sd->ril, message, sd->passwd_type);
+	if (retries !=3D NULL) {
+		memcpy(sd->retries, retries, sizeof(sd->retries));
+		g_free(retries);
+	}
+
+	/* TODO: re-factor to not use macro for FAILURE;
+	   doesn't return error! */
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		/*
+		 * Refresh passwd_state (not needed if the unlock is
+		 * successful, as an event will refresh the state in that case)
+		 */
+		send_get_sim_status(sim);
+	}
+}
+
+static void ril_pin_send(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	/*
+	 * TODO: This function is supposed to enter the pending password, which
+	 * might be also PIN2. So we must check the pending PIN in the future.
+	 */
+
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sim);
+	struct parcel rilp;
+
+	sd->passwd_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
+
+	g_ril_request_pin_send(sd->ril,
+				passwd,
+				sd->aid_str,
+				&rilp);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_ENTER_SIM_PIN, &rilp,
+			ril_pin_change_state_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void enter_pin_done(const struct ofono_error *error, void *data)
+{
+	struct change_state_cbd *csd =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(csd->sim);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("%s: wrong password", __func__);
+		sd->unlock_pending =3D FALSE;
+		CALLBACK_WITH_FAILURE(csd->cb, csd->data);
+	} else {
+		ril_pin_change_state(csd->sim, csd->passwd_type, csd->enable,
+					csd->passwd, csd->cb, csd->data);
+	}
+
+	g_free(csd);
+}
+
+static void ril_pin_change_state(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct parcel rilp;
+	struct req_pin_change_state req;
+	int ret =3D 0;
+
+	/*
+	 * If we want to unlock a password that has not been entered yet,
+	 * we enter it before trying to unlock. We need sd->unlock_pending as
+	 * the password still has not yet been refreshed when this function is
+	 * called from enter_pin_done().
+	 */
+	if (ofono_sim_get_password_type(sim) =3D=3D passwd_type
+			&& enable =3D=3D FALSE && sd->unlock_pending =3D=3D FALSE) {
+		struct change_state_cbd *csd =3D g_malloc0(sizeof(*csd));
+		csd->sim =3D sim;
+		csd->passwd_type =3D passwd_type;
+		csd->enable =3D enable;
+		csd->passwd =3D passwd;
+		csd->cb =3D cb;
+		csd->data =3D data;
+		sd->unlock_pending =3D TRUE;
+
+		ril_pin_send(sim, passwd, enter_pin_done, csd);
+
+		return;
+	}
+
+	sd->unlock_pending =3D FALSE;
+
+	cbd =3D cb_data_new(cb, data, sim);
+
+	sd->passwd_type =3D passwd_type;
+
+	req.aid_str =3D sd->aid_str;
+	req.passwd_type =3D passwd_type;
+	req.enable =3D enable;
+	req.passwd =3D passwd;
+
+	if (!g_ril_request_pin_change_state(sd->ril,
+						&req,
+						&rilp)) {
+		ofono_error("Couldn't build pin change state request");
+		goto error;
+	}
+
+	ret =3D g_ril_send(sd->ril, RIL_REQUEST_SET_FACILITY_LOCK, &rilp,
+				ril_pin_change_state_cb, cbd, g_free);
+
+error:
+	if (ret =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_pin_send_puk(struct ofono_sim *sim,
+				const char *puk, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sim);
+	struct parcel rilp;
+
+	sd->passwd_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
+
+	g_ril_request_pin_send_puk(sd->ril,
+					puk,
+					passwd,
+					sd->aid_str,
+					&rilp);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_ENTER_SIM_PUK, &rilp,
+			ril_pin_change_state_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void ril_change_passwd(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old_passwd, const char *new_passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data, sim);
+	struct parcel rilp;
+	int request =3D RIL_REQUEST_CHANGE_SIM_PIN;
+
+	sd->passwd_type =3D passwd_type;
+
+	g_ril_request_change_passwd(sd->ril,
+					old_passwd,
+					new_passwd,
+					sd->aid_str,
+					&rilp);
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		request =3D RIL_REQUEST_CHANGE_SIM_PIN2;
+
+	if (g_ril_send(sd->ril, request, &rilp, ril_pin_change_state_cb,
+			cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static gboolean listen_and_get_sim_status(gpointer user)
+{
+	struct ofono_sim *sim =3D user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	send_get_sim_status(sim);
+
+	g_ril_register(sd->ril, RIL_UNSOL_RESPONSE_SIM_STATUS_CHANGED,
+			(GRilNotifyFunc) ril_sim_status_changed, sim);
+
+	/* TODO: should we also register for RIL_UNSOL_SIM_REFRESH? */
+	return FALSE;
+}
+
+static gboolean ril_sim_register(gpointer user)
+{
+	struct ofono_sim *sim =3D user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	ofono_sim_register(sim);
+
+	if (sd->ril_state_watch !=3D NULL &&
+			!ofono_sim_add_state_watch(sim, sd->ril_state_watch,
+							sd->modem, NULL))
+		ofono_error("Error registering ril sim watch");
+
+	/*
+	 * We use g_idle_add here to make sure that the presence of the SIM
+	 * interface is signalled before signalling anything else from the said
+	 * interface, as ofono_sim_register also uses g_idle_add.
+	 */
+	g_idle_add(listen_and_get_sim_status, sim);
+
+	return FALSE;
+}
+
+static int ril_sim_probe(struct ofono_sim *sim, unsigned int vendor,
+				void *data)
+{
+	struct ril_sim_data *ril_data =3D data;
+	GRil *ril =3D ril_data->gril;
+	struct sim_data *sd;
+	int i;
+
+	sd =3D g_new0(struct sim_data, 1);
+	sd->ril =3D g_ril_clone(ril);
+	sd->vendor =3D vendor;
+	sd->aid_str =3D NULL;
+	sd->app_str =3D NULL;
+	sd->app_type =3D RIL_APPTYPE_UNKNOWN;
+	sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+	sd->passwd_type =3D OFONO_SIM_PASSWORD_NONE;
+	sd->modem =3D ril_data->modem;
+	sd->ril_state_watch =3D ril_data->ril_state_watch;
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		sd->retries[i] =3D -1;
+
+	ofono_sim_set_data(sim, sd);
+
+	/*
+	 * TODO: analyze if capability check is needed
+	 * and/or timer should be adjusted.
+	 *
+	 * ofono_sim_register() needs to be called after the
+	 * driver has been set in ofono_sim_create(), which
+	 * calls this function.	 Most other drivers make some
+	 * kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle event
+	 * instead.
+	 */
+	g_idle_add(ril_sim_register, sim);
+
+	return 0;
+}
+
+static void ril_sim_remove(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	ofono_sim_set_data(sim, NULL);
+
+	g_ril_unref(sd->ril);
+	g_free(sd->aid_str);
+	g_free(sd->app_str);
+	g_free(sd);
+}
+
+static struct ofono_sim_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_sim_probe,
+	.remove			=3D ril_sim_remove,
+	.read_file_info		=3D ril_sim_read_info,
+	.read_file_transparent	=3D ril_sim_read_binary,
+	.read_file_linear	=3D ril_sim_read_record,
+	.read_file_cyclic	=3D ril_sim_read_record,
+	.write_file_transparent	=3D ril_sim_update_binary,
+	.write_file_linear	=3D ril_sim_update_record,
+	.write_file_cyclic	=3D ril_sim_update_cyclic,
+	.read_imsi		=3D ril_read_imsi,
+	.query_passwd_state	=3D ril_query_passwd_state,
+	.send_passwd		=3D ril_pin_send,
+	.query_pin_retries	=3D ril_query_pin_retries,
+	.reset_passwd		=3D ril_pin_send_puk,
+	.change_passwd		=3D ril_change_passwd,
+	.lock			=3D ril_pin_change_state,
+/*
+ * TODO: Implmenting PIN/PUK support requires defining
+ * the following driver methods.
+ *
+ * In the meanwhile, as long as the SIM card is present,
+ * and unlocked, the core SIM code will check for the
+ * presence of query_passwd_state, and if null, then the
+ * function sim_initialize_after_pin() is called.
+ *
+ *	.query_locked		=3D ril_pin_query_enabled,
+ */
+};
+
+void ril_sim_init(void)
+{
+	DBG("");
+	ofono_sim_driver_register(&driver);
+}
+
+void ril_sim_exit(void)
+{
+	ofono_sim_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/sms.c b/drivers/rilmodem/sms.c
new file mode 100644
index 0000000..14816e5
--- /dev/null
+++ b/drivers/rilmodem/sms.c
@@ -0,0 +1,315 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL Modem Support
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013 Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <ctype.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+#include <gril.h>
+#include <parcel.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sms.h>
+#include "smsutil.h"
+#include "util.h"
+
+#include "rilmodem.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+#include "grilunsol.h"
+
+struct sms_data {
+	GRil *ril;
+	unsigned int vendor;
+};
+
+static void ril_csca_set_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sms_sca_set_cb_t cb =3D cbd->cb;
+	struct sms_data *sd =3D cbd->user;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(sd->ril, message->req),
+			ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_csca_set(struct ofono_sms *sms,
+			const struct ofono_phone_number *sca,
+			ofono_sms_sca_set_cb_t cb, void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+
+	g_ril_request_set_smsc_address(sd->ril, sca, &rilp);
+
+	/* Send request to RIL */
+	if (g_ril_send(sd->ril, RIL_REQUEST_SET_SMSC_ADDRESS, &rilp,
+			ril_csca_set_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, user_data);
+	}
+}
+
+static void ril_csca_query_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sms_sca_query_cb_t cb =3D cbd->cb;
+	struct sms_data *sd =3D cbd->user;
+	struct ofono_phone_number *sca;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		ofono_error("%s RILD reply failure: %s",
+			g_ril_request_id_to_string(sd->ril, message->req),
+			ril_error_to_string(message->error));
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	sca =3D g_ril_reply_parse_get_smsc_address(sd->ril, message);
+	if (sca =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+	} else {
+		CALLBACK_WITH_SUCCESS(cb, sca, cbd->data);
+		g_free(sca);
+	}
+}
+
+static void ril_csca_query(struct ofono_sms *sms, ofono_sms_sca_query_cb_t=
 cb,
+					void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+
+	DBG("Sending csca_query");
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_GET_SMSC_ADDRESS, NULL,
+			ril_csca_query_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, NULL, user_data);
+	}
+}
+
+static void ril_submit_sms_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	ofono_sms_submit_cb_t cb =3D cbd->cb;
+	struct sms_data *sd =3D cbd->user;
+	int mr =3D 0;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+		mr =3D g_ril_reply_parse_sms_response(sd->ril, message);
+	} else {
+		decode_ril_error(&error, "FAIL");
+	}
+
+	cb(&error, mr, cbd->data);
+}
+
+static void ril_cmgs(struct ofono_sms *sms, const unsigned char *pdu,
+			int pdu_len, int tpdu_len, int mms,
+			ofono_sms_submit_cb_t cb, void *user_data)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, sd);
+	struct parcel rilp;
+	struct req_sms_cmgs req;
+
+	DBG("pdu_len: %d, tpdu_len: %d mms: %d", pdu_len, tpdu_len, mms);
+
+	/* TODO: if (mms) { ... } */
+
+	req.pdu =3D pdu;
+	req.pdu_len =3D pdu_len;
+	req.tpdu_len =3D tpdu_len;
+
+	g_ril_request_sms_cmgs(sd->ril, &req, &rilp);
+
+	if (g_ril_send(sd->ril, RIL_REQUEST_SEND_SMS, &rilp,
+			ril_submit_sms_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, -1, user_data);
+	}
+}
+
+static void ril_ack_delivery_cb(struct ril_msg *message, gpointer user_dat=
a)
+{
+	if (message->error !=3D RIL_E_SUCCESS)
+		ofono_error("SMS acknowledgement failed: "
+				"Further SMS reception is not guaranteed");
+}
+
+static void ril_ack_delivery(struct ofono_sms *sms)
+{
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	struct parcel rilp;
+
+	g_ril_request_sms_acknowledge(sd->ril, &rilp);
+
+	/* TODO: should ACK be sent for either of the error cases? */
+
+	/* ACK the incoming NEW_SMS */
+	g_ril_send(sd->ril, RIL_REQUEST_SMS_ACKNOWLEDGE, &rilp,
+			ril_ack_delivery_cb, NULL, NULL);
+
+}
+
+static void ril_sms_notify(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *sd =3D ofono_sms_get_data(sms);
+	unsigned int smsc_len;
+	long ril_buf_len;
+	struct unsol_sms_data *pdu_data;
+
+	DBG("req: %d; data_len: %d", message->req, (int) message->buf_len);
+
+	pdu_data =3D g_ril_unsol_parse_new_sms(sd->ril, message);
+	if (pdu_data =3D=3D NULL)
+		goto error;
+
+	/*
+	 * The first octect in the pdu contains the SMSC address length
+	 * which is the X following octects it reads. We add 1 octet to
+	 * the read length to take into account this read octet in order
+	 * to calculate the proper tpdu length.
+	 */
+	smsc_len =3D pdu_data->data[0] + 1;
+	ril_buf_len =3D pdu_data->length;
+	DBG("smsc_len is %d", smsc_len);
+
+	if (message->req =3D=3D RIL_UNSOL_RESPONSE_NEW_SMS)
+		/* Last parameter is 'tpdu_len' ( substract SMSC length ) */
+		ofono_sms_deliver_notify(sms, pdu_data->data,
+						ril_buf_len,
+						ril_buf_len - smsc_len);
+	else if (message->req =3D=3D RIL_UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT)
+		ofono_sms_status_notify(sms, pdu_data->data, ril_buf_len,
+						ril_buf_len - smsc_len);
+
+	/* ACK the incoming NEW_SMS */
+	ril_ack_delivery(sms);
+
+	g_ril_unsol_free_sms_data(pdu_data);
+
+error:
+	;
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	DBG("");
+	ofono_sms_register(sms);
+
+	/* register to receive INCOMING_SMS and SMS status reports */
+	g_ril_register(data->ril, RIL_UNSOL_RESPONSE_NEW_SMS,
+			ril_sms_notify,	sms);
+	g_ril_register(data->ril, RIL_UNSOL_RESPONSE_NEW_SMS_STATUS_REPORT,
+			ril_sms_notify, sms);
+
+	/* This makes the delayed call a single-shot */
+	return FALSE;
+}
+
+static int ril_sms_probe(struct ofono_sms *sms, unsigned int vendor,
+				void *user)
+{
+	GRil *ril =3D user;
+	struct sms_data *data;
+
+	data =3D g_new0(struct sms_data, 1);
+	data->ril =3D g_ril_clone(ril);
+	data->vendor =3D vendor;
+
+	ofono_sms_set_data(sms, data);
+
+	/*
+	 * ofono_sms_register() needs to be called after
+	 * the driver has been set in ofono_sms_create(), which
+	 * calls this function.  Most other drivers make some
+	 * kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle add instead.
+	 */
+	g_idle_add(ril_delayed_register, sms);
+
+	return 0;
+}
+
+static void ril_sms_remove(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	DBG("");
+
+	g_ril_unref(data->ril);
+	g_free(data);
+
+	ofono_sms_set_data(sms, NULL);
+}
+
+static struct ofono_sms_driver driver =3D {
+	.name		=3D RILMODEM,
+	.probe		=3D ril_sms_probe,
+	.sca_query	=3D ril_csca_query,
+	.sca_set	=3D ril_csca_set,
+	.remove		=3D ril_sms_remove,
+	.submit		=3D ril_cmgs,
+
+	/*
+	 * TODO: investigate/implement:
+	 * .bearer_query  =3D NULL,
+	 * .bearer_set	  =3D NULL,
+	 */
+};
+
+void ril_sms_init(void)
+{
+	DBG("");
+	if (ofono_sms_driver_register(&driver))
+		DBG("ofono_sms_driver_register failed!");
+}
+
+void ril_sms_exit(void)
+{
+	DBG("");
+	ofono_sms_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/ussd.c b/drivers/rilmodem/ussd.c
new file mode 100644
index 0000000..04985ec
--- /dev/null
+++ b/drivers/rilmodem/ussd.c
@@ -0,0 +1,264 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013 Jolla Ltd
+ *  Copyright (C) 2013 Canonical Ltd
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/ussd.h>
+#include <smsutil.h>
+#include <util.h>
+
+#include "gril.h"
+#include "grilutil.h"
+#include "grilrequest.h"
+#include "grilunsol.h"
+
+#include "rilmodem.h"
+
+#include "ril_constants.h"
+
+struct ussd_data {
+	GRil *ril;
+};
+
+static gboolean request_success(gpointer data)
+{
+	struct cb_data *cbd =3D data;
+	ofono_ussd_cb_t cb =3D cbd->cb;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	g_free(cbd);
+
+	return FALSE;
+}
+
+static void ril_ussd_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+
+	/*
+	 * We fake an ON_USSD event if there was an error sending the request,
+	 * as core will be waiting for one to respond to the Initiate() call.
+	 * Note that we already made the callback (see ril_ussd_request()).
+	 */
+	if (message->error =3D=3D RIL_E_SUCCESS)
+		g_ril_print_response_no_args(ud->ril, message);
+	else
+		ofono_ussd_notify(ussd, OFONO_USSD_STATUS_NOT_SUPPORTED,
+					0, NULL, 0);
+}
+
+static void ril_ussd_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t cb, void *data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct cb_data *cbd =3D cb_data_new(cb, data, ussd);
+	enum sms_charset charset;
+	char *text =3D NULL;
+	int ret =3D 0;
+
+	if (cbs_dcs_decode(dcs, NULL, NULL, &charset, NULL, NULL, NULL)) {
+
+		if (charset =3D=3D SMS_CHARSET_7BIT) {
+			long written;
+
+			text =3D (char *) unpack_7bit(pdu, len, 0, TRUE,
+							0, &written, 1);
+			if (text !=3D NULL)
+				*(text + written) =3D '\0';
+
+		} else if (charset =3D=3D SMS_CHARSET_UCS2) {
+			text =3D g_convert((char *) pdu, len,
+					"UTF-8//TRANSLIT", "UCS-2BE",
+					NULL, NULL, NULL);
+		} else {
+			ofono_error("%s: No support for charset %d",
+					__func__, charset);
+		}
+	}
+
+	if (text) {
+		struct parcel rilp;
+
+		g_ril_request_send_ussd(ud->ril, text, &rilp);
+
+		ret =3D g_ril_send(ud->ril, RIL_REQUEST_SEND_USSD,
+					&rilp, ril_ussd_cb, ussd, NULL);
+		g_free(text);
+	}
+
+	/*
+	 * We do not wait for the SEND_USSD reply to do the callback, as some
+	 * networks send it after sending one or more ON_USSD events. From the
+	 * ofono core perspective, Initiate() does not return until one ON_USSD
+	 * event is received: making here a successful callback just makes the
+	 * core wait for that event.
+	 */
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	} else {
+		g_idle_add(request_success, cbd);
+	}
+}
+
+static void ril_ussd_cancel_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_ussd *ussd =3D cbd->user;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	ofono_ussd_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(ud->ril, message);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_ussd_cancel(struct ofono_ussd *ussd,
+				ofono_ussd_cb_t cb, void *user_data)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data, ussd);
+	int ret;
+
+	ret =3D g_ril_send(ud->ril, RIL_REQUEST_CANCEL_USSD, NULL,
+				ril_ussd_cancel_cb, cbd, g_free);
+
+	if (ret <=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, user_data);
+	}
+}
+
+static void ril_ussd_notify(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	struct unsol_ussd *unsol;
+
+	unsol =3D g_ril_unsol_parse_ussd(ud->ril, message);
+	if (unsol =3D=3D NULL) {
+		ofono_error("%s: Parsing error", __func__);
+		return;
+	}
+
+	/* To fix bug in MTK: USSD-Notify arrive with type 2 instead of 0 */
+	if (g_ril_vendor(ud->ril) =3D=3D OFONO_RIL_VENDOR_MTK &&
+			unsol->message !=3D NULL && unsol->type =3D=3D 2)
+		unsol->type =3D 0;
+
+	/*
+	 * With data coding scheme 0x48, we are saying that the ussd string is a
+	 * UCS-2 string, uncompressed, and with unspecified message class. For
+	 * the DCS coding, see 3gpp 23.038, sect. 5.
+	 */
+	if (unsol->message !=3D NULL) {
+		gsize written;
+		char *ucs2;
+
+		ucs2 =3D g_convert(unsol->message, -1, "UCS-2BE//TRANSLIT",
+					"UTF-8", NULL, &written, NULL);
+		if (ucs2 !=3D NULL) {
+			ofono_ussd_notify(ussd, unsol->type, 0x48,
+					(unsigned char *) ucs2, written);
+			g_free(ucs2);
+		} else {
+			ofono_error("%s: Error transcoding", __func__);
+		}
+	} else {
+		ofono_ussd_notify(ussd, unsol->type, 0, NULL, 0);
+	}
+
+	g_ril_unsol_free_ussd(unsol);
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_ussd *ussd =3D user_data;
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+
+	DBG("");
+
+	ofono_ussd_register(ussd);
+
+	/* Register for USSD responses */
+	g_ril_register(ud->ril, RIL_UNSOL_ON_USSD, ril_ussd_notify, ussd);
+
+	return FALSE;
+}
+
+static int ril_ussd_probe(struct ofono_ussd *ussd,
+					unsigned int vendor,
+					void *user)
+{
+	GRil *ril =3D user;
+	struct ussd_data *ud =3D g_new0(struct ussd_data, 1);
+
+	ud->ril =3D g_ril_clone(ril);
+	ofono_ussd_set_data(ussd, ud);
+	g_idle_add(ril_delayed_register, ussd);
+
+	return 0;
+}
+
+static void ril_ussd_remove(struct ofono_ussd *ussd)
+{
+	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
+	ofono_ussd_set_data(ussd, NULL);
+
+	g_ril_unref(ud->ril);
+	g_free(ud);
+}
+
+static struct ofono_ussd_driver driver =3D {
+	.name		=3D RILMODEM,
+	.probe		=3D ril_ussd_probe,
+	.remove		=3D ril_ussd_remove,
+	.request	=3D ril_ussd_request,
+	.cancel		=3D ril_ussd_cancel
+};
+
+void ril_ussd_init(void)
+{
+	ofono_ussd_driver_register(&driver);
+}
+
+void ril_ussd_exit(void)
+{
+	ofono_ussd_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/vendor.h b/drivers/rilmodem/vendor.h
new file mode 100644
index 0000000..83cc939
--- /dev/null
+++ b/drivers/rilmodem/vendor.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd. All rights reserved.
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
+#ifndef RILMODEM_VENDOR_H
+#define RILMODEM_VENDOR_H
+
+enum ofono_ril_vendor {
+	OFONO_RIL_VENDOR_AOSP =3D 0,
+	OFONO_RIL_VENDOR_MTK,
+	OFONO_RIL_VENDOR_INFINEON,
+	OFONO_RIL_VENDOR_QCOM_MSIM
+};
+
+#endif /* RILMODEM_VENDOR_H */
diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
new file mode 100644
index 0000000..3fa4b37
--- /dev/null
+++ b/drivers/rilmodem/voicecall.c
@@ -0,0 +1,824 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012-2013 Canonical Ltd.
+ *  Copyright (C) 2013 Jolla Ltd.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/voicecall.h>
+
+#include "gril.h"
+#include "grilrequest.h"
+#include "grilreply.h"
+#include "grilunsol.h"
+
+#include "common.h"
+#include "rilmodem.h"
+#include "voicecall.h"
+
+/* Amount of ms we wait between CLCC calls */
+#define POLL_CLCC_INTERVAL 300
+
+#define FLAG_NEED_CLIP 1
+
+#define MAX_DTMF_BUFFER 32
+
+/* To use with change_state_req::affected_types */
+#define AFFECTED_STATES_ALL 0x3F
+
+/* Auto-answer delay in seconds */
+#define AUTO_ANSWER_DELAY_S 3
+
+struct release_id_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	int id;
+};
+
+struct change_state_req {
+	struct ofono_voicecall *vc;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	/* Call states affected by a local release (1 << enum call_status) */
+	int affected_types;
+};
+
+struct lastcause_req {
+	struct ofono_voicecall *vc;
+	int id;
+};
+
+/* Data for dial after swap */
+struct hold_before_dial_req {
+	struct ofono_voicecall *vc;
+	struct ofono_phone_number dial_ph;
+	enum ofono_clir_option dial_clir;
+};
+
+static void send_one_dtmf(struct ril_voicecall_data *vd);
+static void clear_dtmf_queue(struct ril_voicecall_data *vd);
+
+static void lastcause_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct lastcause_req *reqdata =3D user_data;
+	struct ofono_voicecall *vc =3D reqdata->vc;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	enum ofono_disconnect_reason reason;
+
+	reason =3D g_ril_reply_parse_call_fail_cause(vd->ril, message);
+
+	DBG("Call %d ended with reason %d", reqdata->id, reason);
+
+	ofono_voicecall_disconnected(vc, reqdata->id, reason, NULL);
+}
+
+static gboolean auto_answer_call(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+
+	DBG("");
+
+	ril_answer(vc, NULL, NULL);
+
+	return FALSE;
+}
+
+static gboolean is_auto_answer(struct ril_voicecall_data *vd,
+				struct ofono_call *call)
+{
+	static const char test_mcc_mnc_1[] =3D "00101";
+	static const char test_mcc_mnc_2[] =3D "001001";
+
+	const char *imsi;
+	struct ofono_sim *sim;
+
+	if (call->status !=3D CALL_STATUS_INCOMING)
+		return FALSE;
+
+	sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, vd->modem);
+	if (sim =3D=3D NULL)
+		return FALSE;
+
+	imsi =3D ofono_sim_get_imsi(sim);
+	if (imsi =3D=3D NULL)
+		return FALSE;
+
+	if (strncmp(imsi, test_mcc_mnc_1, sizeof(test_mcc_mnc_1) - 1) =3D=3D 0 ||
+		strncmp(imsi, test_mcc_mnc_2, sizeof(test_mcc_mnc_2) - 1)
+			=3D=3D 0) {
+		ofono_info("Auto answering incoming call, imsi is %s", imsi);
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void clcc_poll_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	int reqid =3D RIL_REQUEST_LAST_CALL_FAIL_CAUSE;
+	GSList *calls;
+	GSList *n, *o;
+	struct ofono_call *nc, *oc;
+
+	/*
+	 * We consider all calls have been dropped if there is no radio, which
+	 * happens, for instance, when flight mode is set whilst in a call.
+	 */
+	if (message->error !=3D RIL_E_SUCCESS &&
+			message->error !=3D RIL_E_RADIO_NOT_AVAILABLE) {
+		ofono_error("We are polling CLCC and received an error");
+		ofono_error("All bets are off for call management");
+		return;
+	}
+
+	calls =3D g_ril_reply_parse_get_calls(vd->ril, message);
+
+	n =3D calls;
+	o =3D vd->calls;
+
+	while (n || o) {
+		nc =3D n ? n->data : NULL;
+		oc =3D o ? o->data : NULL;
+
+		/* TODO: Add comments explaining call id handling */
+		if (oc && (nc =3D=3D NULL || (nc->id > oc->id))) {
+			if (vd->local_release & (1 << oc->id)) {
+				ofono_voicecall_disconnected(vc, oc->id,
+					OFONO_DISCONNECT_REASON_LOCAL_HANGUP,
+					NULL);
+			} else if (message->error =3D=3D
+						RIL_E_RADIO_NOT_AVAILABLE) {
+				ofono_voicecall_disconnected(vc, oc->id,
+					OFONO_DISCONNECT_REASON_ERROR,
+					NULL);
+			} else {
+				/* Get disconnect cause before calling core */
+				struct lastcause_req *reqdata =3D
+					g_try_new0(struct lastcause_req, 1);
+				if (reqdata !=3D NULL) {
+					reqdata->vc =3D user_data;
+					reqdata->id =3D oc->id;
+
+					g_ril_send(vd->ril, reqid, NULL,
+							lastcause_cb, reqdata,
+							g_free);
+				}
+			}
+
+			clear_dtmf_queue(vd);
+
+			o =3D o->next;
+		} else if (nc && (oc =3D=3D NULL || (nc->id < oc->id))) {
+			/* new call, signal it */
+			if (nc->type) {
+				ofono_voicecall_notify(vc, nc);
+
+				if (vd->cb) {
+					struct ofono_error error;
+					ofono_voicecall_cb_t cb =3D vd->cb;
+					decode_ril_error(&error, "OK");
+					cb(&error, vd->data);
+					vd->cb =3D NULL;
+					vd->data =3D NULL;
+				}
+
+				if (is_auto_answer(vd, nc))
+					g_timeout_add_seconds(
+							AUTO_ANSWER_DELAY_S,
+							auto_answer_call, vc);
+			}
+
+			n =3D n->next;
+		} else {
+			/*
+			 * Always use the clip_validity from old call
+			 * the only place this is truly told to us is
+			 * in the CLIP notify, the rest are fudged
+			 * anyway.  Useful when RING, CLIP is used,
+			 * and we're forced to use CLCC and clip_validity
+			 * is 1
+			 */
+			if (oc->clip_validity =3D=3D 1)
+				nc->clip_validity =3D oc->clip_validity;
+
+			nc->cnap_validity =3D oc->cnap_validity;
+
+			/*
+			 * CDIP doesn't arrive as part of CLCC, always
+			 * re-use from the old call
+			 */
+			memcpy(&nc->called_number, &oc->called_number,
+					sizeof(oc->called_number));
+
+			/*
+			 * If the CLIP is not provided and the CLIP never
+			 * arrives, or RING is used, then signal the call
+			 * here
+			 */
+			if (nc->status =3D=3D CALL_STATUS_INCOMING &&
+					(vd->flags & FLAG_NEED_CLIP)) {
+				if (nc->type)
+					ofono_voicecall_notify(vc, nc);
+
+				vd->flags &=3D ~FLAG_NEED_CLIP;
+			} else if (memcmp(nc, oc, sizeof(*nc)) && nc->type)
+				ofono_voicecall_notify(vc, nc);
+
+			n =3D n->next;
+			o =3D o->next;
+		}
+	}
+
+	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
+	g_slist_free(vd->calls);
+
+	vd->calls =3D calls;
+	vd->local_release =3D 0;
+}
+
+gboolean ril_poll_clcc(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	g_ril_send(vd->ril, RIL_REQUEST_GET_CURRENT_CALLS, NULL,
+			clcc_poll_cb, vc, NULL);
+
+	vd->clcc_source =3D 0;
+
+	return FALSE;
+}
+
+static void generic_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct change_state_req *req =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	struct ofono_error error;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		decode_ril_error(&error, "OK");
+	} else {
+		decode_ril_error(&error, "FAIL");
+		goto out;
+	}
+
+	g_ril_print_response_no_args(vd->ril, message);
+
+	if (req->affected_types) {
+		GSList *l;
+		struct ofono_call *call;
+
+		for (l =3D vd->calls; l; l =3D l->next) {
+			call =3D l->data;
+
+			if (req->affected_types & (1 << call->status))
+				vd->local_release |=3D (1 << call->id);
+		}
+	}
+
+out:
+	g_ril_send(vd->ril, RIL_REQUEST_GET_CURRENT_CALLS, NULL,
+			clcc_poll_cb, req->vc, NULL);
+
+	/* We have to callback after we schedule a poll if required */
+	if (req->cb)
+		req->cb(&error, req->data);
+}
+
+static int ril_template(const guint rreq, struct ofono_voicecall *vc,
+			GRilResponseFunc func, unsigned int affected_types,
+			gpointer pdata, ofono_voicecall_cb_t cb, void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+	int ret;
+
+	if (req =3D=3D NULL)
+		goto error;
+
+	req->vc =3D vc;
+	req->cb =3D cb;
+	req->data =3D data;
+	req->affected_types =3D affected_types;
+
+	ret =3D g_ril_send(vd->ril, rreq, pdata, func, req, g_free);
+	if (ret > 0)
+		return ret;
+error:
+	g_free(req);
+
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, data);
+
+	return 0;
+}
+
+static void rild_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_voicecall *vc =3D cbd->user;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	/*
+	 * DIAL_MODIFIED_TO_DIAL means redirection. The call we will see when
+	 * polling will have a different called number.
+	 */
+	if (message->error =3D=3D RIL_E_SUCCESS ||
+			(g_ril_vendor(vd->ril) =3D=3D OFONO_RIL_VENDOR_AOSP &&
+			message->error =3D=3D RIL_E_DIAL_MODIFIED_TO_DIAL)) {
+		decode_ril_error(&error, "OK");
+	} else {
+		decode_ril_error(&error, "FAIL");
+		goto out;
+	}
+
+	g_ril_print_response_no_args(vd->ril, message);
+
+	/* CLCC will update the oFono call list with proper ids  */
+	if (!vd->clcc_source)
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL,
+						ril_poll_clcc, vc);
+
+	/* we cannot answer just yet since we don't know the call id */
+	vd->cb =3D cb;
+	vd->data =3D cbd->data;
+
+	return;
+
+out:
+	cb(&error, cbd->data);
+}
+
+static void dial(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct cb_data *cbd =3D cb_data_new(cb, data, vc);
+	struct parcel rilp;
+
+	g_ril_request_dial(vd->ril, ph, clir, &rilp);
+
+	/* Send request to RIL */
+	if (g_ril_send(vd->ril, RIL_REQUEST_DIAL, &rilp,
+			rild_cb, cbd, g_free) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static void hold_before_dial_cb(struct ril_msg *message, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	struct hold_before_dial_req *req =3D cbd->user;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+	ofono_voicecall_cb_t cb =3D cbd->cb;
+
+	if (message->error !=3D RIL_E_SUCCESS) {
+		g_free(req);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	g_ril_print_response_no_args(vd->ril, message);
+
+	/* Current calls held: we can dial now */
+	dial(req->vc, &req->dial_ph, req->dial_clir, cb, cbd->data);
+
+	g_free(req);
+}
+
+void ril_dial(struct ofono_voicecall *vc, const struct ofono_phone_number =
*ph,
+		enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+		void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	int current_active =3D 0;
+	struct ofono_call *call;
+	GSList *l;
+
+	/* Check for current active calls */
+	for (l =3D vd->calls; l; l =3D l->next) {
+		call =3D l->data;
+
+		if (call->status =3D=3D CALL_STATUS_ACTIVE) {
+			current_active =3D 1;
+			break;
+		}
+	}
+
+	/*
+	 * The network will put current active calls on hold. In some cases
+	 * (mako), the modem also updates properly the state. In others
+	 * (maguro), we need to explicitly set the state to held. In both cases
+	 * we send a request for holding the active call, as it is not harmful
+	 * when it is not really needed, and is what Android does.
+	 */
+	if (current_active) {
+		struct hold_before_dial_req *req;
+		struct cb_data *cbd;
+
+		req =3D g_malloc0(sizeof(*req));
+		req->vc =3D vc;
+		req->dial_ph =3D *ph;
+		req->dial_clir =3D clir;
+
+		cbd =3D cb_data_new(cb, data, req);
+
+		if (g_ril_send(vd->ril, RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE,
+				NULL, hold_before_dial_cb, cbd, g_free) =3D=3D 0) {
+			g_free(cbd);
+			CALLBACK_WITH_FAILURE(cb, data);
+		}
+
+	} else {
+		dial(vc, ph, clir, cb, data);
+	}
+}
+
+void ril_hangup_all(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
+			void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct parcel rilp;
+	struct ofono_error error;
+	struct ofono_call *call;
+	GSList *l;
+
+	for (l =3D vd->calls; l; l =3D l->next) {
+		call =3D l->data;
+
+		if (call->status =3D=3D CALL_STATUS_INCOMING) {
+			/*
+			 * Need to use this request so that declined
+			 * calls in this state, are properly forwarded
+			 * to voicemail.  REQUEST_HANGUP doesn't do the
+			 * right thing for some operators, causing the
+			 * caller to hear a fast busy signal.
+			 */
+			ril_template(RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND,
+					vc, generic_cb, AFFECTED_STATES_ALL,
+					NULL, NULL, NULL);
+		} else {
+
+			/* TODO: Hangup just the active ones once we have call
+			 * state tracking (otherwise it can't handle ringing) */
+			g_ril_request_hangup(vd->ril, call->id, &rilp);
+
+			/* Send request to RIL */
+			ril_template(RIL_REQUEST_HANGUP, vc, generic_cb,
+					AFFECTED_STATES_ALL, &rilp, NULL, NULL);
+		}
+	}
+
+	/* TODO: Deal in case of an error at hungup */
+	decode_ril_error(&error, "OK");
+	cb(&error, data);
+}
+
+void ril_hangup_specific(struct ofono_voicecall *vc,
+				int id, ofono_voicecall_cb_t cb, void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct parcel rilp;
+
+	DBG("Hanging up call with id %d", id);
+
+	g_ril_request_hangup(vd->ril, id, &rilp);
+
+	/* Send request to RIL */
+	ril_template(RIL_REQUEST_HANGUP, vc, generic_cb,
+			AFFECTED_STATES_ALL, &rilp, cb, data);
+}
+
+void ril_call_state_notify(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	g_ril_print_unsol_no_args(vd->ril, message);
+
+	/* Just need to request the call list again */
+	ril_poll_clcc(vc);
+
+	return;
+}
+
+static void ril_ss_notify(struct ril_msg *message, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct unsol_supp_svc_notif *unsol;
+
+	unsol =3D g_ril_unsol_parse_supp_svc_notif(vd->ril,  message);
+	if (unsol =3D=3D NULL) {
+		ofono_error("%s: Parsing error", __func__);
+		return;
+	}
+
+	DBG("RIL data: MT/MO: %i, code: %i, index: %i",
+		unsol->notif_type, unsol->code, unsol->index);
+
+	/* 0 stands for MO intermediate, 1 for MT unsolicited */
+	/* TODO How do we know the affected call? Refresh call list? */
+	if (unsol->notif_type =3D=3D 1)
+		ofono_voicecall_ssn_mt_notify(
+			vc, 0, unsol->code, unsol->index, &unsol->number);
+	else
+		ofono_voicecall_ssn_mo_notify(vc, 0, unsol->code, unsol->index);
+
+	g_ril_unsol_free_supp_svc_notif(unsol);
+}
+
+void ril_answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void =
*data)
+{
+	DBG("Answering current call");
+
+	/* Send request to RIL */
+	ril_template(RIL_REQUEST_ANSWER, vc, generic_cb, 0, NULL, cb, data);
+}
+
+static void ril_send_dtmf_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct ril_voicecall_data *vd =3D user_data;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		/* Remove sent DTMF character from queue */
+		gchar *tmp_tone_queue =3D g_strdup(vd->tone_queue + 1);
+		int remaining =3D strlen(tmp_tone_queue);
+
+		memcpy(vd->tone_queue, tmp_tone_queue, remaining);
+		vd->tone_queue[remaining] =3D '\0';
+		g_free(tmp_tone_queue);
+
+		vd->tone_pending =3D FALSE;
+
+		if (remaining > 0)
+			send_one_dtmf(vd);
+	} else {
+		DBG("error=3D%d", message->error);
+		clear_dtmf_queue(vd);
+	}
+}
+
+static void send_one_dtmf(struct ril_voicecall_data *vd)
+{
+	struct parcel rilp;
+
+	if (vd->tone_pending =3D=3D TRUE)
+		return; /* RIL request pending */
+
+	if (strlen(vd->tone_queue) =3D=3D 0)
+		return; /* nothing to send */
+
+	g_ril_request_dtmf(vd->ril, vd->tone_queue[0], &rilp);
+
+	g_ril_send(vd->ril, RIL_REQUEST_DTMF, &rilp,
+			ril_send_dtmf_cb, vd, NULL);
+
+	vd->tone_pending =3D TRUE;
+}
+
+void ril_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct ofono_error error;
+
+	DBG("Queue '%s'", dtmf);
+
+	/*
+	 * Queue any incoming DTMF (up to MAX_DTMF_BUFFER characters),
+	 * send them to RIL one-by-one, immediately call back
+	 * core with no error
+	 */
+	g_strlcat(vd->tone_queue, dtmf, MAX_DTMF_BUFFER);
+	send_one_dtmf(vd);
+
+	/* We don't really care about errors here */
+	decode_ril_error(&error, "OK");
+	cb(&error, data);
+}
+
+static void clear_dtmf_queue(struct ril_voicecall_data *vd)
+{
+	g_free(vd->tone_queue);
+	vd->tone_queue =3D g_strnfill(MAX_DTMF_BUFFER + 1, '\0');
+	vd->tone_pending =3D FALSE;
+}
+
+void ril_create_multiparty(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_CONFERENCE, vc, generic_cb, 0, NULL, cb, data);
+}
+
+void ril_private_chat(struct ofono_voicecall *vc, int id,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct parcel rilp;
+
+	g_ril_request_separate_conn(vd->ril, id, &rilp);
+
+	/* Send request to RIL */
+	ril_template(RIL_REQUEST_SEPARATE_CONNECTION, vc,
+			generic_cb, 0, &rilp, cb, data);
+}
+
+void ril_swap_without_accept(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE, vc,
+			generic_cb, 0, NULL, cb, data);
+}
+
+void ril_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_SWITCH_HOLDING_AND_ACTIVE, vc,
+			generic_cb, 0, NULL, cb, data);
+}
+
+void ril_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND, vc,
+			generic_cb, 0, NULL, cb, data);
+}
+
+void ril_release_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_HANGUP_FOREGROUND_RESUME_BACKGROUND, vc,
+			generic_cb, 0, NULL, cb, data);
+}
+
+void ril_set_udub(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data)
+{
+	ril_template(RIL_REQUEST_HANGUP_WAITING_OR_BACKGROUND, vc,
+			generic_cb, 0, NULL, cb, data);
+}
+
+static gboolean enable_supp_svc(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	struct parcel rilp;
+
+	g_ril_request_set_supp_svc_notif(vd->ril, &rilp);
+
+	g_ril_send(vd->ril, RIL_REQUEST_SET_SUPP_SVC_NOTIFICATION, &rilp,
+			NULL, vc, NULL);
+
+	/* Makes this a single shot */
+	return FALSE;
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	ofono_voicecall_register(vc);
+
+	/* Initialize call list */
+	ril_poll_clcc(vc);
+
+	/* Unsol when call state changes */
+	g_ril_register(vd->ril, RIL_UNSOL_RESPONSE_CALL_STATE_CHANGED,
+			ril_call_state_notify, vc);
+
+	/* Unsol when call set on hold */
+	g_ril_register(vd->ril, RIL_UNSOL_SUPP_SVC_NOTIFICATION,
+			ril_ss_notify, vc);
+
+	/* request supplementary service notifications*/
+	enable_supp_svc(vc);
+
+	/* This makes the timeout a single-shot */
+	return FALSE;
+}
+
+void ril_voicecall_start(struct ril_voicecall_driver_data *driver_data,
+				struct ofono_voicecall *vc,
+				unsigned int vendor,
+				struct ril_voicecall_data *vd)
+{
+	vd->ril =3D g_ril_clone(driver_data->gril);
+	vd->modem =3D driver_data->modem;
+	vd->vendor =3D vendor;
+	vd->cb =3D NULL;
+	vd->data =3D NULL;
+
+	clear_dtmf_queue(vd);
+
+	ofono_voicecall_set_data(vc, vd);
+
+	/*
+	 * ofono_voicecall_register() needs to be called after
+	 * the driver has been set in ofono_voicecall_create(),
+	 * which calls this function.  Most other drivers make
+	 * some kind of capabilities query to the modem, and then
+	 * call register in the callback; we use an idle event instead.
+	 */
+	g_idle_add(ril_delayed_register, vc);
+}
+
+int ril_voicecall_probe(struct ofono_voicecall *vc, unsigned int vendor,
+			void *data)
+{
+	struct ril_voicecall_driver_data *driver_data =3D data;
+	struct ril_voicecall_data *vd;
+
+	vd =3D g_try_new0(struct ril_voicecall_data, 1);
+	if (vd =3D=3D NULL)
+		return -ENOMEM;
+
+	ril_voicecall_start(driver_data, vc, vendor, vd);
+
+	return 0;
+}
+
+void ril_voicecall_remove(struct ofono_voicecall *vc)
+{
+	struct ril_voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	if (vd->clcc_source)
+		g_source_remove(vd->clcc_source);
+
+	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
+	g_slist_free(vd->calls);
+
+	ofono_voicecall_set_data(vc, NULL);
+
+	g_ril_unref(vd->ril);
+	g_free(vd->tone_queue);
+	g_free(vd);
+}
+
+static struct ofono_voicecall_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_voicecall_probe,
+	.remove			=3D ril_voicecall_remove,
+	.dial			=3D ril_dial,
+	.answer			=3D ril_answer,
+	.hangup_all		=3D ril_hangup_all,
+	.release_specific	=3D ril_hangup_specific,
+	.send_tones		=3D ril_send_dtmf,
+	.create_multiparty	=3D ril_create_multiparty,
+	.private_chat		=3D ril_private_chat,
+	.swap_without_accept	=3D ril_swap_without_accept,
+	.hold_all_active	=3D ril_hold_all_active,
+	.release_all_held	=3D ril_release_all_held,
+	.set_udub		=3D ril_set_udub,
+	.release_all_active	=3D ril_release_all_active,
+};
+
+void ril_voicecall_init(void)
+{
+	ofono_voicecall_driver_register(&driver);
+}
+
+void ril_voicecall_exit(void)
+{
+	ofono_voicecall_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/voicecall.h b/drivers/rilmodem/voicecall.h
new file mode 100644
index 0000000..0407abe
--- /dev/null
+++ b/drivers/rilmodem/voicecall.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+struct ril_voicecall_data {
+	GSList *calls;
+	/* Call local hangup indicator, one bit per call (1 << call_id) */
+	unsigned int local_release;
+	unsigned int clcc_source;
+	GRil *ril;
+	struct ofono_modem *modem;
+	unsigned int vendor;
+	unsigned char flags;
+	ofono_voicecall_cb_t cb;
+	void *data;
+	gchar *tone_queue;
+	gboolean tone_pending;
+};
+
+int ril_voicecall_probe(struct ofono_voicecall *vc, unsigned int vendor,
+			void *data);
+void ril_voicecall_remove(struct ofono_voicecall *vc);
+void ril_dial(struct ofono_voicecall *vc, const struct ofono_phone_number =
*ph,
+		enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+		void *data);
+void ril_answer(struct ofono_voicecall *vc,
+		ofono_voicecall_cb_t cb, void *data);
+void ril_hangup_all(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb,
+			void *data);
+void ril_hangup_specific(struct ofono_voicecall *vc,
+				int id, ofono_voicecall_cb_t cb, void *data);
+void ril_send_dtmf(struct ofono_voicecall *vc, const char *dtmf,
+			ofono_voicecall_cb_t cb, void *data);
+void ril_create_multiparty(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data);
+void ril_private_chat(struct ofono_voicecall *vc, int id,
+			ofono_voicecall_cb_t cb, void *data);
+void ril_swap_without_accept(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data);
+void ril_hold_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data);
+void ril_release_all_held(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data);
+void ril_set_udub(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+void ril_release_all_active(struct ofono_voicecall *vc,
+				ofono_voicecall_cb_t cb, void *data);
+
+void ril_voicecall_start(struct ril_voicecall_driver_data *driver_data,
+				struct ofono_voicecall *vc,
+				unsigned int vendor,
+				struct ril_voicecall_data *vd);
+void ril_call_state_notify(struct ril_msg *message, gpointer user_data);
+gboolean ril_poll_clcc(gpointer user_data);
-- =

2.1.4


--===============0686821476984851384==--

