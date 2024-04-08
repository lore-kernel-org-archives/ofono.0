Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7ED7E8
	for <ofono@lists.linux.dev>; Mon,  8 Apr 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613440; cv=none; b=QmllsFBV1dmoQK1FaZLPmcxsxh7q7CwGPGYwivRhN5UKAqQfTfHVEUUAIkkfwOZymeqWibpVEmwUeajGEBp31am+u7lS3LcRWgxrnxdsZT+aHnECDmv308jo4T5r5gMilxe8gKbHf/OoJjbYPYzlkNSZPZNOl8VtOCeCUYZypKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613440; c=relaxed/simple;
	bh=VSY+m7bPLfJ4u1mHkYixKtINUybGyN6wzRmtRVFL21U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtBPXpU8VHXvLyvxAGQB6nIipeM7t19CCKQNAnc9xMvOihVHNGYO6qCQARmQ+93u1qTGgMBSs2xtjVHRqTVq7pYrZFJIipNgw3jFZw9BBMiY8m5eclD+Mz40qWoAFhr8xSvfMeB9zpjU/njlCNp0NAaLUnrm2IZAdkuekxWtpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHsJLlA5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHsJLlA5"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa20adda1dso1734617eaf.1
        for <ofono@lists.linux.dev>; Mon, 08 Apr 2024 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712613433; x=1713218233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1UtszftW7K0BRLbuk3Uds1iEX7VC8pzQeAFUeqm3J0=;
        b=YHsJLlA5GpunQmcG1WO6I1mcwzuqZjfElfkU5xM+ZCC4KgHI4CbbNr04f4BlOFCZR/
         gumGrH0PyI+osjHOrY5XGVC0phJdh91n/xRERLcoNIdoAf45y1h0GGPh6quc0fScPewB
         4sJTUwprPpCHrDeWvSOxdlG5rgpGkMn644XC5yoT5ZZLvbVJWBBcYiXO5Sycivoavfjp
         W+v7RKNS9eSxpYZMbgd3O5yq884y3pqjyViwv8Bq52yU9tfTiZBt29fleK4puGDOhMFA
         uv7WUdNxDukui3ViIYu7GCJwNUZhCbzK40meEh5KBdqgCbweUqbK/6lFv1vf8+XHxqLF
         gG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613433; x=1713218233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1UtszftW7K0BRLbuk3Uds1iEX7VC8pzQeAFUeqm3J0=;
        b=E5Cr1PSEwKRHuu6sW1FoiyAGxk7XkL28cUbCeO9YE6kSlkBykOD6T11BCPkscIRdgZ
         nAnclaAPjqD0gvi8dOr6exoutNpC6U+9V9m8tJhuYduC/uK9+R9m1VNQAnGD7pixjb2P
         FWvfafl1oU7cpS8E/gAjj3ikbq/d2M8OlNoAndVIhsaEvHaCXbut4a7CFvjjJXnrxYfa
         06E9FiLnud1jpsFbjjnKXfxdwuYOkX97K18EyLdiSuGftyIn+s2sBdiBWk3J9oL70Xeu
         qB0obsPqhl6vTi2+kmf+McBy3oqUBGlB3H/GDPpUuQSBaMmMuHSolDHzc1IaYR6Bzpkc
         VFyg==
X-Gm-Message-State: AOJu0YwSwgvOMnClw8EpLHG5GamdImGZRgnC4IHWUiwSeFRA8d1Jm1/2
	dDpqLxr97pemRA18dXrlW3k+N2GcFpz4CaPz8ieBeRvLqhRqgbYcUX+2rwrC
X-Google-Smtp-Source: AGHT+IEKKkfw+M44n+Qw6JlPsl9lWm25CAvEQ/0SWrtrh3vkjJCcbAbIhaWJfPyk+GbA0FZcA5Vovg==
X-Received: by 2002:a05:6820:1529:b0:5aa:4d23:9114 with SMTP id ay41-20020a056820152900b005aa4d239114mr3229215oob.3.1712613433209;
        Mon, 08 Apr 2024 14:57:13 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id i22-20020a9d68d6000000b006ea190267e5sm512321oto.43.2024.04.08.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:57:12 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/2] hfp_ag_bluez5: Fix use-after-free
