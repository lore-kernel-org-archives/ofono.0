Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DC76C87
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649757; cv=none; b=YERuR2AuIKtQxs+4yegzo0UOcOtkb1T5/dmxz8ml8yqVMA8tl9cNcxgswPUqJUrFbNEjL7PZj02j4i3K7L62TDak+JU2laj9PVscq3IpBSs6VQOhPG5Os19YkJIE7adJ1prPiOBxCebCkNk7EX0dXWK16L2jcmum/If3pTO0oWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649757; c=relaxed/simple;
	bh=W7qdf5MvGmr4jAxM51WnyMfVC+Xkts0o9ZVQfb3NIOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvFfkTLw0WThL4Gv2h1di4vKfwdWrBjgVsrNjrQDaFPJpUBAWVbz7uGs6ABAGvl/mAfO8FHAfnjov9nOiHqjIVurU4ZOFyMeRY0uMKLI8u1Ly5ybdbnu17Q0Ys/ALfcLpEMhRfnwlT1B87uy3qCFHEqaS5AEUWswnebuAHzKYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDlbo3g7; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDlbo3g7"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3514750b6e.1
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649754; x=1707254554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/asj+PQDU2JvGzvRCInLFoPH7wGSo3ElHlbin6l4ShY=;
        b=SDlbo3g7eQuZxRLEWRSW3rD6I9AWTFFyh2AcaVthb43LWHe03lPpYWLh6foocMaVbO
         5iaYULNIBYuDrm8tb8oDpvcYmmLIqIdNo9pOPK3eKHPTg0Q985fkkG+W+3CzIhjjNtuu
         hKHNecThjFiCf6Js+qcy3+yaKolQ5ZEViOCvHMTyrjPhvrLYZ5YEyU6yRnMdU7Q3tU0P
         29qlBCe2zseAYf6ASEuEAAWNUbkC0L0swa/WuCvjEjEUy3h2mxNvAbFS0l6GLDxWa+VP
         +0UWKGH3adyA2JAmNuQr1Vc8kxgP95KciQkV3aJyj8PuYBxuvQ5A15LSgKWqijmw9wyb
         8KoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649754; x=1707254554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/asj+PQDU2JvGzvRCInLFoPH7wGSo3ElHlbin6l4ShY=;
        b=T2l37qwJvFMkDxw/ktFcCEnR802VrP+sZVu1zGK406rNsiNiNBGp8oeN0Xqx2wabu+
         Gu1oN4BK2p+pZcNs6c8F//7ajfKTRKcA9AxSUuQGfsco/HjVEYm5lwswEyd7k8WZdoCi
         eFNwvA+Weh9uSMS7o5EYiNNVmNQQrHM3//5/ITC622j1lwpYRaUDQAkuFu60LaVbCXNv
         yDyTT0/xi7LDcGJmrNoXIsz29NAEDjqTBYCZAGQHMNmAc9cKvDytQtgab8gVvRqTo8zn
         hn2RB+3yaCG7oZn+K8ImRrfhRDnMgzrA95r/Jg6ybMwy9DRtuqk/T8SLn82eTn+yz5s2
         f6mA==
X-Gm-Message-State: AOJu0Yy3pr5+lxBqqDDDKwv9mGk195eXXVXhZyGf1hjBEan4bml/E1Cq
	LaguA1XWtZEYVykMjh6UgfwpHiYa0yJcuZO46kdFAT/nDSXZU7zXkSxoy2jP
X-Google-Smtp-Source: AGHT+IE7EpExYg5cgcp36PzgIt7Qi85NiiNCtfho3ZUes0XTQWxAdwRqW1fJMM8396XefJSZdqtHwQ==
X-Received: by 2002:a05:6870:4992:b0:214:b399:4d2c with SMTP id ho18-20020a056870499200b00214b3994d2cmr539418oab.20.1706649753652;
        Tue, 30 Jan 2024 13:22:33 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:33 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 14/17] lte: Refactor lte settings management
