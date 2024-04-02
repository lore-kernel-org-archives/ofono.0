Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FE1D6AE
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097068; cv=none; b=rOpHc1ZeR/DQqsNbWVJxmHamfoPPfecY+QvP/iIodecaR+p3cbSuijW38MmtGjLHInp1WDNgXPN7L6Vs3zenRjX1m+muNluNy4H+D9T1h2Z38JMiUPFLP4vES3WQSLbHX0DW72+RCDOIq31BPpebkBOYNsuxFkw++4KZq90hT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097068; c=relaxed/simple;
	bh=MkfkVZSWEBmQ2nREg/cLfaKsLACZ1XgFoqNqqRD6lN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWA5ZhHnz5knyWwwxEEzLXVeR4SshrUymZzItAbbjUjbi5NJGFoAZT/rhr3yEbcM64bDvlfZLQRb/RxcZCcd7lVFrSgiFf2qSN5uPk9hY3gEljZYSahoteWGFZ8MwJCpD7PloTHnbQ9TjTMsv9KYBjr6cDw5PrkgCw9BMchunwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVTt9DZ1; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVTt9DZ1"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a492093073so178847eaf.0
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097065; x=1712701865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vol3mTWKS+Qu0Kx+jxxrbOYp82878IwpfnUQzmwos6Q=;
        b=ZVTt9DZ14wgS1ZJ7KfXY47UKBU53q81jU1gRq7eLvj1rAgdt2dnIZGA1tuqcPB1mWt
         st8QIlP6PL9NHhozCcYGtFou8W0LFBfZv1EFAgx5p0Te9EvjZGT0XadKwmciv4rqMl4Z
         EPTdbHnpL5vDkh8lVL3+m/G/gaWjRR0FEjrdUzt0iWSlgdFdplu+qTLjIIF1ga5IkvhR
         GgHKLxebseoCMO+uRKh7w8CySIyWsLYm9yYhbxReHgPMe5jEFfGrV/ZIAoQKFmB9fXiG
         yZx9mWXQ8eA3l/3p4Le6Q4DGIOZ1GuyL8y8MsNG8OInY2pyCL5gYur0b4Vw0+CD7EWl2
         jcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097065; x=1712701865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vol3mTWKS+Qu0Kx+jxxrbOYp82878IwpfnUQzmwos6Q=;
        b=WE2U6GfNpXMhcBM1RJlBSQrwhv5L7kqyEYN05D+7uNCMEzk/++tilBM0hKlwt3Ce5V
         hM+HUWk8DuIdu4NyTmA6iM83Intwp9ohwiNgp6Xns4GnjO9eWXkveLXnuOaTKpU7OqkX
         Ag5/VOrW80W1tzj/ErAGoBLO91aGPo8G19jPEI6tG9GmUOisk//iJqbHl5sYmXfzXkOZ
         lp4/BWi7OGBE28DqBQcD1A2TQHfaCMg98K8XhDX76j6V4wJpixs5QzE2YtLEwUb96eaD
         YpGZHeNLYVuQ9JHwo9rNEW5zZYIq+kGoqZaggZ5D6nppLOMUwRG6yRnqrFrd+8BjOR6b
         cWNQ==
X-Gm-Message-State: AOJu0YyV76tdbjWK0UDV8K96c7fPLKV30VeaWcRt7/ypWb+RyXbrwc8K
	0WcHVZgGvlSzgsupU9cobRkVrOiadX/aK06YVCWaYOt9JaY8JWxq7PvAXu7n
X-Google-Smtp-Source: AGHT+IF60rQgKJ3cLxza4YQZ7RLwda8EAANoekGNt801OM1vp8BGqgJ6Q1YNwChmu3tcMVrn8JAxTQ==
X-Received: by 2002:a05:6820:2993:b0:5a4:9b0f:3652 with SMTP id dq19-20020a056820299300b005a49b0f3652mr298749oob.3.1712097065445;
        Tue, 02 Apr 2024 15:31:05 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:05 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 13/13] examples: Fix use after free and resource leaks
