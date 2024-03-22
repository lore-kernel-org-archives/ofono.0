Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAC481B3
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122162; cv=none; b=hJue5wRWjs3Q1N4sxB2YXD2Dx/ebDssG77L8BQ+tNZBV7a0gpoLPdfCrwryarhlvQWWgQSIGxmNvkjEvIlAwrfhBsVtivD618hQskN5lZoXsDPbpeA2Uh9UBn+el4k5sMBLKg2TNTXpluXc62nMGWlbltpOmColFreh0+f7b+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122162; c=relaxed/simple;
	bh=4brL2qU0kuwi1SJQmYUJ4q/6oVcrD12DdqMEQtGOEwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg0PRaOFeSw3/ENBLiwmeFd4760e9RkZjpzFlOvnMcnkKeOWRbhwFQCCrMiCyv+By2zDv4fmhX+Grn4a5kk8VSoEIN18naRJQASGOusKa24QTv/o1x7s98A97EFwSDRAsJ75ZLfzSRwSB4Ii2go/U4buwukjL+4kJY4vXJpqn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfQo4TYv; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfQo4TYv"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6adb43e39so1458849a34.0
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122159; x=1711726959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTCa7ZZZZ+zjMIO42Z8wRCgssRlS5QYaWaU3HvvcqzM=;
        b=OfQo4TYv4ssit0GEMX5R4l0op+eArEpLixGPFQAZjbTbQ2PcVnKT6M/FN7GHAF5iMS
         Tatp2pokhXMkyKCy6k6VqzNzJ9L9zjb5zxEGfCT7owM64vebZxHNBZAKQaZwBhgRQqVB
         fsFQG9DRrbIG8AxTuPZZv8O+Cy7Pj+BHKwfVpV2LLbFHyTAdEKzdFhrdZ21upadI3t9L
         1ybsEUizkr3tycsOI+dVKJqlLibD4E0VaafY8f/8y4aRb7i7U01PzgdBJs5VNxGSNY6v
         TUGTRIjW2rxL7rf7T0+6lYHaM+elv8J+DVMp3/I1+MEeYaqAQKASsOvANipQvfcsGBf4
         nL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122159; x=1711726959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTCa7ZZZZ+zjMIO42Z8wRCgssRlS5QYaWaU3HvvcqzM=;
        b=juZzfPMfRrq8N4s38i0rBGLnbdU/0ree/wsKhEdh66WrG2KUJRqHvuP7p02RRrpeYJ
         gQHk26ue85uefD1K6wKtxDejjhpY7FenaNcAjTrkgA+vGZgZbm5CL51A60ctAxQM8/qi
         LJq9W3Ww6k8HC1aGbmWs0GKY1HKcTccQBxdoHQeQEo5O5fdrTR0qXdhYFH/LmLIeVvE6
         BPlUxTyTMPFAWoXZ3xCEzD5n+MP75uno+qSV4BCz1AHnwjOuvBbLMYBe4Mut68zcYI61
         S0ejc4UXX6LBeEVwJdp+8rsfts2xLnRJBc/UoQXPBHqGBsgm+KRsnp6IQCZjAuBhTd7w
         vZXA==
X-Gm-Message-State: AOJu0YzWFoREE0X0VNqegufizyGjmN56mwZTSYBGZDUCqdN5LJ6G0ZZ8
	pTgf1WUjm+SMVhaOWs/GgozgKJA56v8gkZQOpZacAs6PMm1CuwdxShhU9IRK
X-Google-Smtp-Source: AGHT+IECCw0B+2qJtNGJPWVIjY8wTG6yH5zOjPLL07p8RxeXiQowP135S9uc+N1gQlS+5h9kye3vPA==
X-Received: by 2002:a05:6830:1106:b0:6e5:a89:2ddd with SMTP id w6-20020a056830110600b006e50a892dddmr2404716otq.27.1711122159704;
        Fri, 22 Mar 2024 08:42:39 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:39 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/11] modem: add implementation for the Capabilities property
Date: Fri, 22 Mar 2024 10:42:18 -0500
Message-ID: <20240322154234.2720542-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Capabilities property is made available via GetProperties() D-Bus
method.  It is also emitted prior to emitting the PropertyChanged signal
for the Powered property.  This ensures that any clients that might use
the capability information, will obtain it prior to the modem being
enabled / powered up.
---
 include/modem.h | 14 ++++++++++++++
 src/modem.c     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/modem.h b/include/modem.h
