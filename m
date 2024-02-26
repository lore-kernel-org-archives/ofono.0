Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261A156CF
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918663; cv=none; b=FyQE4Vd2YjFHS/JmSgloNNnhP39e48W9yyFVnsbfMsuLsr5lNETYV9d2Gf5wWiq9LB8L2OWlZjBtBJZDaYBJ6IWBUvS8FIP4v6iyj2r0CctzGItS5wepc7djHMESn7zdrb6eLJ/iA/9ggIZrTQarnV/iyD3vIOaKXeFG/ojPlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918663; c=relaxed/simple;
	bh=80EkPlXIo1lj6NonOh5H46XKPYVX0mbE5w8HXzAAqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPc199oUt3ObpBxxwNZXg0BssgLGw0D6g+zER8UGB6JgNoE5X4qD/7TjvXVlnQcPbwDk4/d2tbc0T016rPC8uXd4X9x7DsG7W91lX8+ArKWOKsupNNcWpViEOpbejHXT1o6d4DbreinR4Maek+odRKaPK+ymr1x0gQUSV8aYnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA52ko1M; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA52ko1M"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddca59e336so1596478a34.0
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918660; x=1709523460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pphoeplo09GEg01P26kIC5z4xTPHi39OnvFelDXjgQ=;
        b=HA52ko1MwoAlVjYq/kyHKgzKjimz87II63XerLrRxMgKCjVLSggWahZ9DGNqgPal7B
         kcKcgLSJqloGmsUrF5T5OSGynoyNRc5ht6VwS0ODfIp3/lqFT/m8fX1q/td4Ktmn24rn
         /HL6xhVyvRBuAD0L5PANQfs5K1/qnFV7ZZzvpi2xZijMaJzBio8YjzA/5xqHTOA6m5dN
         wkXh6lfQEsvo3i0HXET3MUZnVv/td0s1TgC7whl6jI8UIbkuCv5jr2lkTYy+J40OLdPO
         sSc6PUeaIz1Xr7nBY/7BqiK+/C7Xe1TkNNbotc0TWv8Ej4P9O2jslJ/ige6SpbY7IzXO
         VESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918660; x=1709523460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pphoeplo09GEg01P26kIC5z4xTPHi39OnvFelDXjgQ=;
        b=l7sDxZCW73M/j0T80kerqg0KLkoMImIrMBiBGVD4L3z8V30j8FIZFJeMcdfV4j+tDu
         0rtb8SwFw6ApZScVz9dpJXWG0je1xzCcjLhPJMzyEtXIb8H7Wvn0Fek27CWZf5TUTAzy
         aQVpV+SackXXmWss+EOMJ5cC44+236Jy8JF6pAOaX7JYP3Nq1t3YcRXpo3MzA4je0Jcu
         3wb3xmaQPOtH0z0991TIUTkOBGwk8u9j5V+nwuJ3QBT19Vu0TDsOapGFt3mVdncFRyda
         f1hggr9R4KxhoSgaDrGxDd4Q6zNX/5RI/r1LFS4Cvj/wuNTSMJYyxxYP73hDGpZeN9Ye
         3Cmg==
X-Gm-Message-State: AOJu0Yyclk7mimNotL1FKXLj7VC06ygFsQvONr22JFaNL+taVUclBei2
	V0vKL2Vn1y1c6O8uV3RkZrQ+RkMfgtJMUoAtZX0Xmw6kHva9oag91J3CYsCJ
X-Google-Smtp-Source: AGHT+IF/gAGOO5Ip5yHE4tk2uy61q7lcBl7W/AGOcxRXEmQm4Tny3bNnYaekogZRgLCEeQuyQ7KH+g==
X-Received: by 2002:a05:6830:650e:b0:6e4:926f:5f78 with SMTP id cm14-20020a056830650e00b006e4926f5f78mr2047445otb.10.1708918660559;
        Sun, 25 Feb 2024 19:37:40 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:40 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 22/22] core: Drop g_strdup use