Date: Tue, 30 Jan 2024 15:21:19 -0600
Message-ID: <20240130212137.814082-14-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support LTE Default bearer provisioning, refactor how
the settings are loaded and saved from disk:
  1. Instead of storing the imsi in a malloced variable, obtain it directly
     from the sim atom.
  2. Do not try to save the settings when the lte atom is removed.  If
     the settings have not been provisioned or modified by the user,
     writing the settings file will have no effect, and makes it harder
     to detect whether provisioning should be attempted in the future.
  3. Use ell for the nicer to use _auto_ variables, access to the
     L_WARN macro.
  4. Use l_settings instead of g_key_file.  The underlying file format is
     identical.
  5. Convert g_strlcpy to l_strlcpy
  6. Convert g_str_equal to l_streq0
  7. Convert strdup/g_free to l_strdup and l_free
---
 src/lte.c | 169 +++++++++++++++++++++++++++---------------------------
 1 file changed, 85 insertions(+), 84 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 7280b2913a8d..d412e15d90f9 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -32,6 +32,8 @@
 
 #include <glib.h>
 #include <gdbus.h>
+#include <ell/ell.h>
+#include <ell/useful.h>
 
 #include "ofono.h"
 
@@ -50,59 +52,50 @@ struct ofono_lte {
 	const struct ofono_lte_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
-	char *imsi;
-	GKeyFile *settings;
+	struct l_settings *settings;
 	DBusMessage *pending;
 	struct ofono_lte_default_attach_info pending_info;
 	struct ofono_lte_default_attach_info info;
 };
 