index 1fa3df33544d..a70723a229a8 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -40,6 +40,10 @@ enum ofono_modem_type {
 	OFONO_MODEM_TYPE_TEST,
 };
 
+enum ofono_modem_capability {
+	OFONO_MODEM_CAPABILITY_LTE = 0x1,
+};
+
 typedef void (*ofono_modem_online_cb_t)(const struct ofono_error *error,
 					void *data);
 
@@ -134,6 +138,16 @@ ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem);
 void ofono_modem_set_name(struct ofono_modem *modem, const char *name);
 void ofono_modem_set_driver(struct ofono_modem *modem, const char *type);
 
+/*
+ * Set the capabilities of the modem.  This method should be called in
+ * the driver probe() method if the capability information can be obtained
+ * early, for example using the model information, or vid/pid of the device.
+ *
+ * Otherwise, it should be called prior to setting the device powered.
+ */
+void ofono_modem_set_capabilities(struct ofono_modem *modem,
+						unsigned int capabilities);
+
 int ofono_modem_set_string(struct ofono_modem *modem,
 				const char *key, const char *value);
 const char *ofono_modem_get_string(struct ofono_modem *modem, const char *key);
diff --git a/src/modem.c b/src/modem.c
index 24ab61761325..bfd5d7a81c45 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -88,6 +88,7 @@ struct ofono_modem {
 	void			*driver_data;
 	char			*driver_type;
 	char			*name;
+	unsigned int		capabilities;
 };
 
 struct ofono_devinfo {
@@ -162,6 +163,23 @@ static char **get_interfaces(struct ofono_modem *modem)
 	return interfaces;
 }
 
+static char **get_capabilities(struct ofono_modem *modem)
+{
+	char **capabilities;
+	unsigned int i = 0;
+
+	if (!modem->capabilities)
+		return NULL;
+
+	capabilities = l_new(char *,
+			__builtin_popcount(modem->capabilities) + 1);
+
+	if (modem->capabilities & OFONO_MODEM_CAPABILITY_LTE)
+		capabilities[i++] = "lte";
+
+	return capabilities;
+}
+
 unsigned int __ofono_modem_callid_next(struct ofono_modem *modem)
 {
 	unsigned int i;
@@ -849,6 +867,7 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 	dbus_bool_t emergency = ofono_modem_get_emergency_mode(modem);
 	const char *strtype;
 	const char *system_path;
+	char **capabilities;
 
 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -910,6 +929,13 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 
 	strtype = modem_type_to_string(modem->driver->modem_type);
 	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING, &strtype);
+
+	capabilities = get_capabilities(modem);
+	if (capabilities) {
+		ofono_dbus_dict_append_array(dict, "Capabilities",
+						DBUS_TYPE_STRING, &capabilities);
+		l_free(capabilities);
+	}
 }
 
 static DBusMessage *modem_get_properties(DBusConnection *conn,
@@ -1237,6 +1263,19 @@ void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t powered)
 		modem->timeout = 0;
 	}
 
+	if (powered && powered != modem->powered) {
+		char **capabilities = get_capabilities(modem);
+
+		if (capabilities) {
+			ofono_dbus_signal_array_property_changed(conn,
+						modem->path,
+						OFONO_MODEM_INTERFACE,
+						"Capabilities", DBUS_TYPE_STRING,
+						&capabilities);
+			l_free(capabilities);
+		}
+	}
+
 	if (modem->powered_pending != modem->powered &&
 						modem->pending != NULL) {
 		DBusMessage *reply;
@@ -1874,6 +1913,17 @@ void ofono_modem_set_driver(struct ofono_modem *modem, const char *type)
 	modem->driver_type = l_strdup(type);
 }
 
+void ofono_modem_set_capabilities(struct ofono_modem *modem,
+						unsigned int capabilities)
+{
+	if (!modem)
+		return;
+
+	DBG("%u", capabilities);
+
+	modem->capabilities = capabilities;
+}
+
 struct ofono_modem *ofono_modem_create(const char *name, const char *type)
 {
 	struct ofono_modem *modem;
-- 
2.43.0