Date: Sun, 25 Feb 2024 21:37:05 -0600
Message-ID: <20240226033724.1460079-22-denkenz@gmail.com>
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

Replace with l_strdup
---
 src/audio-settings.c     |  6 +++---
 src/cbs.c                |  4 ++--
 src/emulator.c           |  4 ++--
 src/gnssagent.c          |  8 ++++----
 src/handsfree-audio.c    | 28 ++++++++++++----------------
 src/location-reporting.c |  4 ++--
 src/netmonagent.c        |  8 ++++----
 src/phonebook.c          | 12 ++++++------
 src/radio-settings.c     |  4 ++--
 src/sms.c                |  4 ++--
 src/smsagent.c           | 12 ++++++------
 src/stkagent.c           |  8 ++++----
 src/ussd.c               |  8 ++++----
 13 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/src/audio-settings.c b/src/audio-settings.c
index 24c4213a1b82..99dabf26a214 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -68,8 +68,8 @@ void ofono_audio_settings_mode_notify(struct ofono_audio_settings *as,
 
 	DBG("mode %s", mode);
 
-	g_free(as->mode);
-	as->mode = g_strdup(mode);
+	l_free(as->mode);
+	as->mode = l_strdup(mode);
 
 	if (as->mode == NULL)
 		return;
@@ -151,7 +151,7 @@ static void audio_settings_remove(struct ofono_atom *atom)
 	if (as->driver && as->driver->remove)
 		as->driver->remove(as);
 
-	g_free(as->mode);
+	l_free(as->mode);
 	g_free(as);
 }
 
diff --git a/src/cbs.c b/src/cbs.c
index 2c45330130a0..684463674297 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -602,7 +602,7 @@ static void cbs_unregister(struct ofono_atom *atom)
 	if (cbs->settings) {
 		storage_close(cbs->imsi, SETTINGS_STORE, cbs->settings, TRUE);
 
-		g_free(cbs->imsi);
+		l_free(cbs->imsi);
 		cbs->imsi = NULL;
 		cbs->settings = NULL;
 	}
@@ -868,7 +868,7 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	if (cbs->settings == NULL)
 		return;
 
-	cbs->imsi = g_strdup(imsi);
+	cbs->imsi = l_strdup(imsi);
 
 	cbs->topics = NULL;
 
diff --git a/src/emulator.c b/src/emulator.c
index b3afb3da6de3..2d7475988580 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1138,7 +1138,7 @@ static void emulator_add_indicator(struct ofono_emulator *em, const char* name,
 		return;
 	}
 
-	ind->name = g_strdup(name);
+	ind->name = l_strdup(name);
 	ind->min = min;
 	ind->max = max;
 	ind->value = dflt;
@@ -1163,7 +1163,7 @@ static void emulator_unregister(struct ofono_atom *atom)
 	for (l = em->indicators; l; l = l->next) {
 		struct indicator *ind = l->data;
 
-		g_free(ind->name);
+		l_free(ind->name);
 		g_free(ind);
 	}
 
diff --git a/src/gnssagent.c b/src/gnssagent.c
index f370dec835fe..cb27917296f1 100644
--- a/src/gnssagent.c
+++ b/src/gnssagent.c
@@ -113,8 +113,8 @@ void gnss_agent_free(struct gnss_agent *agent)
 	if (agent->removed_cb)
 		agent->removed_cb(agent->removed_data);
 
-	g_free(agent->path);
-	g_free(agent->bus);
+	l_free(agent->path);
+	l_free(agent->bus);
 	g_free(agent);
 }
 
@@ -135,8 +135,8 @@ struct gnss_agent *gnss_agent_new(const char *path, const char *sender)
 	if (agent == NULL)
 		return NULL;
 