Date: Mon,  8 Apr 2024 16:56:57 -0500
Message-ID: <20240408215710.2984399-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408215710.2984399-1-denkenz@gmail.com>
References: <20240408215710.2984399-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

valgrind reports many use-after-free errors inside hfp_ag_bluez5.c
when oFono is being shutdown.  This is caused by hfp_ag plugin not
tracking atom watches properly.  Fix this by correctly removing both sim
and voicecall atom watches appropriately.  Since all modems are now
tracked, remove the 'sim_hash' hash table and the 'modems' doubly-linked
list.

ofonod[29]: src/voicecall.c:voicecall_remove() atom: 0x5697140
==29== Invalid read of size 8
==29==    at 0x48E28C9: g_list_remove (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8B84: sim_state_watch (hfp_ag_bluez5.c:353)
==29==    by 0x4E8CDE: sim_watch (hfp_ag_bluez5.c:396)
==29==    by 0x502F65: call_watches (modem.c:314)
==29==    by 0x502FE2: __ofono_atom_unregister (modem.c:334)
==29==    by 0x503381: flush_atoms (modem.c:483)
==29==    by 0x50366D: modem_change_state (modem.c:586)
==29==    by 0x504225: set_powered (modem.c:974)
==29==    by 0x506966: modem_unregister (modem.c:2154)
==29==    by 0x506BD2: ofono_modem_remove (modem.c:2220)
==29==    by 0x4C8753: phonesim_exit (phonesim.c:1177)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==  Address 0x56c3350 is 0 bytes inside a block of size 24 free'd
==29==    at 0x484488F: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x49093C0: g_slice_free_chain_with_offset (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E90A3: hfp_ag_exit (hfp_ag_bluez5.c:514)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==    by 0x5015F8: main (main.c:315)
==29==  Block was alloc'd at
==29==    at 0x4841828: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x48EE762: g_malloc (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x48E0FE8: g_list_append (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8BDD: sim_state_watch (hfp_ag_bluez5.c:365)
==29==    by 0x53274E: call_state_watches (sim.c:374)
==29==    by 0x535D1E: sim_set_ready (sim.c:1784)
==29==    by 0x53611A: sim_imsi_obtained (sim.c:1885)
==29==    by 0x536280: sim_imsi_cb (sim.c:1934)
==29==    by 0x489FAA: at_cimi_cb (sim.c:455)
==29==    by 0x4ED979: at_chat_finish_command (gatchat.c:465)
==29==    by 0x4EDB84: at_chat_handle_command_response (gatchat.c:527)
==29==    by 0x4EDE3F: have_line (gatchat.c:606)
==29==

...

ofonod[29]: plugins/bluez5.c:bt_unregister_profile() Bluetooth: Unregistering profile /bluetooth/profile/hfp_ag
==29== Invalid read of size 8
==29==    at 0x48C8076: g_hash_table_lookup (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8CF4: sim_watch (hfp_ag_bluez5.c:398)
==29==    by 0x502F65: call_watches (modem.c:314)
==29==    by 0x502FE2: __ofono_atom_unregister (modem.c:334)
==29==    by 0x503381: flush_atoms (modem.c:483)
==29==    by 0x50366D: modem_change_state (modem.c:586)
==29==    by 0x504225: set_powered (modem.c:974)
==29==    by 0x506966: modem_unregister (modem.c:2154)
==29==    by 0x506BD2: ofono_modem_remove (modem.c:2220)
==29==    by 0x4C8753: phonesim_exit (phonesim.c:1177)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==    by 0x5015F8: main (main.c:315)
==29==  Address 0x5133f58 is 56 bytes inside a block of size 96 free'd
==29==    at 0x484488F: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x4E90CB: hfp_ag_exit (hfp_ag_bluez5.c:516)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==    by 0x5015F8: main (main.c:315)
==29==  Block was alloc'd at
==29==    at 0x4841828: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x48EE762: g_malloc (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x48D3182: g_hash_table_new_full (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8FEB: hfp_ag_init (hfp_ag_bluez5.c:489)
==29==    by 0x50286D: __ofono_plugin_init (plugin.c:175)
==29==    by 0x5015C6: main (main.c:309)

...

==29== Invalid read of size 4
==29==    at 0x48D0483: g_hash_table_remove (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8D21: sim_watch (hfp_ag_bluez5.c:399)
==29==    by 0x502F65: call_watches (modem.c:314)
==29==    by 0x502FE2: __ofono_atom_unregister (modem.c:334)
==29==    by 0x503381: flush_atoms (modem.c:483)
==29==    by 0x50366D: modem_change_state (modem.c:586)
==29==    by 0x504225: set_powered (modem.c:974)
==29==    by 0x506966: modem_unregister (modem.c:2154)
==29==    by 0x506BD2: ofono_modem_remove (modem.c:2220)
==29==    by 0x4C8753: phonesim_exit (phonesim.c:1177)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==    by 0x5015F8: main (main.c:315)
==29==  Address 0x5133f28 is 8 bytes inside a block of size 96 free'd
==29==    at 0x484488F: free (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x4E90CB: hfp_ag_exit (hfp_ag_bluez5.c:516)
==29==    by 0x502925: __ofono_plugin_cleanup (plugin.c:201)
==29==    by 0x5015F8: main (main.c:315)
==29==  Block was alloc'd at
==29==    at 0x4841828: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==29==    by 0x48EE762: g_malloc (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x48D3182: g_hash_table_new_full (in /usr/lib/libglib-2.0.so.0.7800.3)
==29==    by 0x4E8FEB: hfp_ag_init (hfp_ag_bluez5.c:489)
==29==    by 0x50286D: __ofono_plugin_init (plugin.c:175)
==29==    by 0x5015C6: main (main.c:309)
---
 plugins/hfp_ag_bluez5.c | 216 +++++++++++++++++++++++++---------------
 1 file changed, 136 insertions(+), 80 deletions(-)

diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
index 15acf413f00c..13079ec702d4 100644
--- a/plugins/hfp_ag_bluez5.c
+++ b/plugins/hfp_ag_bluez5.c
@@ -53,10 +53,73 @@
 
 #define HFP_AG_DRIVER		"hfp-ag-driver"
 
-static guint modemwatch_id;
-static GList *modems;
-static GHashTable *sim_hash = NULL;
+static unsigned int modemwatch_id;
+struct l_queue *modem_infos;
 static GHashTable *connection_hash;
+static bool profile_registered;
+
+struct modem_info {
+	struct ofono_modem *modem;
+	unsigned int sim_watch;
+	unsigned int voicecall_watch;
+	unsigned int sim_state_watch;
+	struct ofono_sim *sim;
+};
+
+static void modem_info_free(struct modem_info *info)
+{
+	if (!info)
+		return;
+
+	if (info->sim_state_watch)
+		ofono_sim_remove_state_watch(info->sim, info->sim_state_watch);
+
+	if (info->voicecall_watch)
+		__ofono_modem_remove_atom_watch(info->modem,
+							info->voicecall_watch);
+
+	if (info->sim_watch)
+		__ofono_modem_remove_atom_watch(info->modem, info->sim_watch);
+
+	l_free(info);
+}
+
+static bool modem_matches(const void *data, const void *user_data)
+{
+	const struct modem_info *info = data;
+
+	return info->modem == user_data;
+}
+
+static unsigned int num_active(struct ofono_modem **first_active)
+{
+	const struct l_queue_entry *entry;
+	unsigned int n_active = 0;
+
+	for (entry = l_queue_get_entries(modem_infos);
+						entry; entry = entry->next) {
+		struct modem_info *info = entry->data;
+
+		if (!info->sim)
+			continue;
+
+		if (ofono_sim_get_state(info->sim) != OFONO_SIM_STATE_READY)
+			continue;
+
+		if (!__ofono_modem_find_atom(info->modem,
+						OFONO_ATOM_TYPE_VOICECALL))
+			continue;
+
+		n_active += 1;
+
+		if (first_active) {
+			*first_active = info->modem;
+			first_active = NULL;
+		}
+	}
+
+	return n_active;
+}
 
 static int hfp_card_probe(struct ofono_handsfree_card *card,
 					unsigned int vendor, void *data)
@@ -200,15 +263,13 @@ static DBusMessage *profile_new_connection(DBusConnection *conn,
 	}
 
 	/* Pick the first voicecall capable modem */
-	if (modems == NULL) {
+	if (!num_active(&modem)) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
 						".Rejected",
 						"No voice call capable modem");
 	}
 
-	modem = modems->data;
-
 	DBG("Picked modem %p for emulator", modem);
 
 	memset(&saddr, 0, sizeof(saddr));
@@ -341,114 +402,107 @@ static const GDBusMethodTable profile_methods[] = {
 	{ }
 };
 
-static void sim_state_watch(enum ofono_sim_state new_state, void *data)
+static void update_profile_registration(void)
 {
-	struct ofono_modem *modem = data;
 	DBusConnection *conn = ofono_dbus_get_connection();
+	unsigned int n_active = num_active(NULL);
 
-	if (new_state != OFONO_SIM_STATE_READY) {
-		if (modems == NULL)
-			return;
-
-		modems = g_list_remove(modems, modem);
-		if (modems != NULL)
-			return;
-
+	if (!n_active && profile_registered) {
+		DBG("Unregistering HFP AG profile");
 		bt_unregister_profile(conn, HFP_AG_EXT_PROFILE_PATH);
-
-		return;
+		profile_registered = false;
+	} else if (n_active == 1 && !profile_registered) {
+		DBG("Registering HFP AG profile");
+		bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_7, "hfp_ag",
+					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
+		profile_registered = true;
 	}
+}
 
-	if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL) == NULL)
-		return;
-
-	modems = g_list_append(modems, modem);
-
-	if (modems->next != NULL)
-		return;
+static void sim_state_watch_destroy(void *data)
+{
+	struct modem_info *info = data;
 
-	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_7, "hfp_ag",
-					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
+	info->sim_state_watch = 0;
+	info->sim = NULL;
 }
 
-static gboolean sim_watch_remove(gpointer key, gpointer value,
-				gpointer user_data)
+static void sim_state_watch(enum ofono_sim_state new_state, void *data)
 {
-	struct ofono_sim *sim = key;
+	update_profile_registration();
+}
 
-	ofono_sim_remove_state_watch(sim, GPOINTER_TO_UINT(value));
+static void sim_watch_destroy(void *data)
+{
+	struct modem_info *info = data;
 
-	return TRUE;
+	info->sim_watch = 0;
 }
 
 static void sim_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
 {
+	struct modem_info *info = data;
 	struct ofono_sim *sim = __ofono_atom_get_data(atom);
-	struct ofono_modem *modem = data;
-	int watch;
 
-	if (cond == OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
-		sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, modem);
-
-		sim_watch_remove(sim, g_hash_table_lookup(sim_hash, sim), NULL);
-		g_hash_table_remove(sim_hash, sim);
+	DBG("");
 
+	if (cond == OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, info);
+		info->sim = NULL;
 		return;
 	}
 
-	watch = ofono_sim_add_state_watch(sim, sim_state_watch, modem, NULL);
-	g_hash_table_insert(sim_hash, sim, GUINT_TO_POINTER(watch));
-	sim_state_watch(ofono_sim_get_state(sim), modem);
+	info->sim = sim;
+	info->sim_state_watch =
+		ofono_sim_add_state_watch(sim, sim_state_watch, info,
+						sim_state_watch_destroy);
+	sim_state_watch(ofono_sim_get_state(sim), info);
+}
+
+static void voicecall_watch_destroy(void *user)
+{
+	struct modem_info *info = user;
+
+	info->voicecall_watch = 0;
 }
 
 static void voicecall_watch(struct ofono_atom *atom,
 				enum ofono_atom_watch_condition cond,
 				void *data)
 {
-	struct ofono_atom *sim_atom;
-	struct ofono_sim *sim;
-	struct ofono_modem *modem;
-	DBusConnection *conn = ofono_dbus_get_connection();
-
-	if (cond == OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
-		return;
-
-	/*
-	 * This logic is only intended to handle voicecall atoms
-	 * registered in post_sim state or later
-	 */
-	modem = __ofono_atom_get_modem(atom);
-
-	sim_atom = __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
-	if (sim_atom == NULL)
-		return;
-
-	sim = __ofono_atom_get_data(sim_atom);
-	if (ofono_sim_get_state(sim) != OFONO_SIM_STATE_READY)
-		return;
-
-	modems = g_list_append(modems, modem);
-
-	if (modems->next != NULL)
-		return;
-
-	bt_register_profile(conn, HFP_AG_UUID, HFP_VERSION_1_7, "hfp_ag",
-					HFP_AG_EXT_PROFILE_PATH, NULL, 0);
+	DBG("");
+	update_profile_registration();
 }
 
 static void modem_watch(struct ofono_modem *modem, gboolean added, void *user)
 {
+	struct modem_info *info;
+
 	DBG("modem: %p, added: %d", modem, added);
 
-	if (added == FALSE)
+	if (added == FALSE) {
+		info = l_queue_remove_if(modem_infos, modem_matches, modem);
+		DBG("Removing modem %p, info: %p", modem, info);
+		modem_info_free(info);
 		return;
+	}
+
+	info = l_new(struct modem_info, 1);
+	info->modem = modem;
+
+	info->sim_watch =
+		__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+						sim_watch, info,
+						sim_watch_destroy);
+	info->voicecall_watch =
+		__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
+						voicecall_watch, info,
+						voicecall_watch_destroy);
 
-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
-					sim_watch, modem, NULL);
-	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
-					voicecall_watch, modem, NULL);
+	DBG("Adding modem %p, info: %p", modem, info);
+	l_queue_push_tail(modem_infos, info);
 }
 
 static void call_modemwatch(struct ofono_modem *modem, void *user)
@@ -461,6 +515,8 @@ static int hfp_ag_init(void)
 	DBusConnection *conn = ofono_dbus_get_connection();
 	int err;
 
+	DBG("");
+
 	if (DBUS_TYPE_UNIX_FD < 0)
 		return -EBADF;
 
@@ -481,7 +537,7 @@ static int hfp_ag_init(void)
 		return err;
 	}
 
-	sim_hash = g_hash_table_new(g_direct_hash, g_direct_equal);
+	modem_infos = l_queue_new();
 
 	modemwatch_id = __ofono_modemwatch_add(modem_watch, NULL, NULL);
 	__ofono_modem_foreach(call_modemwatch, NULL);
@@ -498,6 +554,8 @@ static void hfp_ag_exit(void)
 {
 	DBusConnection *conn = ofono_dbus_get_connection();
 
+	DBG("");
+
 	__ofono_modemwatch_remove(modemwatch_id);
 	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
@@ -506,9 +564,7 @@ static void hfp_ag_exit(void)
 
 	g_hash_table_destroy(connection_hash);
 
-	g_list_free(modems);
-	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
-	g_hash_table_destroy(sim_hash);
+	l_queue_destroy(modem_infos, (l_queue_destroy_func_t) modem_info_free);
 
 	ofono_handsfree_audio_unref();
 }
-- 
2.43.0

