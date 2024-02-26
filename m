Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564214008
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918650; cv=none; b=eZCIToXicWEa1wPklwL1cKjczibuq6iJPNvYFTgF/IO3ZN26d8a41LzFvROvDzVwf7luYMYrVH8wuK28NWA70jCQjyxwFUtOA9rqXdOvx1WeKaedKhYPYP69HwEXRi/yGkbjBFu2XmjX/UwWS8G4CAc+rTJCzlGr0/9ee1oK8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918650; c=relaxed/simple;
	bh=6xZCzY3CewCh/vkOP/1wkDv7eqzRGUjVIdMHxqFMQZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpFMKrp8ociRmsTIsMbkkzDYL11A4GtY26UNXMCLV8vWD7ilouAcRhMrmQMs0L1vt5pHWDznTGEXUTGKB6IadMtgz/qKn81ZHN+/cbMC4CsmlgeJSjSYIbWCo3KPzRC3FwzGqOJDR6u5BUOssaS3PmklwgYjXJKhrNEX7+wSSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd6X6pXf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd6X6pXf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c19937913fso1002856b6e.3
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918648; x=1709523448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QH1gZeISFilH0DtE1rQTW1HUzoFcM97AVNQNNHunA8=;
        b=Hd6X6pXfxyHt3z8Qackvot5LdLetAgV/uUzrBclqK9s3qNTy3B0EBb0cryZ0hJuDNI
         u/tvqr5OcZtsGWar6loZTDh4ewoRDwaD06YiYr7FwHv3nbOLUvPglvB+XTHic0IkadcG
         iY7E19swGkS2hvhSwnHyvgUSjDz/+slotwg6hUWeQ5D4eqG8v+uGSAIyjokLxxMXGNyg
         K81IsrNAATmSkDO+oF22aLGXKnE7QRxSN0E9oNrNyApip54hkizFh1FUG1LUtNBgDHj2
         A3D6ArcKvAhBTlu8V9olC+vDb2RdaDrBc4Z8CRQV5jO5s9JOLO4yCy/TBlQJ78N8TIMd
         J07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918648; x=1709523448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QH1gZeISFilH0DtE1rQTW1HUzoFcM97AVNQNNHunA8=;
        b=oUQatf7+dr+mJin5iE+c3dHnKXDo50dyoUV3W/Gz9hG+S1KkLXdYvDNnLuEAzKuL63
         rFyN4mlAVx0prJv10blRoyBabru0SZaNG80Ubo7izcKOKb1pUg1DXeTPVtLCCP96+jnh
         MS6NuswXhbEFOi9K7ETUdMCdKR50yaoazhYLsKsk2AlPlBNZHN/k6p8GsPB59mMQnFGf
         k0mzLkqz2jCjZejOmtG48UrQKHiVVIvewYN2GtHVLXs8qsqwaDnguZsvQC3THU/E2eQO
         2RBpVfwaBRICK733EBuXs0D/xhL6XvMJb6jt8gmgP+UMJe9nW39j9lHunVJQ16eIYVVj
         WFvA==
X-Gm-Message-State: AOJu0YxS6aluA124oHxUQ9GOKgEcin2pstn+LrbY5Fudm+/InNKPUZLB
	RFOp8ypYeXBd4A+OqisANUjjQCrusmRsnr0M15VQnlWDwLMsDR179waSJsl/
X-Google-Smtp-Source: AGHT+IEidjHXxQtUf8KZuTn7GaFM1xCoroL7fxo73RxwbDjfIiIARDD7/WYLjcHPEIG452Sv1BFNlw==
X-Received: by 2002:a05:6808:278c:b0:3c1:3a0c:c1c8 with SMTP id es12-20020a056808278c00b003c13a0cc1c8mr6341192oib.51.1708918648072;
        Sun, 25 Feb 2024 19:37:28 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:27 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/22] sim: Remove g_strfreev use
Date: Sun, 25 Feb 2024 21:36:46 -0600
Message-ID: <20240226033724.1460079-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace by l_strfreev
---
 src/sim.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 1873eccccf2e..db65d22f40fd 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -264,13 +264,13 @@ static char **get_own_numbers(GSList *own_numbers)
 	if (own_numbers)
 		nelem = g_slist_length(own_numbers);
 
-	ret = g_new0(char *, nelem + 1);
+	ret = l_new(char *, nelem + 1);
 
 	nelem = 0;
 	for (l = own_numbers; l; l = l->next) {
 		num = l->data;
 
-		ret[nelem++] = g_strdup(phone_number_to_string(num));
+		ret[nelem++] = l_strdup(phone_number_to_string(num));
 	}
 
 	return ret;
@@ -289,7 +289,7 @@ static char **get_locked_pins(struct ofono_sim *sim)
 		nelem += 1;
 	}
 
-	ret = g_new0(char *, nelem + 1);
+	ret = l_new(char *, nelem + 1);
 
 	nelem = 0;
 