Date: Tue,  2 Apr 2024 17:30:38 -0500
Message-ID: <20240402223054.2819526-13-denkenz@gmail.com>
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

The emulator example plugin does not track modem powered watches, and
thus leaks them.  Additionally, the plugin opens ports for both HFP and
DUN emulators.  However, only a single server watch is tracked, leading
to the other watch being leaked.

Since the modem powered watches are not tracked, they are never
unregistered.  This can lead to situations where emulator plugin is
destroyed (and thus all data associated with it is freed) before all
modems have been removed.  When modems are removed subsequently,
registered powered watches will be invoked.  This will result in
use-after-free errors being reported by valgrind.
---
 examples/emulator.c | 151 +++++++++++++++++++++++++++++++-------------
 1 file changed, 108 insertions(+), 43 deletions(-)

diff --git a/examples/emulator.c b/examples/emulator.c
index 5c92bd6659c4..972c1acfc0e3 100644
--- a/examples/emulator.c
+++ b/examples/emulator.c
@@ -44,8 +44,48 @@
 #define HFP_PORT 12347
 
 static unsigned int modemwatch_id;
-guint server_watch;
-static GList *modems;
+static guint dun_watch;
+static guint hfp_watch;
+static struct l_queue *modem_infos;
+static unsigned int n_powered;
+
+struct modem_info {
+       struct ofono_modem *modem;
+       unsigned int watch_id;
+};
+
+static bool modem_matches(const void *data, const void *user_data)
+{
+	const struct modem_info *info = data;
+
+	return info->modem == user_data;
+}
+
+static void modem_info_free(struct modem_info *info)
+{
+	if (!info)
+		return;
+
+	if (info->watch_id)
+		__ofono_modem_remove_powered_watch(info->modem, info->watch_id);
+
+	l_free(info);
+}
+
+static struct ofono_modem *find_first_powered(void)
+{
+	const struct l_queue_entry *entry;
+
+	for (entry = l_queue_get_entries(modem_infos); entry;
+							entry = entry->next) {
+		struct ofono_modem *modem = entry->data;
+
+		if (ofono_modem_get_powered(modem))
+			return modem;
+	}
+
+	return NULL;
+}
 
 static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
 							gpointer user)
@@ -64,28 +104,35 @@ static gboolean on_socket_connected(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	/* Pick the first powered modem */
-	modem = modems->data;
+	modem = find_first_powered();
+	if (!modem)
+		goto error;
+
 	DBG("Picked modem %p for emulator", modem);
 
 	em = ofono_emulator_create(modem, GPOINTER_TO_INT(user));
-	if (em == NULL)
-		close(fd);
-	else
-		ofono_emulator_register(em, fd);
+	if (!em)
+		goto error;
 
+	ofono_emulator_register(em, fd);
+	return TRUE;
+
+error:
+	close(fd);
 	return TRUE;
 }
 
-static gboolean create_tcp(short port, enum ofono_emulator_type type)
+static guint create_tcp(short port, enum ofono_emulator_type type)
 {
 	struct sockaddr_in addr;
 	int sk;
 	int reuseaddr = 1;
 	GIOChannel *server;
+	guint server_watch;
 
 	sk = socket(PF_INET, SOCK_STREAM, 0);
 	if (sk < 0)
-		return FALSE;
+		return 0;
 
 	memset(&addr, 0, sizeof(addr));
 
@@ -108,62 +155,77 @@ static gboolean create_tcp(short port, enum ofono_emulator_type type)
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				on_socket_connected, GINT_TO_POINTER(type),
 				NULL);
-
 	g_io_channel_unref(server);
 
 	DBG("Created server_watch: %u", server_watch);
-
-	return TRUE;
+	return server_watch;
 
 err:
 	close(sk);