-static void lte_load_settings(struct ofono_lte *lte)
+static int lte_load_settings(struct ofono_lte *lte)
 {
-	char *apn;
-	char *proto_str;
-	char *auth_method_str;
-	char *username;
-	char *password;
-
-	if (lte->imsi == NULL)
-		return;
-
-	lte->settings = storage_open(lte->imsi, SETTINGS_STORE);
-
-	if (lte->settings == NULL) {
-		ofono_error("LTE: Can't open settings file, "
-				"changes won't be persistent");
-		return;
-	}
-
-	apn = g_key_file_get_string(lte->settings, SETTINGS_GROUP,
-				LTE_APN, NULL);
-	proto_str = g_key_file_get_string(lte->settings, SETTINGS_GROUP,
-				LTE_PROTO, NULL);
-	auth_method_str = g_key_file_get_string(lte->settings, SETTINGS_GROUP,
-				LTE_AUTH_METHOD, NULL);
-	username = g_key_file_get_string(lte->settings, SETTINGS_GROUP,
-				LTE_USERNAME, NULL);
-	password = g_key_file_get_string(lte->settings, SETTINGS_GROUP,
-				LTE_PASSWORD, NULL);
-	if (apn && is_valid_apn(apn))
-		strcpy(lte->info.apn, apn);
+	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
+	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	const char *imsi = ofono_sim_get_imsi(sim);
+	_auto_(l_free) char *path = NULL;
+	_auto_(l_free) char *apn = NULL;
+	const char *proto_str;
+	const char *auth_method_str;
+	_auto_(l_free) char *username = NULL;
+	_auto_(l_free) char *password = NULL;
+
+	if (L_WARN_ON(!sim || !imsi))
+		return -ENOKEY;
+
+	path = storage_get_file_path(imsi, SETTINGS_STORE);
+	if (!l_settings_load_from_file(lte->settings, path))
+		return -ENOENT;
+
+	apn = l_settings_get_string(lte->settings, SETTINGS_GROUP, LTE_APN);
+	proto_str = l_settings_get_value(lte->settings, SETTINGS_GROUP,
+						LTE_PROTO);
+	auth_method_str = l_settings_get_value(lte->settings, SETTINGS_GROUP,
+						LTE_AUTH_METHOD);
+	username = l_settings_get_string(lte->settings, SETTINGS_GROUP,
+						LTE_USERNAME);
+	password = l_settings_get_string(lte->settings, SETTINGS_GROUP,
+						LTE_PASSWORD);
 
-	if (proto_str == NULL)
-		proto_str = g_strdup("ip");
+	if (!gprs_auth_method_from_string(auth_method_str,
+							&lte->info.auth_method))
+		lte->info.auth_method = OFONO_GPRS_AUTH_METHOD_NONE;
 
-	/* this must have a valid default */
 	if (!gprs_proto_from_string(proto_str, &lte->info.proto))
 		lte->info.proto = OFONO_GPRS_PROTO_IP;
 
-	if (auth_method_str == NULL)
-		auth_method_str = g_strdup("none");
-
-	/* this must have a valid default */
-	if (!gprs_auth_method_from_string(auth_method_str,
-							&lte->info.auth_method))
-		lte->info.auth_method = OFONO_GPRS_AUTH_METHOD_NONE;
+	if (apn && is_valid_apn(apn))
+		strcpy(lte->info.apn, apn);
 
 	if (username && strlen(username) <= OFONO_GPRS_MAX_USERNAME_LENGTH)
 		strcpy(lte->info.username, username);
@@ -110,11 +103,28 @@ static void lte_load_settings(struct ofono_lte *lte)
 	if (password && strlen(password) <= OFONO_GPRS_MAX_PASSWORD_LENGTH)
 		strcpy(lte->info.password, password);
 
-	g_free(apn);
-	g_free(proto_str);
-	g_free(auth_method_str);
-	g_free(username);
-	g_free(password);
+	return 0;
+}
+
+static void lte_save_settings(struct ofono_lte *lte)
+{
+	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
+	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	const char *imsi = ofono_sim_get_imsi(sim);
+	_auto_(l_free) char *path = NULL;
+	_auto_(l_free) char *data = NULL;
+	size_t len;
+
+	if (!imsi)
+		return;
+
+	data = l_settings_to_data(lte->settings, &len);
+	if (!data)
+		return;
+
+	path = storage_get_file_path(imsi, SETTINGS_STORE);
+
+	L_WARN_ON(write_file(data, len, "%s", path) < 0);
 }
 
 static DBusMessage *lte_get_properties(DBusConnection *conn,
@@ -180,12 +190,12 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
 	 */
 	dbus_message_iter_init(lte->pending, &iter);
 	dbus_message_iter_get_basic(&iter, &str);
-	key = strdup(str);
+	key = l_strdup(str);
 
 	dbus_message_iter_next(&iter);
 	dbus_message_iter_recurse(&iter, &var);
 	dbus_message_iter_get_basic(&var, &str);
-	value = strdup(str);
+	value = l_strdup(str);
 
 	memcpy(&lte->info, &lte->pending_info, sizeof(lte->info));
 
@@ -200,13 +210,13 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
 		 */
 		if (!*value)
 			/* Clear entry on empty string. */
-			g_key_file_remove_key(lte->settings,
-				SETTINGS_GROUP, key, NULL);
+			l_settings_remove_key(lte->settings,
+						SETTINGS_GROUP, key);
 		else
-			g_key_file_set_string(lte->settings,
-				SETTINGS_GROUP, key, value);
+			l_settings_set_string(lte->settings,
+						SETTINGS_GROUP, key, value);
 
-		storage_sync(lte->imsi, SETTINGS_STORE, lte->settings);
+		lte_save_settings(lte);
 	}
 
 	ofono_dbus_signal_property_changed(conn, path,
@@ -214,8 +224,8 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
 					key,
 					DBUS_TYPE_STRING, &value);
 
