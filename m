Content-Type: multipart/mixed; boundary="===============0843940419920086035=="
MIME-Version: 1.0
From: You-Sheng Yang <vicamo@gmail.com>
Subject: [PATCH 2/3] include: move include/* into include/ofono/
Date: Tue, 23 Dec 2014 00:07:47 +0800
Message-ID: <1419264468-22351-2-git-send-email-vicamo@gmail.com>
In-Reply-To: <1419264468-22351-1-git-send-email-vicamo@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0843940419920086035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: You-Sheng Yang <vicamo@gmail.com>

diff --git a/include/audio-settings.h b/include/audio-settings.h
deleted file mode 100644
index 362f8df..0000000
--- a/include/audio-settings.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_AUDIO_SETTINGS_H
-#define __OFONO_AUDIO_SETTINGS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_audio_settings;
-
-struct ofono_audio_settings_driver {
-	const char *name;
-	int (*probe)(struct ofono_audio_settings *as,
-				unsigned int vendor, void *data);
-	void (*remove)(struct ofono_audio_settings *as);
-};
-
-void ofono_audio_settings_active_notify(struct ofono_audio_settings *as,
-						ofono_bool_t active);
-void ofono_audio_settings_mode_notify(struct ofono_audio_settings *as,
-						const char *mode);
-
-int ofono_audio_settings_driver_register(
-				const struct ofono_audio_settings_driver *d);
-void ofono_audio_settings_driver_unregister(
-				const struct ofono_audio_settings_driver *d);
-
-struct ofono_audio_settings *ofono_audio_settings_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_audio_settings_register(struct ofono_audio_settings *as);
-void ofono_audio_settings_remove(struct ofono_audio_settings *as);
-
-void ofono_audio_settings_set_data(struct ofono_audio_settings *as, void *=
data);
-void *ofono_audio_settings_get_data(struct ofono_audio_settings *as);
-
-struct ofono_modem *ofono_audio_settings_get_modem(
-					struct ofono_audio_settings *as);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_AUDIO_SETTINGS_H */
diff --git a/include/call-barring.h b/include/call-barring.h
deleted file mode 100644
index 6e96ee0..0000000
--- a/include/call-barring.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CALL_BARRING_H
-#define __OFONO_CALL_BARRING_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_call_barring;
-
-typedef void (*ofono_call_barring_set_cb_t)(const struct ofono_error *erro=
r,
-						void *data);
-typedef void (*ofono_call_barring_query_cb_t)(const struct ofono_error *er=
ror,
-					int status, void *data);
-
-struct ofono_call_barring_driver {
-	const char *name;
-	int (*probe)(struct ofono_call_barring *cb, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_call_barring *cb);
-	void (*set)(struct ofono_call_barring *barr, const char *lock,
-			int enable, const char *passwd, int cls,
-			ofono_call_barring_set_cb_t cb, void *data);
-	void (*query)(struct ofono_call_barring *barr, const char *lock,
-			int cls, ofono_call_barring_query_cb_t cb, void *data);
-	void (*set_passwd)(struct ofono_call_barring *barr, const char *lock,
-			const char *old_passwd, const char *new_passwd,
-			ofono_call_barring_set_cb_t cb, void *data);
-};
-
-int ofono_call_barring_driver_register(
-				const struct ofono_call_barring_driver *d);
-void ofono_call_barring_driver_unregister(
-				const struct ofono_call_barring_driver *d);
-
-struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *m=
odem,
-							unsigned int vendor,
-							const char *driver,
-							void *data);
-
-void ofono_call_barring_register(struct ofono_call_barring *cb);
-void ofono_call_barring_remove(struct ofono_call_barring *cb);
-
-void ofono_call_barring_set_data(struct ofono_call_barring *cb, void *data=
);
-void *ofono_call_barring_get_data(struct ofono_call_barring *cb);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CALL_BARRING_H */
diff --git a/include/call-forwarding.h b/include/call-forwarding.h
deleted file mode 100644
index b213aa8..0000000
--- a/include/call-forwarding.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CALL_FORWARDING_H
-#define __OFONO_CALL_FORWARDING_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_call_forwarding;
-
-/* 27.007 Section 7.11 Call Forwarding */
-struct ofono_call_forwarding_condition {
-	int status;
-	int cls;
-	struct ofono_phone_number phone_number;
-	int time;
-};
-
-typedef void (*ofono_call_forwarding_set_cb_t)(const struct ofono_error *e=
rror,
-						void *data);
-typedef void (*ofono_call_forwarding_query_cb_t)(
-			const struct ofono_error *error, int total,
-			const struct ofono_call_forwarding_condition *list,
-			void *data);
-
-struct ofono_call_forwarding_driver {
-	const char *name;
-	int (*probe)(struct ofono_call_forwarding *cf, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_call_forwarding *cf);
-	void (*activation)(struct ofono_call_forwarding *cf,
-				int type, int cls,
-				ofono_call_forwarding_set_cb_t cb, void *data);
-	void (*registration)(struct ofono_call_forwarding *cf,
-				int type, int cls,
-				const struct ofono_phone_number *number,
-				int time,
-				ofono_call_forwarding_set_cb_t cb, void *data);
-	void (*deactivation)(struct ofono_call_forwarding *cf,
-				int type, int cls,
-				ofono_call_forwarding_set_cb_t cb, void *data);
-	void (*erasure)(struct ofono_call_forwarding *cf, int type, int cls,
-				ofono_call_forwarding_set_cb_t cb, void *data);
-	void (*query)(struct ofono_call_forwarding *cf, int type, int cls,
-				ofono_call_forwarding_query_cb_t cb,
-				void *data);
-};
-
-int ofono_call_forwarding_driver_register(
-				const struct ofono_call_forwarding_driver *d);
-void ofono_call_forwarding_driver_unregister(
-				const struct ofono_call_forwarding_driver *d);
-
-struct ofono_call_forwarding *ofono_call_forwarding_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_call_forwarding_register(struct ofono_call_forwarding *cf);
-void ofono_call_forwarding_remove(struct ofono_call_forwarding *cf);
-
-void ofono_call_forwarding_set_data(struct ofono_call_forwarding *cf,
-					void *data);
-void *ofono_call_forwarding_get_data(struct ofono_call_forwarding *cf);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CALL_FORWARDING_H */
diff --git a/include/call-meter.h b/include/call-meter.h
deleted file mode 100644
index 1e97142..0000000
--- a/include/call-meter.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CALL_METER_H
-#define __OFONO_CALL_METER_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_call_meter;
-
-typedef void (*ofono_call_meter_query_cb_t)(const struct ofono_error *erro=
r,
-						int value, void *data);
-
-typedef void (*ofono_call_meter_puct_query_cb_t)(
-					const struct ofono_error *error,
-					const char *currency, double ppu,
-					void *data);
-
-typedef void(*ofono_call_meter_set_cb_t)(const struct ofono_error *error,
-						void *data);
-
-struct ofono_call_meter_driver {
-	const char *name;
-	int (*probe)(struct ofono_call_meter *cm, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_call_meter *cm);
-	void (*call_meter_query)(struct ofono_call_meter *cm,
-				ofono_call_meter_query_cb_t cb, void *data);
-	void (*acm_query)(struct ofono_call_meter *cm,
-				ofono_call_meter_query_cb_t cb, void *data);
-	void (*acm_reset)(struct ofono_call_meter *cm, const char *sim_pin2,
-				ofono_call_meter_set_cb_t cb, void *data);
-	void (*acm_max_query)(struct ofono_call_meter *cm,
-				ofono_call_meter_query_cb_t cb, void *data);
-	void (*acm_max_set)(struct ofono_call_meter *cm, int new_value,
-				const char *sim_pin2,
-				ofono_call_meter_set_cb_t cb, void *data);
-	void (*puct_query)(struct ofono_call_meter *cm,
-			ofono_call_meter_puct_query_cb_t cb, void *data);
-	void (*puct_set)(struct ofono_call_meter *cm, const char *currency,
-				double ppu, const char *sim_pin2,
-				ofono_call_meter_set_cb_t cb, void *data);
-};
-
-int ofono_call_meter_driver_register(const struct ofono_call_meter_driver =
*d);
-void ofono_call_meter_driver_unregister(
-				const struct ofono_call_meter_driver *d);
-
-struct ofono_call_meter *ofono_call_meter_create(struct ofono_modem *modem,
-							unsigned int vendor,
-							const char *driver,
-							void *data);
-
-void ofono_call_meter_register(struct ofono_call_meter *cm);
-void ofono_call_meter_remove(struct ofono_call_meter *cm);
-
-void ofono_call_meter_maximum_notify(struct ofono_call_meter *cm);
-void ofono_call_meter_changed_notify(struct ofono_call_meter *cm,
-					int new_value);
-
-void ofono_call_meter_set_data(struct ofono_call_meter *cm, void *data);
-void *ofono_call_meter_get_data(struct ofono_call_meter *cm);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CALL_METER_H */
diff --git a/include/call-settings.h b/include/call-settings.h
deleted file mode 100644
index 277b84b..0000000
--- a/include/call-settings.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CALL_SETTINGS_H
-#define __OFONO_CALL_SETTINGS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_call_settings;
-
-typedef void (*ofono_call_settings_status_cb_t)(const struct ofono_error *=
error,
-						int status, void *data);
-
-typedef void (*ofono_call_settings_set_cb_t)(const struct ofono_error *err=
or,
-						void *data);
-
-typedef void (*ofono_call_settings_clir_cb_t)(const struct ofono_error *er=
ror,
-					int override, int network, void *data);
-
-struct ofono_call_settings_driver {
-	const char *name;
-	int (*probe)(struct ofono_call_settings *cs, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_call_settings *cs);
-	void (*clip_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_status_cb_t cb, void *data);
-	void (*cnap_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_status_cb_t cb, void *data);
-	void (*cdip_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_status_cb_t cb, void *data);
-	void (*colp_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_status_cb_t cb, void *data);
-	void (*clir_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_clir_cb_t cb, void *data);
-	void (*colr_query)(struct ofono_call_settings *cs,
-				ofono_call_settings_status_cb_t cb, void *data);
-	void (*clir_set)(struct ofono_call_settings *cs, int mode,
-				ofono_call_settings_set_cb_t cb, void *data);
-	void (*cw_query)(struct ofono_call_settings *cs, int cls,
-			ofono_call_settings_status_cb_t cb, void *data);
-	void (*cw_set)(struct ofono_call_settings *cs, int mode, int cls,
-			ofono_call_settings_set_cb_t cb, void *data);
-};
-
-int ofono_call_settings_driver_register(
-				const struct ofono_call_settings_driver *d);
-void ofono_call_settings_driver_unregister(
-				const struct ofono_call_settings_driver *d);
-
-struct ofono_call_settings *ofono_call_settings_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_call_settings_register(struct ofono_call_settings *cs);
-void ofono_call_settings_remove(struct ofono_call_settings *cs);
-
-void ofono_call_settings_set_data(struct ofono_call_settings *cs, void *da=
ta);
-void *ofono_call_settings_get_data(struct ofono_call_settings *cs);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CALL_SETTINGS_H */
diff --git a/include/call-volume.h b/include/call-volume.h
deleted file mode 100644
index 1217025..0000000
--- a/include/call-volume.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CALL_VOLUME_H
-#define __OFONO_CALL_VOLUME_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-#include <ofono/dbus.h>
-
-struct ofono_call_volume;
-
-typedef void (*ofono_call_volume_cb_t)(const struct ofono_error *error,
-					void *data);
-
-struct ofono_call_volume_driver {
-	const char *name;
-	int (*probe)(struct ofono_call_volume *cv, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_call_volume *cv);
-	void (*speaker_volume)(struct ofono_call_volume *cv,
-				unsigned char percent,
-				ofono_call_volume_cb_t cb, void *data);
-	void (*microphone_volume)(struct ofono_call_volume *cv,
-					unsigned char percent,
-					ofono_call_volume_cb_t cb, void *data);
-	void (*mute)(struct ofono_call_volume *cv, int muted,
-			ofono_call_volume_cb_t cb, void *data);
-};
-
-void ofono_call_volume_set_speaker_volume(struct ofono_call_volume *cv,
-						unsigned char percent);
-void ofono_call_volume_set_microphone_volume(struct ofono_call_volume *cv,
-						unsigned char percent);
-void ofono_call_volume_set_muted(struct ofono_call_volume *cv, int muted);
-
-int ofono_call_volume_driver_register(const struct ofono_call_volume_drive=
r *d);
-void ofono_call_volume_driver_unregister(
-			const struct ofono_call_volume_driver *d);
-
-struct ofono_call_volume *ofono_call_volume_create(struct ofono_modem *mod=
em,
-			unsigned int vendor, const char *driver, void *data);
-
-void ofono_call_volume_register(struct ofono_call_volume *cv);
-void ofono_call_volume_remove(struct ofono_call_volume *cv);
-
-void ofono_call_volume_set_data(struct ofono_call_volume *cv, void *data);
-void *ofono_call_volume_get_data(struct ofono_call_volume *cv);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CALL_VOLUME_H */
diff --git a/include/cbs.h b/include/cbs.h
deleted file mode 100644
index 8dae3ba..0000000
--- a/include/cbs.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CBS_H
-#define __OFONO_CBS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_cbs;
-
-typedef void (*ofono_cbs_set_cb_t)(const struct ofono_error *error,
-					void *data);
-
-struct ofono_cbs_driver {
-	const char *name;
-	int (*probe)(struct ofono_cbs *cbs, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_cbs *cbs);
-	void (*set_topics)(struct ofono_cbs *cbs, const char *topics,
-				ofono_cbs_set_cb_t cb, void *data);
-	void (*clear_topics)(struct ofono_cbs *cbs,
-				ofono_cbs_set_cb_t cb, void *data);
-};
-
-void ofono_cbs_notify(struct ofono_cbs *cbs, const unsigned char *pdu, int=
 len);
