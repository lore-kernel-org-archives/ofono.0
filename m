Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6AA14D6F3
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160369; cv=none; b=a6z+rWyr+//fi/m3geUDO3qQig88rfw1U/FwqXXZ8lFoYqxQ1S4gBxe3qi/OVPeAiR5IQ1vn7GgxswzlLKtcFJTHOqoCT2WTJp4VnfH1rMij5EpuuRdBotDyFIU/Umc/b1OvoOmLK8WunP9I30DlEhm2y8igDXR6GhlWq+i3AvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160369; c=relaxed/simple;
	bh=2yTKEfhHkIg/up3+wwOAaK9J2AR5AvDliW+mUFBk/mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbXtbhl7k4BWDwwdqKYlVwuRjhuepLCqNCjptdPFj/3b9oVFBNwzXNFAeH46l9znGd8iqnTycD1NWXgbcrL961vSkA6iBZNr9bVKTMzuOyQoqyFF6wV8cJsfdfvIUdEmlPiuqhrlTHqVHiOJpfoG+kyRGdHF2SAsXW7N4pB02nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFMih97S; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFMih97S"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e125818649so3692a34.1
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160367; x=1712765167; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNuhAYPkpRIdVqTtTC2kKgQAxbnzz0Rcmel+VCHhK/A=;
        b=XFMih97Sah1sLX9IfZKR3C491eJpi1Sk3G8x5bkcygAMm1MzfhPUeuyCm5rgF9rfDy
         yHyliULJUMcPaicmHA+22D2ox2VLOtfT3v4UdOIYiTtiLFdodlu/ey1FL8D89LQCSAWP
         RYBGwya+Ndt7t0o7BfUJ2/1hjv4z8JQMm5Y+UMipXihjtjaC/c5vIE3syNPoms3n0PJw
         41+/vnUQnrHH9XahGSZ77cD2lu2LO+PFRwM87F0jgk6KOUrJhJTMprzmnt1fRIr9V4gZ
         IRZoNg2cUeagxQANBTPZip2mV9H4CybMDAQyCNIy/XoOamC3a5LWoAfdy2KA1YXpVT2r
         DEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160367; x=1712765167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNuhAYPkpRIdVqTtTC2kKgQAxbnzz0Rcmel+VCHhK/A=;
        b=xPoE38nGEhZJnwDjljlR0upTh10b1bWZqjLxpQH2h0jJFb0Wxahsjhcu9/LvkuKezR
         jEoIfFjBISIXOQrVCnBCoeGEEUH8Xz8vAphn/LSFm9DOE0NlKH5+DeBpVbPXamA/xPXX
         O4ghQ5RM2AesJv7adZSV9dZYn9SfGs86cXKoli5PaTptbUgHf5NdT3n7ovF1akRyokap
         Jzc7BdhgGjpd2TslzK0PTwJst9CPIHqKXWS6N5ax0DaMmDl4VONk5zSq4XrgHP9+55kI
         QzAJMCUTJuXOYgnnsrVdeUHkyHzDwxbDmNt/6LrF67msFIfd+BN3bQQsIRPs7vvMU8mq
         UXvA==
X-Gm-Message-State: AOJu0Yx/CKxbc/6JwABFmFsiq9BaGmT2OL0IghC8I4kd4RsPWj/GDqTv
	qqg0OwSVVZMITbsELVvBcyvfUSpOBBuRLGasJUn2CufqOJ8QE7LevtRjBG1H
X-Google-Smtp-Source: AGHT+IGIZb5VvS1yKqYTfU1r0MHeR+rQBMqsPgac1aBuSYT+xSinYkz7sVT4ZOK0OI0tCRVQzpBrCg==
X-Received: by 2002:a9d:68c7:0:b0:6e6:8ec7:85d6 with SMTP id i7-20020a9d68c7000000b006e68ec785d6mr18190005oto.31.1712160367045;
        Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/14] ofono: Add support for ofono main.conf settings
Date: Wed,  3 Apr 2024 11:05:34 -0500
Message-ID: <20240403160557.2828145-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403160557.2828145-1-denkenz@gmail.com>
References: <20240403160557.2828145-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It would be useful to support some oFono wide configuration settings
that can be configured for the system.  Introduce a new
__ofono_get_config() function that will obtain the parsed settings file
as a pointer to l_settings.  The settings will be parsed from the
configuration directory set using CONFIGURATION_DIRECTORY environment
variable, or the default CONFIGDIR variable set during
configuration/compilation.
---
 src/main.c  | 32 ++++++++++++++++++++++++++++++++
 src/ofono.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/src/main.c b/src/main.c
index 141853eef8ae..6dd073b4f31a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -39,6 +39,12 @@
 #define SHUTDOWN_GRACE_SECONDS 10
 
 static GMainLoop *event_loop;
+static struct l_settings *ofono_config;
+
+const struct l_settings *__ofono_get_config(void)
+{
+	return ofono_config;
+}
 
 void __ofono_exit(void)
 {
@@ -204,6 +210,9 @@ int main(int argc, char **argv)
 	DBusError error;
 	guint signal;
 	struct ell_event_source *source;
+	const char *config_dir;
+	char **config_dirs;
+	unsigned int i;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -254,6 +263,27 @@ int main(int argc, char **argv)
 
 	__ofono_log_init(argv[0], option_debug, option_detach);
 
+	config_dir = getenv("CONFIGURATION_DIRECTORY");
+	if (!config_dir)
+		config_dir = CONFIGDIR;
+
+	l_debug("Using configuration directory: %s", config_dir);
+	config_dirs = l_strsplit(config_dir, ':');
+	ofono_config = l_settings_new();
+
+	for (i = 0; config_dirs[i]; i++) {
+		_auto_(l_free) char *path = l_strdup_printf("%s/main.conf",
+								config_dirs[i]);
+
+		if (!l_settings_load_from_file(ofono_config, path))
+			continue;
+
+		l_info("Loaded configuration from %s", path);
+		break;
+	}
+
+	l_strv_free(config_dirs);
+
 	dbus_error_init(&error);
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, OFONO_SERVICE, &error);
@@ -291,6 +321,8 @@ fail_module_init:
 	__ofono_dbus_cleanup();
 	dbus_connection_unref(conn);
 
+	l_settings_free(ofono_config);
+
 cleanup:
 	g_source_remove(signal);
 
diff --git a/src/ofono.h b/src/ofono.h
index 294e90a37c23..80add8351ee7 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -26,6 +26,7 @@
 
 #include <ofono/types.h>
 
+const struct l_settings *__ofono_get_config(void);
 void __ofono_exit(void);
 
 int __ofono_handsfree_audio_manager_init(void);
-- 
2.43.0

