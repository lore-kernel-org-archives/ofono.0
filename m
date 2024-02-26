Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369B14008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918660; cv=none; b=fLLTlWVrp60wcLEXWmESqFrnIOcYn3tQxpXIu5v1+CxTDO+5Fa9SX17IoNVnmTzoZ5Vza+nGTBpBuGFE0EonubtB0WFxxXvdHvjqPWH0X2AzWYemDyx4EgJv3ohKpIG13RDyIWNfx7GppERquvdFPEwlZzlsaDPNWjg2WJTthyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918660; c=relaxed/simple;
	bh=bQdIuuVwimIv7zgtEA07jGD5iMVZ0QRUodXVfrfDvLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp1N59wn/7aSAy8yak6i8OE+XCW3wLQxZgP7t9TLDTXVr5gaxgGT4WBRJdv44SWZNZ507lUbuY+Bib/mNBgUHJo8dsxwOoyZiLbdZh32Z1oxZb9PipvuXdrMRYyANPISzXJgvbR0zH7BChibAmbnCcXUChOhi7fGpo+E9iWkow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTgL9Gyt; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTgL9Gyt"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a035a1124dso1003905eaf.1
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918658; x=1709523458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9BJ7oLjhkTjF1ACuOM9MkDuvj49cSEOEc1hcNR4iAM=;
        b=GTgL9GytZKgICMZwcEWNLBGZzAaHWZXJ4iMc24BvVu+phWk8Yj4ECZAQmBJdTHznCW
         kuTInVIMDlLSpYKGnI518vgOh+cO1Ehl4CYCqeczwr5jusZHuhiGIk4VW8fmSZdstI+s
         TWokFoOjVzPH0qLhmFmifB11fXTATD0wtQgK0m6FBZat4Tb/w2hbbrmAHj8oX35bUB5Q
         5xMILVzQWcPZt6N91Us+teurRoSPpZj9qmixp4LXO/fPzxNiS7IbU8NBU7t+wMrt3dIb
         g3y1TTfSilQ0+etnYG//ACYYyggMS8IiAqBD9Dy2376YdEsyrqA78BhI/EcnhIG36+7b
         PcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918658; x=1709523458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9BJ7oLjhkTjF1ACuOM9MkDuvj49cSEOEc1hcNR4iAM=;
        b=FP8GFGvOzUmoq5BvpLO/qw5ss16gYEWYwpC9x+Z43Yjod9b3QWDys7Ny8OFjkokymx
         oEajkCKWis2toniOh835A7o66boZ6QESKbEadw7cZledTnLcbSMGe3rS8QMMPPi0hAr8
         BX29kupLwqq//43aq7vfBx8bxx5aAQu9r3yF6E5XPHhk8hRc2lTK4dZpYrRXFKTwcYkM
         qHu7S+f7cwzMJS3YSWyJMKHHU6ZBEVZ1cGyJY8RTigiI8+oVJNyTQs1aIe4yHucKcL2v
         4d3rjDplC/1bVKsz4Bd9VNw2AveuZye2oWDeKKnQwlbMNd3w/9mr2U4g+yvMRNZzDj31
         Dr7w==
X-Gm-Message-State: AOJu0YzFHSREEjeQ0pqAbwkrlcEGtuaqlwlJcvzwBYncEkN1Hxb+qp8S
	I/P00oh4MnLLCVtmKjRl1HfAgdATpyGJv9hvWF0IHTzcaaYBE9jtTTFx/IfT
X-Google-Smtp-Source: AGHT+IGHIV4TxUYIZBrNf6GhAOxxCMJmutB5E1eTUCPbzKsnah6i2wHT7QVyumP+l4m38Wi4MFXj9w==
X-Received: by 2002:a4a:6506:0:b0:5a0:3bbf:d4e7 with SMTP id y6-20020a4a6506000000b005a03bbfd4e7mr5302528ooc.6.1708918657885;
        Sun, 25 Feb 2024 19:37:37 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:37 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 18/22] modem: Drop g_strdup use