-
-int ofono_cbs_driver_register(const struct ofono_cbs_driver *d);
-void ofono_cbs_driver_unregister(const struct ofono_cbs_driver *d);
-
-struct ofono_cbs *ofono_cbs_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_cbs_register(struct ofono_cbs *cbs);
-void ofono_cbs_remove(struct ofono_cbs *cbs);
-
-void ofono_cbs_set_data(struct ofono_cbs *cbs, void *data);
-void *ofono_cbs_get_data(struct ofono_cbs *cbs);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CBS_H */
diff --git a/include/cdma-connman.h b/include/cdma-connman.h
deleted file mode 100644
index 3e6493e..0000000
--- a/include/cdma-connman.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010-2011  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CDMA_CONNMAN_H
-#define __OFONO_CDMA_CONNMAN_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_cdma_connman;
-
-#define OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH 63
-#define OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH 255
-
-typedef void (*ofono_cdma_connman_cb_t)(const struct ofono_error *error,
-						void *data);
-typedef void (*ofono_cdma_connman_up_cb_t)(const struct ofono_error *error,
-						const char *interface,
-						ofono_bool_t static_ip,
-						const char *address,
-						const char *netmask,
-						const char *gw,
-						const char **dns,
-						void *data);
-
-struct ofono_cdma_connman_driver {
-	const char *name;
-	int (*probe)(struct ofono_cdma_connman *cm, unsigned int vendor,
-						void *data);
-	void (*remove)(struct ofono_cdma_connman *cm);
-	void (*activate)(struct ofono_cdma_connman *cm,
-						const char *username,
-						const char *password,
-						ofono_cdma_connman_up_cb_t cb,
-						void *data);
-	void (*deactivate)(struct ofono_cdma_connman *cm,
-						ofono_cdma_connman_cb_t cb,
-						void *data);
-};
-
-int ofono_cdma_connman_driver_register(
-				const struct ofono_cdma_connman_driver *d);
-void ofono_cdma_connman_driver_unregister(
-				const struct ofono_cdma_connman_driver *d);
-
-void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm);
-
-void ofono_cdma_connman_dormant_notify(struct ofono_cdma_connman *cm,
-					ofono_bool_t dormant);
-
-struct ofono_cdma_connman *ofono_cdma_connman_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver,
-						void *data);
-
-void ofono_cdma_connman_register(struct ofono_cdma_connman *cm);
-void ofono_cdma_connman_remove(struct ofono_cdma_connman *cm);
-
-void ofono_cdma_connman_set_data(struct ofono_cdma_connman *cm,
-						void *data);
-void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CDMA_CONNMAN_H */
diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
deleted file mode 100644
index 529dab5..0000000
--- a/include/cdma-netreg.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CDMA_NETREG_H
-#define __OFONO_CDMA_NETREG_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-enum cdma_netreg_status {
-	CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
-	CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
-	CDMA_NETWORK_REGISTRATION_STATUS_ROAMING =3D		2,
-};
-
-struct ofono_cdma_netreg;
-
-typedef void (*ofono_cdma_netreg_serving_system_cb_t)(
-				const struct ofono_error *error,
-				const char *sid,
-				void *data);
-
-struct ofono_cdma_netreg_driver {
-	const char *name;
-	int (*probe)(struct ofono_cdma_netreg *cdma_netreg,
-				unsigned int vendor,
-				void *data);
-	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
-	void (*serving_system)(struct ofono_cdma_netreg *cdma_netreg,
-			ofono_cdma_netreg_serving_system_cb_t cb, void *data);
-};
-
-void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
-					enum cdma_netreg_status status);
-void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
-					int strength);
-void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *netr=
eg,
-						int data_strength);
-int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg);
-
-int ofono_cdma_netreg_driver_register(
-				const struct ofono_cdma_netreg_driver *d);
-void ofono_cdma_netreg_driver_unregister(
-				const struct ofono_cdma_netreg_driver *d);
-
-struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
-							unsigned int vendor,
-							const char *driver,
-							void *data);
-
-void ofono_cdma_netreg_register(struct ofono_cdma_netreg *cdma_netreg);
-void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *cdma_netreg);
-
-void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg,
-				void *data);
-void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CDMA_NETREG_H */
diff --git a/include/cdma-provision.h b/include/cdma-provision.h
deleted file mode 100644
index a6d5765..0000000
--- a/include/cdma-provision.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CDMA_PROVISION_H
-#define __OFONO_CDMA_PROVISION_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct ofono_cdma_provision_driver {
-	const char *name;
-	int priority;
-	int (*get_provider_name)(const char *sid, char **name);
-};
-
-int ofono_cdma_provision_driver_register(
-		const struct ofono_cdma_provision_driver *driver);
-void ofono_cdma_provision_driver_unregister(
-		const struct ofono_cdma_provision_driver *driver);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CDMA_PROVISION_H */
diff --git a/include/cdma-sms.h b/include/cdma-sms.h
deleted file mode 100644
index 3b19f04..0000000
--- a/include/cdma-sms.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010-2011  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CDMA_SMS_H
-#define __OFONO_CDMA_SMS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_cdma_sms;
-
-typedef void (*ofono_cdma_sms_submit_cb_t)(const struct ofono_error *error,
-						void *data);
-
-struct ofono_cdma_sms_driver {
-	const char *name;
-	int (*probe)(struct ofono_cdma_sms *cdma_sms, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_cdma_sms *cdma_sms);
-	void (*submit)(struct ofono_cdma_sms *cdma_sms,
-			const unsigned char *tpdu,
-			int tpdu_len, ofono_cdma_sms_submit_cb_t cb,
-			void *data);
-};
-
-void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
-					const unsigned char *pdu, int tpdu_len);
-
-int ofono_cdma_sms_driver_register(const struct ofono_cdma_sms_driver *d);
-void ofono_cdma_sms_driver_unregister(const struct ofono_cdma_sms_driver *=
d);
-
-struct ofono_cdma_sms *ofono_cdma_sms_create(struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver,
-						void *data);
-
-void ofono_cdma_sms_register(struct ofono_cdma_sms *cdma_sms);
-void ofono_cdma_sms_remove(struct ofono_cdma_sms *cdma_sms);
-
-void ofono_cdma_sms_set_data(struct ofono_cdma_sms *cdma_sms, void *data);
-void *ofono_cdma_sms_get_data(struct ofono_cdma_sms *cdma_sms);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CDMA_SMS_H */
diff --git a/include/cdma-voicecall.h b/include/cdma-voicecall.h
deleted file mode 100644
index 5a4d475..0000000
--- a/include/cdma-voicecall.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CDMA_VOICECALL_H
-#define __OFONO_CDMA_VOICECALL_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_cdma_voicecall;
-
-enum cdma_call_status {
-	CDMA_CALL_STATUS_ACTIVE,
-	CDMA_CALL_STATUS_DIALING,
-	CDMA_CALL_STATUS_ALERTING,
-	CDMA_CALL_STATUS_INCOMING,
-	CDMA_CALL_STATUS_DISCONNECTED
-};
-
-typedef void (*ofono_cdma_voicecall_cb_t)(const struct ofono_error *error,
-						void *data);
-
-/* Voice call related functionality, including AT+CDV, AT+CHV */
-struct ofono_cdma_voicecall_driver {
-	const char *name;
-	int (*probe)(struct ofono_cdma_voicecall *vc,
-			unsigned int vendor, void *data);
-	void (*remove)(struct ofono_cdma_voicecall *vc);
-
-	void (*dial)(struct ofono_cdma_voicecall *vc,
-			const struct ofono_cdma_phone_number *number,
-			ofono_cdma_voicecall_cb_t cb, void *data);
-
-	/* Hangs up active, dialing, alerting or incoming calls */
-	void (*hangup)(struct ofono_cdma_voicecall *vc,
-			ofono_cdma_voicecall_cb_t cb, void *data);
-
-	void (*answer)(struct ofono_cdma_voicecall *vc,
-			ofono_cdma_voicecall_cb_t cb, void *data);
-
-	void (*send_flash)(struct ofono_cdma_voicecall *vc, const char *string,
-			ofono_cdma_voicecall_cb_t cb, void *data);
-
-	void (*send_tones)(struct ofono_cdma_voicecall *vc, const char *tones,
-			ofono_cdma_voicecall_cb_t cb, void *data);
-};
-
-void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
-					enum ofono_disconnect_reason reason,
-					const struct ofono_error *error);
-
-int ofono_cdma_voicecall_driver_register(
-			const struct ofono_cdma_voicecall_driver *d);
-void ofono_cdma_voicecall_driver_unregister(
-			const struct ofono_cdma_voicecall_driver *d);
-
-struct ofono_cdma_voicecall *ofono_cdma_voicecall_create(
-					struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_cdma_voicecall_register(struct ofono_cdma_voicecall *vc);
-void ofono_cdma_voicecall_remove(struct ofono_cdma_voicecall *vc);
-
-void ofono_cdma_voicecall_set_data(struct ofono_cdma_voicecall *vc,
-					void *data);
-void *ofono_cdma_voicecall_get_data(struct ofono_cdma_voicecall *vc);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CDMA_VOICECALL_H */
diff --git a/include/ctm.h b/include/ctm.h
deleted file mode 100644
index 76d1544..0000000
--- a/include/ctm.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
- *  Copyright (C) 2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_CTM_H
-#define __OFONO_CTM_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_ctm;
-
-typedef void (*ofono_ctm_set_cb_t)(const struct ofono_error *error,
-					void *data);
-typedef void (*ofono_ctm_query_cb_t)(const struct ofono_error *error,
-					ofono_bool_t enable, void *data);
-
-struct ofono_ctm_driver {
-	const char *name;
-	int (*probe)(struct ofono_ctm *ctm, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_ctm *ctm);
-	void (*query_tty)(struct ofono_ctm *ctm,
-				ofono_ctm_query_cb_t cb, void *data);
-	void (*set_tty)(struct ofono_ctm *ctm, ofono_bool_t enable,
-				ofono_ctm_set_cb_t cb, void *data);
-};
-
-int ofono_ctm_driver_register(const struct ofono_ctm_driver *d);
-void ofono_ctm_driver_unregister(const struct ofono_ctm_driver *d);
-
-struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_ctm_register(struct ofono_ctm *ctm);
-void ofono_ctm_remove(struct ofono_ctm *ctm);
-
-void ofono_ctm_set_data(struct ofono_ctm *ctm, void *data);
-void *ofono_ctm_get_data(struct ofono_ctm *ctm);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_CTM_H */
diff --git a/include/dbus.h b/include/dbus.h
deleted file mode 100644
index 3d39eff..0000000
--- a/include/dbus.h
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_DBUS_H
-#define __OFONO_DBUS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <dbus/dbus.h>
-
-#define OFONO_SERVICE	"org.ofono"
-#define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
-#define OFONO_MANAGER_PATH "/"
-#define OFONO_MODEM_INTERFACE "org.ofono.Modem"
-#define OFONO_CALL_BARRING_INTERFACE "org.ofono.CallBarring"
-#define OFONO_CALL_FORWARDING_INTERFACE "org.ofono.CallForwarding"
-#define OFONO_CALL_METER_INTERFACE "org.ofono.CallMeter"
-#define OFONO_CALL_SETTINGS_INTERFACE "org.ofono.CallSettings"
-#define OFONO_CALL_VOLUME_INTERFACE OFONO_SERVICE ".CallVolume"
-#define OFONO_CELL_BROADCAST_INTERFACE "org.ofono.CellBroadcast"
-#define OFONO_CONNECTION_CONTEXT_INTERFACE "org.ofono.ConnectionContext"
-#define OFONO_CONNECTION_MANAGER_INTERFACE "org.ofono.ConnectionManager"
-#define OFONO_MESSAGE_MANAGER_INTERFACE "org.ofono.MessageManager"
-#define OFONO_MESSAGE_INTERFACE "org.ofono.Message"
-#define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
-#define OFONO_SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementarySer=
vices"
-#define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
-#define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
-#define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
-#define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
-#define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
-#define OFONO_TEXT_TELEPHONY_INTERFACE "org.ofono.TextTelephony"
-#define OFONO_SIM_MANAGER_INTERFACE "org.ofono.SimManager"
-#define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
-#define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
-#define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
-#define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
-#define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
-#define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
-#define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
-#define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
-#define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
-
-/* CDMA Interfaces */
-#define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-#define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
-#define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
-#define OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE \
-					"org.ofono.cdma.NetworkRegistration"
-
-/* Essentially a{sv} */
-#define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
-					DBUS_TYPE_STRING_AS_STRING \
-					DBUS_TYPE_VARIANT_AS_STRING \
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
-
-DBusConnection *ofono_dbus_get_connection(void);
-
-void ofono_dbus_dict_append(DBusMessageIter *dict, const char *key, int ty=
pe,
-				const void *value);
-
-void ofono_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
-					int type, const void *val);
-
-void ofono_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
-					int type, const void *val);
-
-int ofono_dbus_signal_property_changed(DBusConnection *conn, const char *p=
ath,
-					const char *interface, const char *name,
-					int type, const void *value);
-
-int ofono_dbus_signal_array_property_changed(DBusConnection *conn,
-						const char *path,
-						const char *interface,
-						const char *name, int type,
-						const void *value);
-
-int ofono_dbus_signal_dict_property_changed(DBusConnection *conn,
-						const char *path,
-						const char *interface,
-						const char *name, int type,
-						const void *value);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_DBUS_H */
diff --git a/include/devinfo.h b/include/devinfo.h
deleted file mode 100644
index a9acce9..0000000
--- a/include/devinfo.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_DEVINFO_H
-#define __OFONO_DEVINFO_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_devinfo;
-
-typedef void (*ofono_devinfo_query_cb_t)(const struct ofono_error *error,
-					const char *attribute, void *data);
-
-struct ofono_devinfo_driver {
-	const char *name;
-	int (*probe)(struct ofono_devinfo *info, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_devinfo *info);
-	void (*query_manufacturer)(struct ofono_devinfo *info,
-			ofono_devinfo_query_cb_t cb, void *data);
-	void (*query_serial)(struct ofono_devinfo *info,
-			ofono_devinfo_query_cb_t cb, void *data);
-	void (*query_model)(struct ofono_devinfo *info,
-			ofono_devinfo_query_cb_t cb, void *data);
-	void (*query_revision)(struct ofono_devinfo *info,
-			ofono_devinfo_query_cb_t cb, void *data);
-};
-
-int ofono_devinfo_driver_register(const struct ofono_devinfo_driver *d);
-void ofono_devinfo_driver_unregister(const struct ofono_devinfo_driver *d);
-
-struct ofono_devinfo *ofono_devinfo_create(struct ofono_modem *modem,
-							unsigned int vendor,
-							const char *driver,
-							void *data);
-void ofono_devinfo_register(struct ofono_devinfo *info);
-void ofono_devinfo_remove(struct ofono_devinfo *info);
-
-void ofono_devinfo_set_data(struct ofono_devinfo *info, void *data);
-void *ofono_devinfo_get_data(struct ofono_devinfo *info);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_MODEM_INFO_H */
diff --git a/include/emulator.h b/include/emulator.h
deleted file mode 100644
index 5e8d431..0000000
--- a/include/emulator.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_EMULATOR_H
-#define __OFONO_EMULATOR_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-#define OFONO_EMULATOR_IND_BATTERY "battchg"
-#define OFONO_EMULATOR_IND_CALL "call"
-#define OFONO_EMULATOR_IND_CALLHELD "callheld"
-#define OFONO_EMULATOR_IND_CALLSETUP "callsetup"
-#define OFONO_EMULATOR_IND_ROAMING "roam"
-#define OFONO_EMULATOR_IND_SERVICE "service"
-#define OFONO_EMULATOR_IND_SIGNAL "signal"
-
-#define OFONO_EMULATOR_CALL_INACTIVE 0
-#define OFONO_EMULATOR_CALL_ACTIVE 1
-
-#define OFONO_EMULATOR_CALLSETUP_INACTIVE 0
-#define OFONO_EMULATOR_CALLSETUP_INCOMING 1
-#define OFONO_EMULATOR_CALLSETUP_OUTGOING 2
-#define OFONO_EMULATOR_CALLSETUP_ALERTING 3
-
-#define OFONO_EMULATOR_CALLHELD_NONE 0
-#define OFONO_EMULATOR_CALLHELD_MULTIPLE 1
-#define OFONO_EMULATOR_CALLHELD_ON_HOLD 2
-
-struct ofono_emulator;
-struct ofono_emulator_request;
-
-enum ofono_emulator_type {
-	OFONO_EMULATOR_TYPE_DUN,
-	OFONO_EMULATOR_TYPE_HFP,
-};
-
-enum ofono_emulator_request_type {
-	OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY,
-	OFONO_EMULATOR_REQUEST_TYPE_QUERY,
-	OFONO_EMULATOR_REQUEST_TYPE_SUPPORT,
-	OFONO_EMULATOR_REQUEST_TYPE_SET,
-};
-
-typedef void (*ofono_emulator_request_cb_t)(struct ofono_emulator *em,
-					struct ofono_emulator_request *req,
-					void *data);
-
-struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
-						enum ofono_emulator_type type);
-
-void ofono_emulator_register(struct ofono_emulator *em, int fd);
-
-void ofono_emulator_remove(struct ofono_emulator *em);
-
-void ofono_emulator_send_final(struct ofono_emulator *em,
-				const struct ofono_error *final);
-void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
-					const char *result);
-void ofono_emulator_send_intermediate(struct ofono_emulator *em,
-					const char *result);
-void ofono_emulator_send_info(struct ofono_emulator *em, const char *line,
-				ofono_bool_t last);
-
-ofono_bool_t ofono_emulator_add_handler(struct ofono_emulator *em,
-					const char *prefix,
-					ofono_emulator_request_cb_t cb,
-					void *data, ofono_destroy_func destroy);
-ofono_bool_t ofono_emulator_remove_handler(struct ofono_emulator *em,
-						const char *prefix);
-
-ofono_bool_t ofono_emulator_request_next_string(
-					struct ofono_emulator_request *req,
-					const char **str);
-ofono_bool_t ofono_emulator_request_next_number(
-					struct ofono_emulator_request *req,
-					int *number);
-
-const char *ofono_emulator_request_get_raw(struct ofono_emulator_request *=
req);
-
-enum ofono_emulator_request_type ofono_emulator_request_get_type(
-					struct ofono_emulator_request *req);
-
-void ofono_emulator_set_indicator(struct ofono_emulator *em,
-					const char *name, int value);
-void ofono_emulator_set_hf_indicator_active(struct ofono_emulator *em,
-						int indicator,
-						ofono_bool_t active);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_EMULATOR_H */
diff --git a/include/gnss.h b/include/gnss.h
deleted file mode 100644
index e7fc660..0000000
--- a/include/gnss.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *  Copyright (C) 2011  ST-Ericsson AB.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_GNSS_H
-#define __OFONO_GNSS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_gnss;
-
-typedef void (*ofono_gnss_cb_t)(const struct ofono_error *error, void *dat=
a);
-
-struct ofono_gnss_driver {
-	const char *name;
-	int (*probe)(struct ofono_gnss *gnss, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_gnss *gnss);
-	void (*send_element)(struct ofono_gnss *gnss,
-				const char *xml,
-				ofono_gnss_cb_t cb, void *data);
-	void (*set_position_reporting)(struct ofono_gnss *gnss,
-					ofono_bool_t enable,
-					ofono_gnss_cb_t cb,
-					void *data);
-};
-
-void ofono_gnss_notify_posr_request(struct ofono_gnss *gnss, const char *x=
ml);
-void ofono_gnss_notify_posr_reset(struct ofono_gnss *gnss);
-int ofono_gnss_driver_register(const struct ofono_gnss_driver *d);
-void ofono_gnss_driver_unregister(const struct ofono_gnss_driver *d);
-
-struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_gnss_register(struct ofono_gnss *gnss);
-void ofono_gnss_remove(struct ofono_gnss *gnss);
-
-void ofono_gnss_set_data(struct ofono_gnss *gnss, void *data);
-void *ofono_gnss_get_data(struct ofono_gnss *gnss);
-
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_GNSS_H */
diff --git a/include/gprs-context.h b/include/gprs-context.h
deleted file mode 100644
index ed27e66..0000000
--- a/include/gprs-context.h
+++ /dev/null
@@ -1,130 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_GPRS_CONTEXT_H
-#define __OFONO_GPRS_CONTEXT_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_gprs_context;
-
-#define OFONO_GPRS_MAX_APN_LENGTH 127
-#define OFONO_GPRS_MAX_USERNAME_LENGTH 63
-#define OFONO_GPRS_MAX_PASSWORD_LENGTH 255
-
-enum ofono_gprs_proto {
-	OFONO_GPRS_PROTO_IP =3D 0,
-	OFONO_GPRS_PROTO_IPV6,
-	OFONO_GPRS_PROTO_IPV4V6,
-};
-
-enum ofono_gprs_context_type {
-	OFONO_GPRS_CONTEXT_TYPE_ANY =3D 0,
-	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
-	OFONO_GPRS_CONTEXT_TYPE_MMS,
-	OFONO_GPRS_CONTEXT_TYPE_WAP,
-	OFONO_GPRS_CONTEXT_TYPE_IMS,
-};
-
-enum ofono_gprs_auth_method {
-	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
-	OFONO_GPRS_AUTH_METHOD_PAP,
-};
-
-struct ofono_gprs_primary_context {
-	unsigned int cid;
-	int direction;
-	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
-	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
-	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
-	enum ofono_gprs_proto proto;
-	enum ofono_gprs_auth_method auth_method;
-};
-
-typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
-					void *data);
-
-struct ofono_gprs_context_driver {
-	const char *name;
-	int (*probe)(struct ofono_gprs_context *gc, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_gprs_context *gc);
-	void (*activate_primary)(struct ofono_gprs_context *gc,
-				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_cb_t cb, void *data);
-	void (*deactivate_primary)(struct ofono_gprs_context *gc,
-					unsigned int id,
-					ofono_gprs_context_cb_t cb, void *data);
-	void (*detach_shutdown)(struct ofono_gprs_context *gc,
-					unsigned int id);
-};
-
-void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
-					unsigned int id);
-
-int ofono_gprs_context_driver_register(
-				const struct ofono_gprs_context_driver *d);
-void ofono_gprs_context_driver_unregister(
-				const struct ofono_gprs_context_driver *d);
-
-struct ofono_gprs_context *ofono_gprs_context_create(struct ofono_modem *m=
odem,
-						unsigned int vendor,
-						const char *driver, void *data);
-void ofono_gprs_context_remove(struct ofono_gprs_context *gc);
-
-void ofono_gprs_context_set_data(struct ofono_gprs_context *gc, void *data=
);
-void *ofono_gprs_context_get_data(struct ofono_gprs_context *gc);
-
-struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc);
-
-void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
-					enum ofono_gprs_context_type type);
-
-void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
-					const char *interface);
-
-void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
-						const char *address,
-						ofono_bool_t static_ip);
-void ofono_gprs_context_set_ipv4_netmask(struct ofono_gprs_context *gc,
-						const char *netmask);
-void ofono_gprs_context_set_ipv4_gateway(struct ofono_gprs_context *gc,
-						const char *gateway);
-void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *gc,
-						const char **dns);
-
-void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
-						const char *address);
-void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context *=
gc,
-						unsigned char length);
-void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
-						const char *gateway);
-void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
-						const char **dns);
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_GPRS_CONTEXT_H */
diff --git a/include/gprs-provision.h b/include/gprs-provision.h
deleted file mode 100644
index 2dd792b..0000000
--- a/include/gprs-provision.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_GPRS_PROVISION_H
-#define __OFONO_GPRS_PROVISION_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include "gprs-context.h"
-
-struct ofono_gprs_provision_data {
-	enum ofono_gprs_context_type type;
-	enum ofono_gprs_proto proto;
-	char *name;
-	char *apn;
-	char *username;
-	char *password;
-	enum ofono_gprs_auth_method auth_method;
-	char *message_proxy;
-	char *message_center;
-};
-
-struct ofono_gprs_provision_driver {
-	const char *name;
-	int priority;
-	int (*get_settings)(const char *mcc, const char *mnc, const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count);
-};
-
-int ofono_gprs_provision_driver_register(
-			const struct ofono_gprs_provision_driver *driver);
-void ofono_gprs_provision_driver_unregister(
-			const struct ofono_gprs_provision_driver *driver);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_GPRS_PROVISION_H */
diff --git a/include/gprs.h b/include/gprs.h
deleted file mode 100644
index 6c46d18..0000000
--- a/include/gprs.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_GPRS_H
-#define __OFONO_GPRS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_gprs;
-struct ofono_gprs_context;
-
-typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
-						int status, void *data);
-
-typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
-
-struct ofono_gprs_driver {
-	const char *name;
-	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_gprs *gprs);
-	void (*set_attached)(struct ofono_gprs *gprs, int attached,
-				ofono_gprs_cb_t cb, void *data);
-	void (*attached_status)(struct ofono_gprs *gprs,
-					ofono_gprs_status_cb_t cb, void *data);
-};
-
-enum gprs_suspend_cause {
-	GPRS_SUSPENDED_DETACHED,
-	GPRS_SUSPENDED_SIGNALLING,
-	GPRS_SUSPENDED_CALL,
-	GPRS_SUSPENDED_NO_COVERAGE,
-	GPRS_SUSPENDED_UNKNOWN_CAUSE,
-};
-
-void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
-void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
-void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
-void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
-void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer);
-
-int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
-void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
-
-struct ofono_gprs *ofono_gprs_create(struct ofono_modem *modem,
-					unsigned int vendor, const char *driver,
-					void *data);
-void ofono_gprs_register(struct ofono_gprs *gprs);
-void ofono_gprs_remove(struct ofono_gprs *gprs);
-
-void ofono_gprs_set_data(struct ofono_gprs *gprs, void *data);
-void *ofono_gprs_get_data(struct ofono_gprs *gprs);
-
-void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
-				unsigned int min, unsigned int max);
-void ofono_gprs_add_context(struct ofono_gprs *gprs,
-				struct ofono_gprs_context *gc);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_GPRS_H */
diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
deleted file mode 100644
index 03e3b38..0000000
--- a/include/handsfree-audio.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2013  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_HANDSFREE_AUDIO_H
-#define __OFONO_HANDSFREE_AUDIO_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_handsfree_card;
-
-typedef void (*ofono_handsfree_card_connect_cb_t)(
-				const struct ofono_error *error, void *data);
-
-struct ofono_handsfree_card_driver {
-	const char *name;
-	int (*probe)(struct ofono_handsfree_card *card, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_handsfree_card *card);
-	void (*connect)(struct ofono_handsfree_card *card,
-				ofono_handsfree_card_connect_cb_t cb,
-				void *data);
-};
-
-struct ofono_handsfree_card *ofono_handsfree_card_create(unsigned int vend=
or,
-							const char *driver,
-							void *data);
-int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
-void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
-ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_handsfree_card *c=
ard,
-							unsigned char codec);
-
-ofono_bool_t ofono_handsfree_audio_has_wideband(void);
-
-ofono_bool_t ofono_handsfree_audio_has_transparent_sco(void);
-
-void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
-					void *data);
-void *ofono_handsfree_card_get_data(struct ofono_handsfree_card *card);
-
-void ofono_handsfree_card_set_remote(struct ofono_handsfree_card *card,
-					const char *remote);
-const char *ofono_handsfree_card_get_remote(struct ofono_handsfree_card *c=
ard);
-
-void ofono_handsfree_card_set_local(struct ofono_handsfree_card *card,
-					const char *local);
-const char *ofono_handsfree_card_get_local(struct ofono_handsfree_card *ca=
rd);
-
-int ofono_handsfree_card_connect_sco(struct ofono_handsfree_card *card);
-
-void ofono_handsfree_audio_ref(void);
-void ofono_handsfree_audio_unref(void);
-
-int ofono_handsfree_card_driver_register(
-				const struct ofono_handsfree_card_driver *d);
-void ofono_handsfree_card_driver_unregister(
-				const struct ofono_handsfree_card_driver *d);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_HANDSFREE_AUDIO_H */
diff --git a/include/handsfree.h b/include/handsfree.h
deleted file mode 100644
index ed0deb8..0000000
--- a/include/handsfree.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_HANDSFREE_H
-#define __OFONO_HANDSFREE_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_handsfree;
-
-typedef void (*ofono_handsfree_cb_t)(const struct ofono_error *error,
-					void *data);
-typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
-					const struct ofono_phone_number *number,
-					void *data);
-typedef void (*ofono_handsfree_cnum_query_cb_t)(const struct ofono_error *=
error,
-				int total,
-				const struct ofono_phone_number *numbers,
-				void *data);
-
-struct ofono_handsfree_driver {
-	const char *name;
-	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_handsfree *hf);
-	void (*cnum_query)(struct ofono_handsfree *hf,
-				ofono_handsfree_cnum_query_cb_t cb, void *data);
-	void (*request_phone_number) (struct ofono_handsfree *hf,
-					ofono_handsfree_phone_cb_t cb,
-					void *data);
-	void (*voice_recognition)(struct ofono_handsfree *hf,
-					ofono_bool_t enabled,
-					ofono_handsfree_cb_t cb, void *data);
-	void (*disable_nrec)(struct ofono_handsfree *hf,
-					ofono_handsfree_cb_t cb, void *data);
-	void (*hf_indicator)(struct ofono_handsfree *hf,
-				unsigned short indicator, unsigned int value,
-				ofono_handsfree_cb_t cb, void *data);
-};
-
-void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
-					unsigned int ag_features);
-void ofono_handsfree_set_ag_chld_features(struct ofono_handsfree *hf,
-					unsigned int ag_chld_features);
-void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
-						ofono_bool_t enabled);
-void ofono_handsfree_voice_recognition_notify(struct ofono_handsfree *hf,
-						ofono_bool_t enabled);
-
-void ofono_handsfree_set_hf_indicators(struct ofono_handsfree *hf,
-					const unsigned short *indicators,
-					unsigned int num);
-void ofono_handsfree_hf_indicator_active_notify(struct ofono_handsfree *hf,
-						unsigned int indicator,
-						ofono_bool_t active);
-
-void ofono_handsfree_battchg_notify(struct ofono_handsfree *hf,
-					unsigned char level);
-
-int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
-void ofono_handsfree_driver_unregister(
-			const struct ofono_handsfree_driver *d);
-
-struct ofono_handsfree *ofono_handsfree_create(struct ofono_modem *modem,
-			unsigned int vendor, const char *driver, void *data);
-
-void ofono_handsfree_register(struct ofono_handsfree *hf);
-void ofono_handsfree_remove(struct ofono_handsfree *hf);
-
-void ofono_handsfree_set_data(struct ofono_handsfree *hf, void *data);
-void *ofono_handsfree_get_data(struct ofono_handsfree *hf);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_HANDSFREE_H */
diff --git a/include/history.h b/include/history.h
deleted file mode 100644
index cfa05fc..0000000
--- a/include/history.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_HISTORY_H
-#define __OFONO_HISTORY_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-enum ofono_disconnect_reason;
-struct ofono_call;
-
-enum ofono_history_sms_status {
-	OFONO_HISTORY_SMS_STATUS_PENDING,
-	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
-	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
-	OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED,
-	OFONO_HISTORY_SMS_STATUS_DELIVERED,
-	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
-};
-
-struct ofono_history_context {
-	struct ofono_history_driver *driver;
-	struct ofono_modem *modem;
-	void *data;
-};
-
-struct ofono_history_driver {
-	const char *name;
-	int (*probe)(struct ofono_history_context *context);
-	void (*remove)(struct ofono_history_context *context);
-	void (*call_ended)(struct ofono_history_context *context,
-				const struct ofono_call *call,
-				time_t start, time_t end);
-	void (*call_missed)(struct ofono_history_context *context,
-				const struct ofono_call *call, time_t when);
-	void (*sms_received)(struct ofono_history_context *context,
-				const struct ofono_uuid *uuid, const char *from,
-				const struct tm *remote, const struct tm *local,
-				const char *text);
-	void (*sms_send_pending)(struct ofono_history_context *context,
-					const struct ofono_uuid *uuid,
-					const char *to,
-					time_t when, const char *text);
-	void (*sms_send_status)(struct ofono_history_context *context,
-					const struct ofono_uuid *uuid,
-					time_t when,
-					enum ofono_history_sms_status status);
-};
-
-int ofono_history_driver_register(const struct ofono_history_driver *drive=
r);
-void ofono_history_driver_unregister(const struct ofono_history_driver *dr=
iver);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_HISTORY_H */
diff --git a/include/location-reporting.h b/include/location-reporting.h
deleted file mode 100644
index 0717f71..0000000
--- a/include/location-reporting.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
- *  Copyright (C) 2010  ProFUSION embedded systems.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_LOCATION_REPORTING_H
-#define __OFONO_LOCATION_REPORTING_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_location_reporting;
-
-enum ofono_location_reporting_type {
-	OFONO_LOCATION_REPORTING_TYPE_NMEA =3D 0,
-};
-
-typedef void (*ofono_location_reporting_enable_cb_t)(
-						const struct ofono_error *error,
-						int fd, void *data);
-typedef void (*ofono_location_reporting_disable_cb_t)(
-						const struct ofono_error *error,
-						void *data);
-
-struct ofono_location_reporting_driver {
-	const char *name;
-	enum ofono_location_reporting_type type;
-	int (*probe)(struct ofono_location_reporting *lr, unsigned int vendor,
-								void *data);
-	void (*remove)(struct ofono_location_reporting *lr);
-	void (*enable)(struct ofono_location_reporting *lr,
-			ofono_location_reporting_enable_cb_t cb, void *data);
-	void (*disable)(struct ofono_location_reporting *lr,
-			ofono_location_reporting_disable_cb_t cb, void *data);
-};
-
-int ofono_location_reporting_driver_register(
-			const struct ofono_location_reporting_driver *d);
-void ofono_location_reporting_driver_unregister(
-			const struct ofono_location_reporting_driver *d);
-
-struct ofono_location_reporting *ofono_location_reporting_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_location_reporting_register(struct ofono_location_reporting *lr=
);
-void ofono_location_reporting_remove(struct ofono_location_reporting *lr);
-
-void ofono_location_reporting_set_data(struct ofono_location_reporting *lr,
-								void *data);
-void *ofono_location_reporting_get_data(struct ofono_location_reporting *l=
r);
-
-struct ofono_modem *ofono_location_reporting_get_modem(
-					struct ofono_location_reporting *lr);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_LOCATION_REPORTING_H */
diff --git a/include/log.h b/include/log.h
deleted file mode 100644
index ebfa540..0000000
--- a/include/log.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_LOG_H
-#define __OFONO_LOG_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/**
- * SECTION:log
- * @title: Logging premitives
- * @short_description: Functions for logging error and debug information
- */
-
-extern void ofono_info(const char *format, ...)
-				__attribute__((format(printf, 1, 2)));
-extern void ofono_warn(const char *format, ...)
-				__attribute__((format(printf, 1, 2)));
-extern void ofono_error(const char *format, ...)
-				__attribute__((format(printf, 1, 2)));
-extern void ofono_debug(const char *format, ...)
-				__attribute__((format(printf, 1, 2)));
-
-struct ofono_debug_desc {
-	const char *name;
-	const char *file;
-#define OFONO_DEBUG_FLAG_DEFAULT (0)
-#define OFONO_DEBUG_FLAG_PRINT   (1 << 0)
-	unsigned int flags;
-} __attribute__((aligned(8)));
-
-/**
- * DBG:
- * @fmt: format string
- * @arg...: list of arguments
- *
- * Simple macro around ofono_debug() which also include the function
- * name it is called in.
- */
-#define DBG(fmt, arg...) do { \
-	static struct ofono_debug_desc __ofono_debug_desc \
-	__attribute__((used, section("__debug"), aligned(8))) =3D { \
-		.file =3D __FILE__, .flags =3D OFONO_DEBUG_FLAG_DEFAULT, \
-	}; \
-	if (__ofono_debug_desc.flags & OFONO_DEBUG_FLAG_PRINT) \
-		ofono_debug("%s:%s() " fmt, \
-					__FILE__, __FUNCTION__ , ## arg); \
-} while (0)
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_LOG_H */
diff --git a/include/message-waiting.h b/include/message-waiting.h
deleted file mode 100644
index c120e9d..0000000
--- a/include/message-waiting.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_MESSAGE_WAITING_H
-#define __OFONO_MESSAGE_WAITING_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_message_waiting;
-
-struct ofono_message_waiting *ofono_message_waiting_create(
-						struct ofono_modem *modem);
-void ofono_message_waiting_register(struct ofono_message_waiting *mw);
-void ofono_message_waiting_remove(struct ofono_message_waiting *mw);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_MESSAGE_WAITING_H */
diff --git a/include/modem.h b/include/modem.h
deleted file mode 100644
index e40b23e..0000000
--- a/include/modem.h
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_MODEM_H
-#define __OFONO_MODEM_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_modem;
-
-enum ofono_modem_type {
-	OFONO_MODEM_TYPE_HARDWARE =3D 0,
-	OFONO_MODEM_TYPE_HFP,
-	OFONO_MODEM_TYPE_SAP,
-	OFONO_MODEM_TYPE_TEST,
-};
-
-typedef void (*ofono_modem_online_cb_t)(const struct ofono_error *error,
-					void *data);
-
-typedef ofono_bool_t (*ofono_modem_compare_cb_t)(struct ofono_modem *modem,
-							void *user_data);
-
-struct ofono_modem_driver {
-	const char *name;
-	enum ofono_modem_type modem_type;
-
-	/* Detect existence of device and initialize any device-specific data
-	 * structures */
-	int (*probe)(struct ofono_modem *modem);
-
-	/* Destroy data structures allocated during probe and cleanup */
-	void (*remove)(struct ofono_modem *modem);
-
-	/* Power up device */
-	int (*enable)(struct ofono_modem *modem);
-
-	/* Power down device */
-	int (*disable)(struct ofono_modem *modem);
-
-	/* Enable or disable cellular radio */
-	void (*set_online)(struct ofono_modem *modem, ofono_bool_t online,
-				ofono_modem_online_cb_t callback, void *data);
-
-	/* Populate the atoms available without SIM / Locked SIM */
-	void (*pre_sim)(struct ofono_modem *modem);
-
-	/* Populate the atoms that are available with SIM / Unlocked SIM*/
-	void (*post_sim)(struct ofono_modem *modem);
-
-	/* Populate the atoms available online */
-	void (*post_online)(struct ofono_modem *modem);
-};
-
-void ofono_modem_add_interface(struct ofono_modem *modem,
-				const char *interface);
-void ofono_modem_remove_interface(struct ofono_modem *modem,
-					const char *interface);
-
-const char *ofono_modem_get_path(struct ofono_modem *modem);
-
-void ofono_modem_set_data(struct ofono_modem *modem, void *data);
-void *ofono_modem_get_data(struct ofono_modem *modem);
-
-struct ofono_modem *ofono_modem_create(const char *name, const char *type);
-int ofono_modem_register(struct ofono_modem *modem);
-
-ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
-void ofono_modem_remove(struct ofono_modem *modem);
-
-void ofono_modem_reset(struct ofono_modem *modem);
-
-void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
-ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
-
-ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
-
-ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
-
-void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
-void ofono_modem_set_driver(struct ofono_modem *modem, const char *type);
-
-int ofono_modem_set_string(struct ofono_modem *modem,
-				const char *key, const char *value);
-const char *ofono_modem_get_string(struct ofono_modem *modem, const char *=
key);
-
-int ofono_modem_set_integer(struct ofono_modem *modem,
-				const char *key, int value);
-int ofono_modem_get_integer(struct ofono_modem *modem, const char *key);
-
-int ofono_modem_set_boolean(struct ofono_modem *modem,
-				const char *key, ofono_bool_t value);
-ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem,
-					const char *key);
-
-int ofono_modem_driver_register(const struct ofono_modem_driver *);
-void ofono_modem_driver_unregister(const struct ofono_modem_driver *);
-
-struct ofono_modem *ofono_modem_find(ofono_modem_compare_cb_t func,
-					void *user_data);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_MODEM_H */
diff --git a/include/netreg.h b/include/netreg.h
deleted file mode 100644
index 4338c14..0000000
--- a/include/netreg.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_NETREG_H
-#define __OFONO_NETREG_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_netreg;
-
-/* Theoretical limit is 16, but each GSM char can be encoded into
- *  * 3 UTF8 characters resulting in 16*3=3D48 chars
- *   */
-#define OFONO_MAX_OPERATOR_NAME_LENGTH 63
-
-struct ofono_network_operator {
-	char name[OFONO_MAX_OPERATOR_NAME_LENGTH + 1];
-	char mcc[OFONO_MAX_MCC_LENGTH + 1];
-	char mnc[OFONO_MAX_MNC_LENGTH + 1];
-	int status;
-	int tech;
-};
-
-typedef void (*ofono_netreg_operator_cb_t)(const struct ofono_error *error,
-					const struct ofono_network_operator *op,
-					void *data);
-
-typedef void (*ofono_netreg_register_cb_t)(const struct ofono_error *error,
-						void *data);
-
-typedef void (*ofono_netreg_operator_list_cb_t)(const struct ofono_error *=
error,
-				int total,
-				const struct ofono_network_operator *list,
-				void *data);
-
-typedef void (*ofono_netreg_status_cb_t)(const struct ofono_error *error,
-					int status, int lac, int ci, int tech,
-					void *data);
-
-typedef void (*ofono_netreg_strength_cb_t)(const struct ofono_error *error,
-						int strength, void *data);
-
-/* Network related functions, including registration status, operator sele=
ction
- * and signal strength indicators.
- *
- * It is up to the plugin to implement CSQ polling if the modem does not s=
upport
- * vendor extensions for signal strength notification.
- */
-struct ofono_netreg_driver {
-	const char *name;
-	int (*probe)(struct ofono_netreg *netreg, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_netreg *netreg);
-	void (*registration_status)(struct ofono_netreg *netreg,
-			ofono_netreg_status_cb_t cb, void *data);
-	void (*current_operator)(struct ofono_netreg *netreg,
-			ofono_netreg_operator_cb_t cb, void *data);
-	void (*list_operators)(struct ofono_netreg *netreg,
-			ofono_netreg_operator_list_cb_t cb, void *data);
-	void (*register_auto)(struct ofono_netreg *netreg,
-			ofono_netreg_register_cb_t cb, void *data);
-	void (*register_manual)(struct ofono_netreg *netreg,
-				const char *mcc, const char *mnc,
-				ofono_netreg_register_cb_t cb, void *data);
-	void (*strength)(struct ofono_netreg *netreg,
-			ofono_netreg_strength_cb_t, void *data);
-};
-
-void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h);
-void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
-					int lac, int ci, int tech);
-void ofono_netreg_time_notify(struct ofono_netreg *netreg,
-				struct ofono_network_time *info);
-
-int ofono_netreg_driver_register(const struct ofono_netreg_driver *d);
-void ofono_netreg_driver_unregister(const struct ofono_netreg_driver *d);
-
-struct ofono_netreg *ofono_netreg_create(struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver,
-						void *data);
-
-void ofono_netreg_register(struct ofono_netreg *netreg);
-void ofono_netreg_remove(struct ofono_netreg *netreg);
-
-void ofono_netreg_set_data(struct ofono_netreg *netreg, void *data);
-void *ofono_netreg_get_data(struct ofono_netreg *netreg);
-
-int ofono_netreg_get_location(struct ofono_netreg *netreg);
-int ofono_netreg_get_cellid(struct ofono_netreg *netreg);
-int ofono_netreg_get_status(struct ofono_netreg *netreg);
-int ofono_netreg_get_technology(struct ofono_netreg *netreg);
-const char *ofono_netreg_get_mcc(struct ofono_netreg *netreg);
-const char *ofono_netreg_get_mnc(struct ofono_netreg *netreg);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_NETREG_H */
diff --git a/include/nettime.h b/include/nettime.h
deleted file mode 100644
index 0f23cc7..0000000
--- a/include/nettime.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_NETTIME_H
-#define __OFONO_NETTIME_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct ofono_network_time;
-
-struct ofono_nettime_context {
-	struct ofono_nettime_driver *driver;
-	struct ofono_modem *modem;
-	void *data;
-};
-
-struct ofono_nettime_driver {
-	const char *name;
-	int (*probe)(struct ofono_nettime_context *context);
-	void (*remove)(struct ofono_nettime_context *context);
-	void (*info_received)(struct ofono_nettime_context *context,
-				struct ofono_network_time *info);
-};
-
-int ofono_nettime_driver_register(const struct ofono_nettime_driver *drive=
r);
-void ofono_nettime_driver_unregister(const struct ofono_nettime_driver *dr=
iver);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_NETTIME_H */
diff --git a/include/ofono/audio-settings.h b/include/ofono/audio-settings.h
new file mode 100644
index 0000000..362f8df
--- /dev/null
+++ b/include/ofono/audio-settings.h
@@ -0,0 +1,68 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_AUDIO_SETTINGS_H
+#define __OFONO_AUDIO_SETTINGS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_audio_settings;
+
+struct ofono_audio_settings_driver {
+	const char *name;
+	int (*probe)(struct ofono_audio_settings *as,
+				unsigned int vendor, void *data);
+	void (*remove)(struct ofono_audio_settings *as);
+};
+
+void ofono_audio_settings_active_notify(struct ofono_audio_settings *as,
+						ofono_bool_t active);
+void ofono_audio_settings_mode_notify(struct ofono_audio_settings *as,
+						const char *mode);
+
+int ofono_audio_settings_driver_register(
+				const struct ofono_audio_settings_driver *d);
+void ofono_audio_settings_driver_unregister(
+				const struct ofono_audio_settings_driver *d);
+
+struct ofono_audio_settings *ofono_audio_settings_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_audio_settings_register(struct ofono_audio_settings *as);
+void ofono_audio_settings_remove(struct ofono_audio_settings *as);
+
+void ofono_audio_settings_set_data(struct ofono_audio_settings *as, void *=
data);
+void *ofono_audio_settings_get_data(struct ofono_audio_settings *as);
+
+struct ofono_modem *ofono_audio_settings_get_modem(
+					struct ofono_audio_settings *as);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_AUDIO_SETTINGS_H */
diff --git a/include/ofono/call-barring.h b/include/ofono/call-barring.h
new file mode 100644
index 0000000..6e96ee0
--- /dev/null
+++ b/include/ofono/call-barring.h
@@ -0,0 +1,73 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CALL_BARRING_H
+#define __OFONO_CALL_BARRING_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_call_barring;
+
+typedef void (*ofono_call_barring_set_cb_t)(const struct ofono_error *erro=
r,
+						void *data);
+typedef void (*ofono_call_barring_query_cb_t)(const struct ofono_error *er=
ror,
+					int status, void *data);
+
+struct ofono_call_barring_driver {
+	const char *name;
+	int (*probe)(struct ofono_call_barring *cb, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_call_barring *cb);
+	void (*set)(struct ofono_call_barring *barr, const char *lock,
+			int enable, const char *passwd, int cls,
+			ofono_call_barring_set_cb_t cb, void *data);
+	void (*query)(struct ofono_call_barring *barr, const char *lock,
+			int cls, ofono_call_barring_query_cb_t cb, void *data);
+	void (*set_passwd)(struct ofono_call_barring *barr, const char *lock,
+			const char *old_passwd, const char *new_passwd,
+			ofono_call_barring_set_cb_t cb, void *data);
+};
+
+int ofono_call_barring_driver_register(
+				const struct ofono_call_barring_driver *d);
+void ofono_call_barring_driver_unregister(
+				const struct ofono_call_barring_driver *d);
+
+struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *m=
odem,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+
+void ofono_call_barring_register(struct ofono_call_barring *cb);
+void ofono_call_barring_remove(struct ofono_call_barring *cb);
+
+void ofono_call_barring_set_data(struct ofono_call_barring *cb, void *data=
);
+void *ofono_call_barring_get_data(struct ofono_call_barring *cb);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CALL_BARRING_H */
diff --git a/include/ofono/call-forwarding.h b/include/ofono/call-forwardin=
g.h
new file mode 100644
index 0000000..b213aa8
--- /dev/null
+++ b/include/ofono/call-forwarding.h
@@ -0,0 +1,92 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CALL_FORWARDING_H
+#define __OFONO_CALL_FORWARDING_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_call_forwarding;
+
+/* 27.007 Section 7.11 Call Forwarding */
+struct ofono_call_forwarding_condition {
+	int status;
+	int cls;
+	struct ofono_phone_number phone_number;
+	int time;
+};
+
+typedef void (*ofono_call_forwarding_set_cb_t)(const struct ofono_error *e=
rror,
+						void *data);
+typedef void (*ofono_call_forwarding_query_cb_t)(
+			const struct ofono_error *error, int total,
+			const struct ofono_call_forwarding_condition *list,
+			void *data);
+
+struct ofono_call_forwarding_driver {
+	const char *name;
+	int (*probe)(struct ofono_call_forwarding *cf, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_call_forwarding *cf);
+	void (*activation)(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data);
+	void (*registration)(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				const struct ofono_phone_number *number,
+				int time,
+				ofono_call_forwarding_set_cb_t cb, void *data);
+	void (*deactivation)(struct ofono_call_forwarding *cf,
+				int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data);
+	void (*erasure)(struct ofono_call_forwarding *cf, int type, int cls,
+				ofono_call_forwarding_set_cb_t cb, void *data);
+	void (*query)(struct ofono_call_forwarding *cf, int type, int cls,
+				ofono_call_forwarding_query_cb_t cb,
+				void *data);
+};
+
+int ofono_call_forwarding_driver_register(
+				const struct ofono_call_forwarding_driver *d);
+void ofono_call_forwarding_driver_unregister(
+				const struct ofono_call_forwarding_driver *d);
+
+struct ofono_call_forwarding *ofono_call_forwarding_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_call_forwarding_register(struct ofono_call_forwarding *cf);
+void ofono_call_forwarding_remove(struct ofono_call_forwarding *cf);
+
+void ofono_call_forwarding_set_data(struct ofono_call_forwarding *cf,
+					void *data);
+void *ofono_call_forwarding_get_data(struct ofono_call_forwarding *cf);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CALL_FORWARDING_H */
diff --git a/include/ofono/call-meter.h b/include/ofono/call-meter.h
new file mode 100644
index 0000000..1e97142
--- /dev/null
+++ b/include/ofono/call-meter.h
@@ -0,0 +1,90 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CALL_METER_H
+#define __OFONO_CALL_METER_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_call_meter;
+
+typedef void (*ofono_call_meter_query_cb_t)(const struct ofono_error *erro=
r,
+						int value, void *data);
+
+typedef void (*ofono_call_meter_puct_query_cb_t)(
+					const struct ofono_error *error,
+					const char *currency, double ppu,
+					void *data);
+
+typedef void(*ofono_call_meter_set_cb_t)(const struct ofono_error *error,
+						void *data);
+
+struct ofono_call_meter_driver {
+	const char *name;
+	int (*probe)(struct ofono_call_meter *cm, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_call_meter *cm);
+	void (*call_meter_query)(struct ofono_call_meter *cm,
+				ofono_call_meter_query_cb_t cb, void *data);
+	void (*acm_query)(struct ofono_call_meter *cm,
+				ofono_call_meter_query_cb_t cb, void *data);
+	void (*acm_reset)(struct ofono_call_meter *cm, const char *sim_pin2,
+				ofono_call_meter_set_cb_t cb, void *data);
+	void (*acm_max_query)(struct ofono_call_meter *cm,
+				ofono_call_meter_query_cb_t cb, void *data);
+	void (*acm_max_set)(struct ofono_call_meter *cm, int new_value,
+				const char *sim_pin2,
+				ofono_call_meter_set_cb_t cb, void *data);
+	void (*puct_query)(struct ofono_call_meter *cm,
+			ofono_call_meter_puct_query_cb_t cb, void *data);
+	void (*puct_set)(struct ofono_call_meter *cm, const char *currency,
+				double ppu, const char *sim_pin2,
+				ofono_call_meter_set_cb_t cb, void *data);
+};
+
+int ofono_call_meter_driver_register(const struct ofono_call_meter_driver =
*d);
+void ofono_call_meter_driver_unregister(
+				const struct ofono_call_meter_driver *d);
+
+struct ofono_call_meter *ofono_call_meter_create(struct ofono_modem *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+
+void ofono_call_meter_register(struct ofono_call_meter *cm);
+void ofono_call_meter_remove(struct ofono_call_meter *cm);
+
+void ofono_call_meter_maximum_notify(struct ofono_call_meter *cm);
+void ofono_call_meter_changed_notify(struct ofono_call_meter *cm,
+					int new_value);
+
+void ofono_call_meter_set_data(struct ofono_call_meter *cm, void *data);
+void *ofono_call_meter_get_data(struct ofono_call_meter *cm);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CALL_METER_H */
diff --git a/include/ofono/call-settings.h b/include/ofono/call-settings.h
new file mode 100644
index 0000000..277b84b
--- /dev/null
+++ b/include/ofono/call-settings.h
@@ -0,0 +1,87 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CALL_SETTINGS_H
+#define __OFONO_CALL_SETTINGS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_call_settings;
+
+typedef void (*ofono_call_settings_status_cb_t)(const struct ofono_error *=
error,
+						int status, void *data);
+
+typedef void (*ofono_call_settings_set_cb_t)(const struct ofono_error *err=
or,
+						void *data);
+
+typedef void (*ofono_call_settings_clir_cb_t)(const struct ofono_error *er=
ror,
+					int override, int network, void *data);
+
+struct ofono_call_settings_driver {
+	const char *name;
+	int (*probe)(struct ofono_call_settings *cs, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_call_settings *cs);
+	void (*clip_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
+	void (*cnap_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
+	void (*cdip_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
+	void (*colp_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
+	void (*clir_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_clir_cb_t cb, void *data);
+	void (*colr_query)(struct ofono_call_settings *cs,
+				ofono_call_settings_status_cb_t cb, void *data);
+	void (*clir_set)(struct ofono_call_settings *cs, int mode,
+				ofono_call_settings_set_cb_t cb, void *data);
+	void (*cw_query)(struct ofono_call_settings *cs, int cls,
+			ofono_call_settings_status_cb_t cb, void *data);
+	void (*cw_set)(struct ofono_call_settings *cs, int mode, int cls,
+			ofono_call_settings_set_cb_t cb, void *data);
+};
+
+int ofono_call_settings_driver_register(
+				const struct ofono_call_settings_driver *d);
+void ofono_call_settings_driver_unregister(
+				const struct ofono_call_settings_driver *d);
+
+struct ofono_call_settings *ofono_call_settings_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_call_settings_register(struct ofono_call_settings *cs);
+void ofono_call_settings_remove(struct ofono_call_settings *cs);
+
+void ofono_call_settings_set_data(struct ofono_call_settings *cs, void *da=
ta);
+void *ofono_call_settings_get_data(struct ofono_call_settings *cs);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CALL_SETTINGS_H */
diff --git a/include/ofono/call-volume.h b/include/ofono/call-volume.h
new file mode 100644
index 0000000..1217025
--- /dev/null
+++ b/include/ofono/call-volume.h
@@ -0,0 +1,75 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CALL_VOLUME_H
+#define __OFONO_CALL_VOLUME_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+#include <ofono/dbus.h>
+
+struct ofono_call_volume;
+
+typedef void (*ofono_call_volume_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_call_volume_driver {
+	const char *name;
+	int (*probe)(struct ofono_call_volume *cv, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_call_volume *cv);
+	void (*speaker_volume)(struct ofono_call_volume *cv,
+				unsigned char percent,
+				ofono_call_volume_cb_t cb, void *data);
+	void (*microphone_volume)(struct ofono_call_volume *cv,
+					unsigned char percent,
+					ofono_call_volume_cb_t cb, void *data);
+	void (*mute)(struct ofono_call_volume *cv, int muted,
+			ofono_call_volume_cb_t cb, void *data);
+};
+
+void ofono_call_volume_set_speaker_volume(struct ofono_call_volume *cv,
+						unsigned char percent);
+void ofono_call_volume_set_microphone_volume(struct ofono_call_volume *cv,
+						unsigned char percent);
+void ofono_call_volume_set_muted(struct ofono_call_volume *cv, int muted);
+
+int ofono_call_volume_driver_register(const struct ofono_call_volume_drive=
r *d);
+void ofono_call_volume_driver_unregister(
+			const struct ofono_call_volume_driver *d);
+
+struct ofono_call_volume *ofono_call_volume_create(struct ofono_modem *mod=
em,
+			unsigned int vendor, const char *driver, void *data);
+
+void ofono_call_volume_register(struct ofono_call_volume *cv);
+void ofono_call_volume_remove(struct ofono_call_volume *cv);
+
+void ofono_call_volume_set_data(struct ofono_call_volume *cv, void *data);
+void *ofono_call_volume_get_data(struct ofono_call_volume *cv);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CALL_VOLUME_H */
diff --git a/include/ofono/cbs.h b/include/ofono/cbs.h
new file mode 100644
index 0000000..8dae3ba
--- /dev/null
+++ b/include/ofono/cbs.h
@@ -0,0 +1,65 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CBS_H
+#define __OFONO_CBS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cbs;
+
+typedef void (*ofono_cbs_set_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_cbs_driver {
+	const char *name;
+	int (*probe)(struct ofono_cbs *cbs, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_cbs *cbs);
+	void (*set_topics)(struct ofono_cbs *cbs, const char *topics,
+				ofono_cbs_set_cb_t cb, void *data);
+	void (*clear_topics)(struct ofono_cbs *cbs,
+				ofono_cbs_set_cb_t cb, void *data);
+};
+
+void ofono_cbs_notify(struct ofono_cbs *cbs, const unsigned char *pdu, int=
 len);
+
+int ofono_cbs_driver_register(const struct ofono_cbs_driver *d);
+void ofono_cbs_driver_unregister(const struct ofono_cbs_driver *d);
+
+struct ofono_cbs *ofono_cbs_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_cbs_register(struct ofono_cbs *cbs);
+void ofono_cbs_remove(struct ofono_cbs *cbs);
+
+void ofono_cbs_set_data(struct ofono_cbs *cbs, void *data);
+void *ofono_cbs_get_data(struct ofono_cbs *cbs);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CBS_H */
diff --git a/include/ofono/cdma-connman.h b/include/ofono/cdma-connman.h
new file mode 100644
index 0000000..3e6493e
--- /dev/null
+++ b/include/ofono/cdma-connman.h
@@ -0,0 +1,89 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_CDMA_CONNMAN_H
+#define __OFONO_CDMA_CONNMAN_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_connman;
+
+#define OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH 63
+#define OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH 255
+
+typedef void (*ofono_cdma_connman_cb_t)(const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_cdma_connman_up_cb_t)(const struct ofono_error *error,
+						const char *interface,
+						ofono_bool_t static_ip,
+						const char *address,
+						const char *netmask,
+						const char *gw,
+						const char **dns,
+						void *data);
+
+struct ofono_cdma_connman_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_connman *cm, unsigned int vendor,
+						void *data);
+	void (*remove)(struct ofono_cdma_connman *cm);
+	void (*activate)(struct ofono_cdma_connman *cm,
+						const char *username,
+						const char *password,
+						ofono_cdma_connman_up_cb_t cb,
+						void *data);
+	void (*deactivate)(struct ofono_cdma_connman *cm,
+						ofono_cdma_connman_cb_t cb,
+						void *data);
+};
+
+int ofono_cdma_connman_driver_register(
+				const struct ofono_cdma_connman_driver *d);
+void ofono_cdma_connman_driver_unregister(
+				const struct ofono_cdma_connman_driver *d);
+
+void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm);
+
+void ofono_cdma_connman_dormant_notify(struct ofono_cdma_connman *cm,
+					ofono_bool_t dormant);
+
+struct ofono_cdma_connman *ofono_cdma_connman_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_cdma_connman_register(struct ofono_cdma_connman *cm);
+void ofono_cdma_connman_remove(struct ofono_cdma_connman *cm);
+
+void ofono_cdma_connman_set_data(struct ofono_cdma_connman *cm,
+						void *data);
+void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_CONNMAN_H */
diff --git a/include/ofono/cdma-netreg.h b/include/ofono/cdma-netreg.h
new file mode 100644
index 0000000..529dab5
--- /dev/null
+++ b/include/ofono/cdma-netreg.h
@@ -0,0 +1,83 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CDMA_NETREG_H
+#define __OFONO_CDMA_NETREG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum cdma_netreg_status {
+	CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
+	CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
+	CDMA_NETWORK_REGISTRATION_STATUS_ROAMING =3D		2,
+};
+
+struct ofono_cdma_netreg;
+
+typedef void (*ofono_cdma_netreg_serving_system_cb_t)(
+				const struct ofono_error *error,
+				const char *sid,
+				void *data);
+
+struct ofono_cdma_netreg_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_netreg *cdma_netreg,
+				unsigned int vendor,
+				void *data);
+	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
+	void (*serving_system)(struct ofono_cdma_netreg *cdma_netreg,
+			ofono_cdma_netreg_serving_system_cb_t cb, void *data);
+};
+
+void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
+					enum cdma_netreg_status status);
+void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
+					int strength);
+void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *netr=
eg,
+						int data_strength);
+int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg);
+
+int ofono_cdma_netreg_driver_register(
+				const struct ofono_cdma_netreg_driver *d);
+void ofono_cdma_netreg_driver_unregister(
+				const struct ofono_cdma_netreg_driver *d);
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *cdma_netreg);
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *cdma_netreg);
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg,
+				void *data);
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_NETREG_H */
diff --git a/include/ofono/cdma-provision.h b/include/ofono/cdma-provision.h
new file mode 100644
index 0000000..a6d5765
--- /dev/null
+++ b/include/ofono/cdma-provision.h
@@ -0,0 +1,44 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CDMA_PROVISION_H
+#define __OFONO_CDMA_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_cdma_provision_driver {
+	const char *name;
+	int priority;
+	int (*get_provider_name)(const char *sid, char **name);
+};
+
+int ofono_cdma_provision_driver_register(
+		const struct ofono_cdma_provision_driver *driver);
+void ofono_cdma_provision_driver_unregister(
+		const struct ofono_cdma_provision_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_PROVISION_H */
diff --git a/include/ofono/cdma-sms.h b/include/ofono/cdma-sms.h
new file mode 100644
index 0000000..3b19f04
--- /dev/null
+++ b/include/ofono/cdma-sms.h
@@ -0,0 +1,68 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_CDMA_SMS_H
+#define __OFONO_CDMA_SMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_sms;
+
+typedef void (*ofono_cdma_sms_submit_cb_t)(const struct ofono_error *error,
+						void *data);
+
+struct ofono_cdma_sms_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_sms *cdma_sms, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cdma_sms *cdma_sms);
+	void (*submit)(struct ofono_cdma_sms *cdma_sms,
+			const unsigned char *tpdu,
+			int tpdu_len, ofono_cdma_sms_submit_cb_t cb,
+			void *data);
+};
+
+void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
+					const unsigned char *pdu, int tpdu_len);
+
+int ofono_cdma_sms_driver_register(const struct ofono_cdma_sms_driver *d);
+void ofono_cdma_sms_driver_unregister(const struct ofono_cdma_sms_driver *=
d);
+
+struct ofono_cdma_sms *ofono_cdma_sms_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_cdma_sms_register(struct ofono_cdma_sms *cdma_sms);
+void ofono_cdma_sms_remove(struct ofono_cdma_sms *cdma_sms);
+
+void ofono_cdma_sms_set_data(struct ofono_cdma_sms *cdma_sms, void *data);
+void *ofono_cdma_sms_get_data(struct ofono_cdma_sms *cdma_sms);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_SMS_H */
diff --git a/include/ofono/cdma-voicecall.h b/include/ofono/cdma-voicecall.h
new file mode 100644
index 0000000..5a4d475
--- /dev/null
+++ b/include/ofono/cdma-voicecall.h
@@ -0,0 +1,94 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_CDMA_VOICECALL_H
+#define __OFONO_CDMA_VOICECALL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_voicecall;
+
+enum cdma_call_status {
+	CDMA_CALL_STATUS_ACTIVE,
+	CDMA_CALL_STATUS_DIALING,
+	CDMA_CALL_STATUS_ALERTING,
+	CDMA_CALL_STATUS_INCOMING,
+	CDMA_CALL_STATUS_DISCONNECTED
+};
+
+typedef void (*ofono_cdma_voicecall_cb_t)(const struct ofono_error *error,
+						void *data);
+
+/* Voice call related functionality, including AT+CDV, AT+CHV */
+struct ofono_cdma_voicecall_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_voicecall *vc,
+			unsigned int vendor, void *data);
+	void (*remove)(struct ofono_cdma_voicecall *vc);
+
+	void (*dial)(struct ofono_cdma_voicecall *vc,
+			const struct ofono_cdma_phone_number *number,
+			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	/* Hangs up active, dialing, alerting or incoming calls */
+	void (*hangup)(struct ofono_cdma_voicecall *vc,
+			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*answer)(struct ofono_cdma_voicecall *vc,
+			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*send_flash)(struct ofono_cdma_voicecall *vc, const char *string,
+			ofono_cdma_voicecall_cb_t cb, void *data);
+
+	void (*send_tones)(struct ofono_cdma_voicecall *vc, const char *tones,
+			ofono_cdma_voicecall_cb_t cb, void *data);
+};
+
+void ofono_cdma_voicecall_disconnected(struct ofono_cdma_voicecall *vc,
+					enum ofono_disconnect_reason reason,
+					const struct ofono_error *error);
+
+int ofono_cdma_voicecall_driver_register(
+			const struct ofono_cdma_voicecall_driver *d);
+void ofono_cdma_voicecall_driver_unregister(
+			const struct ofono_cdma_voicecall_driver *d);
+
+struct ofono_cdma_voicecall *ofono_cdma_voicecall_create(
+					struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_cdma_voicecall_register(struct ofono_cdma_voicecall *vc);
+void ofono_cdma_voicecall_remove(struct ofono_cdma_voicecall *vc);
+
+void ofono_cdma_voicecall_set_data(struct ofono_cdma_voicecall *vc,
+					void *data);
+void *ofono_cdma_voicecall_get_data(struct ofono_cdma_voicecall *vc);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_VOICECALL_H */
diff --git a/include/ofono/ctm.h b/include/ofono/ctm.h
new file mode 100644
index 0000000..76d1544
--- /dev/null
+++ b/include/ofono/ctm.h
@@ -0,0 +1,66 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CTM_H
+#define __OFONO_CTM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_ctm;
+
+typedef void (*ofono_ctm_set_cb_t)(const struct ofono_error *error,
+					void *data);
+typedef void (*ofono_ctm_query_cb_t)(const struct ofono_error *error,
+					ofono_bool_t enable, void *data);
+
+struct ofono_ctm_driver {
+	const char *name;
+	int (*probe)(struct ofono_ctm *ctm, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_ctm *ctm);
+	void (*query_tty)(struct ofono_ctm *ctm,
+				ofono_ctm_query_cb_t cb, void *data);
+	void (*set_tty)(struct ofono_ctm *ctm, ofono_bool_t enable,
+				ofono_ctm_set_cb_t cb, void *data);
+};
+
+int ofono_ctm_driver_register(const struct ofono_ctm_driver *d);
+void ofono_ctm_driver_unregister(const struct ofono_ctm_driver *d);
+
+struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_ctm_register(struct ofono_ctm *ctm);
+void ofono_ctm_remove(struct ofono_ctm *ctm);
+
+void ofono_ctm_set_data(struct ofono_ctm *ctm, void *data);
+void *ofono_ctm_get_data(struct ofono_ctm *ctm);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CTM_H */
diff --git a/include/ofono/dbus.h b/include/ofono/dbus.h
new file mode 100644
index 0000000..3d39eff
--- /dev/null
+++ b/include/ofono/dbus.h
@@ -0,0 +1,108 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_DBUS_H
+#define __OFONO_DBUS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <dbus/dbus.h>
+
+#define OFONO_SERVICE	"org.ofono"
+#define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
+#define OFONO_MANAGER_PATH "/"
+#define OFONO_MODEM_INTERFACE "org.ofono.Modem"
+#define OFONO_CALL_BARRING_INTERFACE "org.ofono.CallBarring"
+#define OFONO_CALL_FORWARDING_INTERFACE "org.ofono.CallForwarding"
+#define OFONO_CALL_METER_INTERFACE "org.ofono.CallMeter"
+#define OFONO_CALL_SETTINGS_INTERFACE "org.ofono.CallSettings"
+#define OFONO_CALL_VOLUME_INTERFACE OFONO_SERVICE ".CallVolume"
+#define OFONO_CELL_BROADCAST_INTERFACE "org.ofono.CellBroadcast"
+#define OFONO_CONNECTION_CONTEXT_INTERFACE "org.ofono.ConnectionContext"
+#define OFONO_CONNECTION_MANAGER_INTERFACE "org.ofono.ConnectionManager"
+#define OFONO_MESSAGE_MANAGER_INTERFACE "org.ofono.MessageManager"
+#define OFONO_MESSAGE_INTERFACE "org.ofono.Message"
+#define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
+#define OFONO_SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementarySer=
vices"
+#define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
+#define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
+#define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
+#define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
+#define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
+#define OFONO_TEXT_TELEPHONY_INTERFACE "org.ofono.TextTelephony"
+#define OFONO_SIM_MANAGER_INTERFACE "org.ofono.SimManager"
+#define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
+#define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
+#define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
+#define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
+#define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
+#define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
+#define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
+#define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
+#define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
+
+/* CDMA Interfaces */
+#define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
+#define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
+#define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
+#define OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE \
+					"org.ofono.cdma.NetworkRegistration"
+
+/* Essentially a{sv} */
+#define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
+					DBUS_TYPE_STRING_AS_STRING \
+					DBUS_TYPE_VARIANT_AS_STRING \
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+
+DBusConnection *ofono_dbus_get_connection(void);
+
+void ofono_dbus_dict_append(DBusMessageIter *dict, const char *key, int ty=
pe,
+				const void *value);
+
+void ofono_dbus_dict_append_array(DBusMessageIter *dict, const char *key,
+					int type, const void *val);
+
+void ofono_dbus_dict_append_dict(DBusMessageIter *dict, const char *key,
+					int type, const void *val);
+
+int ofono_dbus_signal_property_changed(DBusConnection *conn, const char *p=
ath,
+					const char *interface, const char *name,
+					int type, const void *value);
+
+int ofono_dbus_signal_array_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name, int type,
+						const void *value);
+
+int ofono_dbus_signal_dict_property_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name, int type,
+						const void *value);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_DBUS_H */
diff --git a/include/ofono/devinfo.h b/include/ofono/devinfo.h
new file mode 100644
index 0000000..a9acce9
--- /dev/null
+++ b/include/ofono/devinfo.h
@@ -0,0 +1,68 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_DEVINFO_H
+#define __OFONO_DEVINFO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_devinfo;
+
+typedef void (*ofono_devinfo_query_cb_t)(const struct ofono_error *error,
+					const char *attribute, void *data);
+
+struct ofono_devinfo_driver {
+	const char *name;
+	int (*probe)(struct ofono_devinfo *info, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_devinfo *info);
+	void (*query_manufacturer)(struct ofono_devinfo *info,
+			ofono_devinfo_query_cb_t cb, void *data);
+	void (*query_serial)(struct ofono_devinfo *info,
+			ofono_devinfo_query_cb_t cb, void *data);
+	void (*query_model)(struct ofono_devinfo *info,
+			ofono_devinfo_query_cb_t cb, void *data);
+	void (*query_revision)(struct ofono_devinfo *info,
+			ofono_devinfo_query_cb_t cb, void *data);
+};
+
+int ofono_devinfo_driver_register(const struct ofono_devinfo_driver *d);
+void ofono_devinfo_driver_unregister(const struct ofono_devinfo_driver *d);
+
+struct ofono_devinfo *ofono_devinfo_create(struct ofono_modem *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+void ofono_devinfo_register(struct ofono_devinfo *info);
+void ofono_devinfo_remove(struct ofono_devinfo *info);
+
+void ofono_devinfo_set_data(struct ofono_devinfo *info, void *data);
+void *ofono_devinfo_get_data(struct ofono_devinfo *info);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_MODEM_INFO_H */
diff --git a/include/ofono/emulator.h b/include/ofono/emulator.h
new file mode 100644
index 0000000..5e8d431
--- /dev/null
+++ b/include/ofono/emulator.h
@@ -0,0 +1,115 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_EMULATOR_H
+#define __OFONO_EMULATOR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+#define OFONO_EMULATOR_IND_BATTERY "battchg"
+#define OFONO_EMULATOR_IND_CALL "call"
+#define OFONO_EMULATOR_IND_CALLHELD "callheld"
+#define OFONO_EMULATOR_IND_CALLSETUP "callsetup"
+#define OFONO_EMULATOR_IND_ROAMING "roam"
+#define OFONO_EMULATOR_IND_SERVICE "service"
+#define OFONO_EMULATOR_IND_SIGNAL "signal"
+
+#define OFONO_EMULATOR_CALL_INACTIVE 0
+#define OFONO_EMULATOR_CALL_ACTIVE 1
+
+#define OFONO_EMULATOR_CALLSETUP_INACTIVE 0
+#define OFONO_EMULATOR_CALLSETUP_INCOMING 1
+#define OFONO_EMULATOR_CALLSETUP_OUTGOING 2
+#define OFONO_EMULATOR_CALLSETUP_ALERTING 3
+
+#define OFONO_EMULATOR_CALLHELD_NONE 0
+#define OFONO_EMULATOR_CALLHELD_MULTIPLE 1
+#define OFONO_EMULATOR_CALLHELD_ON_HOLD 2
+
+struct ofono_emulator;
+struct ofono_emulator_request;
+
+enum ofono_emulator_type {
+	OFONO_EMULATOR_TYPE_DUN,
+	OFONO_EMULATOR_TYPE_HFP,
+};
+
+enum ofono_emulator_request_type {
+	OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY,
+	OFONO_EMULATOR_REQUEST_TYPE_QUERY,
+	OFONO_EMULATOR_REQUEST_TYPE_SUPPORT,
+	OFONO_EMULATOR_REQUEST_TYPE_SET,
+};
+
+typedef void (*ofono_emulator_request_cb_t)(struct ofono_emulator *em,
+					struct ofono_emulator_request *req,
+					void *data);
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+						enum ofono_emulator_type type);
+
+void ofono_emulator_register(struct ofono_emulator *em, int fd);
+
+void ofono_emulator_remove(struct ofono_emulator *em);
+
+void ofono_emulator_send_final(struct ofono_emulator *em,
+				const struct ofono_error *final);
+void ofono_emulator_send_unsolicited(struct ofono_emulator *em,
+					const char *result);
+void ofono_emulator_send_intermediate(struct ofono_emulator *em,
+					const char *result);
+void ofono_emulator_send_info(struct ofono_emulator *em, const char *line,
+				ofono_bool_t last);
+
+ofono_bool_t ofono_emulator_add_handler(struct ofono_emulator *em,
+					const char *prefix,
+					ofono_emulator_request_cb_t cb,
+					void *data, ofono_destroy_func destroy);
+ofono_bool_t ofono_emulator_remove_handler(struct ofono_emulator *em,
+						const char *prefix);
+
+ofono_bool_t ofono_emulator_request_next_string(
+					struct ofono_emulator_request *req,
+					const char **str);
+ofono_bool_t ofono_emulator_request_next_number(
+					struct ofono_emulator_request *req,
+					int *number);
+
+const char *ofono_emulator_request_get_raw(struct ofono_emulator_request *=
req);
+
+enum ofono_emulator_request_type ofono_emulator_request_get_type(
+					struct ofono_emulator_request *req);
+
+void ofono_emulator_set_indicator(struct ofono_emulator *em,
+					const char *name, int value);
+void ofono_emulator_set_hf_indicator_active(struct ofono_emulator *em,
+						int indicator,
+						ofono_bool_t active);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/include/ofono/gnss.h b/include/ofono/gnss.h
new file mode 100644
index 0000000..e7fc660
--- /dev/null
+++ b/include/ofono/gnss.h
@@ -0,0 +1,69 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  ST-Ericsson AB.
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
+#ifndef __OFONO_GNSS_H
+#define __OFONO_GNSS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_gnss;
+
+typedef void (*ofono_gnss_cb_t)(const struct ofono_error *error, void *dat=
a);
+
+struct ofono_gnss_driver {
+	const char *name;
+	int (*probe)(struct ofono_gnss *gnss, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_gnss *gnss);
+	void (*send_element)(struct ofono_gnss *gnss,
+				const char *xml,
+				ofono_gnss_cb_t cb, void *data);
+	void (*set_position_reporting)(struct ofono_gnss *gnss,
+					ofono_bool_t enable,
+					ofono_gnss_cb_t cb,
+					void *data);
+};
+
+void ofono_gnss_notify_posr_request(struct ofono_gnss *gnss, const char *x=
ml);
+void ofono_gnss_notify_posr_reset(struct ofono_gnss *gnss);
+int ofono_gnss_driver_register(const struct ofono_gnss_driver *d);
+void ofono_gnss_driver_unregister(const struct ofono_gnss_driver *d);
+
+struct ofono_gnss *ofono_gnss_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_gnss_register(struct ofono_gnss *gnss);
+void ofono_gnss_remove(struct ofono_gnss *gnss);
+
+void ofono_gnss_set_data(struct ofono_gnss *gnss, void *data);
+void *ofono_gnss_get_data(struct ofono_gnss *gnss);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GNSS_H */
diff --git a/include/ofono/gprs-context.h b/include/ofono/gprs-context.h
new file mode 100644
index 0000000..ed27e66
--- /dev/null
+++ b/include/ofono/gprs-context.h
@@ -0,0 +1,130 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_GPRS_CONTEXT_H
+#define __OFONO_GPRS_CONTEXT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_gprs_context;
+
+#define OFONO_GPRS_MAX_APN_LENGTH 127
+#define OFONO_GPRS_MAX_USERNAME_LENGTH 63
+#define OFONO_GPRS_MAX_PASSWORD_LENGTH 255
+
+enum ofono_gprs_proto {
+	OFONO_GPRS_PROTO_IP =3D 0,
+	OFONO_GPRS_PROTO_IPV6,
+	OFONO_GPRS_PROTO_IPV4V6,
+};
+
+enum ofono_gprs_context_type {
+	OFONO_GPRS_CONTEXT_TYPE_ANY =3D 0,
+	OFONO_GPRS_CONTEXT_TYPE_INTERNET,
+	OFONO_GPRS_CONTEXT_TYPE_MMS,
+	OFONO_GPRS_CONTEXT_TYPE_WAP,
+	OFONO_GPRS_CONTEXT_TYPE_IMS,
+};
+
+enum ofono_gprs_auth_method {
+	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
+	OFONO_GPRS_AUTH_METHOD_PAP,
+};
+
+struct ofono_gprs_primary_context {
+	unsigned int cid;
+	int direction;
+	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum ofono_gprs_proto proto;
+	enum ofono_gprs_auth_method auth_method;
+};
+
+typedef void (*ofono_gprs_context_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_gprs_context_driver {
+	const char *name;
+	int (*probe)(struct ofono_gprs_context *gc, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_gprs_context *gc);
+	void (*activate_primary)(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data);
+	void (*deactivate_primary)(struct ofono_gprs_context *gc,
+					unsigned int id,
+					ofono_gprs_context_cb_t cb, void *data);
+	void (*detach_shutdown)(struct ofono_gprs_context *gc,
+					unsigned int id);
+};
+
+void ofono_gprs_context_deactivated(struct ofono_gprs_context *gc,
+					unsigned int id);
+
+int ofono_gprs_context_driver_register(
+				const struct ofono_gprs_context_driver *d);
+void ofono_gprs_context_driver_unregister(
+				const struct ofono_gprs_context_driver *d);
+
+struct ofono_gprs_context *ofono_gprs_context_create(struct ofono_modem *m=
odem,
+						unsigned int vendor,
+						const char *driver, void *data);
+void ofono_gprs_context_remove(struct ofono_gprs_context *gc);
+
+void ofono_gprs_context_set_data(struct ofono_gprs_context *gc, void *data=
);
+void *ofono_gprs_context_get_data(struct ofono_gprs_context *gc);
+
+struct ofono_modem *ofono_gprs_context_get_modem(struct ofono_gprs_context=
 *gc);
+
+void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
+					enum ofono_gprs_context_type type);
+
+void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
+					const char *interface);
+
+void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
+						const char *address,
+						ofono_bool_t static_ip);
+void ofono_gprs_context_set_ipv4_netmask(struct ofono_gprs_context *gc,
+						const char *netmask);
+void ofono_gprs_context_set_ipv4_gateway(struct ofono_gprs_context *gc,
+						const char *gateway);
+void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns);
+
+void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
+						const char *address);
+void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context *=
gc,
+						unsigned char length);
+void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
+						const char *gateway);
+void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
+						const char **dns);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_CONTEXT_H */
diff --git a/include/ofono/gprs-provision.h b/include/ofono/gprs-provision.h
new file mode 100644
index 0000000..2dd792b
--- /dev/null
+++ b/include/ofono/gprs-provision.h
@@ -0,0 +1,60 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_GPRS_PROVISION_H
+#define __OFONO_GPRS_PROVISION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gprs-context.h"
+
+struct ofono_gprs_provision_data {
+	enum ofono_gprs_context_type type;
+	enum ofono_gprs_proto proto;
+	char *name;
+	char *apn;
+	char *username;
+	char *password;
+	enum ofono_gprs_auth_method auth_method;
+	char *message_proxy;
+	char *message_center;
+};
+
+struct ofono_gprs_provision_driver {
+	const char *name;
+	int priority;
+	int (*get_settings)(const char *mcc, const char *mnc, const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count);
+};
+
+int ofono_gprs_provision_driver_register(
+			const struct ofono_gprs_provision_driver *driver);
+void ofono_gprs_provision_driver_unregister(
+			const struct ofono_gprs_provision_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_PROVISION_H */
diff --git a/include/ofono/gprs.h b/include/ofono/gprs.h
new file mode 100644
index 0000000..6c46d18
--- /dev/null
+++ b/include/ofono/gprs.h
@@ -0,0 +1,85 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_GPRS_H
+#define __OFONO_GPRS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_gprs;
+struct ofono_gprs_context;
+
+typedef void (*ofono_gprs_status_cb_t)(const struct ofono_error *error,
+						int status, void *data);
+
+typedef void (*ofono_gprs_cb_t)(const struct ofono_error *error, void *dat=
a);
+
+struct ofono_gprs_driver {
+	const char *name;
+	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_gprs *gprs);
+	void (*set_attached)(struct ofono_gprs *gprs, int attached,
+				ofono_gprs_cb_t cb, void *data);
+	void (*attached_status)(struct ofono_gprs *gprs,
+					ofono_gprs_status_cb_t cb, void *data);
+};
+
+enum gprs_suspend_cause {
+	GPRS_SUSPENDED_DETACHED,
+	GPRS_SUSPENDED_SIGNALLING,
+	GPRS_SUSPENDED_CALL,
+	GPRS_SUSPENDED_NO_COVERAGE,
+	GPRS_SUSPENDED_UNKNOWN_CAUSE,
+};
+
+void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status);
+void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
+void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
+void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer);
+
+int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
+void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
+
+struct ofono_gprs *ofono_gprs_create(struct ofono_modem *modem,
+					unsigned int vendor, const char *driver,
+					void *data);
+void ofono_gprs_register(struct ofono_gprs *gprs);
+void ofono_gprs_remove(struct ofono_gprs *gprs);
+
+void ofono_gprs_set_data(struct ofono_gprs *gprs, void *data);
+void *ofono_gprs_get_data(struct ofono_gprs *gprs);
+
+void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
+				unsigned int min, unsigned int max);
+void ofono_gprs_add_context(struct ofono_gprs *gprs,
+				struct ofono_gprs_context *gc);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_GPRS_H */
diff --git a/include/ofono/handsfree-audio.h b/include/ofono/handsfree-audi=
o.h
new file mode 100644
index 0000000..03e3b38
--- /dev/null
+++ b/include/ofono/handsfree-audio.h
@@ -0,0 +1,84 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_HANDSFREE_AUDIO_H
+#define __OFONO_HANDSFREE_AUDIO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_handsfree_card;
+
+typedef void (*ofono_handsfree_card_connect_cb_t)(
+				const struct ofono_error *error, void *data);
+
+struct ofono_handsfree_card_driver {
+	const char *name;
+	int (*probe)(struct ofono_handsfree_card *card, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_handsfree_card *card);
+	void (*connect)(struct ofono_handsfree_card *card,
+				ofono_handsfree_card_connect_cb_t cb,
+				void *data);
+};
+
+struct ofono_handsfree_card *ofono_handsfree_card_create(unsigned int vend=
or,
+							const char *driver,
+							void *data);
+int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
+void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
+ofono_bool_t ofono_handsfree_card_set_codec(struct ofono_handsfree_card *c=
ard,
+							unsigned char codec);
+
+ofono_bool_t ofono_handsfree_audio_has_wideband(void);
+
+ofono_bool_t ofono_handsfree_audio_has_transparent_sco(void);
+
+void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
+					void *data);
+void *ofono_handsfree_card_get_data(struct ofono_handsfree_card *card);
+
+void ofono_handsfree_card_set_remote(struct ofono_handsfree_card *card,
+					const char *remote);
+const char *ofono_handsfree_card_get_remote(struct ofono_handsfree_card *c=
ard);
+
+void ofono_handsfree_card_set_local(struct ofono_handsfree_card *card,
+					const char *local);
+const char *ofono_handsfree_card_get_local(struct ofono_handsfree_card *ca=
rd);
+
+int ofono_handsfree_card_connect_sco(struct ofono_handsfree_card *card);
+
+void ofono_handsfree_audio_ref(void);
+void ofono_handsfree_audio_unref(void);
+
+int ofono_handsfree_card_driver_register(
+				const struct ofono_handsfree_card_driver *d);
+void ofono_handsfree_card_driver_unregister(
+				const struct ofono_handsfree_card_driver *d);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_HANDSFREE_AUDIO_H */
diff --git a/include/ofono/handsfree.h b/include/ofono/handsfree.h
new file mode 100644
index 0000000..ed0deb8
--- /dev/null
+++ b/include/ofono/handsfree.h
@@ -0,0 +1,100 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#ifndef __OFONO_HANDSFREE_H
+#define __OFONO_HANDSFREE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_handsfree;
+
+typedef void (*ofono_handsfree_cb_t)(const struct ofono_error *error,
+					void *data);
+typedef void (*ofono_handsfree_phone_cb_t)(const struct ofono_error *error,
+					const struct ofono_phone_number *number,
+					void *data);
+typedef void (*ofono_handsfree_cnum_query_cb_t)(const struct ofono_error *=
error,
+				int total,
+				const struct ofono_phone_number *numbers,
+				void *data);
+
+struct ofono_handsfree_driver {
+	const char *name;
+	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_handsfree *hf);
+	void (*cnum_query)(struct ofono_handsfree *hf,
+				ofono_handsfree_cnum_query_cb_t cb, void *data);
+	void (*request_phone_number) (struct ofono_handsfree *hf,
+					ofono_handsfree_phone_cb_t cb,
+					void *data);
+	void (*voice_recognition)(struct ofono_handsfree *hf,
+					ofono_bool_t enabled,
+					ofono_handsfree_cb_t cb, void *data);
+	void (*disable_nrec)(struct ofono_handsfree *hf,
+					ofono_handsfree_cb_t cb, void *data);
+	void (*hf_indicator)(struct ofono_handsfree *hf,
+				unsigned short indicator, unsigned int value,
+				ofono_handsfree_cb_t cb, void *data);
+};
+
+void ofono_handsfree_set_ag_features(struct ofono_handsfree *hf,
+					unsigned int ag_features);
+void ofono_handsfree_set_ag_chld_features(struct ofono_handsfree *hf,
+					unsigned int ag_chld_features);
+void ofono_handsfree_set_inband_ringing(struct ofono_handsfree *hf,
+						ofono_bool_t enabled);
+void ofono_handsfree_voice_recognition_notify(struct ofono_handsfree *hf,
+						ofono_bool_t enabled);
+
+void ofono_handsfree_set_hf_indicators(struct ofono_handsfree *hf,
+					const unsigned short *indicators,
+					unsigned int num);
+void ofono_handsfree_hf_indicator_active_notify(struct ofono_handsfree *hf,
+						unsigned int indicator,
+						ofono_bool_t active);
+
+void ofono_handsfree_battchg_notify(struct ofono_handsfree *hf,
+					unsigned char level);
+
+int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
+void ofono_handsfree_driver_unregister(
+			const struct ofono_handsfree_driver *d);
+
+struct ofono_handsfree *ofono_handsfree_create(struct ofono_modem *modem,
+			unsigned int vendor, const char *driver, void *data);
+
+void ofono_handsfree_register(struct ofono_handsfree *hf);
+void ofono_handsfree_remove(struct ofono_handsfree *hf);
+
+void ofono_handsfree_set_data(struct ofono_handsfree *hf, void *data);
+void *ofono_handsfree_get_data(struct ofono_handsfree *hf);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_HANDSFREE_H */
diff --git a/include/ofono/history.h b/include/ofono/history.h
new file mode 100644
index 0000000..cfa05fc
--- /dev/null
+++ b/include/ofono/history.h
@@ -0,0 +1,79 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_HISTORY_H
+#define __OFONO_HISTORY_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum ofono_disconnect_reason;
+struct ofono_call;
+
+enum ofono_history_sms_status {
+	OFONO_HISTORY_SMS_STATUS_PENDING,
+	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
+	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED,
+	OFONO_HISTORY_SMS_STATUS_DELIVERED,
+	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
+};
+
+struct ofono_history_context {
+	struct ofono_history_driver *driver;
+	struct ofono_modem *modem;
+	void *data;
+};
+
+struct ofono_history_driver {
+	const char *name;
+	int (*probe)(struct ofono_history_context *context);
+	void (*remove)(struct ofono_history_context *context);
+	void (*call_ended)(struct ofono_history_context *context,
+				const struct ofono_call *call,
+				time_t start, time_t end);
+	void (*call_missed)(struct ofono_history_context *context,
+				const struct ofono_call *call, time_t when);
+	void (*sms_received)(struct ofono_history_context *context,
+				const struct ofono_uuid *uuid, const char *from,
+				const struct tm *remote, const struct tm *local,
+				const char *text);
+	void (*sms_send_pending)(struct ofono_history_context *context,
+					const struct ofono_uuid *uuid,
+					const char *to,
+					time_t when, const char *text);
+	void (*sms_send_status)(struct ofono_history_context *context,
+					const struct ofono_uuid *uuid,
+					time_t when,
+					enum ofono_history_sms_status status);
+};
+
+int ofono_history_driver_register(const struct ofono_history_driver *drive=
r);
+void ofono_history_driver_unregister(const struct ofono_history_driver *dr=
iver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_HISTORY_H */
diff --git a/include/ofono/location-reporting.h b/include/ofono/location-re=
porting.h
new file mode 100644
index 0000000..0717f71
--- /dev/null
+++ b/include/ofono/location-reporting.h
@@ -0,0 +1,81 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2010  ProFUSION embedded systems.
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
+#ifndef __OFONO_LOCATION_REPORTING_H
+#define __OFONO_LOCATION_REPORTING_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_location_reporting;
+
+enum ofono_location_reporting_type {
+	OFONO_LOCATION_REPORTING_TYPE_NMEA =3D 0,
+};
+
+typedef void (*ofono_location_reporting_enable_cb_t)(
+						const struct ofono_error *error,
+						int fd, void *data);
+typedef void (*ofono_location_reporting_disable_cb_t)(
+						const struct ofono_error *error,
+						void *data);
+
+struct ofono_location_reporting_driver {
+	const char *name;
+	enum ofono_location_reporting_type type;
+	int (*probe)(struct ofono_location_reporting *lr, unsigned int vendor,
+								void *data);
+	void (*remove)(struct ofono_location_reporting *lr);
+	void (*enable)(struct ofono_location_reporting *lr,
+			ofono_location_reporting_enable_cb_t cb, void *data);
+	void (*disable)(struct ofono_location_reporting *lr,
+			ofono_location_reporting_disable_cb_t cb, void *data);
+};
+
+int ofono_location_reporting_driver_register(
+			const struct ofono_location_reporting_driver *d);
+void ofono_location_reporting_driver_unregister(
+			const struct ofono_location_reporting_driver *d);
+
+struct ofono_location_reporting *ofono_location_reporting_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_location_reporting_register(struct ofono_location_reporting *lr=
);
+void ofono_location_reporting_remove(struct ofono_location_reporting *lr);
+
+void ofono_location_reporting_set_data(struct ofono_location_reporting *lr,
+								void *data);
+void *ofono_location_reporting_get_data(struct ofono_location_reporting *l=
r);
+
+struct ofono_modem *ofono_location_reporting_get_modem(
+					struct ofono_location_reporting *lr);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_LOCATION_REPORTING_H */
diff --git a/include/ofono/log.h b/include/ofono/log.h
new file mode 100644
index 0000000..ebfa540
--- /dev/null
+++ b/include/ofono/log.h
@@ -0,0 +1,74 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_LOG_H
+#define __OFONO_LOG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * SECTION:log
+ * @title: Logging premitives
+ * @short_description: Functions for logging error and debug information
+ */
+
+extern void ofono_info(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+extern void ofono_warn(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+extern void ofono_error(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+extern void ofono_debug(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+
+struct ofono_debug_desc {
+	const char *name;
+	const char *file;
+#define OFONO_DEBUG_FLAG_DEFAULT (0)
+#define OFONO_DEBUG_FLAG_PRINT   (1 << 0)
+	unsigned int flags;
+} __attribute__((aligned(8)));
+
+/**
+ * DBG:
+ * @fmt: format string
+ * @arg...: list of arguments
+ *
+ * Simple macro around ofono_debug() which also include the function
+ * name it is called in.
+ */
+#define DBG(fmt, arg...) do { \
+	static struct ofono_debug_desc __ofono_debug_desc \
+	__attribute__((used, section("__debug"), aligned(8))) =3D { \
+		.file =3D __FILE__, .flags =3D OFONO_DEBUG_FLAG_DEFAULT, \
+	}; \
+	if (__ofono_debug_desc.flags & OFONO_DEBUG_FLAG_PRINT) \
+		ofono_debug("%s:%s() " fmt, \
+					__FILE__, __FUNCTION__ , ## arg); \
+} while (0)
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_LOG_H */
diff --git a/include/ofono/message-waiting.h b/include/ofono/message-waitin=
g.h
new file mode 100644
index 0000000..c120e9d
--- /dev/null
+++ b/include/ofono/message-waiting.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_MESSAGE_WAITING_H
+#define __OFONO_MESSAGE_WAITING_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_message_waiting;
+
+struct ofono_message_waiting *ofono_message_waiting_create(
+						struct ofono_modem *modem);
+void ofono_message_waiting_register(struct ofono_message_waiting *mw);
+void ofono_message_waiting_remove(struct ofono_message_waiting *mw);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_MESSAGE_WAITING_H */
diff --git a/include/ofono/modem.h b/include/ofono/modem.h
new file mode 100644
index 0000000..e40b23e
--- /dev/null
+++ b/include/ofono/modem.h
@@ -0,0 +1,128 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_MODEM_H
+#define __OFONO_MODEM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_modem;
+
+enum ofono_modem_type {
+	OFONO_MODEM_TYPE_HARDWARE =3D 0,
+	OFONO_MODEM_TYPE_HFP,
+	OFONO_MODEM_TYPE_SAP,
+	OFONO_MODEM_TYPE_TEST,
+};
+
+typedef void (*ofono_modem_online_cb_t)(const struct ofono_error *error,
+					void *data);
+
+typedef ofono_bool_t (*ofono_modem_compare_cb_t)(struct ofono_modem *modem,
+							void *user_data);
+
+struct ofono_modem_driver {
+	const char *name;
+	enum ofono_modem_type modem_type;
+
+	/* Detect existence of device and initialize any device-specific data
+	 * structures */
+	int (*probe)(struct ofono_modem *modem);
+
+	/* Destroy data structures allocated during probe and cleanup */
+	void (*remove)(struct ofono_modem *modem);
+
+	/* Power up device */
+	int (*enable)(struct ofono_modem *modem);
+
+	/* Power down device */
+	int (*disable)(struct ofono_modem *modem);
+
+	/* Enable or disable cellular radio */
+	void (*set_online)(struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t callback, void *data);
+
+	/* Populate the atoms available without SIM / Locked SIM */
+	void (*pre_sim)(struct ofono_modem *modem);
+
+	/* Populate the atoms that are available with SIM / Unlocked SIM*/
+	void (*post_sim)(struct ofono_modem *modem);
+
+	/* Populate the atoms available online */
+	void (*post_online)(struct ofono_modem *modem);
+};
+
+void ofono_modem_add_interface(struct ofono_modem *modem,
+				const char *interface);
+void ofono_modem_remove_interface(struct ofono_modem *modem,
+					const char *interface);
+
+const char *ofono_modem_get_path(struct ofono_modem *modem);
+
+void ofono_modem_set_data(struct ofono_modem *modem, void *data);
+void *ofono_modem_get_data(struct ofono_modem *modem);
+
+struct ofono_modem *ofono_modem_create(const char *name, const char *type);
+int ofono_modem_register(struct ofono_modem *modem);
+
+ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem);
+void ofono_modem_remove(struct ofono_modem *modem);
+
+void ofono_modem_reset(struct ofono_modem *modem);
+
+void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t power=
ed);
+ofono_bool_t ofono_modem_get_powered(struct ofono_modem *modem);
+
+ofono_bool_t ofono_modem_get_online(struct ofono_modem *modem);
+
+ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
+
+void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
+void ofono_modem_set_driver(struct ofono_modem *modem, const char *type);
+
+int ofono_modem_set_string(struct ofono_modem *modem,
+				const char *key, const char *value);
+const char *ofono_modem_get_string(struct ofono_modem *modem, const char *=
key);
+
+int ofono_modem_set_integer(struct ofono_modem *modem,
+				const char *key, int value);
+int ofono_modem_get_integer(struct ofono_modem *modem, const char *key);
+
+int ofono_modem_set_boolean(struct ofono_modem *modem,
+				const char *key, ofono_bool_t value);
+ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem,
+					const char *key);
+
+int ofono_modem_driver_register(const struct ofono_modem_driver *);
+void ofono_modem_driver_unregister(const struct ofono_modem_driver *);
+
+struct ofono_modem *ofono_modem_find(ofono_modem_compare_cb_t func,
+					void *user_data);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_MODEM_H */
diff --git a/include/ofono/netreg.h b/include/ofono/netreg.h
new file mode 100644
index 0000000..4338c14
--- /dev/null
+++ b/include/ofono/netreg.h
@@ -0,0 +1,122 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_NETREG_H
+#define __OFONO_NETREG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_netreg;
+
+/* Theoretical limit is 16, but each GSM char can be encoded into
+ *  * 3 UTF8 characters resulting in 16*3=3D48 chars
+ *   */
+#define OFONO_MAX_OPERATOR_NAME_LENGTH 63
+
+struct ofono_network_operator {
+	char name[OFONO_MAX_OPERATOR_NAME_LENGTH + 1];
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	int status;
+	int tech;
+};
+
+typedef void (*ofono_netreg_operator_cb_t)(const struct ofono_error *error,
+					const struct ofono_network_operator *op,
+					void *data);
+
+typedef void (*ofono_netreg_register_cb_t)(const struct ofono_error *error,
+						void *data);
+
+typedef void (*ofono_netreg_operator_list_cb_t)(const struct ofono_error *=
error,
+				int total,
+				const struct ofono_network_operator *list,
+				void *data);
+
+typedef void (*ofono_netreg_status_cb_t)(const struct ofono_error *error,
+					int status, int lac, int ci, int tech,
+					void *data);
+
+typedef void (*ofono_netreg_strength_cb_t)(const struct ofono_error *error,
+						int strength, void *data);
+
+/* Network related functions, including registration status, operator sele=
ction
+ * and signal strength indicators.
+ *
+ * It is up to the plugin to implement CSQ polling if the modem does not s=
upport
+ * vendor extensions for signal strength notification.
+ */
+struct ofono_netreg_driver {
+	const char *name;
+	int (*probe)(struct ofono_netreg *netreg, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_netreg *netreg);
+	void (*registration_status)(struct ofono_netreg *netreg,
+			ofono_netreg_status_cb_t cb, void *data);
+	void (*current_operator)(struct ofono_netreg *netreg,
+			ofono_netreg_operator_cb_t cb, void *data);
+	void (*list_operators)(struct ofono_netreg *netreg,
+			ofono_netreg_operator_list_cb_t cb, void *data);
+	void (*register_auto)(struct ofono_netreg *netreg,
+			ofono_netreg_register_cb_t cb, void *data);
+	void (*register_manual)(struct ofono_netreg *netreg,
+				const char *mcc, const char *mnc,
+				ofono_netreg_register_cb_t cb, void *data);
+	void (*strength)(struct ofono_netreg *netreg,
+			ofono_netreg_strength_cb_t, void *data);
+};
+
+void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h);
+void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
+					int lac, int ci, int tech);
+void ofono_netreg_time_notify(struct ofono_netreg *netreg,
+				struct ofono_network_time *info);
+
+int ofono_netreg_driver_register(const struct ofono_netreg_driver *d);
+void ofono_netreg_driver_unregister(const struct ofono_netreg_driver *d);
+
+struct ofono_netreg *ofono_netreg_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_netreg_register(struct ofono_netreg *netreg);
+void ofono_netreg_remove(struct ofono_netreg *netreg);
+
+void ofono_netreg_set_data(struct ofono_netreg *netreg, void *data);
+void *ofono_netreg_get_data(struct ofono_netreg *netreg);
+
+int ofono_netreg_get_location(struct ofono_netreg *netreg);
+int ofono_netreg_get_cellid(struct ofono_netreg *netreg);
+int ofono_netreg_get_status(struct ofono_netreg *netreg);
+int ofono_netreg_get_technology(struct ofono_netreg *netreg);
+const char *ofono_netreg_get_mcc(struct ofono_netreg *netreg);
+const char *ofono_netreg_get_mnc(struct ofono_netreg *netreg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_NETREG_H */
diff --git a/include/ofono/nettime.h b/include/ofono/nettime.h
new file mode 100644
index 0000000..0f23cc7
--- /dev/null
+++ b/include/ofono/nettime.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_NETTIME_H
+#define __OFONO_NETTIME_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_network_time;
+
+struct ofono_nettime_context {
+	struct ofono_nettime_driver *driver;
+	struct ofono_modem *modem;
+	void *data;
+};
+
+struct ofono_nettime_driver {
+	const char *name;
+	int (*probe)(struct ofono_nettime_context *context);
+	void (*remove)(struct ofono_nettime_context *context);
+	void (*info_received)(struct ofono_nettime_context *context,
+				struct ofono_network_time *info);
+};
+
+int ofono_nettime_driver_register(const struct ofono_nettime_driver *drive=
r);
+void ofono_nettime_driver_unregister(const struct ofono_nettime_driver *dr=
iver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_NETTIME_H */
diff --git a/include/ofono/phonebook.h b/include/ofono/phonebook.h
new file mode 100644
index 0000000..73780b2
--- /dev/null
+++ b/include/ofono/phonebook.h
@@ -0,0 +1,74 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_PHONEBOOK_H
+#define __OFONO_PHONEBOOK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_phonebook;
+
+typedef void (*ofono_phonebook_cb_t)(const struct ofono_error *error,
+					void *data);
+
+/* Export entries reports results through ofono_phonebook_entry, if an err=
or
+ * occurs, ofono_phonebook_entry should not be called
+ */
+struct ofono_phonebook_driver {
+	const char *name;
+	int (*probe)(struct ofono_phonebook *pb, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_phonebook *pb);
+	void (*export_entries)(struct ofono_phonebook *pb, const char *storage,
+				ofono_phonebook_cb_t cb, void *data);
+};
+
+void ofono_phonebook_entry(struct ofono_phonebook *pb, int index,
+				const char *number, int type,
+				const char *text, int hidden,
+				const char *group,
+				const char *adnumber, int adtype,
+				const char *secondtext, const char *email,
+				const char *sip_uri, const char *tel_uri);
+
+int ofono_phonebook_driver_register(const struct ofono_phonebook_driver *d=
);
+void ofono_phonebook_driver_unregister(const struct ofono_phonebook_driver=
 *d);
+
+struct ofono_phonebook *ofono_phonebook_create(struct ofono_modem *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data);
+
+void ofono_phonebook_register(struct ofono_phonebook *pb);
+void ofono_phonebook_remove(struct ofono_phonebook *pb);
+
+void ofono_phonebook_set_data(struct ofono_phonebook *pb, void *data);
+void *ofono_phonebook_get_data(struct ofono_phonebook *pb);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PHONEBOOK_H */
diff --git a/include/ofono/plugin.h b/include/ofono/plugin.h
new file mode 100644
index 0000000..654fc98
--- /dev/null
+++ b/include/ofono/plugin.h
@@ -0,0 +1,91 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_PLUGIN_H
+#define __OFONO_PLUGIN_H
+
+#include <ofono/version.h>
+#include <ofono/log.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifndef OFONO_API_SUBJECT_TO_CHANGE
+#error "Please define OFONO_API_SUBJECT_TO_CHANGE to acknowledge your \
+understanding that oFono hasn't reached a stable API."
+#endif
+
+#define OFONO_PLUGIN_PRIORITY_LOW      -100
+#define OFONO_PLUGIN_PRIORITY_DEFAULT     0
+#define OFONO_PLUGIN_PRIORITY_HIGH      100
+
+/**
+ * SECTION:plugin
+ * @title: Plugin premitives
+ * @short_description: Functions for declaring plugins
+ */
+
+struct ofono_plugin_desc {
+	const char *name;
+	const char *description;
+	const char *version;
+	int priority;
+	int (*init) (void);
+	void (*exit) (void);
+	void *debug_start;
+	void *debug_stop;
+};
+
+/**
+ * OFONO_PLUGIN_DEFINE:
+ * @name: plugin name
+ * @description: plugin description
+ * @version: plugin version string
+ * @init: init function called on plugin loading
+ * @exit: exit function called on plugin removal
+ *
+ * Macro for defining a plugin descriptor
+ */
+#ifdef OFONO_PLUGIN_BUILTIN
+#define OFONO_PLUGIN_DEFINE(name, description, version, priority, init, ex=
it) \
+		struct ofono_plugin_desc __ofono_builtin_ ## name =3D { \
+			#name, description, version, priority, init, exit \
+		};
+#else
+#define OFONO_PLUGIN_DEFINE(name, description, version, priority, init, ex=
it) \
+		extern struct ofono_debug_desc __start___debug[] \
+				__attribute__ ((weak, visibility("hidden"))); \
+		extern struct ofono_debug_desc __stop___debug[] \
+				__attribute__ ((weak, visibility("hidden"))); \
+		extern struct ofono_plugin_desc ofono_plugin_desc \
+				__attribute__ ((visibility("default"))); \
+		struct ofono_plugin_desc ofono_plugin_desc =3D { \
+			#name, description, version, priority, init, exit, \
+			__start___debug, __stop___debug \
+		};
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PLUGIN_H */
diff --git a/include/ofono/private-network.h b/include/ofono/private-networ=
k.h
new file mode 100644
index 0000000..860d40a
--- /dev/null
+++ b/include/ofono/private-network.h
@@ -0,0 +1,56 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_PRIVATE_NETWORK_H
+#define __OFONO_PRIVATE_NETWORK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_private_network_settings {
+	int fd;
+	char *server_ip;
+	char *peer_ip;
+	char *primary_dns;
+	char *secondary_dns;
+};
+
+typedef void (*ofono_private_network_cb_t)(
+			const struct ofono_private_network_settings *settings,
+			void *data);
+
+struct ofono_private_network_driver {
+	char *name;
+	int (*request)(ofono_private_network_cb_t cb, void *data);
+	void (*release)(int uid);
+};
+
+int ofono_private_network_driver_register(
+			const struct ofono_private_network_driver *d);
+void ofono_private_network_driver_unregister(
+			const struct ofono_private_network_driver *d);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_PRIVATE_NETWORK_H */
diff --git a/include/ofono/radio-settings.h b/include/ofono/radio-settings.h
new file mode 100644
index 0000000..59b9888
--- /dev/null
+++ b/include/ofono/radio-settings.h
@@ -0,0 +1,140 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_RADIO_SETTINGS_H
+#define __OFONO_RADIO_SETTINGS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum ofono_radio_access_mode {
+	OFONO_RADIO_ACCESS_MODE_ANY	=3D 0x0,
+	OFONO_RADIO_ACCESS_MODE_GSM	=3D 0x1,
+	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 0x2,
+	OFONO_RADIO_ACCESS_MODE_LTE	=3D 0x4,
+};
+
+enum ofono_radio_band_gsm {
+	OFONO_RADIO_BAND_GSM_ANY,
+	OFONO_RADIO_BAND_GSM_850,
+	OFONO_RADIO_BAND_GSM_900P,
+	OFONO_RADIO_BAND_GSM_900E,
+	OFONO_RADIO_BAND_GSM_1800,
+	OFONO_RADIO_BAND_GSM_1900,
+};
+
+enum ofono_radio_band_umts {
+	OFONO_RADIO_BAND_UMTS_ANY,
+	OFONO_RADIO_BAND_UMTS_850,
+	OFONO_RADIO_BAND_UMTS_900,
+	OFONO_RADIO_BAND_UMTS_1700AWS,
+	OFONO_RADIO_BAND_UMTS_1900,
+	OFONO_RADIO_BAND_UMTS_2100,
+};
+
+struct ofono_radio_settings;
+
+typedef void (*ofono_radio_settings_rat_mode_set_cb_t)(
+						const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_radio_settings_rat_mode_query_cb_t)(
+					const struct ofono_error *error,
+					enum ofono_radio_access_mode mode,
+					void *data);
+
+typedef void (*ofono_radio_settings_band_set_cb_t)(
+						const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_radio_settings_band_query_cb_t)(
+					const struct ofono_error *error,
+					enum ofono_radio_band_gsm band_gsm,
+					enum ofono_radio_band_umts band_umts,
+					void *data);
+
+typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(
+						const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(
+						const struct ofono_error *error,
+						ofono_bool_t enable,
+						void *data);
+
+typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
+						const struct ofono_error *error,
+						unsigned int available_rats,
+						void *data);
+
+struct ofono_radio_settings_driver {
+	const char *name;
+	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_radio_settings *rs);
+	void (*query_rat_mode)(struct ofono_radio_settings *rs,
+				ofono_radio_settings_rat_mode_query_cb_t cb,
+				void *data);
+	void (*set_rat_mode)(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_rat_mode_set_cb_t cb,
+				void *data);
+	void (*query_band)(struct ofono_radio_settings *rs,
+				ofono_radio_settings_band_query_cb_t cb,
+				void *data);
+	void (*set_band)(struct ofono_radio_settings *rs,
+				enum ofono_radio_band_gsm band_gsm,
+				enum ofono_radio_band_umts band_umts,
+				ofono_radio_settings_band_set_cb_t cb,
+				void *data);
+	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data);
+	void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t,
+				void *data);
+	void (*query_available_rats)(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data);
+};
+
+int ofono_radio_settings_driver_register(
+				const struct ofono_radio_settings_driver *d);
+void ofono_radio_settings_driver_unregister(
+				const struct ofono_radio_settings_driver *d);
+
+struct ofono_radio_settings *ofono_radio_settings_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_radio_settings_register(struct ofono_radio_settings *rs);
+void ofono_radio_settings_remove(struct ofono_radio_settings *rs);
+
+void ofono_radio_settings_set_data(struct ofono_radio_settings *rs, void *=
data);
+void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_RADIO_SETTINGS_H */
diff --git a/include/ofono/sim-auth.h b/include/ofono/sim-auth.h
new file mode 100644
index 0000000..0a62adc
--- /dev/null
+++ b/include/ofono/sim-auth.h
@@ -0,0 +1,64 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_SIM_AUTH_H
+#define __OFONO_SIM_AUTH_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_sim_auth;
+
+typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
+					const unsigned char *dataobj,
+					int len, void *data);
+
+struct ofono_sim_auth_driver {
+	const char *name;
+	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_sim_auth *sa);
+
+	void (*list_apps)(struct ofono_sim_auth *sa,
+				ofono_sim_list_apps_cb_t cb, void *data);
+};
+
+int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
+void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d);
+
+struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver, void *data);
+
+void ofono_sim_auth_register(struct ofono_sim_auth *sa);
+void ofono_sim_auth_remove(struct ofono_sim_auth *sa);
+
+void ofono_sim_auth_set_data(struct ofono_sim_auth *sa, void *data);
+void *ofono_sim_auth_get_data(struct ofono_sim_auth *sa);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIM_AUTH_H */
diff --git a/include/ofono/sim.h b/include/ofono/sim.h
new file mode 100644
index 0000000..ed850f9
--- /dev/null
+++ b/include/ofono/sim.h
@@ -0,0 +1,255 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_SIM_H
+#define __OFONO_SIM_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_sim;
+struct ofono_sim_context;
+
+/* 51.011 Section 9.3 */
+enum ofono_sim_file_structure {
+	OFONO_SIM_FILE_STRUCTURE_TRANSPARENT =3D 0,
+	OFONO_SIM_FILE_STRUCTURE_FIXED =3D 1,
+	OFONO_SIM_FILE_STRUCTURE_CYCLIC =3D 3
+};
+
+enum ofono_sim_password_type {
+	OFONO_SIM_PASSWORD_NONE =3D 0,
+	OFONO_SIM_PASSWORD_SIM_PIN,
+	OFONO_SIM_PASSWORD_PHSIM_PIN,
+	OFONO_SIM_PASSWORD_PHFSIM_PIN,
+	OFONO_SIM_PASSWORD_SIM_PIN2,
+	OFONO_SIM_PASSWORD_PHNET_PIN,
+	OFONO_SIM_PASSWORD_PHNETSUB_PIN,
+	OFONO_SIM_PASSWORD_PHSP_PIN,
+	OFONO_SIM_PASSWORD_PHCORP_PIN,
+	OFONO_SIM_PASSWORD_SIM_PUK,
+	OFONO_SIM_PASSWORD_PHFSIM_PUK,
+	OFONO_SIM_PASSWORD_SIM_PUK2,
+	OFONO_SIM_PASSWORD_PHNET_PUK,
+	OFONO_SIM_PASSWORD_PHNETSUB_PUK,
+	OFONO_SIM_PASSWORD_PHSP_PUK,
+	OFONO_SIM_PASSWORD_PHCORP_PUK,
+	OFONO_SIM_PASSWORD_INVALID,
+};
+
+enum ofono_sim_phase {
+	OFONO_SIM_PHASE_1G,
+	OFONO_SIM_PHASE_2G,
+	OFONO_SIM_PHASE_2G_PLUS,
+	OFONO_SIM_PHASE_3G,
+	OFONO_SIM_PHASE_UNKNOWN,
+};
+
+enum ofono_sim_cphs_phase {
+	OFONO_SIM_CPHS_PHASE_NONE,
+	OFONO_SIM_CPHS_PHASE_1G,
+	OFONO_SIM_CPHS_PHASE_2G,
+};
+
+enum ofono_sim_state {
+	OFONO_SIM_STATE_NOT_PRESENT,
+	OFONO_SIM_STATE_INSERTED,
+	OFONO_SIM_STATE_LOCKED_OUT,
+	OFONO_SIM_STATE_READY,
+	OFONO_SIM_STATE_RESETTING,
+};
+
+typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
+					int filelength,
+					enum ofono_sim_file_structure structure,
+					int recordlength,
+					const unsigned char access[3],
+					unsigned char file_status,
+					void *data);
+
+typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
+					const unsigned char *sdata, int length,
+					void *data);
+
+typedef void (*ofono_sim_write_cb_t)(const struct ofono_error *error,
+					void *data);
+
+typedef void (*ofono_sim_imsi_cb_t)(const struct ofono_error *error,
+					const char *imsi, void *data);
+
+typedef void (*ofono_sim_state_event_cb_t)(enum ofono_sim_state new_state,
+					void *data);
+
+typedef void (*ofono_sim_file_read_cb_t)(int ok, int total_length, int rec=
ord,
+					const unsigned char *data,
+					int record_length, void *userdata);
+typedef void (*ofono_sim_file_changed_cb_t)(int id, void *userdata);
+
+typedef void (*ofono_sim_file_write_cb_t)(int ok, void *userdata);
+
+typedef void (*ofono_sim_passwd_cb_t)(const struct ofono_error *error,
+					enum ofono_sim_password_type type,
+					void *data);
+
+typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *error,
+			int retries[OFONO_SIM_PASSWORD_INVALID], void *data);
+
+typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *error,
+					void *data);
+
+typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
+					int locked, void *data);
+
+struct ofono_sim_driver {
+	const char *name;
+	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_sim *sim);
+	void (*read_file_info)(struct ofono_sim *sim, int fileid,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_file_info_cb_t cb, void *data);
+	void (*read_file_transparent)(struct ofono_sim *sim, int fileid,
+			int start, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*read_file_linear)(struct ofono_sim *sim, int fileid,
+			int record, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*read_file_cyclic)(struct ofono_sim *sim, int fileid,
+			int record, int length,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_read_cb_t cb, void *data);
+	void (*write_file_transparent)(struct ofono_sim *sim, int fileid,
+			int start, int length, const unsigned char *value,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_write_cb_t cb, void *data);
+	void (*write_file_linear)(struct ofono_sim *sim, int fileid,
+			int record, int length, const unsigned char *value,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_write_cb_t cb, void *data);
+	void (*write_file_cyclic)(struct ofono_sim *sim, int fileid,
+			int length, const unsigned char *value,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_write_cb_t cb, void *data);
+	void (*read_imsi)(struct ofono_sim *sim,
+			ofono_sim_imsi_cb_t cb, void *data);
+	void (*query_passwd_state)(struct ofono_sim *sim,
+			ofono_sim_passwd_cb_t cb, void *data);
+	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data);
+	void (*query_pin_retries)(struct ofono_sim *sim,
+				ofono_sim_pin_retries_cb_t cb, void *data);
+	void (*reset_passwd)(struct ofono_sim *sim, const char *puk,
+			const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data);
+	void (*change_passwd)(struct ofono_sim *sim,
+			enum ofono_sim_password_type type,
+			const char *old_passwd, const char *new_passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data);
+	void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type type,
+			int enable, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data);
+	void (*query_locked)(struct ofono_sim *sim,
+			enum ofono_sim_password_type type,
+			ofono_sim_locked_cb_t cb, void *data);
+};
+
+int ofono_sim_driver_register(const struct ofono_sim_driver *d);
+void ofono_sim_driver_unregister(const struct ofono_sim_driver *d);
+
+struct ofono_sim *ofono_sim_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_sim_register(struct ofono_sim *sim);
+void ofono_sim_remove(struct ofono_sim *sim);
+
+void ofono_sim_set_data(struct ofono_sim *sim, void *data);
+void *ofono_sim_get_data(struct ofono_sim *sim);
+
+const char *ofono_sim_get_imsi(struct ofono_sim *sim);
+const char *ofono_sim_get_mcc(struct ofono_sim *sim);
+const char *ofono_sim_get_mnc(struct ofono_sim *sim);
+const char *ofono_sim_get_spn(struct ofono_sim *sim);
+enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
+
+enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
+const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
+
+enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim);
+
+unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
+					ofono_sim_state_event_cb_t cb,
+					void *data, ofono_destroy_func destroy);
+
+void ofono_sim_remove_state_watch(struct ofono_sim *sim, unsigned int id);
+
+enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
+
+typedef void (*ofono_sim_spn_cb_t)(const char *spn, const char *dc, void *=
data);
+
+ofono_bool_t ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *=
id,
+					ofono_sim_spn_cb_t cb, void *data,
+					ofono_destroy_func destroy);
+
+ofono_bool_t ofono_sim_remove_spn_watch(struct ofono_sim *sim, unsigned in=
t *id);
+
+void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
+
+struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
+void ofono_sim_context_free(struct ofono_sim_context *context);
+
+/* This will queue an operation to read all available records with id from=
 the
+ * SIM.  Callback cb will be called every time a record has been read, or =
once
+ * if an error has occurred.  For transparent files, the callback will only
+ * be called once.
+ *
+ * Returns 0 if the request could be queued, -1 otherwise.
+ */
+int ofono_sim_read(struct ofono_sim_context *context, int id,
+			enum ofono_sim_file_structure expected,
+			ofono_sim_file_read_cb_t cb, void *data);
+
+int ofono_sim_write(struct ofono_sim_context *context, int id,
+			ofono_sim_file_write_cb_t cb,
+			enum ofono_sim_file_structure structure, int record,
+			const unsigned char *data, int length, void *userdata);
+
+int ofono_sim_read_bytes(struct ofono_sim_context *context, int id,
+			unsigned short offset, unsigned short num_bytes,
+			const unsigned char *path, unsigned int path_len,
+			ofono_sim_file_read_cb_t cb, void *data);
+
+unsigned int ofono_sim_add_file_watch(struct ofono_sim_context *context,
+					int id, ofono_sim_file_changed_cb_t cb,
+					void *userdata,
+					ofono_destroy_func destroy);
+void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
+					unsigned int id);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIM_H */
diff --git a/include/ofono/siri.h b/include/ofono/siri.h
new file mode 100644
index 0000000..7288bca
--- /dev/null
+++ b/include/ofono/siri.h
@@ -0,0 +1,63 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2013  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_SIRI_H
+#define __OFONO_SIRI_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_siri;
+
+typedef void (*ofono_siri_cb_t)(const struct ofono_error *error,
+					struct ofono_siri *siri);
+
+struct ofono_siri_driver {
+	const char *name;
+	int (*probe)(struct ofono_siri *siri, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_siri *siri);
+	void (*set_eyes_free_mode) (struct ofono_siri *siri, ofono_siri_cb_t cb,
+					unsigned int val);
+};
+
+void ofono_siri_set_status(struct ofono_siri *siri, int value);
+
+int ofono_siri_driver_register(const struct ofono_siri_driver *driver);
+void ofono_siri_driver_unregister(const struct ofono_siri_driver *driver);
+
+struct ofono_siri *ofono_siri_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_siri_register(struct ofono_siri *siri);
+void ofono_siri_remove(struct ofono_siri *siri);
+
+void ofono_siri_set_data(struct ofono_siri *siri, void *data);
+void *ofono_siri_get_data(struct ofono_siri *siri);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SIRI_H */
diff --git a/include/ofono/sms.h b/include/ofono/sms.h
new file mode 100644
index 0000000..e926056
--- /dev/null
+++ b/include/ofono/sms.h
@@ -0,0 +1,85 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_SMS_H
+#define __OFONO_SMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_sms;
+
+typedef void (*ofono_sms_sca_query_cb_t)(const struct ofono_error *error,
+					const struct ofono_phone_number *ph,
+					void *data);
+typedef void (*ofono_sms_submit_cb_t)(const struct ofono_error *error, int=
 mr,
+					void *data);
+typedef void (*ofono_sms_sca_set_cb_t)(const struct ofono_error *error,
+					void *data);
+typedef void (*ofono_sms_bearer_set_cb_t)(const struct ofono_error *error,
+						void *data);
+typedef void (*ofono_sms_bearer_query_cb_t)(const struct ofono_error *erro=
r,
+						int bearer, void *data);
+
+struct ofono_sms_driver {
+	const char *name;
+	int (*probe)(struct ofono_sms *sms, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_sms *sms);
+	void (*sca_query)(struct ofono_sms *sms, ofono_sms_sca_query_cb_t cb,
+				void *data);
+	void (*sca_set)(struct ofono_sms *sms,
+			const struct ofono_phone_number *sca,
+			ofono_sms_sca_set_cb_t cb, void *data);
+	void (*submit)(struct ofono_sms *sms, const unsigned char *pdu,
+			int pdu_len, int tpdu_len, int mms,
+			ofono_sms_submit_cb_t cb, void *data);
+	void (*bearer_query)(struct ofono_sms *sms,
+				ofono_sms_bearer_query_cb_t, void *data);
+	void (*bearer_set)(struct ofono_sms *sms, int bearer,
+				ofono_sms_bearer_set_cb_t, void *data);
+};
+
+void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char *=
pdu,
+				int len, int tpdu_len);
+void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char *p=
du,
+				int len, int tpdu_len);
+
+int ofono_sms_driver_register(const struct ofono_sms_driver *d);
+void ofono_sms_driver_unregister(const struct ofono_sms_driver *d);
+
+struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_sms_register(struct ofono_sms *sms);
+void ofono_sms_remove(struct ofono_sms *sms);
+
+void ofono_sms_set_data(struct ofono_sms *sms, void *data);
+void *ofono_sms_get_data(struct ofono_sms *sms);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_SMS_H */
diff --git a/include/ofono/stk.h b/include/ofono/stk.h
new file mode 100644
index 0000000..6182804
--- /dev/null
+++ b/include/ofono/stk.h
@@ -0,0 +1,79 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_STK_H
+#define __OFONO_STK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_stk;
+
+typedef void (*ofono_stk_envelope_cb_t)(const struct ofono_error *error,
+					const unsigned char *rdata,
+					int length, void *data);
+
+typedef void (*ofono_stk_generic_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_stk_driver {
+	const char *name;
+	int (*probe)(struct ofono_stk *stk, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_stk *stk);
+	void (*envelope)(struct ofono_stk *stk,
+				int length, const unsigned char *command,
+				ofono_stk_envelope_cb_t cb, void *data);
+	void (*terminal_response)(struct ofono_stk *stk,
+					int length, const unsigned char *resp,
+					ofono_stk_generic_cb_t cb, void *data);
+	void (*user_confirmation)(struct ofono_stk *stk, ofono_bool_t confirm);
+};
+
+int ofono_stk_driver_register(const struct ofono_stk_driver *d);
+void ofono_stk_driver_unregister(const struct ofono_stk_driver *d);
+
+struct ofono_stk *ofono_stk_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_stk_register(struct ofono_stk *stk);
+void ofono_stk_remove(struct ofono_stk *stk);
+
+void ofono_stk_set_data(struct ofono_stk *stk, void *data);
+void *ofono_stk_get_data(struct ofono_stk *stk);
+
+void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
+					int length, const unsigned char *pdu);
+
+void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk);
+
+void ofono_stk_proactive_command_handled_notify(struct ofono_stk *stk,
+						int length,
+						const unsigned char *pdu);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_STK_H */
diff --git a/include/ofono/types.h b/include/ofono/types.h
new file mode 100644
index 0000000..9a7dfd9
--- /dev/null
+++ b/include/ofono/types.h
@@ -0,0 +1,125 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_TYPES_H
+#define __OFONO_TYPES_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifndef	FALSE
+#define	FALSE	(0)
+#endif
+
+#ifndef	TRUE
+#define	TRUE	(!FALSE)
+#endif
+
+typedef int		ofono_bool_t;
+
+/* MCC is always three digits. MNC is either two or three digits */
+#define OFONO_MAX_MCC_LENGTH 3
+#define OFONO_MAX_MNC_LENGTH 3
+
+typedef void (*ofono_destroy_func)(void *data);
+
+/* 27.007 Section 6.2 */
+enum ofono_clir_option {
+	OFONO_CLIR_OPTION_DEFAULT =3D 0,
+	OFONO_CLIR_OPTION_INVOCATION,
+	OFONO_CLIR_OPTION_SUPPRESSION,
+};
+
+enum ofono_error_type {
+	OFONO_ERROR_TYPE_NO_ERROR =3D 0,
+	OFONO_ERROR_TYPE_CME,
+	OFONO_ERROR_TYPE_CMS,
+	OFONO_ERROR_TYPE_CEER,
+	OFONO_ERROR_TYPE_SIM,
+	OFONO_ERROR_TYPE_FAILURE,
+};
+
+enum ofono_disconnect_reason {
+	OFONO_DISCONNECT_REASON_UNKNOWN =3D 0,
+	OFONO_DISCONNECT_REASON_LOCAL_HANGUP,
+	OFONO_DISCONNECT_REASON_REMOTE_HANGUP,
+	OFONO_DISCONNECT_REASON_ERROR,
+};
+
+struct ofono_error {
+	enum ofono_error_type type;
+	int error;
+};
+
+#define OFONO_MAX_PHONE_NUMBER_LENGTH 80
+#define OFONO_MAX_CALLER_NAME_LENGTH 80
+
+struct ofono_phone_number {
+	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
+	int type;
+};
+
+/* Length of NUM_FIELDS in 3GPP2 C.S0005-E v2.0 */
+#define OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH 256
+
+struct ofono_cdma_phone_number {
+	/* char maps to max size of CHARi (8 bit) in 3GPP2 C.S0005-E v2.0 */
+	char number[OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH];
+};
+
+struct ofono_call {
+	unsigned int id;
+	int type;
+	int direction;
+	int status;
+	struct ofono_phone_number phone_number;
+	struct ofono_phone_number called_number;
+	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
+	int clip_validity;
+	int cnap_validity;
+};
+
+struct ofono_network_time {
+	int sec;	/* Seconds [0..59], -1 if unavailable */
+	int min;	/* Minutes [0..59], -1 if unavailable */
+	int hour;	/* Hours [0..23], -1 if unavailable */
+	int mday;	/* Day of month [1..31], -1 if unavailable */
+	int mon;	/* Month [1..12], -1 if unavailable */
+	int year;	/* Current year, -1 if unavailable */
+	int dst;	/* Current adjustment, in hours */
+	int utcoff;	/* Offset from UTC in seconds */
+};
+
+#define OFONO_SHA1_UUID_LEN 20
+
+struct ofono_uuid {
+	unsigned char uuid[OFONO_SHA1_UUID_LEN];
+};
+
+const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
+void ofono_call_init(struct ofono_call *call);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_TYPES_H */
diff --git a/include/ofono/ussd.h b/include/ofono/ussd.h
new file mode 100644
index 0000000..ac463e7
--- /dev/null
+++ b/include/ofono/ussd.h
@@ -0,0 +1,76 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_USSD_H
+#define __OFONO_USSD_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+/* 3GPP TS 27.007 section 7.15, values for <m> */
+enum ofono_ussd_status {
+	OFONO_USSD_STATUS_NOTIFY =3D 0,
+	OFONO_USSD_STATUS_ACTION_REQUIRED =3D 1,
+	OFONO_USSD_STATUS_TERMINATED =3D 2,
+	OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED =3D 3,
+	OFONO_USSD_STATUS_NOT_SUPPORTED =3D 4,
+	OFONO_USSD_STATUS_TIMED_OUT =3D 5,
+};
+
+struct ofono_ussd;
+
+typedef void (*ofono_ussd_cb_t)(const struct ofono_error *error, void *dat=
a);
+
+struct ofono_ussd_driver {
+	const char *name;
+	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
+	void (*remove)(struct ofono_ussd *ussd);
+	void (*request)(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t, void *data);
+	void (*cancel)(struct ofono_ussd *ussd,
+				ofono_ussd_cb_t cb, void *data);
+};
+
+void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
+			const unsigned char *data, int data_len);
+
+int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
+void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
+
+struct ofono_ussd *ofono_ussd_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_ussd_register(struct ofono_ussd *ussd);
+void ofono_ussd_remove(struct ofono_ussd *ussd);
+
+void ofono_ussd_set_data(struct ofono_ussd *ussd, void *data);
+void *ofono_ussd_get_data(struct ofono_ussd *ussd);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_USSD_H */
diff --git a/include/ofono/version.h.in b/include/ofono/version.h.in
new file mode 100644
index 0000000..396b98a
--- /dev/null
+++ b/include/ofono/version.h.in
@@ -0,0 +1,35 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_VERSION_H
+#define __OFONO_VERSION_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define OFONO_VERSION	"@VERSION@"
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_VERSION_H */
diff --git a/include/ofono/voicecall.h b/include/ofono/voicecall.h
new file mode 100644
index 0000000..4d0b388
--- /dev/null
+++ b/include/ofono/voicecall.h
@@ -0,0 +1,178 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_VOICECALL_H
+#define __OFONO_VOICECALL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_voicecall;
+
+typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
+					void *data);
+
+/* Voice call related functionality, including ATD, ATA, +CHLD, CTFR, CLCC
+ * and VTS.
+ *
+ * It is up to the plugin to implement polling of CLCC if the modem does
+ * not support vendor extensions for call progress indication.
+ */
+struct ofono_voicecall_driver {
+	const char *name;
+	int (*probe)(struct ofono_voicecall *vc, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_voicecall *vc);
+
+	/* According to 22.030 the dial is expected to do the following:
+	 * - If an there is an existing active call(s), and the dial is
+	 *   successful, the active calls are automatically put on hold.
+	 *   Driver must take special care to put the call on hold before
+	 *   returning from atd call.
+	 *
+	 * - The dial has no affect on the state of the waiting call,
+	 *   if the hardware does not support this, then it is better
+	 *   to return an error here.  No special handling of the
+	 *   waiting call is performed by the core
+	 */
+	void (*dial)(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *number,
+			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
+			void *data);
+	/* Answers an incoming call, this usually corresponds to ATA */
+	void (*answer)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+
+	/* Hangs up active, dialing, alerting or incoming calls */
+	void (*hangup_active)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/* Hangs up all calls except waiting calls */
+	void (*hangup_all)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Holds all active calls and answers waiting call.  If there is
+	 * no waiting calls, retrieves held call.  This usually
+	 * corresponds to +CHLD=3D2
+	 */
+	void (*hold_all_active)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/* Releases all held calls, this usually corresponds to +CHLD=3D0*/
+	void (*release_all_held)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Sets the UDUB condition on a waiting call.  This usually
+	 * corresponds to +CHLD=3D0
+	 */
+	void (*set_udub)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Releases all active calls and accepts a possible waiting call.
+	 * This usually corresponds to +CHLD=3D1
+	 */
+	void (*release_all_active)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Releases a specific call given by id.  This usually corresponds to
+	 * +CHLD=3D1X.  In 3GPP this command is only guaranteed to affect active
+	 * calls.  Plugins are encouraged to implement this using vendor
+	 * commands that can also affect held calls
+	 */
+	void (*release_specific)(struct ofono_voicecall *vc, int id,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Breaks out a party given by id from a multiparty call.  This
+	 * usually corresponds to +CHLD=3D2X
+	 */
+	void (*private_chat)(struct ofono_voicecall *vc, int id,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Joins held and active calls together into a multiparty call.  This
+	 * usually corresponds to +CHLD=3D3
+	 */
+	void (*create_multiparty)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Connects two calls together and disconnects from both calls.  This
+	 * usually corresponds to +CHLD=3D4
+	 */
+	void (*transfer)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * Deflects an incoming or waiting call to a given number.  This
+	 * usually corresponds to +CTFR
+	 */
+	void (*deflect)(struct ofono_voicecall *vc,
+			const struct ofono_phone_number *ph,
+			ofono_voicecall_cb_t cb, void *data);
+	/*
+	 * This is equivalent to +CHLD=3D2 but does not affect a possible
+	 * waiting call.
+	 */
+	void (*swap_without_accept)(struct ofono_voicecall *vc,
+			ofono_voicecall_cb_t cb, void *data);
+	void (*send_tones)(struct ofono_voicecall *vc, const char *tones,
+			ofono_voicecall_cb_t cb, void *data);
+};
+
+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+					char **nw_en_list);
+
+void ofono_voicecall_notify(struct ofono_voicecall *vc,
+				const struct ofono_call *call);
+void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
+				enum ofono_disconnect_reason reason,
+				const struct ofono_error *error);
+
+/*
+ * For those protocols where MPTY creation happens outside of oFono's cont=
rol,
+ * e.g. Bluetooth Handsfree, set the hint of the MPTY call list by passing
+ * in a bitmask of ids participating in the MPTY call
+ */
+void ofono_voicecall_mpty_hint(struct ofono_voicecall *vc, unsigned int id=
s);
+
+int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d=
);
+void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d);
+
+struct ofono_voicecall *ofono_voicecall_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_voicecall_register(struct ofono_voicecall *vc);
+void ofono_voicecall_remove(struct ofono_voicecall *vc);
+
+void ofono_voicecall_set_data(struct ofono_voicecall *vc, void *data);
+void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
+int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
+
+void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc, unsigned in=
t id,
+					int code, int index);
+void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc, unsigned in=
t id,
+					int code, int index,
+					const struct ofono_phone_number *ph);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_VOICECALL_H */
diff --git a/include/phonebook.h b/include/phonebook.h
deleted file mode 100644
index 73780b2..0000000
--- a/include/phonebook.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_PHONEBOOK_H
-#define __OFONO_PHONEBOOK_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_phonebook;
-
-typedef void (*ofono_phonebook_cb_t)(const struct ofono_error *error,
-					void *data);
-
-/* Export entries reports results through ofono_phonebook_entry, if an err=
or
- * occurs, ofono_phonebook_entry should not be called
- */
-struct ofono_phonebook_driver {
-	const char *name;
-	int (*probe)(struct ofono_phonebook *pb, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_phonebook *pb);
-	void (*export_entries)(struct ofono_phonebook *pb, const char *storage,
-				ofono_phonebook_cb_t cb, void *data);
-};
-
-void ofono_phonebook_entry(struct ofono_phonebook *pb, int index,
-				const char *number, int type,
-				const char *text, int hidden,
-				const char *group,
-				const char *adnumber, int adtype,
-				const char *secondtext, const char *email,
-				const char *sip_uri, const char *tel_uri);
-
-int ofono_phonebook_driver_register(const struct ofono_phonebook_driver *d=
);
-void ofono_phonebook_driver_unregister(const struct ofono_phonebook_driver=
 *d);
