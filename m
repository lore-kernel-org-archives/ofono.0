Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D957333
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698668; cv=none; b=Sw6/oSaHAHwYdPjqYLlEGc2x0N35iELLdELNNW36glMYWYKe5lKblUBMdTKpZlIY1QxIAbjOKm/+YOAS1QZVjKhCXaT4JfBYDl+SMwah5xlKyN0TdmLUP4SWywy72rsMj1M32mgL3Ul/5z2gXX7CkzLjEDeZl4MZF7SCrY9QLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698668; c=relaxed/simple;
	bh=r0Q/uInQcLFLEcCcTKG1Pp4tg0r/xI7m7tDZA4zLsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjo7MvZyRmGttAkS2hIlNgIVBhK+V5i3sNbGp2arUcy3tqFkbVqn0xniJOzo4qTJU5bjViMVO+vPz2hKcZqYmIvEJ1/exbe1NZ8aTsefVeWX9Xvu0PuZpU30/U5iPtxwixpse1XyO2exJt5WBt3tzH24oiPeMhaEvDgvCcovNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9dEjy5+; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9dEjy5+"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddeb09bc68so967736a34.1
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698666; x=1706303466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTBsf4FJCzzTExE+1+BKzkqSFpCebMu8uZo8rG6en7I=;
        b=O9dEjy5+k5wY6oCQxngoZCXwBvY0h9p3n45XSOLn9xHw91azXCVqiAYiPSNtGMZfgN
         yPzYgQPf6qoG6E7gc3fyWDdphFamu1voY55Bq9q1XtYsOBtToIvv0neksB90zzs0QXRV
         dnHAB8zaUuoJ2DFnj7YlSCfx2P9dFw+gE8fQOWdwnP+2639U9/KO4XuOH2bW5ZW+++hK
         C+nQos7CzF02eLUdlDIM8bAh7K3UneE0RCmrf3O1gePekxfdiIHk+AOW7OhG9XZMm0+z
         aeMEiZGYgoO4Iw5apNwLuAMdXhdM6MuoY8fIrVXIFP+o4ZhKeZ80FmD4sf0iyizjApXV
         Tycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698666; x=1706303466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTBsf4FJCzzTExE+1+BKzkqSFpCebMu8uZo8rG6en7I=;
        b=mDPVqgveH6nPfThDTCUZvCWpbom/fD6hYWZGMYzUjmgj1LyZots1IPi51ZY0i9hidl
         17sSmTdKoSd5jHaX4FYjxqjjeqb7DJ1zr04OFhl1SCaaN/puE0KVgwW3/kmHEI3P72st
         A+UpaIhdywm4yQsArZ8OvLKb+0mcOwi9ztjHlyUiQ0TG+iWAucbNOl2ZwGPWEbf9qug2
         m30ClnQjrNf7xcVlCrm2SZ9XQERAU8Iqvn+I+IWsVYYVvHjUAiC+/nL+cpngm4UJXC+0
         vDjMoYvkSo40BnbAnY0zen/c7QsO2QKx8JMkXLYwp0HLngGbIuLetxpkdpiJQORkmF0Q
         tA1g==
X-Gm-Message-State: AOJu0YxkKaHYylFl1QWTcDJvROE8U8duLbJUTeB908d3NsOTo9Dr0RwJ
	PZVDOA0GEjd/xDxEUtWH9LRfBpA0LUy7gPu/N+FOcon8Kx5fmNntYqgR6L3y
X-Google-Smtp-Source: AGHT+IFY4RxY9p+BSLBky7O/e2Zphr7Ommkb4J1iW7rUeLmDEzIqmwngPMAR86kZJ69BSmrGjOpLHw==
X-Received: by 2002:a05:6830:1bfc:b0:6dc:8f70:e03d with SMTP id k28-20020a0568301bfc00b006dc8f70e03dmr231532otb.11.1705698666346;
        Fri, 19 Jan 2024 13:11:06 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/14] module: Add support for ofono modules
Date: Fri, 19 Jan 2024 15:09:38 -0600
Message-ID: <20240119211017.474598-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119211017.474598-1-denkenz@gmail.com>
References: <20240119211017.474598-1-denkenz@gmail.com>
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
index 00000000..8730f2e1
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
+	size_t n_modules = __stop___ofono_module - __start___ofono_module;
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

