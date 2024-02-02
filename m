Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44112C80C
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914508; cv=none; b=UWkFPy+dzYct2FWfqzj46jE+c5rl48vZaOaSRo/friGhrjpq+uFhgYzsV6NtzfFEN/b5dIIiIntRNYSaYmLpHuTdzwvWWDK2Qdfps7xwXjSDnn8B8zhREIiW6ANaLFn6Pb0mBdW5ZESjx57ZPsHvEv6Bj/Vm9uUOk7UDtch5ViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914508; c=relaxed/simple;
	bh=UxrmgW9reG25GHRAwrrWHbD2mXVxWbkskvWdg/K+RmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCXV1jYVmhhrdc4i9DPTU9GdpYZz29TitrULH+Gpuw17waV1J1eSU86/4/rrn+XjSqFkwFkFq++aBhmAvGviKOlYbMZaqwXqILyY4IJJJaTEOug7xDbAJC5wl18G7ZabRU9vRcWSf9YxWOkBsTBWj59vhrHHlxwsvSO5+MFiF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB7GUX+/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB7GUX+/"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e1214ae9d4so1373978a34.3
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914505; x=1707519305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWm384YdiQF1W0XYQWFOO4Irk31kuG+rGnT/0PYc8a4=;
        b=PB7GUX+/psGR8HJyR9Iqy5S7y3dl6IQa+WTXwmMPiog/hhfmpEfH12aSNr1ZvJaiF3
         GewZtk9yETjQ42WZFuzQBvhbRzIFEnP7B+pnUwrDlkaE2VDiUEPcYh/9VynNyKMu7ccu
         7nxdtoOgTFWsxFViK/fhsiLGd9SbWeCkItE6rpNxZyivE9+hxL1I0DdwxBF5Byy7RAO7
         SFgqHs0qIWF0DgWEm42ZK4ayAIavi0NJW8YptK/tTyBLQiIrl3lS8AldhrP8erl7yBkc
         cUWFYx3R128vfEEQjMcmv4BaGYgC3WEqpImCcBWCgTKcQtzZAIUwjN1k9eGrCSlnXs4V
         Izog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914505; x=1707519305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWm384YdiQF1W0XYQWFOO4Irk31kuG+rGnT/0PYc8a4=;
        b=ghh3+1ABmp6W37HHHUTXzcn3WIC9xtsg8zXLzev+a1/4POPc6q72UQxvt/WJ1p8ecc
         V/h+4pnLx0DV13qXxT8O+qIKDytH9yZKiVE3y/v0kKfhXAK08VQWc10G7geZPKSTfiG9
         tKz3EPqS6CXyIeT1peRgwSpDbceF/F6BQbJueHzX9wjeMcRXQxBDfXEvxEtgyd1QnEoW
         UXObRRpRHzZdTNZYNcfrcmQ6B81F2ZUZwxdmkq3QNNd7IwASEMgHu0ZN/TvoY0ADu+r6
         USw5MxYR55pYrX+Yg4RgEtUWqRduMALJ0Wxn69dBoYu5Wm+pufbJvS3YARrsp08lxVsr
         5z6Q==
X-Gm-Message-State: AOJu0YxJG4zkCFcwCfl7H6egDzWAzo+pNne5iV24e0L70wMsw5qvjTjn
	gZn2cmh8wT349kBuawfOU5sn8ldspayjD2NBTYCkKw9zg+wXyJMSekr4iYKw
X-Google-Smtp-Source: AGHT+IGYUsqm0CuZayESh3mDJsYzxQkaedJUAxK1Wl9002QjGnLjFa2YdhUJ/qddL51pSQcyvFAn/Q==
X-Received: by 2002:a9d:5c06:0:b0:6e1:11b7:9a39 with SMTP id o6-20020a9d5c06000000b006e111b79a39mr9494409otk.23.1706914505254;
        Fri, 02 Feb 2024 14:55:05 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:55:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 15/18] lte: Refactor lte settings management
Date: Fri,  2 Feb 2024 16:53:47 -0600
Message-ID: <20240202225405.993792-15-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
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
 src/lte.c | 168 +++++++++++++++++++++++++++---------------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 7280b2913a8d..158c8e9c2b17 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -32,6 +32,7 @@
 
 #include <glib.h>
 #include <gdbus.h>
+#include <ell/ell.h>
 
 #include "ofono.h"
 
@@ -50,59 +51,50 @@ struct ofono_lte {
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
@@ -110,11 +102,28 @@ static void lte_load_settings(struct ofono_lte *lte)
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
@@ -180,12 +189,12 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
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
 
@@ -200,13 +209,13 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
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
@@ -214,8 +223,8 @@ static void lte_set_default_attach_info_cb(const struct ofono_error *error,
 					key,
 					DBUS_TYPE_STRING, &value);
 
-	g_free(value);
-	g_free(key);
+	l_free(value);
+	l_free(key);
 }
 
 static DBusMessage *lte_set_property(DBusConnection *conn,
@@ -257,14 +266,14 @@ static DBusMessage *lte_set_property(DBusConnection *conn,
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
@@ -286,19 +295,19 @@ static DBusMessage *lte_set_property(DBusConnection *conn,
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
@@ -332,24 +341,19 @@ static void lte_remove(struct ofono_atom *atom)
 
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
@@ -391,29 +395,25 @@ static void lte_init_default_attach_info_cb(const struct ofono_error *error,
 
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