@@ -297,7 +297,7 @@ static char **get_locked_pins(struct ofono_sim *sim)
 		if (sim->locked_pins[i] == FALSE)
 			continue;
 
-		ret[nelem] = g_strdup(sim_passwd_name(i));
+		ret[nelem] = l_strdup(sim_passwd_name(i));
 		nelem += 1;
 	}
 
@@ -345,14 +345,14 @@ static char **get_service_numbers(GSList *service_numbers)
 
 	nelem = g_slist_length(service_numbers) * 2;
 
-	ret = g_new0(char *, nelem + 1);
+	ret = l_new(char *, nelem + 1);
 
 	nelem = 0;
 	for (l = service_numbers; l; l = l->next) {
 		num = l->data;
 
-		ret[nelem++] = g_strdup(num->id);
-		ret[nelem++] = g_strdup(phone_number_to_string(&num->ph));
+		ret[nelem++] = l_strdup(num->id);
+		ret[nelem++] = l_strdup(phone_number_to_string(&num->ph));
 	}
 
 	return ret;
@@ -444,15 +444,14 @@ static DBusMessage *sim_get_properties(DBusConnection *conn,
 	}
 
 	own_numbers = get_own_numbers(sim->own_numbers);
-
 	ofono_dbus_dict_append_array(&dict, "SubscriberNumbers",
 					DBUS_TYPE_STRING, &own_numbers);
-	g_strfreev(own_numbers);
+	l_strfreev(own_numbers);
 
 	locked_pins = get_locked_pins(sim);
 	ofono_dbus_dict_append_array(&dict, "LockedPins",
 					DBUS_TYPE_STRING, &locked_pins);
-	g_strfreev(locked_pins);
+	l_strfreev(locked_pins);
 
 	if (sim->service_numbers && sim->sdn_ready) {
 		service_numbers = get_service_numbers(sim->service_numbers);
@@ -460,7 +459,7 @@ static DBusMessage *sim_get_properties(DBusConnection *conn,
 		ofono_dbus_dict_append_dict(&dict, "ServiceNumbers",
 						DBUS_TYPE_STRING,
 						&service_numbers);
-		g_strfreev(service_numbers);
+		l_strfreev(service_numbers);
 	}
 
 	if (sim->language_prefs)
@@ -832,7 +831,7 @@ static void sim_locked_cb(struct ofono_sim *sim, gboolean locked)
 	if (g_strcmp0(typestr, "pin") == 0)
 		pin_cache_update(sim->iccid, pin);
 
-	g_strfreev(locked_pins);
+	l_strfreev(locked_pins);
 
 	sim_pin_retries_check(sim);
 }
@@ -1413,13 +1412,11 @@ check:
 		sim->own_numbers = sim->new_numbers;
 
 		own_numbers = get_own_numbers(sim->own_numbers);
-
 		ofono_dbus_signal_array_property_changed(conn, path,
 						OFONO_SIM_MANAGER_INTERFACE,
 						"SubscriberNumbers",
 						DBUS_TYPE_STRING, &own_numbers);
-
-		g_strfreev(own_numbers);
+		l_strfreev(own_numbers);
 	} else {
 		g_slist_free_full(sim->new_numbers, g_free);
 	}
@@ -1504,7 +1501,7 @@ check:
 						"ServiceNumbers",
 						DBUS_TYPE_STRING,
 						&service_numbers);
-		g_strfreev(service_numbers);
+		l_strfreev(service_numbers);
 	}
 }
 
@@ -2328,7 +2325,7 @@ static void sim_efli_efpl_changed(int id, void *userdata)
 		return;
 
 	if (sim->language_prefs) {
-		g_strfreev(sim->language_prefs);
+		l_strfreev(sim->language_prefs);
 		sim->language_prefs = NULL;
 	}
 
@@ -2604,7 +2601,7 @@ static void sim_free_early_state(struct ofono_sim *sim)
 	}
 
 	if (sim->language_prefs) {
-		g_strfreev(sim->language_prefs);
+		l_strfreev(sim->language_prefs);
 		sim->language_prefs = NULL;
 	}
 
@@ -2764,7 +2761,7 @@ static void sim_set_locked_pin(struct ofono_sim *sim,
 				OFONO_SIM_MANAGER_INTERFACE, "LockedPins",
 				DBUS_TYPE_STRING, &locked_pins);
 
-	g_strfreev(locked_pins);
+	l_strfreev(locked_pins);
 }
 
 static void sim_query_fac_pinlock_cb(const struct ofono_error *error,
@@ -3187,7 +3184,7 @@ static void sim_pin_query_cb(const struct ofono_error *error,
 						"LockedPins", DBUS_TYPE_STRING,
 						&locked_pins);
 
-				g_strfreev(locked_pins);
+				l_strfreev(locked_pins);
 			}
 		}
 
-- 
2.43.0