-	agent->path = g_strdup(path);
-	agent->bus = g_strdup(sender);
+	agent->path = l_strdup(path);
+	agent->bus = l_strdup(sender);
 
 	agent->disconnect_watch = g_dbus_add_disconnect_watch(conn, sender,
 						gnss_agent_disconnect_cb,
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index a5d3a652af20..a739a5271d7d 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -465,10 +465,8 @@ void *ofono_handsfree_card_get_data(struct ofono_handsfree_card *card)
 void ofono_handsfree_card_set_remote(struct ofono_handsfree_card *card,
 					const char *remote)
 {
-	if (card->remote)
-		g_free(card->remote);
-
-	card->remote = g_strdup(remote);
+	l_free(card->remote);
+	card->remote = l_strdup(remote);
 }
 
 const char *ofono_handsfree_card_get_remote(struct ofono_handsfree_card *card)
@@ -479,10 +477,8 @@ const char *ofono_handsfree_card_get_remote(struct ofono_handsfree_card *card)
 void ofono_handsfree_card_set_local(struct ofono_handsfree_card *card,
 					const char *local)
 {
-	if (card->local)
-		g_free(card->local);
-
-	card->local = g_strdup(local);
+	l_free(card->local);
+	card->local = l_strdup(local);
 }
 
 const char *ofono_handsfree_card_get_local(struct ofono_handsfree_card *card)
@@ -581,7 +577,7 @@ int ofono_handsfree_card_register(struct ofono_handsfree_card *card)
 
 	next_card_id += 1;
 
-	card->path = g_strdup(path);
+	card->path = l_strdup(path);
 	emit_card_added(card);
 
 	return 0;
@@ -606,7 +602,7 @@ static void card_unregister(struct ofono_handsfree_card *card)
 
 	emit_card_removed(card);
 
-	g_free(card->path);
+	l_free(card->path);
 	card->path = NULL;
 }
 
@@ -622,8 +618,8 @@ void ofono_handsfree_card_remove(struct ofono_handsfree_card *card)
 
 	card_list = g_slist_remove(card_list, card);
 
-	g_free(card->remote);
-	g_free(card->local);
+	l_free(card->remote);
+	l_free(card->local);
 
 	if (card->driver && card->driver->remove)
 		card->driver->remove(card);
@@ -663,8 +659,8 @@ static void agent_free(struct agent *agent)
 	if (agent->watch > 0)
 		g_dbus_remove_watch(ofono_dbus_get_connection(), agent->watch);
 
-	g_free(agent->owner);
-	g_free(agent->path);
+	l_free(agent->owner);
+	l_free(agent->path);
 	g_free(agent);
 }
 
@@ -789,8 +785,8 @@ static DBusMessage *am_agent_register(DBusConnection *conn,
 	}
 
 	agent = g_new0(struct agent, 1);
-	agent->owner = g_strdup(sender);
-	agent->path = g_strdup(path);
+	agent->owner = l_strdup(sender);
+	agent->path = l_strdup(path);
 	agent->watch = g_dbus_add_disconnect_watch(conn, sender,
 						agent_disconnect, NULL, NULL);
 
diff --git a/src/location-reporting.c b/src/location-reporting.c
index e9624309154b..412adbdf5166 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -100,7 +100,7 @@ static void client_remove(struct ofono_location_reporting *lr)
 		lr->disconnect_watch = 0;
 	}
 
-	g_free(lr->client_owner);
+	l_free(lr->client_owner);
 }
 
 static void signal_enabled(const struct ofono_location_reporting *lr)
@@ -178,7 +178,7 @@ static void location_reporting_enable_cb(const struct ofono_error *error,
 	}
 
 	lr->enabled = TRUE;
-	lr->client_owner = g_strdup(dbus_message_get_sender(lr->pending));
+	lr->client_owner = l_strdup(dbus_message_get_sender(lr->pending));
 	lr->disconnect_watch = g_dbus_add_disconnect_watch(conn,
 				lr->client_owner, client_exited, lr, NULL);
 
