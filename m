Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67D481B3
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122159; cv=none; b=QA9n4KPbWuRo7m9kja8Wjd5x6xJbKYLZJGNT/NTx3YDMMa34JO+KjXuEm71EnTDCyc57KeJ/WwHm4Dw3JLgrYvOA2vqolpaiPfIgGw9gS50bWGmPTQ1Zlb7MYJh8ZQqFaLeA307IzTLZhNAj+JWLdHwHv5avkzqryZ+6kCh6MU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122159; c=relaxed/simple;
	bh=3nQB5yM+yXF4YwHuYBuGxiw8B2qV2ccA7xTB/Zszzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHZqNyZcGwlgtcygzkkwX7xVa3Y2ZlXqE7GBlQ4ZcWk/USpVj8dW1t1HqLo1rH2Gy+UFBRndZNUIX9P5I4BXeE/tXkFDH3pGiReagYSA1WD2bUI8vP7oWeVO/bSWXt1vo7PbnHKO/6f/zs+fazGVH6tz41Ifc942IIAQvMYfbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFpfN70y; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFpfN70y"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e6775fd386so1351892a34.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122157; x=1711726957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVvZoQp+AQIDlOlnYC6APkftVteuztwRLNYdmRzkiHw=;
        b=MFpfN70yeW5exY8CtRvgLlgG8VYamL2zNhDhZwBgAukA0n6o/+wTzRgG6Ka6q2TYo2
         VGVQKXIahiMzvwLUHBvYkkBeW96V62WcV/fZuicBS4yizWj1IwUtEIWnoRT4CqsnHN5X
         PCaB8F/ZeaJD9EsHjYokPchaH/QrNcDaSE9kcrVHpCowhH58lOkaW03x0hZJFMpgwqZy
         0mWpLHdMnd698cKM7yBDHNEvr0C3N5Z/7RYGApwL5TaFwaEqrAlXro/NJQvRXGhTxFhT
         2eJcQHT5OVf6anvn35BbT9mcuyikwH4FTa7aMBJmCQS0rvw1xpaSogmGRZLRBCSVIZgd
         80Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122157; x=1711726957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVvZoQp+AQIDlOlnYC6APkftVteuztwRLNYdmRzkiHw=;
        b=qkho9YZUEzjNivt2bxiRlI11dOiKZXR5LUHI4MH7kNkMLRTA6+K5vGG8r7RsY4Bycg
         UqhOaeQBU1qM4Eu4yHLUbO+pjFkDDqloEtGXsMpGBJ/r4zNsKI0a/LKVpbSwv+155dkv
         Jurn20sxcbrqY5mFgyM0dBp2bSKszplqP3CuBcidWrAziD8iHukpf9Ip4/gusS+CU9cy
         XXCiE5/2RJ0Ph92YaCPTa23c/L6F4x5MybALC5BkigPnk6wJ1R9u1R5assA/hZr9ru/x
         1hOUQgXf1dvQvCA9JDplKQrFHcKI4BolfiDy8fOcJhhiJoflhcnQil86Gr9Q0PPvEzrk
         Djjg==
X-Gm-Message-State: AOJu0YyGUZSo9NbR2kHRzRJ3IArOt7Y+bJScXLAaGzrjRP7CckeexdZR
	v0DgN1tyXPeB8qlMfbEsoOKJUzsQ1YfpxY8/oQ6WccXYFjJDSDp6IBBc3QjI
X-Google-Smtp-Source: AGHT+IElbD4kdwjaTUDrfeUpNgZvXj5HVb5GUbYsNQaqhPk6Z+TinmQUkqtbDoK8r24QP6koEJynDQ==
X-Received: by 2002:a9d:6e13:0:b0:6e6:9528:6136 with SMTP id e19-20020a9d6e13000000b006e695286136mr22768otr.12.1711122156749;
        Fri, 22 Mar 2024 08:42:36 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:36 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 01/11] phonesim: Allow phonesim to work with Multiplexer=internal
Date: Fri, 22 Mar 2024 10:42:14 -0500
Message-ID: <20240322154234.2720542-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If use_mux code path was used, certain commands (like querying of the
SIM status) were not sent, resulting in incomplete modem initialization.
Fix that.
---
 plugins/phonesim.c | 102 +++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 07afc14d56bb..29a983611d75 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -512,13 +512,27 @@ static void usimstate_notify(GAtResult *result, gpointer user_data)
 	ofono_sim_inserted_notify(data->sim, inserted);
 }
 