-	g_free(value);
-	g_free(key);
+	l_free(value);
+	l_free(key);
 }
 
 static DBusMessage *lte_set_property(DBusConnection *conn,
@@ -257,14 +267,14 @@ static DBusMessage *lte_set_property(DBusConnection *conn,
 	memcpy(&lte->pending_info, &lte->info, sizeof(lte->info));
 
 	if ((strcmp(property, LTE_APN) == 0)) {
-		if (g_str_equal(str, lte->info.apn))
+		if (l_streq0(str, lte->info.apn))
 			return dbus_message_new_method_return(msg);
 
 		/* We do care about empty value: it can be used for reset. */
 		if (is_valid_apn(str) == FALSE && str[0] != '\0')
 			return __ofono_error_invalid_format(msg);
 
-		g_strlcpy(lte->pending_info.apn, str,
+		l_strlcpy(lte->pending_info.apn, str,
 					OFONO_GPRS_MAX_APN_LENGTH + 1);
 	} else if ((strcmp(property, LTE_PROTO) == 0)) {
 		if (!gprs_proto_from_string(str, &proto))
@@ -286,19 +296,19 @@ static DBusMessage *lte_set_property(DBusConnection *conn,
 		if (strlen(str) > OFONO_GPRS_MAX_USERNAME_LENGTH)
 			return __ofono_error_invalid_format(msg);
 
-		if (g_str_equal(str, lte->info.username))
+		if (l_streq0(str, lte->info.username))
 			return dbus_message_new_method_return(msg);
 
-		g_strlcpy(lte->pending_info.username, str,
+		l_strlcpy(lte->pending_info.username, str,
 					OFONO_GPRS_MAX_USERNAME_LENGTH + 1);
 	} else if (strcmp(property, LTE_PASSWORD) == 0) {
 		if (strlen(str) > OFONO_GPRS_MAX_PASSWORD_LENGTH)
 			return __ofono_error_invalid_format(msg);
 
-		if (g_str_equal(str, lte->info.password))
+		if (l_streq0(str, lte->info.password))
 			return dbus_message_new_method_return(msg);
 
-		g_strlcpy(lte->pending_info.password, str,
+		l_strlcpy(lte->pending_info.password, str,
 					OFONO_GPRS_MAX_PASSWORD_LENGTH + 1);
 	} else
 		return __ofono_error_invalid_args(msg);
@@ -332,24 +342,19 @@ static void lte_remove(struct ofono_atom *atom)
 
 	DBG("atom: %p", atom);
 
-	if (lte == NULL)
-		return;
-
-	if (lte->settings) {
-		storage_close(lte->imsi, SETTINGS_STORE, lte->settings, TRUE);
-		lte->settings = NULL;
-	}
+	l_settings_free(lte->settings);
 
 	if (lte->driver && lte->driver->remove)
 		lte->driver->remove(lte);
 
-	g_free(lte->imsi);
-	lte->imsi = NULL;
-
 	g_free(lte);
 }
 
-OFONO_DEFINE_ATOM_CREATE(lte, OFONO_ATOM_TYPE_LTE)
+OFONO_DEFINE_ATOM_CREATE(lte, OFONO_ATOM_TYPE_LTE, {
+	atom->settings = l_settings_new();
+	atom->info.proto = OFONO_GPRS_PROTO_IP;
+	atom->info.auth_method = OFONO_GPRS_AUTH_METHOD_NONE;
+})
 
 static void lte_atom_unregister(struct ofono_atom *atom)
 {
@@ -391,29 +396,25 @@ static void lte_init_default_attach_info_cb(const struct ofono_error *error,
 
 void ofono_lte_register(struct ofono_lte *lte)
 {
-	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
-	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
-	const char *imsi = ofono_sim_get_imsi(sim);
+	/* No settings, go straight to registering the interface on D-Bus */
+	if (lte_load_settings(lte) < 0)
+		goto finish_register;
 
-	if (imsi == NULL) {
-		ofono_error("No sim atom found. It is required for registering LTE atom.");
-		return;
-	}
-
-	lte->imsi = g_strdup(imsi);
-
-	lte_load_settings(lte);
 	if (lte->driver->set_default_attach_info) {
 		lte->driver->set_default_attach_info(lte, &lte->info,
 					lte_init_default_attach_info_cb, lte);
 		return;
 	}
 
+finish_register:
 	ofono_lte_finish_register(lte);
 }
 
 void ofono_lte_remove(struct ofono_lte *lte)
 {
+	if (!lte)
+		return;
+
 	__ofono_atom_free(lte->atom);
 }
 
-- 
2.43.0

