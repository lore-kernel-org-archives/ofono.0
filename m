Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9D2595
	for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025838; cv=none; b=FxMcBXZwL0g+y8VGkOi3XZanC78a1NZsAHsG2d4UuHQ1WyRKB1APF7lNC/8sr7lNXduT3mceieu13NH2TAdjEnVrK1wa7UZDrGuIUZmweUWhwnG3dapOe/3oawBFlnVT+5lM9M1xTGiJkNSPB+IzvmNvSRu2yTIpl9uZ/spO9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025838; c=relaxed/simple;
	bh=Q+ir3+f1oBgtN4Piw5X5R8EKvgjuUEdwPJNpV7xrG2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELRcQsPAEE50x+4zZCXS/XY8oeJ9lhQpB89mFC9hnlBh6hlzL4u5RM3wZ+6xkjJKibiXflC/UiUErpWFxeoJYx/R6sv4l26w/DMrzaf12dHLTOjjNXZIDv5LwLlx8yve3pVnLnE+2EIM0R5Gj449Cc9fdly1FxQn47sWdpLmLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfIWVxS9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfIWVxS9"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c031a077d5so1162882b6e.0
        for <ofono@lists.linux.dev>; Thu, 15 Feb 2024 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708025834; x=1708630634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJktuOZfO9VFVOS54NxUp7BZ38MJysAH9xSj+LFRjtk=;
        b=QfIWVxS9ruIFGbaIPemzBd6P8k74f1LP3zzdkpVs2LuOYkGGCCYaOpLO9nGjPC1D8q
         Axjy+J8I6mwjM5zceDvZgrZCcG6lEQ1mUxgxCylwQkxGotjrrYyqdmioPWRlLHzrLL7X
         HNqtmnuSU3ZZ21nrAHPx4AO0ApaEfUwKuDIIef2JPhWxEl+7QlfDESGyFxNNgmHTX+kC
         tXkGsydjrsn0QmfNibJEavywwHQrb6CXEQR5G9wDFpabVJGqqrP48U77mkG0fnwSgDM9
         ps08ytAJH3zJgF83y2qq3ARYf9xfiq1kiGsR69k40piBv2OLz0yp1mtj877s7nT/A5eX
         71RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025834; x=1708630634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJktuOZfO9VFVOS54NxUp7BZ38MJysAH9xSj+LFRjtk=;
        b=FlJAqnxZFltIAt8NkZJg0jYkoTEzFNu1k+tO8q2+Hetn5Bzk7XpWn8XGSkH6BcWGZb
         ARNLDBYbTVH6X7qWpzbaOwkP3emXcfbifAoVUbxo1/jPhNIsiXP7w3mfDrSzUl7YIn9P
         /jPL3Mi8ucUvTex/e2EI7clZuJu0xLA7MPUoACzMMhVAVM+eufpC1/6YH1keheQ3HJBJ
         LhqZMc0hgpz8cN+Htc/KcqJKFybQ6EYfdOKXbzEqABmLtJdX9YT5o8QyUMBaCMO8WMuw
         Dr3a7Gl0biYGWbMzpO/ds7BVogYFTCWF+BBg8BYta6eNiG3LWp0wDbcx42DGUjI7jkWA
         ez8Q==
X-Gm-Message-State: AOJu0Yzd/xOpYq6hW96hP6Zhtl709fhMw36amQSvawQgSlN6omYycfdL
	eHArtPSaZ13jNsFBSs6MKJYL54zJOsscaujkeBTNEfDHOR4YJHEH0ca6i/Uv
X-Google-Smtp-Source: AGHT+IFJzENyV0GhkKTDkUaf+KkreHiKCkyPeo8OAZKHGq2/xqHbu9dVJmQouIsU8bOFL6AYZHKM0A==
X-Received: by 2002:a05:6871:79a:b0:219:3054:3ea5 with SMTP id o26-20020a056871079a00b0021930543ea5mr2797477oap.45.1708025833434;
        Thu, 15 Feb 2024 11:37:13 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id na9-20020a0568706c0900b00219cf69f50csm462686oab.14.2024.02.15.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:37:13 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] treewide: Make modem drivers builtin
Date: Thu, 15 Feb 2024 13:36:22 -0600
Message-ID: <20240215193625.1140095-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modem drivers are currently defined as plugins that register a
modem driver via ofono_modem_driver_register in the plugin init
method.  While oFono supports external plugins, this functionality
hasn't been used in practice for a long time.  External modem drivers is
also something that upstream project no longer wants to support.

Make all modem drivers builtin and introduce a new macro to make this
explicit.  Remove ofono_modem_driver_register and
ofono_modem_driver_unregister methods.
---
 Makefile.am               | 80 +++++----------------------------------
 include/modem.h           | 19 +++++++---
 plugins/alcatel.c         | 14 +------
 plugins/calypso.c         | 15 +-------
 plugins/cinterion.c       | 14 +------
 plugins/droid.c           | 22 +----------
 plugins/g1.c              | 14 +------
 plugins/gemalto.c         | 14 +------
 plugins/gobi.c            | 14 +------
 plugins/hfp_hf_bluez5.c   | 12 +-----
 plugins/hso.c             | 14 +------
 plugins/huawei.c          | 14 +------
 plugins/icera.c           | 14 +------
 plugins/ifx.c             | 14 +------
 plugins/infineon.c        | 26 +------------
 plugins/isiusb.c          | 15 +-------
 plugins/linktop.c         | 14 +------
 plugins/mbim.c            | 14 +------
 plugins/mbm.c             | 14 +------
 plugins/n900.c            | 14 +------
 plugins/nokia.c           | 14 +------
 plugins/novatel.c         | 14 +------
 plugins/palmpre.c         | 14 +------
 plugins/phonesim.c        | 15 ++------
 plugins/quectel.c         | 14 +------
 plugins/ril.c             | 25 +-----------
 plugins/ril_intel.c       | 14 +------
 plugins/samsung.c         | 14 +------
 plugins/sierra.c          | 14 +------
 plugins/sim7100.c         | 14 +------
 plugins/sim900.c          | 14 +------
 plugins/speedup.c         | 14 +------
 plugins/ste.c             | 14 +------
 plugins/stktest.c         | 10 +----
 plugins/telit.c           | 16 +-------
 plugins/u8500.c           | 16 +-------
 plugins/ublox.c           | 14 +------
 plugins/wavecom.c         | 14 +------
 plugins/xmm7xxx.c         | 16 +-------
 plugins/zte.c             | 14 +------
 src/modem.c               | 68 +++++++++------------------------
 src/ofono.h               | 12 +++---
 unit/test-rilmodem-cb.c   |  2 +-
 unit/test-rilmodem-cs.c   |  2 +-
 unit/test-rilmodem-gprs.c |  2 +-
 unit/test-rilmodem-sms.c  |  2 +-
 46 files changed, 93 insertions(+), 660 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d8766e08a50d..da7a655216ab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -278,13 +278,10 @@ builtin_sources += $(gril_sources)
 builtin_modules += rildev
 builtin_sources += plugins/rildev.c
 
-builtin_modules += ril
 builtin_sources += plugins/ril.c plugins/ril.h
 
-builtin_modules += infineon
 builtin_sources += plugins/infineon.c
 
-builtin_modules += ril_intel
 builtin_sources += plugins/ril_intel.c
 
 builtin_sources += drivers/rilmodem/vendor.h \
@@ -348,13 +345,10 @@ builtin_sources += $(gisi_sources) \
 			drivers/isimodem/uicc-util.h \
 			drivers/isimodem/uicc-util.c
 
-builtin_modules += isiusb
 builtin_sources += plugins/isiusb.c
 
