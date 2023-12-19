Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C22FC3E
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biITHmpA"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7fd9e17d8so10198039f.3
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011266; x=1703616066; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mifx55bjjy4/LNHw/MQxC+9YvZr8rjwqrQ+JRFo+wdI=;
        b=biITHmpAe9FDQDO4jy3cpBOKK+Yq+uWKeT3tzgM+IoygBI0zHoRrM1Kn6z/s/dGsp+
         P/qFAO9OMT0Kphjau/GKyqDYYggEmLAgW6Y8KSEP74u7bjHBVfiDdQ5GzdxOv25DhfFF
         6cRTMtCj7J2PCx8/19F1ZUwWeV+wyEgCCBvhKw/w95HKq0e3HbsAnrN2CGIlzcU16V2n
         JDiC6qxYZOwS3ZHCCfTw88zHin4drUP/M7NVfeLRLur2p2w/tJ3yKTqGCjDrM0I4Tazd
         630XYMv6K2BtoIJW9v66IN/zVoSnAX3hfabawucS7zTuAihDMXXp5xW3JX4TlH31Uo1j
         V+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011266; x=1703616066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mifx55bjjy4/LNHw/MQxC+9YvZr8rjwqrQ+JRFo+wdI=;
        b=WN8esjYTHJahc1g2Alk4Cc3Y7yzwV5r82sef+Ae/Cab8Yoi1RFsuiFciRdWjAVUArJ
         r3RPAPGWGipLcHyf6tUZeX+2Rf7WjmIuZhNrHxEo7j84lYudiInRaL3DasSwa8yxp50V
         9RcvtT3DOjMoUwz57dpbYTajS4jvGBIbDR2uowwPPeTm0H/h6ybBRol6KonSQOdj9wZ7
         8XhMiWlfia22rnrwIvNi8bI3kyeEU0qOgzS5DHIqxSr2OFDcAaW22UfwdzNsxG3DmagJ
         b/BEZjK1fkFbNDZLdyL4zjM5LTMyyv8UJw98CPbf4Ol5S9eOZki0LH5/sGlMr8+5ORSm
         REhw==
X-Gm-Message-State: AOJu0YzkZB12GIVl2LARFSkWzTWH/opeUnHGfwsPYB0EyuCTcOOzoPL+
	0jKoe9MVPWTWZj2Jz00H2OpqmUQmuaU=
X-Google-Smtp-Source: AGHT+IHFtjL77dFkujg6IrYp1OBjXJDhu3/zOpwvI6hFVy7PHw/4z8Rk9M8jY9id83P5v/o4c63nCQ==
X-Received: by 2002:a6b:dc13:0:b0:7b6:ef28:462a with SMTP id s19-20020a6bdc13000000b007b6ef28462amr17894120ioc.6.1703011266328;
        Tue, 19 Dec 2023 10:41:06 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:05 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 03/15] module: Add support for ofono modules
Date: Tue, 19 Dec 2023 12:37:00 -0600
Message-ID: <20231219184016.420116-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
References: <20231219184016.420116-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modules are meant to replace manually calling various __foo_init
and __foo_cleanup calls in main.c.  Instead a single ofono_modules_init
and ofono_modules_cleanup invocation will initialize / cleanup all
registered ofono modules.
---
 Makefile.am   |  3 ++-
 src/main.c    | 11 ++++-------
 src/manager.c |  6 ++++--
 src/modem.c   |  7 +++++--
 src/module.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ofono.h   | 22 ++++++++++++++++++---
 6 files changed, 89 insertions(+), 15 deletions(-)
 create mode 100644 src/module.c

diff --git a/Makefile.am b/Makefile.am
index e7fd030f..f7b59a47 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -725,7 +725,8 @@ src_ofonod_SOURCES = $(builtin_sources) $(gatchat_sources) src/ofono.ver \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
 			src/netmon.c src/lte.c src/ims.c \
