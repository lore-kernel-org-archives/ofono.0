Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419C1D6AE
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097066; cv=none; b=FRZs99PYbYRxiAoA808ehrHPRYifcyv8yOFV5YjGCzXsULgY+YknvqnY42ZzluPUVKd1xOzI5A2tFnO9dHuYDyKivjXP8evgoIsifZI75sKtfDj5LrYnfy20/MzlOsNQUvnUlktUdb27mAVT2ipa0Xw1Nr3R5Go/nuYT1xsdbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097066; c=relaxed/simple;
	bh=fpkxOhYghJN9PKJW/r3LKfNzRX/7z7hBEeZ2vLRX6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzFAaW1LoSKtlLFGcGCETn5s4roFbN5sV/Vub1bzSX97+Z97TZTIuSTF21r5O3SrTOo2Jk6aEw0tzRjTpe5bEBlGpDppWv2rQtzI2uDbz5UioUT48xIcU/LJfT1HXBWlE2i1wUThqrSiU6xeFooGg8YackYYJ729lHmfBatzErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee/nASzq; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee/nASzq"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a496fde460so3581091eaf.1
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097064; x=1712701864; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/TWG2+W2RzqALcg9cVNAXCMYJOSOEY4RrtyMmJ23bI=;
        b=Ee/nASzqA0J5CI8wKoBIAg31O4ka4UZy4EKNpA7Qg0oIIkvI9hpSJ6tn8+tz2ia6Mr
         NhyuzN+UxEtBDx3LSA3xPFtfbND8xdYF9K2ybNZskZk4BVUs4Unsyk0jUdgqRralwR7h
         rpyNnfZqicUPy/2v0ZUqKDGLNdXBM4iFFmHdDMITJFdjkIqv+a22sNMDGafNyvgdkcXF
         mKd+xa/9Sx8qj3BTcKN1B6cNT6hUPrt5wFyOkjMqCuf3jOdjGnIkb2xszDZoPWgP9uhF
         tpjbaFXob1i6MjS6n1vK6Ren+0tUqmURYVrvTcwj0aCaSPIQ72kWOZdADhTbT+lmsDPv
         l1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097064; x=1712701864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/TWG2+W2RzqALcg9cVNAXCMYJOSOEY4RrtyMmJ23bI=;
        b=Ui1/V8GSi0dY61ayVehrEz70wURllObu3EPnum9NzONxk/6MnlqVMN+eCM4YWAlbML
         VIBdQQ2Sliq7GksxKyIFcsCeA6qWe1jv6xU/DIvH3B1UI0dtrpmDEjxv8nERVnkdxWIP
         xG3uJbb21AH6he7nwwBojPofBMjiqDV4b7Ed3wMUtNdIPz8s7S1VCUdOVgdOO7uPcmdM
         dZMbj5liJetH9U5jNUVyh1q0T6M4d8QVskmPsJ7zSyhn3ickdejrCD0FTLUSWk6IrdkK
         RHGv01HrV9hZoG30vG/2QZ7I5l7UaPypUay84EEgEx/afz6asI5w3kNES8PpacHI1zrb
         ZWkA==
X-Gm-Message-State: AOJu0YxW9R/XN3Gnl9wxmjShvauMlgUW3GNqymueJpicRabUIcm95j+u
	edRo0x9tiPMtKpXeKsAi/wWVN2GxfnjMOV0NE674EbOLnZ+MyI9R0Qr+POqo
X-Google-Smtp-Source: AGHT+IHZXf0IvRWpOWcFbqBF9fQQqEP9sS2Bc0CnanRMw/5Fp4JrO3W8anriiVdIvdKuBMzXadipdg==
X-Received: by 2002:a4a:a541:0:b0:5a4:f5b6:4eca with SMTP id s1-20020a4aa541000000b005a4f5b64ecamr11247730oom.7.1712097064142;
        Tue, 02 Apr 2024 15:31:04 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/13] ofono: Add support for ofono main.conf settings
Date: Tue,  2 Apr 2024 17:30:36 -0500
Message-ID: <20240402223054.2819526-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
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
 src/main.c  | 30 ++++++++++++++++++++++++++++++
 src/ofono.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/src/main.c b/src/main.c
index 141853eef8ae..489b4cb71b43 100644
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