-builtin_modules += n900
 builtin_sources += plugins/n900.c plugins/nokia-gpio.h plugins/nokia-gpio.c
 
-builtin_modules += u8500
 builtin_sources += plugins/u8500.c
 endif
 
@@ -389,7 +383,6 @@ builtin_sources += $(qmi_sources) \
 			drivers/qmimodem/netmon.c \
 			drivers/qmimodem/call-settings.c
 
-builtin_modules += gobi
 builtin_sources += plugins/gobi.c
 endif
 
@@ -413,7 +406,6 @@ builtin_sources += $(mbim_sources) \
 			drivers/mbimmodem/gprs.c \
 			drivers/mbimmodem/gprs-context.c
 
-builtin_modules += mbim
 builtin_sources += plugins/mbim.c
 endif
 
@@ -487,7 +479,6 @@ builtin_sources += drivers/atmodem/atutil.h \
 			drivers/ifxmodem/stk.c \
 			drivers/ifxmodem/ctm.c
 
-builtin_modules += stemodem
 builtin_sources += drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/voicecall.c \
@@ -549,96 +540,43 @@ dist_conf_DATA += plugins/phonesim.conf
 endif
 endif
 
-builtin_modules += g1
 builtin_sources += plugins/g1.c
-
-builtin_modules += wavecom
 builtin_sources += plugins/wavecom.c
-
-builtin_modules += calypso
 builtin_sources += plugins/calypso.c
-
-builtin_modules += mbm
 builtin_sources += plugins/mbm.c
-
-builtin_modules += hso
 builtin_sources += plugins/hso.c
-
-builtin_modules += zte
 builtin_sources += plugins/zte.c
-
-builtin_modules += huawei
 builtin_sources += plugins/huawei.c
-
-builtin_modules += sierra
 builtin_sources += plugins/sierra.c
-
-builtin_modules += novatel
 builtin_sources += plugins/novatel.c
-
-builtin_modules += palmpre
 builtin_sources += plugins/palmpre.c
-
-builtin_modules += ifx
 builtin_sources += plugins/ifx.c
-
-builtin_modules += ste
 builtin_sources += plugins/ste.c
-
-builtin_modules += stemgr
-builtin_sources += plugins/stemgr.c
-
-builtin_modules += caif
-builtin_sources += plugins/caif.c
-
-builtin_modules += cinterion
 builtin_sources += plugins/cinterion.c
-
-builtin_modules += gemalto
 builtin_sources += plugins/gemalto.c
-
-builtin_modules += nokia
 builtin_sources += plugins/nokia.c
-
-builtin_modules += linktop
 builtin_sources += plugins/linktop.c
-
-builtin_modules += icera
 builtin_sources += plugins/icera.c
-
-builtin_modules += alcatel
 builtin_sources += plugins/alcatel.c
-
-builtin_modules += speedup
 builtin_sources += plugins/speedup.c
-
-builtin_modules += samsung
 builtin_sources += plugins/samsung.c
-
-builtin_modules += sim900
 builtin_sources += plugins/sim900.c
-
-builtin_modules += sim7100
 builtin_sources += plugins/sim7100.c
-
-builtin_modules += connman
-builtin_sources += plugins/connman.c
-
-builtin_modules += telit
 builtin_sources += plugins/telit.c
-
-builtin_modules += quectel
 builtin_sources += plugins/quectel.c
-
-builtin_modules += ublox
 builtin_sources += plugins/ublox.c
-
-builtin_modules += xmm7xxx
 builtin_sources += plugins/xmm7xxx.c
-
-builtin_modules += droid
 builtin_sources += plugins/droid.c
 
+builtin_modules += stemgr
+builtin_sources += plugins/stemgr.c
+
+builtin_modules += caif
+builtin_sources += plugins/caif.c
+
+builtin_modules += connman
+builtin_sources += plugins/connman.c
+
 if BLUETOOTH
 if BLUEZ4
 builtin_modules += sap