-
-struct ofono_phonebook *ofono_phonebook_create(struct ofono_modem *modem,
-							unsigned int vendor,
-							const char *driver,
-							void *data);
-
-void ofono_phonebook_register(struct ofono_phonebook *pb);
-void ofono_phonebook_remove(struct ofono_phonebook *pb);
-
-void ofono_phonebook_set_data(struct ofono_phonebook *pb, void *data);
-void *ofono_phonebook_get_data(struct ofono_phonebook *pb);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_PHONEBOOK_H */
diff --git a/include/plugin.h b/include/plugin.h
deleted file mode 100644
index 654fc98..0000000
--- a/include/plugin.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_PLUGIN_H
-#define __OFONO_PLUGIN_H
-
-#include <ofono/version.h>
-#include <ofono/log.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#ifndef OFONO_API_SUBJECT_TO_CHANGE
-#error "Please define OFONO_API_SUBJECT_TO_CHANGE to acknowledge your \
-understanding that oFono hasn't reached a stable API."
-#endif
-
-#define OFONO_PLUGIN_PRIORITY_LOW      -100
-#define OFONO_PLUGIN_PRIORITY_DEFAULT     0
-#define OFONO_PLUGIN_PRIORITY_HIGH      100
-
-/**
- * SECTION:plugin
- * @title: Plugin premitives
- * @short_description: Functions for declaring plugins
- */
-
-struct ofono_plugin_desc {
-	const char *name;
-	const char *description;
-	const char *version;
-	int priority;
-	int (*init) (void);
-	void (*exit) (void);
-	void *debug_start;
-	void *debug_stop;
-};
-
-/**
- * OFONO_PLUGIN_DEFINE:
- * @name: plugin name
- * @description: plugin description
- * @version: plugin version string
- * @init: init function called on plugin loading
- * @exit: exit function called on plugin removal
- *
- * Macro for defining a plugin descriptor
- */
-#ifdef OFONO_PLUGIN_BUILTIN
-#define OFONO_PLUGIN_DEFINE(name, description, version, priority, init, ex=
it) \
-		struct ofono_plugin_desc __ofono_builtin_ ## name =3D { \
-			#name, description, version, priority, init, exit \
-		};
-#else
-#define OFONO_PLUGIN_DEFINE(name, description, version, priority, init, ex=
it) \
-		extern struct ofono_debug_desc __start___debug[] \
-				__attribute__ ((weak, visibility("hidden"))); \
-		extern struct ofono_debug_desc __stop___debug[] \
-				__attribute__ ((weak, visibility("hidden"))); \
-		extern struct ofono_plugin_desc ofono_plugin_desc \
-				__attribute__ ((visibility("default"))); \
-		struct ofono_plugin_desc ofono_plugin_desc =3D { \
-			#name, description, version, priority, init, exit, \
-			__start___debug, __stop___debug \
-		};
-#endif
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_PLUGIN_H */
diff --git a/include/private-network.h b/include/private-network.h
deleted file mode 100644
index 860d40a..0000000
--- a/include/private-network.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_PRIVATE_NETWORK_H
-#define __OFONO_PRIVATE_NETWORK_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct ofono_private_network_settings {
-	int fd;
-	char *server_ip;
-	char *peer_ip;
-	char *primary_dns;
-	char *secondary_dns;
-};
-
-typedef void (*ofono_private_network_cb_t)(
-			const struct ofono_private_network_settings *settings,
-			void *data);
-
-struct ofono_private_network_driver {
-	char *name;
-	int (*request)(ofono_private_network_cb_t cb, void *data);
-	void (*release)(int uid);
-};
-
-int ofono_private_network_driver_register(
-			const struct ofono_private_network_driver *d);
-void ofono_private_network_driver_unregister(
-			const struct ofono_private_network_driver *d);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_PRIVATE_NETWORK_H */
diff --git a/include/radio-settings.h b/include/radio-settings.h
deleted file mode 100644
index 59b9888..0000000
--- a/include/radio-settings.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_RADIO_SETTINGS_H
-#define __OFONO_RADIO_SETTINGS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-enum ofono_radio_access_mode {
-	OFONO_RADIO_ACCESS_MODE_ANY	=3D 0x0,
-	OFONO_RADIO_ACCESS_MODE_GSM	=3D 0x1,
-	OFONO_RADIO_ACCESS_MODE_UMTS	=3D 0x2,
-	OFONO_RADIO_ACCESS_MODE_LTE	=3D 0x4,
-};
-
-enum ofono_radio_band_gsm {
-	OFONO_RADIO_BAND_GSM_ANY,
-	OFONO_RADIO_BAND_GSM_850,
-	OFONO_RADIO_BAND_GSM_900P,
-	OFONO_RADIO_BAND_GSM_900E,
-	OFONO_RADIO_BAND_GSM_1800,
-	OFONO_RADIO_BAND_GSM_1900,
-};
-
-enum ofono_radio_band_umts {
-	OFONO_RADIO_BAND_UMTS_ANY,
-	OFONO_RADIO_BAND_UMTS_850,
-	OFONO_RADIO_BAND_UMTS_900,
-	OFONO_RADIO_BAND_UMTS_1700AWS,
-	OFONO_RADIO_BAND_UMTS_1900,
-	OFONO_RADIO_BAND_UMTS_2100,
-};
-
-struct ofono_radio_settings;
-
-typedef void (*ofono_radio_settings_rat_mode_set_cb_t)(
-						const struct ofono_error *error,
-						void *data);
-typedef void (*ofono_radio_settings_rat_mode_query_cb_t)(
-					const struct ofono_error *error,
-					enum ofono_radio_access_mode mode,
-					void *data);
-
-typedef void (*ofono_radio_settings_band_set_cb_t)(
-						const struct ofono_error *error,
-						void *data);
-typedef void (*ofono_radio_settings_band_query_cb_t)(
-					const struct ofono_error *error,
-					enum ofono_radio_band_gsm band_gsm,
-					enum ofono_radio_band_umts band_umts,
-					void *data);
-
-typedef void (*ofono_radio_settings_fast_dormancy_set_cb_t)(
-						const struct ofono_error *error,
-						void *data);
-typedef void (*ofono_radio_settings_fast_dormancy_query_cb_t)(
-						const struct ofono_error *error,
-						ofono_bool_t enable,
-						void *data);
-
-typedef void (*ofono_radio_settings_available_rats_query_cb_t)(
-						const struct ofono_error *error,
-						unsigned int available_rats,
-						void *data);
-
-struct ofono_radio_settings_driver {
-	const char *name;
-	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_radio_settings *rs);
-	void (*query_rat_mode)(struct ofono_radio_settings *rs,
-				ofono_radio_settings_rat_mode_query_cb_t cb,
-				void *data);
-	void (*set_rat_mode)(struct ofono_radio_settings *rs,
-				enum ofono_radio_access_mode mode,
-				ofono_radio_settings_rat_mode_set_cb_t cb,
-				void *data);
-	void (*query_band)(struct ofono_radio_settings *rs,
-				ofono_radio_settings_band_query_cb_t cb,
-				void *data);
-	void (*set_band)(struct ofono_radio_settings *rs,
-				enum ofono_radio_band_gsm band_gsm,
-				enum ofono_radio_band_umts band_umts,
-				ofono_radio_settings_band_set_cb_t cb,
-				void *data);
-	void (*query_fast_dormancy)(struct ofono_radio_settings *rs,
-			ofono_radio_settings_fast_dormancy_query_cb_t cb,
-			void *data);
-	void (*set_fast_dormancy)(struct ofono_radio_settings *rs,
-				ofono_bool_t enable,
-				ofono_radio_settings_fast_dormancy_set_cb_t,
-				void *data);
-	void (*query_available_rats)(struct ofono_radio_settings *rs,
-			ofono_radio_settings_available_rats_query_cb_t cb,
-			void *data);
-};
-
-int ofono_radio_settings_driver_register(
-				const struct ofono_radio_settings_driver *d);
-void ofono_radio_settings_driver_unregister(
-				const struct ofono_radio_settings_driver *d);
-
-struct ofono_radio_settings *ofono_radio_settings_create(
-						struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_radio_settings_register(struct ofono_radio_settings *rs);
-void ofono_radio_settings_remove(struct ofono_radio_settings *rs);
-
-void ofono_radio_settings_set_data(struct ofono_radio_settings *rs, void *=
data);
-void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_RADIO_SETTINGS_H */
diff --git a/include/sim-auth.h b/include/sim-auth.h
deleted file mode 100644
index 0a62adc..0000000
--- a/include/sim-auth.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_SIM_AUTH_H
-#define __OFONO_SIM_AUTH_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_sim_auth;
-
-typedef void (*ofono_sim_list_apps_cb_t)(const struct ofono_error *error,
-					const unsigned char *dataobj,
-					int len, void *data);
-
-struct ofono_sim_auth_driver {
-	const char *name;
-	int (*probe)(struct ofono_sim_auth *sa, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_sim_auth *sa);
-
-	void (*list_apps)(struct ofono_sim_auth *sa,
-				ofono_sim_list_apps_cb_t cb, void *data);
-};
-
-int ofono_sim_auth_driver_register(const struct ofono_sim_auth_driver *d);
-void ofono_sim_auth_driver_unregister(const struct ofono_sim_auth_driver *=
d);
-
-struct ofono_sim_auth *ofono_sim_auth_create(struct ofono_modem *modem,
-						unsigned int vendor,
-						const char *driver, void *data);
-
-void ofono_sim_auth_register(struct ofono_sim_auth *sa);
-void ofono_sim_auth_remove(struct ofono_sim_auth *sa);
-
-void ofono_sim_auth_set_data(struct ofono_sim_auth *sa, void *data);
-void *ofono_sim_auth_get_data(struct ofono_sim_auth *sa);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_SIM_AUTH_H */
diff --git a/include/sim.h b/include/sim.h
deleted file mode 100644
index ed850f9..0000000
--- a/include/sim.h
+++ /dev/null
@@ -1,255 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_SIM_H
-#define __OFONO_SIM_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_sim;
-struct ofono_sim_context;
-
-/* 51.011 Section 9.3 */
-enum ofono_sim_file_structure {
-	OFONO_SIM_FILE_STRUCTURE_TRANSPARENT =3D 0,
-	OFONO_SIM_FILE_STRUCTURE_FIXED =3D 1,
-	OFONO_SIM_FILE_STRUCTURE_CYCLIC =3D 3
-};
-
-enum ofono_sim_password_type {
-	OFONO_SIM_PASSWORD_NONE =3D 0,
-	OFONO_SIM_PASSWORD_SIM_PIN,
-	OFONO_SIM_PASSWORD_PHSIM_PIN,
-	OFONO_SIM_PASSWORD_PHFSIM_PIN,
-	OFONO_SIM_PASSWORD_SIM_PIN2,
-	OFONO_SIM_PASSWORD_PHNET_PIN,
-	OFONO_SIM_PASSWORD_PHNETSUB_PIN,
-	OFONO_SIM_PASSWORD_PHSP_PIN,
-	OFONO_SIM_PASSWORD_PHCORP_PIN,
-	OFONO_SIM_PASSWORD_SIM_PUK,
-	OFONO_SIM_PASSWORD_PHFSIM_PUK,
-	OFONO_SIM_PASSWORD_SIM_PUK2,
-	OFONO_SIM_PASSWORD_PHNET_PUK,
-	OFONO_SIM_PASSWORD_PHNETSUB_PUK,
-	OFONO_SIM_PASSWORD_PHSP_PUK,
-	OFONO_SIM_PASSWORD_PHCORP_PUK,
-	OFONO_SIM_PASSWORD_INVALID,
-};
-
-enum ofono_sim_phase {
-	OFONO_SIM_PHASE_1G,
-	OFONO_SIM_PHASE_2G,
-	OFONO_SIM_PHASE_2G_PLUS,
-	OFONO_SIM_PHASE_3G,
-	OFONO_SIM_PHASE_UNKNOWN,
-};
-
-enum ofono_sim_cphs_phase {
-	OFONO_SIM_CPHS_PHASE_NONE,
-	OFONO_SIM_CPHS_PHASE_1G,
-	OFONO_SIM_CPHS_PHASE_2G,
-};
-
-enum ofono_sim_state {
-	OFONO_SIM_STATE_NOT_PRESENT,
-	OFONO_SIM_STATE_INSERTED,
-	OFONO_SIM_STATE_LOCKED_OUT,
-	OFONO_SIM_STATE_READY,
-	OFONO_SIM_STATE_RESETTING,
-};
-
-typedef void (*ofono_sim_file_info_cb_t)(const struct ofono_error *error,
-					int filelength,
-					enum ofono_sim_file_structure structure,
-					int recordlength,
-					const unsigned char access[3],
-					unsigned char file_status,
-					void *data);
-
-typedef void (*ofono_sim_read_cb_t)(const struct ofono_error *error,
-					const unsigned char *sdata, int length,
-					void *data);
-
-typedef void (*ofono_sim_write_cb_t)(const struct ofono_error *error,
-					void *data);
-
-typedef void (*ofono_sim_imsi_cb_t)(const struct ofono_error *error,
-					const char *imsi, void *data);
-
-typedef void (*ofono_sim_state_event_cb_t)(enum ofono_sim_state new_state,
-					void *data);
-
-typedef void (*ofono_sim_file_read_cb_t)(int ok, int total_length, int rec=
ord,
-					const unsigned char *data,
-					int record_length, void *userdata);
-typedef void (*ofono_sim_file_changed_cb_t)(int id, void *userdata);
-
-typedef void (*ofono_sim_file_write_cb_t)(int ok, void *userdata);
-
-typedef void (*ofono_sim_passwd_cb_t)(const struct ofono_error *error,
-					enum ofono_sim_password_type type,
-					void *data);
-
-typedef void (*ofono_sim_pin_retries_cb_t)(const struct ofono_error *error,
-			int retries[OFONO_SIM_PASSWORD_INVALID], void *data);
-
-typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error *error,
-					void *data);
-
-typedef void (*ofono_sim_locked_cb_t)(const struct ofono_error *error,
-					int locked, void *data);
-
-struct ofono_sim_driver {
-	const char *name;
-	int (*probe)(struct ofono_sim *sim, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_sim *sim);
-	void (*read_file_info)(struct ofono_sim *sim, int fileid,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_file_info_cb_t cb, void *data);
-	void (*read_file_transparent)(struct ofono_sim *sim, int fileid,
-			int start, int length,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_read_cb_t cb, void *data);
-	void (*read_file_linear)(struct ofono_sim *sim, int fileid,
-			int record, int length,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_read_cb_t cb, void *data);
-	void (*read_file_cyclic)(struct ofono_sim *sim, int fileid,
-			int record, int length,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_read_cb_t cb, void *data);
-	void (*write_file_transparent)(struct ofono_sim *sim, int fileid,
-			int start, int length, const unsigned char *value,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_write_cb_t cb, void *data);
-	void (*write_file_linear)(struct ofono_sim *sim, int fileid,
-			int record, int length, const unsigned char *value,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_write_cb_t cb, void *data);
-	void (*write_file_cyclic)(struct ofono_sim *sim, int fileid,
-			int length, const unsigned char *value,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_write_cb_t cb, void *data);
-	void (*read_imsi)(struct ofono_sim *sim,
-			ofono_sim_imsi_cb_t cb, void *data);
-	void (*query_passwd_state)(struct ofono_sim *sim,
-			ofono_sim_passwd_cb_t cb, void *data);
-	void (*send_passwd)(struct ofono_sim *sim, const char *passwd,
-			ofono_sim_lock_unlock_cb_t cb, void *data);
-	void (*query_pin_retries)(struct ofono_sim *sim,
-				ofono_sim_pin_retries_cb_t cb, void *data);
-	void (*reset_passwd)(struct ofono_sim *sim, const char *puk,
-			const char *passwd,
-			ofono_sim_lock_unlock_cb_t cb, void *data);
-	void (*change_passwd)(struct ofono_sim *sim,
-			enum ofono_sim_password_type type,
-			const char *old_passwd, const char *new_passwd,
-			ofono_sim_lock_unlock_cb_t cb, void *data);
-	void (*lock)(struct ofono_sim *sim, enum ofono_sim_password_type type,
-			int enable, const char *passwd,
-			ofono_sim_lock_unlock_cb_t cb, void *data);
-	void (*query_locked)(struct ofono_sim *sim,
-			enum ofono_sim_password_type type,
-			ofono_sim_locked_cb_t cb, void *data);
-};
-
-int ofono_sim_driver_register(const struct ofono_sim_driver *d);
-void ofono_sim_driver_unregister(const struct ofono_sim_driver *d);
-
-struct ofono_sim *ofono_sim_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_sim_register(struct ofono_sim *sim);
-void ofono_sim_remove(struct ofono_sim *sim);
-
-void ofono_sim_set_data(struct ofono_sim *sim, void *data);
-void *ofono_sim_get_data(struct ofono_sim *sim);
-
-const char *ofono_sim_get_imsi(struct ofono_sim *sim);
-const char *ofono_sim_get_mcc(struct ofono_sim *sim);
-const char *ofono_sim_get_mnc(struct ofono_sim *sim);
-const char *ofono_sim_get_spn(struct ofono_sim *sim);
-enum ofono_sim_phase ofono_sim_get_phase(struct ofono_sim *sim);
-
-enum ofono_sim_cphs_phase ofono_sim_get_cphs_phase(struct ofono_sim *sim);
-const unsigned char *ofono_sim_get_cphs_service_table(struct ofono_sim *si=
m);
-
-enum ofono_sim_password_type ofono_sim_get_password_type(struct ofono_sim =
*sim);
-
-unsigned int ofono_sim_add_state_watch(struct ofono_sim *sim,
-					ofono_sim_state_event_cb_t cb,
-					void *data, ofono_destroy_func destroy);
-
-void ofono_sim_remove_state_watch(struct ofono_sim *sim, unsigned int id);
-
-enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim);
-
-typedef void (*ofono_sim_spn_cb_t)(const char *spn, const char *dc, void *=
data);
-
-ofono_bool_t ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *=
id,
-					ofono_sim_spn_cb_t cb, void *data,
-					ofono_destroy_func destroy);
-
-ofono_bool_t ofono_sim_remove_spn_watch(struct ofono_sim *sim, unsigned in=
t *id);
-
-void ofono_sim_inserted_notify(struct ofono_sim *sim, ofono_bool_t inserte=
d);
-
-struct ofono_sim_context *ofono_sim_context_create(struct ofono_sim *sim);
-void ofono_sim_context_free(struct ofono_sim_context *context);
-
-/* This will queue an operation to read all available records with id from=
 the
- * SIM.  Callback cb will be called every time a record has been read, or =
once
- * if an error has occurred.  For transparent files, the callback will only
- * be called once.
- *
- * Returns 0 if the request could be queued, -1 otherwise.
- */
-int ofono_sim_read(struct ofono_sim_context *context, int id,
-			enum ofono_sim_file_structure expected,
-			ofono_sim_file_read_cb_t cb, void *data);
-
-int ofono_sim_write(struct ofono_sim_context *context, int id,
-			ofono_sim_file_write_cb_t cb,
-			enum ofono_sim_file_structure structure, int record,
-			const unsigned char *data, int length, void *userdata);
-
-int ofono_sim_read_bytes(struct ofono_sim_context *context, int id,
-			unsigned short offset, unsigned short num_bytes,
-			const unsigned char *path, unsigned int path_len,
-			ofono_sim_file_read_cb_t cb, void *data);
-
-unsigned int ofono_sim_add_file_watch(struct ofono_sim_context *context,
-					int id, ofono_sim_file_changed_cb_t cb,
-					void *userdata,
-					ofono_destroy_func destroy);
-void ofono_sim_remove_file_watch(struct ofono_sim_context *context,
-					unsigned int id);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_SIM_H */
diff --git a/include/siri.h b/include/siri.h
deleted file mode 100644
index 7288bca..0000000
--- a/include/siri.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2013  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_SIRI_H
-#define __OFONO_SIRI_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_siri;
-
-typedef void (*ofono_siri_cb_t)(const struct ofono_error *error,
-					struct ofono_siri *siri);
-
-struct ofono_siri_driver {
-	const char *name;
-	int (*probe)(struct ofono_siri *siri, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_siri *siri);
-	void (*set_eyes_free_mode) (struct ofono_siri *siri, ofono_siri_cb_t cb,
-					unsigned int val);
-};
-
-void ofono_siri_set_status(struct ofono_siri *siri, int value);
-
-int ofono_siri_driver_register(const struct ofono_siri_driver *driver);
-void ofono_siri_driver_unregister(const struct ofono_siri_driver *driver);
-
-struct ofono_siri *ofono_siri_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_siri_register(struct ofono_siri *siri);
-void ofono_siri_remove(struct ofono_siri *siri);
-
-void ofono_siri_set_data(struct ofono_siri *siri, void *data);
-void *ofono_siri_get_data(struct ofono_siri *siri);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_SIRI_H */
diff --git a/include/sms.h b/include/sms.h
deleted file mode 100644
index e926056..0000000
--- a/include/sms.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_SMS_H
-#define __OFONO_SMS_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_sms;
-
-typedef void (*ofono_sms_sca_query_cb_t)(const struct ofono_error *error,
-					const struct ofono_phone_number *ph,
-					void *data);
-typedef void (*ofono_sms_submit_cb_t)(const struct ofono_error *error, int=
 mr,
-					void *data);
-typedef void (*ofono_sms_sca_set_cb_t)(const struct ofono_error *error,
-					void *data);
-typedef void (*ofono_sms_bearer_set_cb_t)(const struct ofono_error *error,
-						void *data);
-typedef void (*ofono_sms_bearer_query_cb_t)(const struct ofono_error *erro=
r,
-						int bearer, void *data);
-
-struct ofono_sms_driver {
-	const char *name;
-	int (*probe)(struct ofono_sms *sms, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_sms *sms);
-	void (*sca_query)(struct ofono_sms *sms, ofono_sms_sca_query_cb_t cb,
-				void *data);
-	void (*sca_set)(struct ofono_sms *sms,
-			const struct ofono_phone_number *sca,
-			ofono_sms_sca_set_cb_t cb, void *data);
-	void (*submit)(struct ofono_sms *sms, const unsigned char *pdu,
-			int pdu_len, int tpdu_len, int mms,
-			ofono_sms_submit_cb_t cb, void *data);
-	void (*bearer_query)(struct ofono_sms *sms,
-				ofono_sms_bearer_query_cb_t, void *data);
-	void (*bearer_set)(struct ofono_sms *sms, int bearer,
-				ofono_sms_bearer_set_cb_t, void *data);
-};
-
-void ofono_sms_deliver_notify(struct ofono_sms *sms, const unsigned char *=
pdu,
-				int len, int tpdu_len);
-void ofono_sms_status_notify(struct ofono_sms *sms, const unsigned char *p=
du,
-				int len, int tpdu_len);
-
-int ofono_sms_driver_register(const struct ofono_sms_driver *d);
-void ofono_sms_driver_unregister(const struct ofono_sms_driver *d);
-
-struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_sms_register(struct ofono_sms *sms);
-void ofono_sms_remove(struct ofono_sms *sms);
-
-void ofono_sms_set_data(struct ofono_sms *sms, void *data);
-void *ofono_sms_get_data(struct ofono_sms *sms);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_SMS_H */
diff --git a/include/stk.h b/include/stk.h
deleted file mode 100644
index 6182804..0000000
--- a/include/stk.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_STK_H
-#define __OFONO_STK_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_stk;
-
-typedef void (*ofono_stk_envelope_cb_t)(const struct ofono_error *error,
-					const unsigned char *rdata,
-					int length, void *data);
-
-typedef void (*ofono_stk_generic_cb_t)(const struct ofono_error *error,
-					void *data);
-
-struct ofono_stk_driver {
-	const char *name;
-	int (*probe)(struct ofono_stk *stk, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_stk *stk);
-	void (*envelope)(struct ofono_stk *stk,
-				int length, const unsigned char *command,
-				ofono_stk_envelope_cb_t cb, void *data);
-	void (*terminal_response)(struct ofono_stk *stk,
-					int length, const unsigned char *resp,
-					ofono_stk_generic_cb_t cb, void *data);
-	void (*user_confirmation)(struct ofono_stk *stk, ofono_bool_t confirm);
-};
-
-int ofono_stk_driver_register(const struct ofono_stk_driver *d);
-void ofono_stk_driver_unregister(const struct ofono_stk_driver *d);
-
-struct ofono_stk *ofono_stk_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_stk_register(struct ofono_stk *stk);
-void ofono_stk_remove(struct ofono_stk *stk);
-
-void ofono_stk_set_data(struct ofono_stk *stk, void *data);
-void *ofono_stk_get_data(struct ofono_stk *stk);
-
-void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
-					int length, const unsigned char *pdu);
-
-void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk);
-
-void ofono_stk_proactive_command_handled_notify(struct ofono_stk *stk,
-						int length,
-						const unsigned char *pdu);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_STK_H */
diff --git a/include/types.h b/include/types.h
deleted file mode 100644
index 9a7dfd9..0000000
--- a/include/types.h
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_TYPES_H
-#define __OFONO_TYPES_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#ifndef	FALSE
-#define	FALSE	(0)
-#endif
-
-#ifndef	TRUE
-#define	TRUE	(!FALSE)
-#endif
-
-typedef int		ofono_bool_t;
-
-/* MCC is always three digits. MNC is either two or three digits */
-#define OFONO_MAX_MCC_LENGTH 3
-#define OFONO_MAX_MNC_LENGTH 3
-
-typedef void (*ofono_destroy_func)(void *data);
-
-/* 27.007 Section 6.2 */
-enum ofono_clir_option {
-	OFONO_CLIR_OPTION_DEFAULT =3D 0,
-	OFONO_CLIR_OPTION_INVOCATION,
-	OFONO_CLIR_OPTION_SUPPRESSION,
-};
-
-enum ofono_error_type {
-	OFONO_ERROR_TYPE_NO_ERROR =3D 0,
-	OFONO_ERROR_TYPE_CME,
-	OFONO_ERROR_TYPE_CMS,
-	OFONO_ERROR_TYPE_CEER,
-	OFONO_ERROR_TYPE_SIM,
-	OFONO_ERROR_TYPE_FAILURE,
-};
-
-enum ofono_disconnect_reason {
-	OFONO_DISCONNECT_REASON_UNKNOWN =3D 0,
-	OFONO_DISCONNECT_REASON_LOCAL_HANGUP,
-	OFONO_DISCONNECT_REASON_REMOTE_HANGUP,
-	OFONO_DISCONNECT_REASON_ERROR,
-};
-
-struct ofono_error {
-	enum ofono_error_type type;
-	int error;
-};
-
-#define OFONO_MAX_PHONE_NUMBER_LENGTH 80
-#define OFONO_MAX_CALLER_NAME_LENGTH 80
-
-struct ofono_phone_number {
-	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
-	int type;
-};
-
-/* Length of NUM_FIELDS in 3GPP2 C.S0005-E v2.0 */
-#define OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH 256
-
-struct ofono_cdma_phone_number {
-	/* char maps to max size of CHARi (8 bit) in 3GPP2 C.S0005-E v2.0 */
-	char number[OFONO_CDMA_MAX_PHONE_NUMBER_LENGTH];
-};
-
-struct ofono_call {
-	unsigned int id;
-	int type;
-	int direction;
-	int status;
-	struct ofono_phone_number phone_number;
-	struct ofono_phone_number called_number;
-	char name[OFONO_MAX_CALLER_NAME_LENGTH + 1];
-	int clip_validity;
-	int cnap_validity;
-};
-
-struct ofono_network_time {
-	int sec;	/* Seconds [0..59], -1 if unavailable */
-	int min;	/* Minutes [0..59], -1 if unavailable */
-	int hour;	/* Hours [0..23], -1 if unavailable */
-	int mday;	/* Day of month [1..31], -1 if unavailable */
-	int mon;	/* Month [1..12], -1 if unavailable */
-	int year;	/* Current year, -1 if unavailable */
-	int dst;	/* Current adjustment, in hours */
-	int utcoff;	/* Offset from UTC in seconds */
-};
-
-#define OFONO_SHA1_UUID_LEN 20
-
-struct ofono_uuid {
-	unsigned char uuid[OFONO_SHA1_UUID_LEN];
-};
-
-const char *ofono_uuid_to_str(const struct ofono_uuid *uuid);
-void ofono_call_init(struct ofono_call *call);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_TYPES_H */
diff --git a/include/ussd.h b/include/ussd.h
deleted file mode 100644
index ac463e7..0000000
--- a/include/ussd.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_USSD_H
-#define __OFONO_USSD_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-/* 3GPP TS 27.007 section 7.15, values for <m> */
-enum ofono_ussd_status {
-	OFONO_USSD_STATUS_NOTIFY =3D 0,
-	OFONO_USSD_STATUS_ACTION_REQUIRED =3D 1,
-	OFONO_USSD_STATUS_TERMINATED =3D 2,
-	OFONO_USSD_STATUS_LOCAL_CLIENT_RESPONDED =3D 3,
-	OFONO_USSD_STATUS_NOT_SUPPORTED =3D 4,
-	OFONO_USSD_STATUS_TIMED_OUT =3D 5,
-};
-
-struct ofono_ussd;
-
-typedef void (*ofono_ussd_cb_t)(const struct ofono_error *error, void *dat=
a);
-
-struct ofono_ussd_driver {
-	const char *name;
-	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
-	void (*remove)(struct ofono_ussd *ussd);
-	void (*request)(struct ofono_ussd *ussd, int dcs,
-			const unsigned char *pdu, int len,
-			ofono_ussd_cb_t, void *data);
-	void (*cancel)(struct ofono_ussd *ussd,
-				ofono_ussd_cb_t cb, void *data);
-};
-
-void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
-			const unsigned char *data, int data_len);
-
-int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
-void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
-
-struct ofono_ussd *ofono_ussd_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_ussd_register(struct ofono_ussd *ussd);
-void ofono_ussd_remove(struct ofono_ussd *ussd);
-
-void ofono_ussd_set_data(struct ofono_ussd *ussd, void *data);
-void *ofono_ussd_get_data(struct ofono_ussd *ussd);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_USSD_H */
diff --git a/include/version.h.in b/include/version.h.in
deleted file mode 100644
index 396b98a..0000000
--- a/include/version.h.in
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- *
- *  oFono - Open Telephony stack for Linux
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_VERSION_H
-#define __OFONO_VERSION_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#define OFONO_VERSION	"@VERSION@"
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_VERSION_H */
diff --git a/include/voicecall.h b/include/voicecall.h
deleted file mode 100644
index 4d0b388..0000000
--- a/include/voicecall.h
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifndef __OFONO_VOICECALL_H
-#define __OFONO_VOICECALL_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <ofono/types.h>
-
-struct ofono_voicecall;
-
-typedef void (*ofono_voicecall_cb_t)(const struct ofono_error *error,
-					void *data);
-
-/* Voice call related functionality, including ATD, ATA, +CHLD, CTFR, CLCC
- * and VTS.
- *
- * It is up to the plugin to implement polling of CLCC if the modem does
- * not support vendor extensions for call progress indication.
- */
-struct ofono_voicecall_driver {
-	const char *name;
-	int (*probe)(struct ofono_voicecall *vc, unsigned int vendor,
-			void *data);
-	void (*remove)(struct ofono_voicecall *vc);
-
-	/* According to 22.030 the dial is expected to do the following:
-	 * - If an there is an existing active call(s), and the dial is
-	 *   successful, the active calls are automatically put on hold.
-	 *   Driver must take special care to put the call on hold before
-	 *   returning from atd call.
-	 *
-	 * - The dial has no affect on the state of the waiting call,
-	 *   if the hardware does not support this, then it is better
-	 *   to return an error here.  No special handling of the
-	 *   waiting call is performed by the core
-	 */
-	void (*dial)(struct ofono_voicecall *vc,
-			const struct ofono_phone_number *number,
-			enum ofono_clir_option clir, ofono_voicecall_cb_t cb,
-			void *data);
-	/* Answers an incoming call, this usually corresponds to ATA */
-	void (*answer)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-
-	/* Hangs up active, dialing, alerting or incoming calls */
-	void (*hangup_active)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/* Hangs up all calls except waiting calls */
-	void (*hangup_all)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Holds all active calls and answers waiting call.  If there is
-	 * no waiting calls, retrieves held call.  This usually
-	 * corresponds to +CHLD=3D2
-	 */
-	void (*hold_all_active)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/* Releases all held calls, this usually corresponds to +CHLD=3D0*/
-	void (*release_all_held)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Sets the UDUB condition on a waiting call.  This usually
-	 * corresponds to +CHLD=3D0
-	 */
-	void (*set_udub)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Releases all active calls and accepts a possible waiting call.
-	 * This usually corresponds to +CHLD=3D1
-	 */
-	void (*release_all_active)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Releases a specific call given by id.  This usually corresponds to
-	 * +CHLD=3D1X.  In 3GPP this command is only guaranteed to affect active
-	 * calls.  Plugins are encouraged to implement this using vendor
-	 * commands that can also affect held calls
-	 */
-	void (*release_specific)(struct ofono_voicecall *vc, int id,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Breaks out a party given by id from a multiparty call.  This
-	 * usually corresponds to +CHLD=3D2X
-	 */
-	void (*private_chat)(struct ofono_voicecall *vc, int id,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Joins held and active calls together into a multiparty call.  This
-	 * usually corresponds to +CHLD=3D3
-	 */
-	void (*create_multiparty)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Connects two calls together and disconnects from both calls.  This
-	 * usually corresponds to +CHLD=3D4
-	 */
-	void (*transfer)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * Deflects an incoming or waiting call to a given number.  This
-	 * usually corresponds to +CTFR
-	 */
-	void (*deflect)(struct ofono_voicecall *vc,
-			const struct ofono_phone_number *ph,
-			ofono_voicecall_cb_t cb, void *data);
-	/*
-	 * This is equivalent to +CHLD=3D2 but does not affect a possible
-	 * waiting call.
-	 */
-	void (*swap_without_accept)(struct ofono_voicecall *vc,
-			ofono_voicecall_cb_t cb, void *data);
-	void (*send_tones)(struct ofono_voicecall *vc, const char *tones,
-			ofono_voicecall_cb_t cb, void *data);
-};
-
-void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
-					char **nw_en_list);
-
-void ofono_voicecall_notify(struct ofono_voicecall *vc,
-				const struct ofono_call *call);
-void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
-				enum ofono_disconnect_reason reason,
-				const struct ofono_error *error);
-
-/*
- * For those protocols where MPTY creation happens outside of oFono's cont=
rol,
- * e.g. Bluetooth Handsfree, set the hint of the MPTY call list by passing
- * in a bitmask of ids participating in the MPTY call
- */
-void ofono_voicecall_mpty_hint(struct ofono_voicecall *vc, unsigned int id=
s);
-
-int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d=
);
-void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d);
-
-struct ofono_voicecall *ofono_voicecall_create(struct ofono_modem *modem,
-					unsigned int vendor,
-					const char *driver, void *data);
-
-void ofono_voicecall_register(struct ofono_voicecall *vc);
-void ofono_voicecall_remove(struct ofono_voicecall *vc);
-
-void ofono_voicecall_set_data(struct ofono_voicecall *vc, void *data);
-void *ofono_voicecall_get_data(struct ofono_voicecall *vc);
-int ofono_voicecall_get_next_callid(struct ofono_voicecall *vc);
-
-void ofono_voicecall_ssn_mo_notify(struct ofono_voicecall *vc, unsigned in=
t id,
-					int code, int index);
-void ofono_voicecall_ssn_mt_notify(struct ofono_voicecall *vc, unsigned in=
t id,
-					int code, int index,
-					const struct ofono_phone_number *ph);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* __OFONO_VOICECALL_H */
-- =

2.1.4


--===============0843940419920086035==--