Date: Sun, 25 Feb 2024 21:37:01 -0600
Message-ID: <20240226033724.1460079-18-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace with l_strdup
---
 src/modem.c | 64 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index c139fd1e1b53..788e86fba0f6 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -959,7 +959,7 @@ static void lockdown_remove(struct ofono_modem *modem)
 		modem->lock_watch = 0;
 	}
 
-	g_free(modem->lock_owner);
+	l_free(modem->lock_owner);
 	modem->lock_owner = NULL;
 
 	modem->lockdown = FALSE;
@@ -1052,14 +1052,14 @@ static DBusMessage *set_property_lockdown(struct ofono_modem *modem,
 	if (ofono_modem_get_emergency_mode(modem) == TRUE)
 		return __ofono_error_emergency_active(msg);
 
-	modem->lock_owner = g_strdup(caller);
+	modem->lock_owner = l_strdup(caller);
 
 	modem->lock_watch = g_dbus_add_disconnect_watch(conn,
 				modem->lock_owner, lockdown_disconnect,
 				modem, NULL);
 
 	if (modem->lock_watch == 0) {
-		g_free(modem->lock_owner);
+		l_free(modem->lock_owner);
 		modem->lock_owner = NULL;
 
 		return __ofono_error_failed(msg);
@@ -1352,12 +1352,12 @@ void ofono_modem_add_interface(struct ofono_modem *modem,
 	const char *feature;
 
 	modem->interface_list = g_slist_prepend(modem->interface_list,
-						g_strdup(interface));
+						l_strdup(interface));
 
 	feature = get_feature(interface);
 	if (feature)
 		modem->feature_list = g_slist_prepend(modem->feature_list,
-							g_strdup(feature));
+							l_strdup(feature));
 
 	if (modem->interface_update != 0)
 		return;
@@ -1379,7 +1379,7 @@ void ofono_modem_remove_interface(struct ofono_modem *modem,
 		return;
 	}
 
-	g_free(found->data);
+	l_free(found->data);
 	modem->interface_list = g_slist_remove(modem->interface_list,
 						found->data);
 
@@ -1388,7 +1388,7 @@ void ofono_modem_remove_interface(struct ofono_modem *modem,
 		found = g_slist_find_custom(modem->feature_list, feature,
 						(GCompareFunc) strcmp);
 		if (found) {
-			g_free(found->data);
+			l_free(found->data);
 			modem->feature_list =
 				g_slist_remove(modem->feature_list,
 						found->data);
@@ -1411,7 +1411,7 @@ static void query_svn_cb(const struct ofono_error *error,
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR)
 		return;
 
-	info->svn = g_strdup(svn);
+	info->svn = l_strdup(svn);
 
 	ofono_dbus_signal_property_changed(conn, path, OFONO_MODEM_INTERFACE,
 			"SoftwareVersionNumber", DBUS_TYPE_STRING, &info->svn);
@@ -1435,7 +1435,7 @@ static void query_serial_cb(const struct ofono_error *error,
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR)
 		goto out;
 
-	info->serial = g_strdup(serial);
+	info->serial = l_strdup(serial);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_MODEM_INTERFACE,
@@ -1463,7 +1463,7 @@ static void query_revision_cb(const struct ofono_error *error,
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR)
 		goto out;
 
-	info->revision = g_strdup(revision);
+	info->revision = l_strdup(revision);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_MODEM_INTERFACE,
@@ -1494,7 +1494,7 @@ static void query_model_cb(const struct ofono_error *error,
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR)
 		goto out;
 
-	info->model = g_strdup(model);
+	info->model = l_strdup(model);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_MODEM_INTERFACE,
@@ -1526,7 +1526,7 @@ static void query_manufacturer_cb(const struct ofono_error *error,
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR)
 		goto out;
 
-	info->manufacturer = g_strdup(manufacturer);
+	info->manufacturer = l_strdup(manufacturer);
 
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_MODEM_INTERFACE,
@@ -1646,19 +1646,19 @@ static void devinfo_unregister(struct ofono_atom *atom)
 {
 	struct ofono_devinfo *info = __ofono_atom_get_data(atom);
 
-	g_free(info->manufacturer);
+	l_free(info->manufacturer);
 	info->manufacturer = NULL;
 
-	g_free(info->model);
+	l_free(info->model);
 	info->model = NULL;
 
-	g_free(info->revision);
+	l_free(info->revision);
 	info->revision = NULL;
 
-	g_free(info->serial);
+	l_free(info->serial);
 	info->serial = NULL;
 
-	g_free(info->svn);
+	l_free(info->svn);
 	info->svn = NULL;
 }
 
@@ -1725,7 +1725,7 @@ static int set_modem_property(struct ofono_modem *modem, const char *name,
 
 	switch (type) {
 	case PROPERTY_TYPE_STRING:
-		property->value = g_strdup((const char *) value);
+		property->value = l_strdup((const char *) value);
 		break;
 	case PROPERTY_TYPE_INTEGER:
 		property->value = g_memdup2(value, sizeof(int));
@@ -1737,7 +1737,7 @@ static int set_modem_property(struct ofono_modem *modem, const char *name,
 		break;
 	}
 
-	g_hash_table_replace(modem->properties, g_strdup(name), property);
+	g_hash_table_replace(modem->properties, l_strdup(name), property);
 
 	return 0;
 }
@@ -1833,9 +1833,9 @@ void ofono_modem_set_powered_timeout_hint(struct ofono_modem *modem,
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name)
 {
 	if (modem->name)
-		g_free(modem->name);
+		l_free(modem->name);
 
-	modem->name = g_strdup(name);
+	modem->name = l_strdup(name);
 
 	if (modem->driver) {
 		DBusConnection *conn = ofono_dbus_get_connection();
@@ -1857,8 +1857,8 @@ void ofono_modem_set_driver(struct ofono_modem *modem, const char *type)
 	if (strlen(type) > 16)
 		return;
 
-	g_free(modem->driver_type);
-	modem->driver_type = g_strdup(type);
+	l_free(modem->driver_type);
+	modem->driver_type = l_strdup(type);
 }
 
 struct ofono_modem *ofono_modem_create(const char *name, const char *type)
@@ -1887,10 +1887,10 @@ struct ofono_modem *ofono_modem_create(const char *name, const char *type)
 	if (modem == NULL)
 		return modem;
 
-	modem->path = g_strdup(path);
-	modem->driver_type = g_strdup(type);
+	modem->path = l_strdup(path);
+	modem->driver_type = l_strdup(type);
 	modem->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, unregister_property);
+						l_free, unregister_property);
 	modem->timeout_hint = DEFAULT_POWERED_TIMEOUT;
 
 	g_modem_list = g_slist_prepend(g_modem_list, modem);
@@ -2052,7 +2052,7 @@ int ofono_modem_register(struct ofono_modem *modem)
 		return -EIO;
 	}
 
-	g_free(modem->driver_type);
+	l_free(modem->driver_type);
 	modem->driver_type = NULL;
 
 	modem->atom_watches = __ofono_watchlist_new(g_free);
@@ -2102,10 +2102,10 @@ static void modem_unregister(struct ofono_modem *modem)
 	modem->sim_watch = 0;
 	modem->sim_ready_watch = 0;
 
-	g_slist_free_full(modem->interface_list, g_free);
+	g_slist_free_full(modem->interface_list, l_free);
 	modem->interface_list = NULL;
 
-	g_slist_free_full(modem->feature_list, g_free);
+	g_slist_free_full(modem->feature_list, l_free);
 	modem->feature_list = NULL;
 
 	if (modem->timeout) {
@@ -2158,9 +2158,9 @@ void ofono_modem_remove(struct ofono_modem *modem)
 
 	g_modem_list = g_slist_remove(g_modem_list, modem);
 
-	g_free(modem->driver_type);
-	g_free(modem->name);
-	g_free(modem->path);
+	l_free(modem->driver_type);
+	l_free(modem->name);
+	l_free(modem->path);
 	g_free(modem);
 }
 
-- 
2.43.0