diff --git a/include/modem.h b/include/modem.h
index 3667bf4c3b8c..1fa3df33544d 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -46,7 +46,7 @@ typedef void (*ofono_modem_online_cb_t)(const struct ofono_error *error,
 typedef ofono_bool_t (*ofono_modem_compare_cb_t)(struct ofono_modem *modem,
 							void *user_data);
 
-struct ofono_atom_driver_desc {
+struct ofono_driver_desc {
 	const char *name;
 	const void *driver;
 } __attribute__((aligned(8)));
@@ -54,7 +54,7 @@ struct ofono_atom_driver_desc {
 #define OFONO_ATOM_DRIVER_BUILTIN(type, name, driver)			\
 	_Pragma("GCC diagnostic push")					\
 	_Pragma("GCC diagnostic ignored \"-Wattributes\"")		\
-	static struct ofono_atom_driver_desc				\
+	static struct ofono_driver_desc					\
 		__ofono_builtin_ ## type ## _ ##name			\
 		__attribute__((used, retain, section("__" #type),	\
 				aligned(8))) = {			\
@@ -63,7 +63,6 @@ struct ofono_atom_driver_desc {
 	_Pragma("GCC diagnostic pop")
 
 struct ofono_modem_driver {
-	const char *name;
 	enum ofono_modem_type modem_type;
 
 	/* Detect existence of device and initialize any device-specific data
@@ -93,6 +92,17 @@ struct ofono_modem_driver {
 	void (*post_online)(struct ofono_modem *modem);
 };
 
+#define OFONO_MODEM_DRIVER_BUILTIN(name, driver)				\
+	_Pragma("GCC diagnostic push")					\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"")		\
+	static struct ofono_driver_desc					\
+		__ofono_builtin_modem_driver_ ##name			\
+		__attribute__((used, retain, section("__modem"),	\
+				aligned(8))) = {			\
+			#name, driver					\
+		};							\
+	_Pragma("GCC diagnostic pop")
+
 void ofono_modem_add_interface(struct ofono_modem *modem,
 				const char *interface);
 void ofono_modem_remove_interface(struct ofono_modem *modem,
@@ -137,9 +147,6 @@ int ofono_modem_set_boolean(struct ofono_modem *modem,
 ofono_bool_t ofono_modem_get_boolean(struct ofono_modem *modem,
 					const char *key);
 
-int ofono_modem_driver_register(const struct ofono_modem_driver *);
-void ofono_modem_driver_unregister(const struct ofono_modem_driver *);
-
 struct ofono_modem *ofono_modem_find(ofono_modem_compare_cb_t func,
 					void *user_data);
 
diff --git a/plugins/alcatel.c b/plugins/alcatel.c
index 8da06192a70e..8062b6dccc74 100644
--- a/plugins/alcatel.c
+++ b/plugins/alcatel.c
@@ -229,7 +229,6 @@ static void alcatel_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver alcatel_driver = {
-	.name		= "alcatel",
 	.probe		= alcatel_probe,
 	.remove		= alcatel_remove,
 	.enable		= alcatel_enable,
@@ -239,15 +238,4 @@ static struct ofono_modem_driver alcatel_driver = {
 	.post_online	= alcatel_post_online,
 };
 
-static int alcatel_init(void)
-{
-	return ofono_modem_driver_register(&alcatel_driver);
-}
-
-static void alcatel_exit(void)
-{
-	ofono_modem_driver_unregister(&alcatel_driver);
-}
-
-OFONO_PLUGIN_DEFINE(alcatel, "Alcatel modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, alcatel_init, alcatel_exit)
+OFONO_MODEM_DRIVER_BUILTIN(alcatel, &alcatel_driver)
diff --git a/plugins/calypso.c b/plugins/calypso.c
index 815489976eb8..81a6aabbdb88 100644
--- a/plugins/calypso.c
+++ b/plugins/calypso.c
@@ -541,7 +541,6 @@ static void calypso_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver calypso_driver = {
-	.name		= "calypso",
 	.probe		= calypso_probe,
 	.remove		= calypso_remove,
 	.enable		= calypso_enable,
@@ -550,16 +549,4 @@ static struct ofono_modem_driver calypso_driver = {
 	.post_sim	= calypso_post_sim,
 };
 
-static int calypso_init(void)
-{
-	return ofono_modem_driver_register(&calypso_driver);
-}
-
-static void calypso_exit(void)
-{
-	ofono_modem_driver_unregister(&calypso_driver);
-}
-
-OFONO_PLUGIN_DEFINE(calypso, "TI Calypso modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT,
-			calypso_init, calypso_exit)
+OFONO_MODEM_DRIVER_BUILTIN(calypso, &calypso_driver)
diff --git a/plugins/cinterion.c b/plugins/cinterion.c
index cd5e9e812d60..e445091458d2 100644
--- a/plugins/cinterion.c
+++ b/plugins/cinterion.c
@@ -225,7 +225,6 @@ static void cinterion_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver cinterion_driver = {
-	.name		= "cinterion",
 	.probe		= cinterion_probe,
 	.remove		= cinterion_remove,
 	.enable		= cinterion_enable,
@@ -236,15 +235,4 @@ static struct ofono_modem_driver cinterion_driver = {
 	.post_online	= cinterion_post_online,
 };
 
-static int cinterion_init(void)
-{
-	return ofono_modem_driver_register(&cinterion_driver);
-}
-
-static void cinterion_exit(void)
-{
-	ofono_modem_driver_unregister(&cinterion_driver);
-}
-
-OFONO_PLUGIN_DEFINE(cinterion, "Cinterion driver plugin", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, cinterion_init, cinterion_exit)
+OFONO_MODEM_DRIVER_BUILTIN(cinterion, &cinterion_driver)
diff --git a/plugins/droid.c b/plugins/droid.c
index 220d440b6b49..25e26946f79e 100644
--- a/plugins/droid.c
+++ b/plugins/droid.c
@@ -175,7 +175,6 @@ static void droid_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver droid_driver = {
-	.name		= "droid",
 	.probe		= droid_probe,
 	.remove		= droid_remove,
 	.enable		= droid_enable,
@@ -184,23 +183,4 @@ static struct ofono_modem_driver droid_driver = {
 	.post_sim	= droid_post_sim,
 };
 
-static int droid_init(void)
-{
-	return ofono_modem_driver_register(&droid_driver);
-}
-
-static void droid_exit(void)
-{
-	ofono_modem_driver_unregister(&droid_driver);
-}
-
-/* Modem in Motorola Droid has few different interfaces:
- * -- gsmmux over serial -- using very non-standard commands
- * -- QMI -- unfortunately not usable without gsmmux
- * -- standard AT over ttyUSB4 -- unfortunately quite broken
- *
- * This driver is for the standard AT commands.
- */
-
-OFONO_PLUGIN_DEFINE(droid, "Motorola Droid modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, droid_init, droid_exit)
+OFONO_MODEM_DRIVER_BUILTIN(droid, &droid_driver)
diff --git a/plugins/g1.c b/plugins/g1.c
index d915a5657302..b0fd7e92ae67 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -192,7 +192,6 @@ static void g1_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver g1_driver = {
-	.name		= "g1",
 	.probe		= g1_probe,
 	.remove		= g1_remove,
 	.enable		= g1_enable,
@@ -201,15 +200,4 @@ static struct ofono_modem_driver g1_driver = {
 	.post_sim	= g1_post_sim,
 };
 
-static int g1_init(void)
-{
-	return ofono_modem_driver_register(&g1_driver);
-}
-
-static void g1_exit(void)
-{
-	ofono_modem_driver_unregister(&g1_driver);
-}
-
-OFONO_PLUGIN_DEFINE(g1, "HTC G1 modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, g1_init, g1_exit)
+OFONO_MODEM_DRIVER_BUILTIN(g1, &g1_driver)
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index fb6b79e7c168..358d56a7aaf1 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -639,7 +639,6 @@ static void gemalto_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver gemalto_driver = {
-	.name		= "gemalto",
 	.probe		= gemalto_probe,
 	.remove		= gemalto_remove,
 	.enable		= gemalto_enable,
@@ -650,15 +649,4 @@ static struct ofono_modem_driver gemalto_driver = {
 	.post_online	= gemalto_post_online,
 };
 
-static int gemalto_init(void)
-{
-	return ofono_modem_driver_register(&gemalto_driver);
-}
-
-static void gemalto_exit(void)
-{
-	ofono_modem_driver_unregister(&gemalto_driver);
-}
-
-OFONO_PLUGIN_DEFINE(gemalto, "Gemalto modem plugin", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, gemalto_init, gemalto_exit)
+OFONO_MODEM_DRIVER_BUILTIN(gemalto, &gemalto_driver)
diff --git a/plugins/gobi.c b/plugins/gobi.c
index a5500166009d..ad5687dabcc7 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -761,7 +761,6 @@ static void gobi_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver gobi_driver = {
-	.name		= "gobi",
 	.probe		= gobi_probe,
 	.remove		= gobi_remove,
 	.enable		= gobi_enable,
@@ -772,15 +771,4 @@ static struct ofono_modem_driver gobi_driver = {
 	.post_online	= gobi_post_online,
 };
 
-static int gobi_init(void)
-{
-	return ofono_modem_driver_register(&gobi_driver);
-}
-
-static void gobi_exit(void)
-{
-	ofono_modem_driver_unregister(&gobi_driver);
-}
-
-OFONO_PLUGIN_DEFINE(gobi, "Qualcomm Gobi modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, gobi_init, gobi_exit)
+OFONO_MODEM_DRIVER_BUILTIN(gobi, &gobi_driver)
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index bdeb3caa37ce..d45dda9d4196 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -342,7 +342,6 @@ static void hfp_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver hfp_driver = {
-	.name		= "hfp",
 	.modem_type	= OFONO_MODEM_TYPE_HFP,
 	.probe		= hfp_probe,
 	.remove		= hfp_remove,
@@ -352,6 +351,8 @@ static struct ofono_modem_driver hfp_driver = {
 	.post_sim	= hfp_post_sim,
 };
 
+OFONO_MODEM_DRIVER_BUILTIN(hfp, &hfp_driver)
+
 static void bcs_notify(GAtResult *result, gpointer user_data)
 {
 	struct hfp *hfp = user_data;
@@ -849,18 +850,10 @@ static int hfp_init(void)
 		return err;
 	}
 
-	err = ofono_modem_driver_register(&hfp_driver);
-	if (err < 0) {
-		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
-						BLUEZ_PROFILE_INTERFACE);
-		return err;
-	}
-
 	bluez = g_dbus_client_new(conn, BLUEZ_SERVICE, BLUEZ_MANAGER_PATH);
 	if (bluez == NULL) {
 		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
-		ofono_modem_driver_unregister(&hfp_driver);
 		return -ENOMEM;
 	}
 
@@ -883,7 +876,6 @@ static void hfp_exit(void)
 
 	ofono_handsfree_card_driver_unregister(&hfp16_hf_driver);
 
-	ofono_modem_driver_unregister(&hfp_driver);
 	g_dbus_client_unref(bluez);
 
 	ofono_handsfree_audio_unref();
diff --git a/plugins/hso.c b/plugins/hso.c
index b58bf2a53abb..5ecf8d52e368 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -455,7 +455,6 @@ static void hso_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver hso_driver = {
-	.name		= "hso",
 	.probe		= hso_probe,
 	.remove		= hso_remove,
 	.enable		= hso_enable,
@@ -466,15 +465,4 @@ static struct ofono_modem_driver hso_driver = {
 	.post_online	= hso_post_online,
 };
 
-static int hso_init(void)
-{
-	return ofono_modem_driver_register(&hso_driver);
-}
-
-static void hso_exit(void)
-{
-	ofono_modem_driver_unregister(&hso_driver);
-}
-
-OFONO_PLUGIN_DEFINE(hso, "Option HSO modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, hso_init, hso_exit)
+OFONO_MODEM_DRIVER_BUILTIN(hso, &hso_driver)
diff --git a/plugins/huawei.c b/plugins/huawei.c
index 1e0879baaa94..32b536b64aca 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -873,7 +873,6 @@ static void huawei_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver huawei_driver = {
-	.name		= "huawei",
 	.probe		= huawei_probe,
 	.remove		= huawei_remove,
 	.enable		= huawei_enable,
@@ -884,15 +883,4 @@ static struct ofono_modem_driver huawei_driver = {
 	.post_online	= huawei_post_online,
 };
 
-static int huawei_init(void)
-{
-	return ofono_modem_driver_register(&huawei_driver);
-}
-
-static void huawei_exit(void)
-{
-	ofono_modem_driver_unregister(&huawei_driver);
-}
-
-OFONO_PLUGIN_DEFINE(huawei, "HUAWEI Mobile modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, huawei_init, huawei_exit)
+OFONO_MODEM_DRIVER_BUILTIN(huawei, &huawei_driver)
diff --git a/plugins/icera.c b/plugins/icera.c
index 90aca221b730..b0b1c1dc98d8 100644
--- a/plugins/icera.c
+++ b/plugins/icera.c
@@ -377,7 +377,6 @@ static void icera_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver icera_driver = {
-	.name		= "icera",
 	.probe		= icera_probe,
 	.remove		= icera_remove,
 	.enable		= icera_enable,
@@ -388,15 +387,4 @@ static struct ofono_modem_driver icera_driver = {
 	.post_online	= icera_post_online,
 };
 
-static int icera_init(void)
-{
-	return ofono_modem_driver_register(&icera_driver);
-}
-
-static void icera_exit(void)
-{
-	ofono_modem_driver_unregister(&icera_driver);
-}
-
-OFONO_PLUGIN_DEFINE(icera, "Icera modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, icera_init, icera_exit)
+OFONO_MODEM_DRIVER_BUILTIN(icera, &icera_driver)
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 121789e60437..ff7d852b2b59 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -732,7 +732,6 @@ static void ifx_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver ifx_driver = {
-	.name		= "ifx",
 	.probe		= ifx_probe,
 	.remove		= ifx_remove,
 	.enable		= ifx_enable,
@@ -743,15 +742,4 @@ static struct ofono_modem_driver ifx_driver = {
 	.post_online	= ifx_post_online,
 };
 
-static int ifx_init(void)
-{
-	return ofono_modem_driver_register(&ifx_driver);
-}
-
-static void ifx_exit(void)
-{
-	ofono_modem_driver_unregister(&ifx_driver);
-}
-
-OFONO_PLUGIN_DEFINE(ifx, "Infineon modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, ifx_init, ifx_exit)
+OFONO_MODEM_DRIVER_BUILTIN(ifx, &ifx_driver)
diff --git a/plugins/infineon.c b/plugins/infineon.c
index a90aacce837e..8b1f7b883c72 100644
--- a/plugins/infineon.c
+++ b/plugins/infineon.c
@@ -40,7 +40,6 @@ static int inf_probe(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver infineon_driver = {
-	.name = "infineon",
 	.probe = inf_probe,
 	.remove = ril_remove,
 	.enable = ril_enable,
@@ -51,27 +50,4 @@ static struct ofono_modem_driver infineon_driver = {
 	.set_online = ril_set_online,
 };
 
-/*
- * This plugin is a device plugin for infineon modems that use RIL interface.
- * The plugin 'rildev' is used to determine which RIL plugin should be loaded
- * based upon an environment variable.
- */
-static int inf_init(void)
-{
-	int retval = 0;
-
-	retval = ofono_modem_driver_register(&infineon_driver);
-	if (retval != 0)
-		DBG("ofono_modem_driver_register returned: %d", retval);
-
-	return retval;
-}
-
-static void inf_exit(void)
-{
-	DBG("");
-	ofono_modem_driver_unregister(&infineon_driver);
-}
-
-OFONO_PLUGIN_DEFINE(infineon, "Infineon modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, inf_init, inf_exit)
+OFONO_MODEM_DRIVER_BUILTIN(infineon, &infineon_driver)
diff --git a/plugins/isiusb.c b/plugins/isiusb.c
index c1a5d982a295..f948019d2c2d 100644
--- a/plugins/isiusb.c
+++ b/plugins/isiusb.c
@@ -449,7 +449,6 @@ static int isiusb_disable(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver driver = {
-	.name = "isiusb",
 	.probe = isiusb_probe,
 	.remove = isiusb_remove,
 	.set_online = isiusb_online,
@@ -460,16 +459,4 @@ static struct ofono_modem_driver driver = {
 	.disable = isiusb_disable,
 };
 
-static int isiusb_init(void)
-{
-	return ofono_modem_driver_register(&driver);
-}
-
-static void isiusb_exit(void)
-{
-	ofono_modem_driver_unregister(&driver);
-}
-
-OFONO_PLUGIN_DEFINE(isiusb, "Generic modem driver for isi",
-			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
-			isiusb_init, isiusb_exit)
+OFONO_MODEM_DRIVER_BUILTIN(isiusb, &driver)
diff --git a/plugins/linktop.c b/plugins/linktop.c
index 2b8acf769b43..f1f8e01f9b99 100644
--- a/plugins/linktop.c
+++ b/plugins/linktop.c
@@ -254,7 +254,6 @@ static void linktop_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver linktop_driver = {
-	.name		= "linktop",
 	.probe		= linktop_probe,
 	.remove		= linktop_remove,
 	.enable		= linktop_enable,
@@ -265,15 +264,4 @@ static struct ofono_modem_driver linktop_driver = {
 	.post_online	= linktop_post_online,
 };
 
-static int linktop_init(void)
-{
-	return ofono_modem_driver_register(&linktop_driver);
-}
-
-static void linktop_exit(void)
-{
-	ofono_modem_driver_unregister(&linktop_driver);
-}
-
-OFONO_PLUGIN_DEFINE(linktop, "Linktop Datacard modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, linktop_init, linktop_exit)
+OFONO_MODEM_DRIVER_BUILTIN(linktop, &linktop_driver)
diff --git a/plugins/mbim.c b/plugins/mbim.c
index 3e131634f518..81861fbc16f6 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -408,7 +408,6 @@ static void mbim_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver mbim_driver = {
-	.name		= "mbim",
 	.probe		= mbim_probe,
 	.remove		= mbim_remove,
 	.enable		= mbim_enable,
@@ -419,15 +418,4 @@ static struct ofono_modem_driver mbim_driver = {
 	.post_online	= mbim_post_online,
 };
 
-static int mbim_init(void)
-{
-	return ofono_modem_driver_register(&mbim_driver);
-}
-
-static void mbim_exit(void)
-{
-	ofono_modem_driver_unregister(&mbim_driver);
-}
-
-OFONO_PLUGIN_DEFINE(mbim, "MBIM modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, mbim_init, mbim_exit)
+OFONO_MODEM_DRIVER_BUILTIN(mbim, &mbim_driver)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 38297d747ecb..051e339a9a9c 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -477,7 +477,6 @@ static void mbm_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver mbm_driver = {
-	.name		= "mbm",
 	.probe		= mbm_probe,
 	.remove		= mbm_remove,
 	.enable		= mbm_enable,
@@ -488,15 +487,4 @@ static struct ofono_modem_driver mbm_driver = {
 	.post_online	= mbm_post_online,
 };
 
-static int mbm_init(void)
-{
-	return ofono_modem_driver_register(&mbm_driver);
-}
-
-static void mbm_exit(void)
-{
-	ofono_modem_driver_unregister(&mbm_driver);
-}
-
-OFONO_PLUGIN_DEFINE(mbm, "Ericsson MBM modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, mbm_init, mbm_exit)
+OFONO_MODEM_DRIVER_BUILTIN(mbm, &mbm_driver)
diff --git a/plugins/n900.c b/plugins/n900.c
index b75abc977020..058e9e9323b3 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -537,7 +537,6 @@ static int n900_disable(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver n900_driver = {
-	.name = "n900",
 	.probe = n900_probe,
 	.remove = n900_remove,
 	.enable = n900_enable,
@@ -548,15 +547,4 @@ static struct ofono_modem_driver n900_driver = {
 	.post_online = n900_post_online,
 };
 
-static int n900_init(void)
-{
-	return ofono_modem_driver_register(&n900_driver);
-}
-
-static void n900_exit(void)
-{
-	ofono_modem_driver_unregister(&n900_driver);
-}
-
-OFONO_PLUGIN_DEFINE(n900, "Nokia N900 modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, n900_init, n900_exit)
+OFONO_MODEM_DRIVER_BUILTIN(n900, &n900_driver)
diff --git a/plugins/nokia.c b/plugins/nokia.c
index 7f19ce968bdd..e554b487f1ba 100644
--- a/plugins/nokia.c
+++ b/plugins/nokia.c
@@ -236,7 +236,6 @@ static void nokia_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver nokia_driver = {
-	.name		= "nokia",
 	.probe		= nokia_probe,
 	.remove		= nokia_remove,
 	.enable		= nokia_enable,
@@ -246,15 +245,4 @@ static struct ofono_modem_driver nokia_driver = {
 	.post_online	= nokia_post_online,
 };
 
-static int nokia_init(void)
-{
-	return ofono_modem_driver_register(&nokia_driver);
-}
-
-static void nokia_exit(void)
-{
-	ofono_modem_driver_unregister(&nokia_driver);
-}
-
-OFONO_PLUGIN_DEFINE(nokia, "Nokia Datacard modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, nokia_init, nokia_exit)
+OFONO_MODEM_DRIVER_BUILTIN(nokia, &nokia_driver)
diff --git a/plugins/novatel.c b/plugins/novatel.c
index c01aa54858f7..d04209df15b8 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -328,7 +328,6 @@ static void novatel_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver novatel_driver = {
-	.name		= "novatel",
 	.probe		= novatel_probe,
 	.remove		= novatel_remove,
 	.enable		= novatel_enable,
@@ -339,15 +338,4 @@ static struct ofono_modem_driver novatel_driver = {
 	.post_online	= novatel_post_online,
 };
 
-static int novatel_init(void)
-{
-	return ofono_modem_driver_register(&novatel_driver);
-}
-
-static void novatel_exit(void)
-{
-	ofono_modem_driver_unregister(&novatel_driver);
-}
-
-OFONO_PLUGIN_DEFINE(novatel, "Novatel Wireless modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, novatel_init, novatel_exit)
+OFONO_MODEM_DRIVER_BUILTIN(novatel, &novatel_driver)
diff --git a/plugins/palmpre.c b/plugins/palmpre.c
index c495f280a646..3039b53214eb 100644
--- a/plugins/palmpre.c
+++ b/plugins/palmpre.c
@@ -211,7 +211,6 @@ static void palmpre_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver palmpre_driver = {
-	.name		= "palmpre",
 	.probe		= palmpre_probe,
 	.remove		= palmpre_remove,
 	.enable		= palmpre_enable,
@@ -220,15 +219,4 @@ static struct ofono_modem_driver palmpre_driver = {
 	.post_sim	= palmpre_post_sim
 };
 
-static int palmpre_init(void)
-{
-	return ofono_modem_driver_register(&palmpre_driver);
-}
-
-static void palmpre_exit(void)
-{
-	ofono_modem_driver_unregister(&palmpre_driver);
-}
-
-OFONO_PLUGIN_DEFINE(palmpre, "Palm Pre driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, palmpre_init, palmpre_exit)
+OFONO_MODEM_DRIVER_BUILTIN(palmpre, &palmpre_driver)
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index a4fdddc68489..07afc14d56bb 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -911,7 +911,6 @@ static void phonesim_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver phonesim_driver = {
-	.name		= "phonesim",
 	.probe		= phonesim_probe,
 	.remove		= phonesim_remove,
 	.enable		= phonesim_enable,
@@ -922,6 +921,8 @@ static struct ofono_modem_driver phonesim_driver = {
 	.post_online	= phonesim_post_online,
 };
 
+OFONO_MODEM_DRIVER_BUILTIN(phonesim, &phonesim_driver)
+
 static int localhfp_probe(struct ofono_modem *modem)
 {
 	struct hfp_slc_info *info;
@@ -1036,7 +1037,6 @@ static void localhfp_pre_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver localhfp_driver = {
-	.name		= "localhfp",
 	.probe		= localhfp_probe,
 	.remove		= localhfp_remove,
 	.enable		= localhfp_enable,
@@ -1044,6 +1044,8 @@ static struct ofono_modem_driver localhfp_driver = {
 	.pre_sim	= localhfp_pre_sim,
 };
 
+OFONO_MODEM_DRIVER_BUILTIN(localhfp, &localhfp_driver)
+
 static struct ofono_modem *create_modem(GKeyFile *keyfile, const char *group)
 {
 	const char *driver = "phonesim";
@@ -1144,15 +1146,8 @@ done:
 
 static int phonesim_init(void)
 {
-	int err;
 	char *conf_override = getenv("OFONO_PHONESIM_CONFIG");
 
-	err = ofono_modem_driver_register(&phonesim_driver);
-	if (err < 0)
-		return err;
-
-	ofono_modem_driver_register(&localhfp_driver);
-
 	if (conf_override)
 		parse_config(conf_override);
 	else
@@ -1173,8 +1168,6 @@ static void phonesim_exit(void)
 
 	g_slist_free(modem_list);
 	modem_list = NULL;
-
-	ofono_modem_driver_unregister(&phonesim_driver);
 }
 
 OFONO_PLUGIN_DEFINE(phonesim, "Phone Simulator driver", VERSION,
diff --git a/plugins/quectel.c b/plugins/quectel.c
index 1dd67e802525..69e1ff48729d 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -1386,7 +1386,6 @@ static void quectel_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver quectel_driver = {
-	.name			= "quectel",
 	.probe			= quectel_probe,
 	.remove			= quectel_remove,
 	.enable			= quectel_enable,
@@ -1397,15 +1396,4 @@ static struct ofono_modem_driver quectel_driver = {
 	.post_online		= quectel_post_online,
 };
 
-static int quectel_init(void)
-{
-	return ofono_modem_driver_register(&quectel_driver);
-}
-
-static void quectel_exit(void)
-{
-	ofono_modem_driver_unregister(&quectel_driver);
-}
-
-OFONO_PLUGIN_DEFINE(quectel, "Quectel driver", VERSION,
-    OFONO_PLUGIN_PRIORITY_DEFAULT, quectel_init, quectel_exit)
+OFONO_MODEM_DRIVER_BUILTIN(quectel, &quectel_driver)
diff --git a/plugins/ril.c b/plugins/ril.c
index edc5f09a2c53..885f4a1b8970 100644
--- a/plugins/ril.c
+++ b/plugins/ril.c
@@ -439,7 +439,6 @@ int ril_disable(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver ril_driver = {
-	.name = "ril",
 	.probe = ril_probe,
 	.remove = ril_remove,
 	.enable = ril_enable,
@@ -450,26 +449,4 @@ static struct ofono_modem_driver ril_driver = {
 	.set_online = ril_set_online,
 };
 
-/*
- * This plugin is a generic ( aka default ) device plugin for RIL-based devices.
- * The plugin 'rildev' is used to determine which RIL plugin should be loaded
- * based upon an environment variable.
- */
-static int ril_init(void)
-{
-	int retval = ofono_modem_driver_register(&ril_driver);
-
-	if (retval != 0)
-		DBG("ofono_modem_driver_register returned: %d", retval);
-
-	return retval;
-}
-
-static void ril_exit(void)
-{
-	DBG("");
-	ofono_modem_driver_unregister(&ril_driver);
-}
-
-OFONO_PLUGIN_DEFINE(ril, "RIL modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, ril_init, ril_exit)
+OFONO_MODEM_DRIVER_BUILTIN(ril, &ril_driver)
diff --git a/plugins/ril_intel.c b/plugins/ril_intel.c
index 86c9e00bb57a..44110652b1fa 100644
--- a/plugins/ril_intel.c
+++ b/plugins/ril_intel.c
@@ -599,7 +599,6 @@ static int ril_disable(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver ril_driver = {
-	.name = "ril_intel",
 	.probe = ril_probe,
 	.remove = ril_remove,
 	.enable = ril_enable,
@@ -610,15 +609,4 @@ static struct ofono_modem_driver ril_driver = {
 	.set_online = ril_set_online,
 };
 
-static int ril_init(void)
-{
-	return ofono_modem_driver_register(&ril_driver);
-}
-
-static void ril_exit(void)
-{
-	ofono_modem_driver_unregister(&ril_driver);
-}
-
-OFONO_PLUGIN_DEFINE(ril_intel, "Intel RIL-based modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, ril_init, ril_exit)
+OFONO_MODEM_DRIVER_BUILTIN(ril_intel, &ril_driver)
diff --git a/plugins/samsung.c b/plugins/samsung.c
index 1780943be941..a52ad3e60ba0 100644
--- a/plugins/samsung.c
+++ b/plugins/samsung.c
@@ -234,7 +234,6 @@ static void samsung_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver samsung_driver = {
-	.name		= "samsung",
 	.probe		= samsung_probe,
 	.remove		= samsung_remove,
 	.enable		= samsung_enable,
@@ -244,15 +243,4 @@ static struct ofono_modem_driver samsung_driver = {
 	.post_online	= samsung_post_online,
 };
 
-static int samsung_init(void)
-{
-	return ofono_modem_driver_register(&samsung_driver);
-}
-
-static void samsung_exit(void)
-{
-	ofono_modem_driver_unregister(&samsung_driver);
-}
-
-OFONO_PLUGIN_DEFINE(samsung, "Samsung modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, samsung_init, samsung_exit)
+OFONO_MODEM_DRIVER_BUILTIN(samsung, &samsung_driver)
diff --git a/plugins/sierra.c b/plugins/sierra.c
index 0cc1f3a7d33f..3c3c3dd09e62 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -250,7 +250,6 @@ static void sierra_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver sierra_driver = {
-	.name		= "sierra",
 	.probe		= sierra_probe,
 	.remove		= sierra_remove,
 	.enable		= sierra_enable,
@@ -261,15 +260,4 @@ static struct ofono_modem_driver sierra_driver = {
 	.post_online	= sierra_post_online,
 };
 
-static int sierra_init(void)
-{
-	return ofono_modem_driver_register(&sierra_driver);
-}
-
-static void sierra_exit(void)
-{
-	ofono_modem_driver_unregister(&sierra_driver);
-}
-
-OFONO_PLUGIN_DEFINE(sierra, "Sierra Wireless modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, sierra_init, sierra_exit)
+OFONO_MODEM_DRIVER_BUILTIN(sierra, &sierra_driver)
diff --git a/plugins/sim7100.c b/plugins/sim7100.c
index 7c7e46d123c3..c461cc3277c1 100644
--- a/plugins/sim7100.c
+++ b/plugins/sim7100.c
@@ -250,7 +250,6 @@ static void sim7100_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver sim7100_driver = {
-	.name		= "sim7100",
 	.probe		= sim7100_probe,
 	.remove		= sim7100_remove,
 	.enable		= sim7100_enable,
@@ -259,15 +258,4 @@ static struct ofono_modem_driver sim7100_driver = {
 	.post_sim	= sim7100_post_sim,
 };
 
-static int sim7100_init(void)
-{
-	return ofono_modem_driver_register(&sim7100_driver);
-}
-
-static void sim7100_exit(void)
-{
-	ofono_modem_driver_unregister(&sim7100_driver);
-}
-
-OFONO_PLUGIN_DEFINE(sim7100, "SIMCom SIM7100E modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, sim7100_init, sim7100_exit)
+OFONO_MODEM_DRIVER_BUILTIN(sim7100, &sim7100_driver)
diff --git a/plugins/sim900.c b/plugins/sim900.c
index 256483eadeb2..14455847ad48 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -451,7 +451,6 @@ static void sim900_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver sim900_driver = {
-	.name		= "sim900",
 	.probe		= sim900_probe,
 	.remove		= sim900_remove,
 	.enable		= sim900_enable,
@@ -461,15 +460,4 @@ static struct ofono_modem_driver sim900_driver = {
 	.post_online	= sim900_post_online,
 };
 
-static int sim900_init(void)
-{
-	return ofono_modem_driver_register(&sim900_driver);
-}
-
-static void sim900_exit(void)
-{
-	ofono_modem_driver_unregister(&sim900_driver);
-}
-
-OFONO_PLUGIN_DEFINE(sim900, "SIM900 modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, sim900_init, sim900_exit)
+OFONO_MODEM_DRIVER_BUILTIN(sim900, &sim900_driver)
diff --git a/plugins/speedup.c b/plugins/speedup.c
index 0b5d22892f4d..6bbbae061156 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -372,7 +372,6 @@ static void speedup_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver speedup_driver = {
-	.name		= "speedup",
 	.probe		= speedup_probe,
 	.remove		= speedup_remove,
 	.enable		= speedup_enable,
@@ -383,15 +382,4 @@ static struct ofono_modem_driver speedup_driver = {
 	.post_online	= speedup_post_online,
 };
 
-static int speedup_init(void)
-{
-	return ofono_modem_driver_register(&speedup_driver);
-}
-
-static void speedup_exit(void)
-{
-	ofono_modem_driver_unregister(&speedup_driver);
-}
-
-OFONO_PLUGIN_DEFINE(speedup, "Speed Up modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, speedup_init, speedup_exit)
+OFONO_MODEM_DRIVER_BUILTIN(speedup, &speedup_driver)
diff --git a/plugins/ste.c b/plugins/ste.c
index 92669294e394..fd850d8a4d6d 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -507,7 +507,6 @@ static void ste_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver ste_driver = {
-	.name		= "ste",
 	.probe		= ste_probe,
 	.remove		= ste_remove,
 	.enable		= ste_enable,
@@ -518,15 +517,4 @@ static struct ofono_modem_driver ste_driver = {
 	.post_online	= ste_post_online,
 };
 
-static int ste_init(void)
-{
-	return ofono_modem_driver_register(&ste_driver);
-}
-
-static void ste_exit(void)
-{
-	ofono_modem_driver_unregister(&ste_driver);
-}
-
-OFONO_PLUGIN_DEFINE(ste, "ST-Ericsson modem driver", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, ste_init, ste_exit)
+OFONO_MODEM_DRIVER_BUILTIN(ste, &ste_driver)
diff --git a/plugins/stktest.c b/plugins/stktest.c
index c8cc9fbd8063..cddb39d8e743 100644
--- a/plugins/stktest.c
+++ b/plugins/stktest.c
@@ -219,7 +219,6 @@ static void stktest_post_online(struct ofono_modem *modem)
 
 static struct ofono_modem_driver stktest_driver = {
 	.modem_type	= OFONO_MODEM_TYPE_TEST,
-	.name		= "stktest",
 	.probe		= stktest_probe,
 	.remove		= stktest_remove,
 	.enable		= stktest_enable,
@@ -230,14 +229,10 @@ static struct ofono_modem_driver stktest_driver = {
 	.post_online	= stktest_post_online,
 };
 
+OFONO_MODEM_DRIVER_BUILTIN(stktest, &stktest_driver)
+
 static int stktest_init(void)
 {
-	int err;
-
-	err = ofono_modem_driver_register(&stktest_driver);
-	if (err < 0)
-		return err;
-
 	stktest = ofono_modem_create("stktest", "stktest");
 	ofono_modem_register(stktest);
 
@@ -247,7 +242,6 @@ static int stktest_init(void)
 static void stktest_exit(void)
 {
 	ofono_modem_remove(stktest);
-	ofono_modem_driver_unregister(&stktest_driver);
 }
 
 OFONO_PLUGIN_DEFINE(stktest, "STK End-to-End tester driver", VERSION,
diff --git a/plugins/telit.c b/plugins/telit.c
index 094d762f09b7..0c4c59103a0a 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -508,7 +508,6 @@ static void telit_remove(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver telit_driver = {
-	.name		= "telit",
 	.probe		= telit_probe,
 	.remove		= telit_remove,
 	.enable		= telit_enable,
@@ -517,17 +516,4 @@ static struct ofono_modem_driver telit_driver = {
 	.post_online	= telit_post_online,
 };
 
-static int telit_init(void)
-{
-	DBG("");
-
-	return ofono_modem_driver_register(&telit_driver);
-}
-
-static void telit_exit(void)
-{
-	ofono_modem_driver_unregister(&telit_driver);
-}
-
-OFONO_PLUGIN_DEFINE(telit, "Telit driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, telit_init, telit_exit)
+OFONO_MODEM_DRIVER_BUILTIN(telit, &telit_driver)
diff --git a/plugins/u8500.c b/plugins/u8500.c
index 044b76ffcf2a..bba51ed90bfb 100644
--- a/plugins/u8500.c
+++ b/plugins/u8500.c
@@ -659,7 +659,6 @@ static void u8500_devinfo_remove(struct ofono_devinfo *info)
 }
 
 static struct ofono_modem_driver driver = {
-	.name = "u8500",
 	.probe = u8500_probe,
 	.remove = u8500_remove,
 	.set_online = u8500_online,
@@ -680,17 +679,4 @@ static struct ofono_devinfo_driver devinfo_driver = {
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(devinfo, u8500, &devinfo_driver)
-
-static int u8500_init(void)
-{
-	return ofono_modem_driver_register(&driver);
-}
-
-static void u8500_exit(void)
-{
-	ofono_modem_driver_unregister(&driver);
-}
-
-OFONO_PLUGIN_DEFINE(u8500, "ST-Ericsson U8500 modem driver",
-			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
-			u8500_init, u8500_exit)
+OFONO_MODEM_DRIVER_BUILTIN(u8500, &driver)
diff --git a/plugins/ublox.c b/plugins/ublox.c
index efcd40cfffd4..c5661ab6b1ad 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -490,7 +490,6 @@ static void ublox_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver ublox_driver = {
-	.name		= "ublox",
 	.probe		= ublox_probe,
 	.remove		= ublox_remove,
 	.enable		= ublox_enable,
@@ -501,15 +500,4 @@ static struct ofono_modem_driver ublox_driver = {
 	.post_online	= ublox_post_online,
 };
 
-static int ublox_init(void)
-{
-	return ofono_modem_driver_register(&ublox_driver);
-}
-
-static void ublox_exit(void)
-{
-	ofono_modem_driver_unregister(&ublox_driver);
-}
-
-OFONO_PLUGIN_DEFINE(ublox, "u-blox modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, ublox_init, ublox_exit)
+OFONO_MODEM_DRIVER_BUILTIN(ublox, &ublox_driver)
diff --git a/plugins/wavecom.c b/plugins/wavecom.c
index 03830bf511fe..1f1de8eb96e4 100644
--- a/plugins/wavecom.c
+++ b/plugins/wavecom.c
@@ -151,7 +151,6 @@ static void wavecom_post_sim(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver wavecom_driver = {
-	.name		= "wavecom",
 	.probe		= wavecom_probe,
 	.remove		= wavecom_remove,
 	.enable		= wavecom_enable,
@@ -160,15 +159,4 @@ static struct ofono_modem_driver wavecom_driver = {
 	.post_sim	= wavecom_post_sim,
 };
 
-static int wavecom_init(void)
-{
-	return ofono_modem_driver_register(&wavecom_driver);
-}
-
-static void wavecom_exit(void)
-{
-	ofono_modem_driver_unregister(&wavecom_driver);
-}
-
-OFONO_PLUGIN_DEFINE(wavecom, "Wavecom driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_init, wavecom_exit)
+OFONO_MODEM_DRIVER_BUILTIN(wavecom, &wavecom_driver)
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index b31572c5d17f..871c964c03b8 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1701,7 +1701,6 @@ static void xmm7xxx_remove(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver xmm7xxx_driver = {
-	.name		= "xmm7xxx",
 	.probe		= xmm7xxx_probe,
 	.remove		= xmm7xxx_remove,
 	.enable		= xmm7xxx_enable,
@@ -1712,17 +1711,4 @@ static struct ofono_modem_driver xmm7xxx_driver = {
 	.post_online	= xmm7xxx_post_online,
 };
 
-static int xmm7xxx_init(void)
-{
-	DBG("");
-
-	return ofono_modem_driver_register(&xmm7xxx_driver);
-}
-
-static void xmm7xxx_exit(void)
-{
-	ofono_modem_driver_unregister(&xmm7xxx_driver);
-}
-
-OFONO_PLUGIN_DEFINE(xmm7xxx, "Intel XMM7xxx driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, xmm7xxx_init, xmm7xxx_exit)
+OFONO_MODEM_DRIVER_BUILTIN(xmm7xxx, &xmm7xxx_driver)
diff --git a/plugins/zte.c b/plugins/zte.c
index b6093af97653..7e12f0747958 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -345,7 +345,6 @@ static void zte_post_online(struct ofono_modem *modem)
 }
 
 static struct ofono_modem_driver zte_driver = {
-	.name		= "zte",
 	.probe		= zte_probe,
 	.remove		= zte_remove,
 	.enable		= zte_enable,
@@ -356,15 +355,4 @@ static struct ofono_modem_driver zte_driver = {
 	.post_online	= zte_post_online,
 };
 
-static int zte_init(void)
-{
-	return ofono_modem_driver_register(&zte_driver);
-}
-
-static void zte_exit(void)
-{
-	ofono_modem_driver_unregister(&zte_driver);
-}
-
-OFONO_PLUGIN_DEFINE(zte, "ZTE modem driver", VERSION,
-		OFONO_PLUGIN_PRIORITY_DEFAULT, zte_init, zte_exit)
+OFONO_MODEM_DRIVER_BUILTIN(zte, &zte_driver)
diff --git a/src/modem.c b/src/modem.c
index 354d2b8606d3..c139fd1e1b53 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -36,7 +36,6 @@
 
 #define DEFAULT_POWERED_TIMEOUT (20)
 
-static GSList *g_driver_list;
 static GSList *g_modem_list;
 
 static int next_modem_id;
@@ -456,11 +455,11 @@ static void flush_atoms(struct ofono_modem *modem, enum modem_state new_state)
 	}
 }
 
-const void *__ofono_atom_driver_builtin_find(const char *name,
-				const struct ofono_atom_driver_desc *start,
-				const struct ofono_atom_driver_desc *stop)
+const void *__ofono_driver_builtin_find(const char *name,
+				const struct ofono_driver_desc *start,
+				const struct ofono_driver_desc *stop)
 {
-	const struct ofono_atom_driver_desc *desc;
+	const struct ofono_driver_desc *desc;
 
 	if (!name)
 		return NULL;
@@ -2007,10 +2006,14 @@ ofono_bool_t ofono_modem_is_registered(struct ofono_modem *modem)
 	return TRUE;
 }
 
+extern struct ofono_driver_desc __start___modem[];
+extern struct ofono_driver_desc __stop___modem[];
+
 int ofono_modem_register(struct ofono_modem *modem)
 {
+	const struct ofono_modem_driver *drv;
 	DBusConnection *conn = ofono_dbus_get_connection();
-	GSList *l;
+	int r;
 
 	DBG("%p", modem);
 
@@ -2023,21 +2026,17 @@ int ofono_modem_register(struct ofono_modem *modem)
 	if (modem->driver != NULL)
 		return -EALREADY;
 
-	for (l = g_driver_list; l; l = l->next) {
-		const struct ofono_modem_driver *drv = l->data;
+	drv = __ofono_driver_builtin_find(modem->driver_type,
+						__start___modem,
+						__stop___modem);
+	if (!drv || !drv->probe)
+		return -ENODEV;
 
-		if (g_strcmp0(drv->name, modem->driver_type))
-			continue;
+	r = drv->probe(modem);
+	if (r < 0)
+		return r;
 
-		if (drv->probe(modem) < 0)
-			continue;
-
-		modem->driver = drv;
-		break;
-	}
-
-	if (modem->driver == NULL)
-		return -ENODEV;
+	modem->driver = drv;
 
 	if (!g_dbus_register_interface(conn, modem->path,
 					OFONO_MODEM_INTERFACE,
@@ -2198,37 +2197,6 @@ void __ofono_modem_sim_reset(struct ofono_modem *modem)
 	modem_change_state(modem, MODEM_STATE_PRE_SIM);
 }
 
-int ofono_modem_driver_register(const struct ofono_modem_driver *d)
-{
-	DBG("driver: %p, name: %s", d, d->name);
-
-	if (d->probe == NULL)
-		return -EINVAL;
-
-	g_driver_list = g_slist_prepend(g_driver_list, (void *) d);
-
-	return 0;
-}
-
-void ofono_modem_driver_unregister(const struct ofono_modem_driver *d)
-{
-	GSList *l;
-	struct ofono_modem *modem;
-
-	DBG("driver: %p, name: %s", d, d->name);
-
-	g_driver_list = g_slist_remove(g_driver_list, (void *) d);
-
-	for (l = g_modem_list; l; l = l->next) {
-		modem = l->data;
-
-		if (modem->driver != d)
-			continue;
-
-		modem_unregister(modem);
-	}
-}
-
 void __ofono_modem_shutdown(void)
 {
 	struct ofono_modem *modem;
diff --git a/src/ofono.h b/src/ofono.h
index a243d3fb66c6..294e90a37c23 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -233,13 +233,13 @@ gboolean __ofono_modem_remove_atom_watch(struct ofono_modem *modem,
 
 void __ofono_atom_free(struct ofono_atom *atom);
 
-const void *__ofono_atom_driver_builtin_find(const char *name,
-				const struct ofono_atom_driver_desc *start,
-				const struct ofono_atom_driver_desc *stop);
+const void *__ofono_driver_builtin_find(const char *name,
+				const struct ofono_driver_desc *start,
+				const struct ofono_driver_desc *stop);
 
 #define OFONO_DEFINE_ATOM_CREATE(type, atom_type, ...)			\
-extern struct ofono_atom_driver_desc __start___ ## type[];		\
-extern struct ofono_atom_driver_desc __stop___ ## type[];		\
+extern struct ofono_driver_desc __start___ ## type[];			\
+extern struct ofono_driver_desc __stop___ ## type[];			\
 									\
 struct ofono_ ## type *ofono_ ## type ##_create(			\
 				struct ofono_modem *modem,		\
@@ -247,7 +247,7 @@ struct ofono_ ## type *ofono_ ## type ##_create(			\
 				void *data)				\
 {									\
 	const struct ofono_ ## type ## _driver *drv =			\
-		__ofono_atom_driver_builtin_find(driver,		\
+		__ofono_driver_builtin_find(driver,			\
 				__start___ ## type,			\
 				__stop___ ## type);			\
 	struct ofono_ ## type *atom;					\
diff --git a/unit/test-rilmodem-cb.c b/unit/test-rilmodem-cb.c
index 80fa3da11a6e..18951f37ea58 100644
--- a/unit/test-rilmodem-cb.c
+++ b/unit/test-rilmodem-cb.c
@@ -416,7 +416,7 @@ struct ofono_call_barring {
 	const struct cb_data *cbd;
 };
 
-extern struct ofono_atom_driver_desc __start___call_barring[];
+extern struct ofono_driver_desc __start___call_barring[];
 
 struct ofono_call_barring *ofono_call_barring_create(struct ofono_modem *modem,
 							unsigned int vendor,
diff --git a/unit/test-rilmodem-cs.c b/unit/test-rilmodem-cs.c
index 9eb9546d2589..723f554442dd 100644
--- a/unit/test-rilmodem-cs.c
+++ b/unit/test-rilmodem-cs.c
@@ -392,7 +392,7 @@ struct ofono_call_settings {
 	void *driver_data;
 };
 
-extern struct ofono_atom_driver_desc __start___call_settings[];
+extern struct ofono_driver_desc __start___call_settings[];
 
 struct ofono_call_settings *ofono_call_settings_create(struct ofono_modem *modem,
 							unsigned int vendor,
diff --git a/unit/test-rilmodem-gprs.c b/unit/test-rilmodem-gprs.c
index cc5c0bfb1fe6..78ef3fbe1c31 100644
--- a/unit/test-rilmodem-gprs.c
+++ b/unit/test-rilmodem-gprs.c
@@ -653,7 +653,7 @@ struct rilmodem_test_data test_5 = {
 	.num_steps = G_N_ELEMENTS(steps_test_5)
 };
 
-extern struct ofono_atom_driver_desc __start___gprs[];
+extern struct ofono_driver_desc __start___gprs[];
 
 static void server_connect_cb(gpointer data)
 {
diff --git a/unit/test-rilmodem-sms.c b/unit/test-rilmodem-sms.c
index fd18b8792ed2..51831046582c 100644
--- a/unit/test-rilmodem-sms.c
+++ b/unit/test-rilmodem-sms.c
@@ -423,7 +423,7 @@ struct ofono_sms {
 	const struct sms_data *sd;
 };
 
-extern struct ofono_atom_driver_desc __start___sms[];
+extern struct ofono_driver_desc __start___sms[];
 
 struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
 					unsigned int vendor,
-- 
2.43.0

