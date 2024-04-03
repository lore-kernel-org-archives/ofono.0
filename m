Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823714C58F
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160370; cv=none; b=EKEJ2iBXFyle1nIL5rygh/Un1k36X2m9mJszzpfP/i/kAvkDsVuBf/R4LkoFrB/pWdGMPQtmaoG/pObi6PpHttIa8FTKp2nbKo7e50Bzc4dTMYlGiiGM0q1ibHFkSY6YlzAhvs+R2d5994o2982tUU7ufKUaQtapX7pOgzdXwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160370; c=relaxed/simple;
	bh=085LurbDsqYJZoVhOWwzdvbDxgGMMCSO99X/YXkJfm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF2lCbJbLei0EuD0si/AST9KBMrx179AiEIv4UV/66AedqOccJ/r1vSKsVWLVpMs54LP6tezCPC5GQvN3lWh9o95yNZKUT4256xcFPQbKX28TBsia6dCDOIVdgsjyH7je8fncvOf5Dj8tnEQYdVv81PMW3oypD4MROkkRNRIxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN5jIN6P; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN5jIN6P"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e6db4dfd7aso4742754a34.2
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160368; x=1712765168; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3W8hK2fzJFap+B9VWDMcag62JPy0hq4rvzBgjbA9Y4=;
        b=aN5jIN6PH67PkM+BfYRmQxSD3NEBkzBRxRfnvExgbIENYKE2zvRB+CmofWDZORGPFQ
         HrME5YK6wK89OvovlnwpzqAeWLXnj3spmrxQjMpNeyCzBIlUIxuXGZQvXw3EXixTIDiI
         flXGPhzCxLQac2bM0UUNVq0fShyv2KBkG1kJ72dSs5cxFJjNN0Spys6v/Oyb5PSIYMEB
         S99CNNVaZgX2AFGXwgURSfkz2GeCh2ERn+p4fq2/VNrZgYzZg1zknfFifY5BB6vhMCPx
         R1zrzSrKb8Vm/eqXciSBER/CtV6NbDbbGgIFBiR9ilVCI8XgXFXKhP7Du3VuE9JnWPnF
         LRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160368; x=1712765168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3W8hK2fzJFap+B9VWDMcag62JPy0hq4rvzBgjbA9Y4=;
        b=f2cTMfQWRHtbfjc5pDZRevXZQWoOjeT39bXfGo+lXkRPueqGS/OxrtirfDnDC6FDCE
         N50V7o/e6+rKCeaIUClwxG/W6ZohzEUjUsBhEnGX6ntsT5Auj+IpBEptX4EBY0m9pzZB
         KWd6h4uR/TS9Wzpziaoz97kseEMcozDWEPRfAjLrkgV8q8KyZAE4cJWL9sB3CHnFjDnV
         rAp5CUZRLzuuSv0OCmk56v/T5u703EPOL0EDICiPJmcQ9nvYiGocME/F9nUy3v/d3Zqz
         LTsUuWJ4t4AAO34N0saHz8g35LK7WMW/Ogce/RL5zpgX5L8TxoTmIEAV1YaFgYYlBvHr
         5xYA==
X-Gm-Message-State: AOJu0Ywtw1gXzHF60Bj8UymzES+iHmQu8uX4eKbChPbqb3wgmIaZuJuv
	PBieFMv+aKhCcyq251/1oh0aOTCJIu+cllAUPa9VCOwUUQ+WHfv5IbIT4rf7
X-Google-Smtp-Source: AGHT+IFYmA5jF9o4Tvpjpl5WsaniPD0/XWzlqlm9qStlKT6N5VOZiuSAkCmVcYQF3w+TWNdMAJnKtQ==
X-Received: by 2002:a9d:7d92:0:b0:6e6:af64:3581 with SMTP id j18-20020a9d7d92000000b006e6af643581mr17923492otn.12.1712160368189;
        Wed, 03 Apr 2024 09:06:08 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 13/14] examples: Fix use after free and resource leaks
Date: Wed,  3 Apr 2024 11:05:36 -0500
Message-ID: <20240403160557.2828145-13-denkenz@gmail.com>
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
index 5c92bd6659c4..927cf1fa8b0e 100644
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
+	struct ofono_modem *modem;
+	unsigned int watch_id;
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
+
+	ofono_emulator_register(em, fd);
+	return TRUE;
 
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

