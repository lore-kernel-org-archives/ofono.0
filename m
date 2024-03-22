Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4046B80
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116590; cv=none; b=PwhcEPbOP512WiUE3sX9y64WxupBvTWpb4DIz1TftFSAj0JVdkIDqVXVjrmuKq7JvyPqonDxZpdQcjs5Fs1woZgrXFKO1tPUg7cnThPjPZOTcxZVIeeumS7llNwAzI6XBp/UGcVInV/3znZLB8UqqJT1+MLfqGVXzfd+k4s7/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116590; c=relaxed/simple;
	bh=UGckVs8kvAiNKaZ0ct9e4sOHAz4A5N8SYiUSm8taBRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj8bSghwbRQUhSRaBcQLHZ81WTqVf0cc3E6/nEyingquBOVpEaNvjmPQrLH8ypbHbksyzO0BOthr6+8KaBusMN9oTAVhf+BzpCnMlEBd/5e56NjYEArQp/V11X9JbJuH7EqdQJC6/GfuaycgUMdUAQTVCscv9CZn92fF8iDy5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsvFh8Bp; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsvFh8Bp"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a49261093cso1023259eaf.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116588; x=1711721388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPnakauAsHFa/cxnAnzOPp3cp1QFJU1LAl+CDaN4YZA=;
        b=NsvFh8BpISBgHn86uPE8L+y0C+dUs6jppMZfcEjixM0qa2VhsE6ovjsWbITq+4bQkk
         tblAlcwdCSOK5lZ2f+EvoSJMZzjDTJT4w61D90OOXFEKMzqMeAybQ8LwqxBsCHfbT8Iz
         qx6H3/J3QqNai/3vAfCd/Y23ejP4r9IWsXYkQGr+vYj0lyITKGWMh0hWN07BaCbPvvVi
         tyRJ9V82JCXdyzAeBvv13yFT3Gu1LX6AUn5rxL0/2vlFT24Mmbl653SDnpHrHjmP3NIt
         tvqwJtdjZylnFmxL8s4vtKUSKF5eYBqe5HGup8DOwnka3EkTWy3hLR/ob0sJr0lQeoT9
         U99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116588; x=1711721388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPnakauAsHFa/cxnAnzOPp3cp1QFJU1LAl+CDaN4YZA=;
        b=KG4OyBd2/fb34YOvaR8fElExQCDHnvA/Qe4XbGREC11G2yHegczep2hJXoSUg3+SK/
         JclFNDUZH7L+HZv3fuTBGZfMdw8ti0TDyATAUuzE0p8WJUy+R18S9sHLq2LaNzCjqFkn
         athxFlCf3gFDp4MG8TD2nFCMiAp2sfx2DMhlXNGzSl2MVaMpiQn3g4s5/M56+rqWyh1z
         SedCvp6A0IrQNv/GkyQ/r6vRc9yHlJPFKnVmZEujYslNMyjrn1ICVutHFPqPs3GSjBkm
         iSRmkiLFs0GRzfn0zpY7iWnMOYtIdkXzuCdtECZ20ftEZEq1o64yDptFn0QvDe0m6K+n
         3UwQ==
X-Gm-Message-State: AOJu0Yy50Vdq5mfq0QkLZhyO706WmP10ihb/2h8+lq8zFIkVulLRv2vQ
	1hZyBtbJ2zCpjj/9VZmL1YCAygyu0SK8oMkkiDFt3pfiYSdSMwqLmn+/HNj2
X-Google-Smtp-Source: AGHT+IHVP5gFyFEB0lucueuyPCDsCyZeeoilJ7p5X0pbpwuEgmAA9En2LlTjrokJ/yx/7Qot1yS9Pw==
X-Received: by 2002:a4a:ee84:0:b0:5a1:cefd:73d6 with SMTP id dk4-20020a4aee84000000b005a1cefd73d6mr2690380oob.7.1711116588128;
        Fri, 22 Mar 2024 07:09:48 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/11] modem: add implementation for the Capabilities property
Date: Fri, 22 Mar 2024 09:09:06 -0500
Message-ID: <20240322140942.2703042-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322140942.2703042-1-denkenz@gmail.com>
References: <20240322140942.2703042-1-denkenz@gmail.com>
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
 src/modem.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index 7486a56aa183..3744330a6225 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -88,6 +88,7 @@ struct ofono_modem {
 	void			*driver_data;
 	char			*driver_type;
 	char			*name;
+	unsigned int		capabilities;
 };
 
 struct ofono_devinfo {
@@ -162,6 +163,22 @@ static char **get_interfaces(struct ofono_modem *modem)
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
+	capabilities = l_new(char *, __builtin_popcount(modem->capabilities));
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
@@ -849,6 +866,7 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 	dbus_bool_t emergency = ofono_modem_get_emergency_mode(modem);
 	const char *strtype;
 	const char *system_path;
+	char **capabilities;
 
 	ofono_dbus_dict_append(dict, "Online", DBUS_TYPE_BOOLEAN,
 				&modem->online);
@@ -910,6 +928,13 @@ void __ofono_modem_append_properties(struct ofono_modem *modem,
 
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
@@ -1237,6 +1262,19 @@ void ofono_modem_set_powered(struct ofono_modem *modem, ofono_bool_t powered)
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
@@ -1874,6 +1912,17 @@ void ofono_modem_set_driver(struct ofono_modem *modem, const char *type)
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