-static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
+static void emulator_battery_cb(struct ofono_atom *atom, void *data)
 {
-	struct ofono_modem *modem = user_data;
+	struct ofono_emulator *em = __ofono_atom_get_data(atom);
+	int val = 0;
 
-	DBG("");
+	if (GPOINTER_TO_INT(data) > 0)
+		val = (GPOINTER_TO_INT(data) - 1) / 20 + 1;
 
-	ofono_modem_set_powered(modem, ok);
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
+}
+
+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *user_data)
+{
+	struct phonesim_data *data = user_data;
+
+	if (cond != OFONO_ATOM_WATCH_CONDITION_REGISTERED)
+		return;
+
+	emulator_battery_cb(atom, GUINT_TO_POINTER(data->batt_level));
 }
 
 static gboolean phonesim_reset(void *user_data)
@@ -545,17 +559,6 @@ static void crst_notify(GAtResult *result, gpointer user_data)
 	g_idle_add(phonesim_reset, user_data);
 }
 
-static void emulator_battery_cb(struct ofono_atom *atom, void *data)
-{
-	struct ofono_emulator *em = __ofono_atom_get_data(atom);
-	int val = 0;
-
-	if (GPOINTER_TO_INT(data) > 0)
-		val = (GPOINTER_TO_INT(data) - 1) / 20 + 1;
-
-	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
-}
-
 static void cbc_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -582,6 +585,43 @@ static void cbc_notify(GAtResult *result, gpointer user_data)
 						GUINT_TO_POINTER(level));
 }
 
+static void finish_powerup(struct ofono_modem *modem)
+{
+	struct phonesim_data *data = ofono_modem_get_data(modem);
+
+	g_at_chat_send(data->chat, "AT+CSCS=\"GSM\"", none_prefix,
+			NULL, NULL, NULL);
+
+	g_at_chat_register(data->chat, "+CRST:",
+				crst_notify, FALSE, modem, NULL);
+
+	g_at_chat_register(data->chat, "+CBC:",
+				cbc_notify, FALSE, modem, NULL);
+
+	g_at_chat_send(data->chat, "AT+CBC", none_prefix, NULL, NULL, NULL);
+
+	g_at_chat_send(data->chat, "AT+SIMSTATE?", simstate_prefix,
+					simstate_query, modem, NULL);
+	g_at_chat_register(data->chat, "+USIMSTATE:", usimstate_notify,
+						FALSE, modem, NULL);
+
+	data->hfp_watch = __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, data, NULL);
+}
+
+static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem = user_data;
+
+	DBG("");
+
+	ofono_modem_set_powered(modem, ok);
+
+	if (ok)
+		finish_powerup(modem);
+}
+
 static void phonesim_disconnected(gpointer user_data)
 {
 	struct ofono_modem *modem = user_data;
@@ -644,18 +684,6 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
 					cfun_set_on_cb, modem, NULL);
 }
 
-static void emulator_hfp_watch(struct ofono_atom *atom,
-				enum ofono_atom_watch_condition cond,
-				void *user_data)
-{
-	struct phonesim_data *data = user_data;
-
-	if (cond != OFONO_ATOM_WATCH_CONDITION_REGISTERED)
-		return;
-
-	emulator_battery_cb(atom, GUINT_TO_POINTER(data->batt_level));
-}
-
 static int connect_socket(const char *address, int port)
 {
 	struct sockaddr_in addr;
@@ -755,25 +783,7 @@ static int phonesim_enable(struct ofono_modem *modem)
 		return -EINPROGRESS;
 	}
 
-	g_at_chat_send(data->chat, "AT+CSCS=\"GSM\"", none_prefix,
-			NULL, NULL, NULL);
-
-	g_at_chat_register(data->chat, "+CRST:",
-				crst_notify, FALSE, modem, NULL);
-
-	g_at_chat_register(data->chat, "+CBC:",
-				cbc_notify, FALSE, modem, NULL);
-
-	g_at_chat_send(data->chat, "AT+CBC", none_prefix, NULL, NULL, NULL);
-
-	g_at_chat_send(data->chat, "AT+SIMSTATE?", simstate_prefix,
-					simstate_query, modem, NULL);
-	g_at_chat_register(data->chat, "+USIMSTATE:", usimstate_notify,
-						FALSE, modem, NULL);
-
-	data->hfp_watch = __ofono_modem_add_atom_watch(modem,
-					OFONO_ATOM_TYPE_EMULATOR_HFP,
-					emulator_hfp_watch, data, NULL);
+	finish_powerup(modem);
 
 	return 0;
 }
-- 
2.43.0