-			src/netmonagent.c src/netmonagent.h
+			src/netmonagent.c src/netmonagent.h \
+			src/module.c
 
 src_ofonod_LDADD = gdbus/libgdbus-internal.la $(builtin_libadd) $(ell_ldadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/main.c b/src/main.c
index 4529cde1..82157700 100644
--- a/src/main.c
+++ b/src/main.c
@@ -274,12 +274,10 @@ int main(int argc, char **argv)
 
 	__ofono_dbus_init(conn);
 
-	__ofono_modemwatch_init();
-
-	__ofono_manager_init();
+	if (__ofono_modules_init() < 0)
+		goto fail_module_init;
 
 	__ofono_plugin_init(option_plugin, option_noplugin);
-
 	g_free(option_plugin);
 	g_free(option_noplugin);
 
@@ -287,10 +285,9 @@ int main(int argc, char **argv)
 
 	__ofono_plugin_cleanup();
 
-	__ofono_manager_cleanup();
-
-	__ofono_modemwatch_cleanup();
+	__ofono_modules_cleanup();
 
+fail_module_init:
 	__ofono_dbus_cleanup();
 	dbus_connection_unref(conn);
 
diff --git a/src/manager.c b/src/manager.c
index 404f2cad..e3307adb 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -95,7 +95,7 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
-int __ofono_manager_init(void)
+static int manager_init(void)
 {
 	DBusConnection *conn = ofono_dbus_get_connection();
 	gboolean ret;
@@ -111,10 +111,12 @@ int __ofono_manager_init(void)
 	return 0;
 }
 
-void __ofono_manager_cleanup(void)
+static void manager_cleanup(void)
 {
 	DBusConnection *conn = ofono_dbus_get_connection();
 
 	g_dbus_unregister_interface(conn, OFONO_MANAGER_PATH,
 					OFONO_MANAGER_INTERFACE);
 }
+
+OFONO_MODULE(manager, manager_init, manager_cleanup)
diff --git a/src/modem.c b/src/modem.c
index 60717717..354d2b86 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1918,12 +1918,13 @@ static void sim_watch(struct ofono_atom *atom,
 							modem, NULL);
 }
 
-void __ofono_modemwatch_init(void)
+static int modemwatch_init(void)
 {
 	g_modemwatches = __ofono_watchlist_new(g_free);
+	return 0;
 }
 
-void __ofono_modemwatch_cleanup(void)
+static void modemwatch_cleanup(void)
 {
 	__ofono_watchlist_free(g_modemwatches);
 }
@@ -2319,3 +2320,5 @@ void __ofono_modem_dec_emergency_mode(struct ofono_modem *modem)
 out:
 	modem->emergency--;
 }
+
+OFONO_MODULE(modemwatch, modemwatch_init, modemwatch_cleanup)
diff --git a/src/module.c b/src/module.c
new file mode 100644
index 00000000..273a7183
--- /dev/null
+++ b/src/module.c
@@ -0,0 +1,55 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <ell/ell.h>
+
+#include "ofono.h"
+
+extern struct ofono_module_desc __start___ofono_module[];
+extern struct ofono_module_desc __stop___ofono_module[];
+
+int __ofono_modules_init(void)
+{
+	struct ofono_module_desc *desc;
+	size_t i;
+	int r;
+	size_t n_modules =__stop___ofono_module - __start___ofono_module;
+
+	DBG("");
+
+	for (i = 0; i < n_modules; i++) {
+		desc = __start___ofono_module + i;
+		r = desc->init();
+
+		if (r < 0) {
+			ofono_error("Module %s failed to start: %s(%d)",
+					desc->name, strerror(-r), -r);
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+void __ofono_modules_cleanup(void)
+{
+	struct ofono_module_desc *desc;
+	size_t i;
+	size_t n_modules = __stop___ofono_module - __start___ofono_module;
+
+	l_debug("");
+
+	for (i = n_modules; i > 0; i--) {
+		desc = __start___ofono_module + i - 1;
+		desc->exit();
+	}
+}
diff --git a/src/ofono.h b/src/ofono.h
index 2e51776b..e289ff08 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -28,9 +28,6 @@
 
 void __ofono_exit(void);
 
-int __ofono_manager_init(void);
-void __ofono_manager_cleanup(void);
-
 int __ofono_handsfree_audio_manager_init(void);
 void __ofono_handsfree_audio_manager_cleanup(void);
 
@@ -97,6 +94,25 @@ gboolean __ofono_watchlist_remove_item(struct ofono_watchlist *watchlist,
 					unsigned int id);
 void __ofono_watchlist_free(struct ofono_watchlist *watchlist);
 
+struct ofono_module_desc {
+	const char *name;
+	int (*init)(void);
+	void (*exit)(void);
+} __attribute__((aligned(8)));
+
+#define OFONO_MODULE(name, init, exit)					\
+	_Pragma("GCC diagnostic push")					\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")		\
+	static struct ofono_module_desc __ofono_module_ ## name		\
+		__attribute__((used, retain, section("__ofono_module"),	\
+			       aligned(8))) = {				\
+			#name, init, exit				\
+		};							\
+	_Pragma("GCC diagnostic pop")
+
+int __ofono_modules_init(void);
+void __ofono_modules_cleanup(void);
+
 #include <ofono/plugin.h>
 
 int __ofono_plugin_init(const char *pattern, const char *exclude);
-- 
2.43.0