diff --git a/src/netmonagent.c b/src/netmonagent.c
index 7262e0723268..2d58542d4678 100644
--- a/src/netmonagent.c
+++ b/src/netmonagent.c
@@ -85,8 +85,8 @@ void netmon_agent_free(struct netmon_agent *agent)
 	if (agent->removed_cb)
 		agent->removed_cb(agent->removed_data);
 
-	g_free(agent->path);
-	g_free(agent->bus);
+	l_free(agent->path);
+	l_free(agent->bus);
 	g_free(agent);
 }
 
@@ -110,8 +110,8 @@ struct netmon_agent *netmon_agent_new(const char *path,
 	if (agent == NULL)
 		return NULL;
 
-	agent->bus = g_strdup(sender);
-	agent->path = g_strdup(path);
+	agent->bus = l_strdup(sender);
+	agent->path = l_strdup(path);
 
 	agent->disconnect_watch = g_dbus_add_disconnect_watch(conn, sender,
 						netmon_agent_disconnect_cb,
diff --git a/src/phonebook.c b/src/phonebook.c
index eb48980e7a3b..841a817b35b0 100644
--- a/src/phonebook.c
+++ b/src/phonebook.c
@@ -245,7 +245,7 @@ static void print_number(gpointer pointer, gpointer user_data)
 static void destroy_number(gpointer pointer)
 {
 	struct phonebook_number *pn = pointer;
-	g_free(pn->number);
+	l_free(pn->number);
 	g_free(pn);
 }
 
@@ -268,9 +268,9 @@ static void destroy_merged_entry(gpointer pointer)
 {
 	struct phonebook_person *person = pointer;
 	l_free(person->text);
-	g_free(person->group);
-	g_free(person->email);
-	g_free(person->sip_uri);
+	l_free(person->group);
+	l_free(person->email);
+	l_free(person->sip_uri);
 
 	g_slist_free_full(person->number_list, destroy_number);
 
@@ -319,7 +319,7 @@ static gboolean need_merge(const char *text)
 static void merge_field_generic(char **str1, const char *str2)
 {
 	if ((*str1 == NULL) && (str2 != NULL) && (strlen(str2) != 0))
-		*str1 = g_strdup(str2);
+		*str1 = l_strdup(str2);
 }
 
 static void merge_field_number(GSList **l, const char *number, int type, char c)
@@ -327,7 +327,7 @@ static void merge_field_number(GSList **l, const char *number, int type, char c)
 	struct phonebook_number *pn = g_new0(struct phonebook_number, 1);
 	enum phonebook_number_type category;
 
-	pn->number = g_strdup(number);
+	pn->number = l_strdup(number);
 	pn->type = type;
 	switch (tolower(c)) {
 	case 'w':
diff --git a/src/radio-settings.c b/src/radio-settings.c
index 62ce5b6e4a9e..4cd3d6601c03 100644
--- a/src/radio-settings.c
+++ b/src/radio-settings.c
@@ -716,7 +716,7 @@ static void radio_settings_unregister(struct ofono_atom *atom)
 	if (rs->settings) {
 		storage_close(rs->imsi, SETTINGS_STORE, rs->settings, TRUE);
 
-		g_free(rs->imsi);
+		l_free(rs->imsi);
 		rs->imsi = NULL;
 		rs->settings = NULL;
 	}
@@ -805,7 +805,7 @@ static void radio_load_settings(struct ofono_radio_settings *rs,
 		return;
 	}
 
-	rs->imsi = g_strdup(imsi);
+	rs->imsi = l_strdup(imsi);
 
 	error = NULL;
 	rs->band_gsm = g_key_file_get_integer(rs->settings, SETTINGS_GROUP,
diff --git a/src/sms.c b/src/sms.c
index 6f9e01db5e31..2fc91f9e2162 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1779,7 +1779,7 @@ static void sms_remove(struct ofono_atom *atom)
 
 		storage_close(sms->imsi, SETTINGS_STORE, sms->settings, TRUE);
 
-		g_free(sms->imsi);
+		l_free(sms->imsi);
 		sms->imsi = NULL;
 		sms->settings = NULL;
 	}
@@ -1821,7 +1821,7 @@ static void sms_load_settings(struct ofono_sms *sms, const char *imsi)
 	if (sms->settings == NULL)
 		return;
 
-	sms->imsi = g_strdup(imsi);
+	sms->imsi = l_strdup(imsi);
 
 	error = NULL;
 	sms->ref = g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
diff --git a/src/smsagent.c b/src/smsagent.c
index 08b5b34c0fd2..7e15514859da 100644
--- a/src/smsagent.c
+++ b/src/smsagent.c
@@ -132,9 +132,9 @@ struct sms_agent *sms_agent_new(const char *interface,
 	if (agent == NULL)
 		return NULL;
 
-	agent->interface = g_strdup(interface);
-	agent->service = g_strdup(service);
-	agent->path = g_strdup(path);
+	agent->interface = l_strdup(interface);
+	agent->service = l_strdup(service);
+	agent->path = l_strdup(path);
 
 	agent->disconnect_watch = g_dbus_add_disconnect_watch(conn, service,
 							sms_agent_disconnect_cb,
@@ -179,9 +179,9 @@ void sms_agent_free(struct sms_agent *agent)
 	g_slist_foreach(agent->reqs, sms_agent_request_cancel, NULL);
 	g_slist_free(agent->reqs);
 
-	g_free(agent->path);
-	g_free(agent->service);
-	g_free(agent->interface);
+	l_free(agent->path);
+	l_free(agent->service);
+	l_free(agent->interface);
 	g_free(agent);
 }
 
diff --git a/src/stkagent.c b/src/stkagent.c
index 8748ec63022c..cd8bac6bdcd7 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -161,8 +161,8 @@ void stk_agent_free(struct stk_agent *agent)
 	if (agent->removed_cb)
 		agent->removed_cb(agent->removed_data);
 
-	g_free(agent->path);
-	g_free(agent->bus);
+	l_free(agent->path);
+	l_free(agent->bus);
 	g_free(agent);
 }
 
@@ -236,8 +236,8 @@ struct stk_agent *stk_agent_new(const char *path, const char *sender,
 	if (agent == NULL)
 		return NULL;
 
-	agent->path = g_strdup(path);
-	agent->bus = g_strdup(sender);
+	agent->path = l_strdup(path);
+	agent->bus = l_strdup(sender);
 	agent->remove_on_terminate = remove_on_terminate;
 
 	agent->disconnect_watch = g_dbus_add_disconnect_watch(conn, sender,
diff --git a/src/ussd.c b/src/ussd.c
index 67a4d4eafe1f..ff372f19db1d 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -90,7 +90,7 @@ static struct ssc_entry *ssc_entry_create(const char *sc, void *cb, void *data,
 	if (r == NULL)
 		return r;
 
-	r->service = g_strdup(sc);
+	r->service = l_strdup(sc);
 	r->cb = cb;
 	r->user = data;
 	r->destroy = destroy;
@@ -105,7 +105,7 @@ static void ssc_entry_destroy(gpointer pointer)
 	if (ca->destroy)
 		ca->destroy(ca->user);
 
-	g_free(ca->service);
+	l_free(ca->service);
 	g_free(ca);
 }
 
@@ -232,7 +232,7 @@ static gboolean recognized_control_string(struct ofono_ussd *ussd,
 						const char *ss_str,
 						DBusMessage *msg)
 {
-	char *str = g_strdup(ss_str);
+	char *str = l_strdup(ss_str);
 	char *sc, *sia, *sib, *sic, *sid, *dn;
 	int type;
 	gboolean ret = FALSE;
@@ -286,7 +286,7 @@ static gboolean recognized_control_string(struct ofono_ussd *ussd,
 	 */
 
 out:
-	g_free(str);
+	l_free(str);
 
 	return ret;
 }
-- 
2.43.0