-	return FALSE;
+	return 0;
+}
+
+static void powered_watch_destroy(void *user)
+{
+	struct modem_info *info = user;
+
+	DBG("");
+
+	info->watch_id = 0;
 }
 
 static void powered_watch(struct ofono_modem *modem, gboolean powered,
 				void *user)
 {
+	DBG("powered: %d", powered);
+
 	if (powered == FALSE) {
-		DBG("Removing modem %p from the list", modem);
-		modems = g_list_remove(modems, modem);
-
-		if (modems == NULL && server_watch > 0) {
-			DBG("Removing server watch: %u", server_watch);
-			g_source_remove(server_watch);
-			server_watch = 0;
-		}
-	} else {
-		DBG("Adding modem %p to the list", modem);
-		modems = g_list_append(modems, modem);
-
-		if (modems->next == NULL) {
-			create_tcp(DUN_PORT, OFONO_EMULATOR_TYPE_DUN);
-			create_tcp(HFP_PORT, OFONO_EMULATOR_TYPE_HFP);
-		}
+		n_powered -= 1;
+
+		if (n_powered)
+			return;
+
+		g_source_remove(dun_watch);
+		dun_watch = 0;
+
+		g_source_remove(hfp_watch);
+		hfp_watch = 0;
+
+		return;
 	}
+
+	n_powered += 1;
+
+	if (!dun_watch)
+		dun_watch = create_tcp(DUN_PORT, OFONO_EMULATOR_TYPE_DUN);
+
+	if (!hfp_watch)
+		hfp_watch = create_tcp(HFP_PORT, OFONO_EMULATOR_TYPE_HFP);
 }
 
 static void modem_watch(struct ofono_modem *modem, gboolean added, void *user)
 {
+	struct modem_info *info;
+
 	DBG("modem: %p, added: %d", modem, added);
 
 	if (added == FALSE) {
-		DBG("Removing modem %p from the list", modem);
-		modems = g_list_remove(modems, modem);
+		info = l_queue_remove_if(modem_infos, modem_matches, modem);
+		DBG("Removing modem %p, info %p, from the list", modem, info);
+		modem_info_free(info);
 		return;
 	}
 
-	if (ofono_modem_get_powered(modem) == TRUE) {
-		DBG("Adding modem %p to the list", modem);
-		modems = g_list_append(modems, modem);
+	info = l_new(struct modem_info, 1);
+	info->modem = modem;
+	info->watch_id = __ofono_modem_add_powered_watch(modem, powered_watch,
+							info,
+							powered_watch_destroy);
 
-		if (modems->next == NULL) {
-			create_tcp(DUN_PORT, OFONO_EMULATOR_TYPE_DUN);
-			create_tcp(HFP_PORT, OFONO_EMULATOR_TYPE_HFP);
-		}
-	}
+	l_queue_push_tail(modem_infos, info);
 
-	__ofono_modem_add_powered_watch(modem, powered_watch, NULL, NULL);
+	if (ofono_modem_get_powered(modem) == TRUE)
+		powered_watch(modem, TRUE, NULL);
 }
 
 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -175,6 +237,7 @@ static int example_emulator_init(void)
 {
 	DBG("");
 
+	modem_infos = l_queue_new();
 	modemwatch_id = __ofono_modemwatch_add(modem_watch, NULL, NULL);
 
 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -187,11 +250,13 @@ static void example_emulator_exit(void)
 	DBG("");
 
 	__ofono_modemwatch_remove(modemwatch_id);
+	l_queue_destroy(modem_infos, (l_queue_destroy_func_t) modem_info_free);
 
-	g_list_free(modems);
+	if (dun_watch)
+		g_source_remove(dun_watch);
 
-	if (server_watch)
-		g_source_remove(server_watch);
+	if (hfp_watch)
+		g_source_remove(hfp_watch);
 }
 
 OFONO_PLUGIN_DEFINE(example_emulator, "Example AT Modem Emulator Plugin",
-- 
2.43.0

