Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB346420
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116588; cv=none; b=DgjUUFxeMciTwlRLUNjDxOdRONHsUoNvFZr3kM15dmGnSxUXnxGa2AcuEvOFSqgqmtu/4s3CCHlNf9SJT2s14Ws7cez2TyPUKnswJ7LFvwMhpuhxwL5jdRL7fyZ5ddTgZ0zFU0TBkZZynWD9ZQQQlMruUis3ro74zn/VGQFKLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116588; c=relaxed/simple;
	bh=3nQB5yM+yXF4YwHuYBuGxiw8B2qV2ccA7xTB/Zszzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qV3U4x2PD9E0SEUvtZDLVkrLb9Hv56pEvqwX3amqXhLPkY+3iv+cFrgrTpJWa3/9IxBbghvQDRRhOVhm37KiqmStRf+UWpX39kMsfc7gyJOW5FCdJ0OAiZ9ktU9yxqb9mrobU2D12i3b4zlS8NFRoT6weesReig0TPwIuVIdK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWX6G/5g; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWX6G/5g"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a14d7f0e66so623289eaf.1
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116586; x=1711721386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVvZoQp+AQIDlOlnYC6APkftVteuztwRLNYdmRzkiHw=;
        b=UWX6G/5gheoB1fsoXAP29Je/kGudHzRZD1rm9NCBVco4w95xrtBqfjMbffhBVBPi22
         fPXrXCFkbUsNxaJv6V7SQSTBiZjyMy3QsD8v/iIoKH80PTRQO0PYOcq2QgfLZ5omx4sL
         hazNNWYdi+43G4etBNSxur7l3CycC4YllIi6gJW6sB3OyaScjp0bc+AwxDhll+jdt9Qr
         6INcF1qK8i37OLVwNejfyyHzUVc5DVLNqRnNgkF0faJpz741la75OcqGZImunWwr5TMJ
         kAXYJD8+YZaJtW1rdVEDeiO1oBIUx/3d9W6dXiEuZ4fYWk82L21PtN+s64KY0p4uc6fX
         pLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116586; x=1711721386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVvZoQp+AQIDlOlnYC6APkftVteuztwRLNYdmRzkiHw=;
        b=nlrFWo356N5v1ZWssrkJnN1qOFCm0FutVLp/LVqY11tUAOgDFtFZIWeyHx7e/sKvqf
         gSLdnsbQ8UAQdCt6VlRIraIjVFTnWRlhbynSLroA1441EmwhkDYsABl9icVz4ZuSVsIi
         vKR6euQ/57x2Grpu/kfhJ311X8Z+bKzIG8at9D2S5lLgjUDnCtZ++nbvgiUzKSixfP4a
         cyl1GJylYQU069DsRdcMDMXk7ncgVpTCArfxjDVjBms+x1NrRBoDhzJWqvLCIYYCUKi5
         fiZPKsKPXt7mvE9RHHwaLY2/E7S/ByYqRLQdpqo56ZIvnBEzYPDFQ8ax+p9jkZjco/Cg
         MpEw==
X-Gm-Message-State: AOJu0YyUGxxSOqs4rFgjk3ecTE476Y9qMIWiF47f1Mj/QJjzw+Rw2nLJ
	r6ay8KdUKMksfg1vy+1lz05loD0L+F1J4HhDlCtfuR5Pq4P5L5XbP0bliyWX
X-Google-Smtp-Source: AGHT+IHdFUPpHAUQIo2I3WSp74fUYnvgOgLXHYDlgYtJMrZHvzRdCQ/F4fgSiCjhs36RZAGAYaFNfg==
X-Received: by 2002:a05:6820:213:b0:5a4:f5b6:4ed4 with SMTP id bw19-20020a056820021300b005a4f5b64ed4mr2768301oob.8.1711116585830;
        Fri, 22 Mar 2024 07:09:45 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056820258200b005a1f748f3edsm303673oob.30.2024.03.22.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:09:45 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 01/11] phonesim: Allow phonesim to work with Multiplexer=internal
Date: Fri, 22 Mar 2024 09:09:02 -0500
Message-ID: <20240322140942.2703042-1-denkenz@gmail.com>
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

