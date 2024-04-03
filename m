Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469814BFB5
	for <ofono@lists.linux.dev>; Wed,  3 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160363; cv=none; b=dWnF1u80VSam22WRq1fqf68jtwNsXAcaf5gk7aFLDn51kZrInFauSVFqZq3lYGlxLn74srWHy7bXwdjl/GsUjxU2iQ9al/Hd/fG6Ga/KT9tG1c4oz7U55/eCssNY1U1j453R7LoJWvEiB64+a8CWuglMLv4AjeunRlO91bKpPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160363; c=relaxed/simple;
	bh=FyWc1Q0mtKOGVJ/yFXv3XkiWnhZ7+UwTfCoLIL0KW7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYAmcdlGkf0IHZdGWJYkExCBglPgrBNSHqPkFl7LD+tckcyr28ehzvUAnbqDB8vdbIQ7ldqlOysHg1ucReKb27qqwyyqqnY6i3yxiG+LhJA9KjL9DCFwK7RtmUamhKxr7Wfzm7KdtGm5HrLxQzPtj7mqmN00uKo1vevmMbzSppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCYTN5zu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCYTN5zu"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e69a9c0eaeso4242658a34.3
        for <ofono@lists.linux.dev>; Wed, 03 Apr 2024 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160361; x=1712765161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc68nD8Sb1qaFbkAdFK1A6KnzHAVOaQGteOyPMwLjE0=;
        b=LCYTN5zu3OJ5DMqt7bfGubK9KHAixvkrGUOf4/sUmgMywAC99V61j536Twl22ac3rQ
         0XU237kLQJTireE+GPxon7uFNmSd83QnWaPQw8cazjlp6e6IBZDighhmig3k832s+a3b
         U33UBaxnuC+UkRqJtrFIlN4YXuxKvwQrLdUXlqVQ3XwJQqX4XP4ROrdm6kgd+7lYIf3X
         aIrXj6KNTsGScDJ7t/h5lEh2dm/dXSslcw/biNyMzqaMIqGnR0h84Oq+nAvsmiyLBfbh
         VTje2dfHGwPpiCy39j7IzCX5tpmRLcuKPpEb/udP/xLYLSnU4wX9gbQ1goJPoXIXGL0F
         Ewfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160361; x=1712765161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc68nD8Sb1qaFbkAdFK1A6KnzHAVOaQGteOyPMwLjE0=;
        b=tXgUq0ifZ7ghID5gPl+Pm/VK4V+q/fDP1MS6CCdv8Wz8u2/4KDiUsMKTjcfpyxatJs
         NJRF2pqiIaNXUUPbxA+z5MgYw0MIX19TJRok3avLyYKB7vespZzDRbXrYAKM5i/7imnz
         mAl10OCT1QjEFda+nBGs8UWR0aPmrHcxFubEhyeVF2zynDNvdjgoRf3NdGEfV9/qhS8c
         AouTiLk3Tt56qDS3dHO3MR2tZfCL3kJrTWoRI//qz/RYakG9jNKZZv/bspAff1bBQywI
         V4j7deX9xEDPgjlqjjSL/Ngv4S1eYlUimavkyIo9+We9jQXzUfKj717IhTQVCpxypUsz
         CaUA==
X-Gm-Message-State: AOJu0YzAfDOtYkVbtI2kXMnHF2N+sx1osR8BaNqe9cytT3Kdgk2UKmn6
	1G6ls07NJ/UHNYwxdYZuYTHKJ3y0WfnV/eH0c8fblyR5xoNQTu+zsvN/niht
X-Google-Smtp-Source: AGHT+IG+TjcAhLbO5DPmcrCQ3rqL54YqmVBZ61iF1e4LplSz1F9LWzUAiHS7ysj/PcbAjkW3iod0Uw==
X-Received: by 2002:a9d:7844:0:b0:6e6:e347:55dc with SMTP id c4-20020a9d7844000000b006e6e34755dcmr16505009otm.4.1712160360838;
        Wed, 03 Apr 2024 09:06:00 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830100f00b006e6b018a703sm2653635otp.79.2024.04.03.09.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:06:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 02/14] sim: Simplify SPN management logic
Date: Wed,  3 Apr 2024 11:05:25 -0500
Message-ID: <20240403160557.2828145-2-denkenz@gmail.com>
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

The current implementation kicks off reading of the SPN only if an spn
watch has been registered.  This made sense at the time since the only
atoms that used spn were netreg and gprs.  Typically they were
initialized in the post_online state, which in effect delayed SPN
reading until that time.

With the introduction of provisioning inside the LTE atom, the spn watch
is always registered for LTE modems (nearly all modems now and going
forward).  Simplify the SPN reading logic by reading it once the sim has
been initialized by kicking off the read procedure inside sim_ready().

While here, remove tracking of cphs_spn_watch, ef_spn_watch and
cphs_spn_short_watch.  All sim file watches are automatically destroyed
once the ofono_sim_context is destroyed.
---
 src/sim.c | 353 +++++++++++++++++++++++-------------------------------
 1 file changed, 153 insertions(+), 200 deletions(-)

diff --git a/src/sim.c b/src/sim.c
index 8a97e87612d9..861cfe826f05 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -113,9 +113,6 @@ struct ofono_sim {
 	char *spn;
 	char *spn_dc;
 	struct ofono_watchlist *spn_watches;
-	unsigned int ef_spn_watch;
-	unsigned int cphs_spn_watch;
-	unsigned int cphs_spn_short_watch;
 
 	struct sim_fs *simfs;
 	struct sim_fs *simfs_isim;
@@ -139,13 +136,13 @@ struct ofono_sim {
 	GSList *aid_sessions;
 	GSList *aid_list;
 	char *impi;
-	bool reading_spn : 1;
 	bool language_prefs_update : 1;
 	bool fixed_dialing : 1;
 	bool barred_dialing : 1;
 	bool sdn_ready : 1;
 	bool initialized : 1;
 	bool wait_initialized : 1;
+	bool spn_initialized : 1;
 };
 
 struct cached_pin {
@@ -1532,6 +1529,137 @@ static void sim_own_numbers_changed(int id, void *userdata)
 	sim_own_numbers_update(sim);
 }
 
+static void spn_watch_cb(gpointer data, gpointer user_data)
+{
+	struct ofono_watchlist_item *item = data;
+	struct ofono_sim *sim = user_data;
+
+	if (item->notify)
+		((ofono_sim_spn_cb_t) item->notify)(sim->spn, sim->spn_dc,
+							item->notify_data);
+}
+
+static void sim_spn_set(struct ofono_sim *sim, const void *data, int length,
+						const unsigned char *dc)
+{
+	DBusConnection *conn = ofono_dbus_get_connection();
+	const char *path = __ofono_atom_get_path(sim->atom);
+
+	l_free(sim->spn);
+	sim->spn = NULL;
+
+	l_free(sim->spn_dc);
+	sim->spn_dc = NULL;
+
+	if (data == NULL)
+		goto notify;
+
+	/*
+	 * TS 31.102 says:
+	 *
+	 * the string shall use:
+	 *
+	 * - either the SMS default 7-bit coded alphabet as defined in
+	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
+	 *   justified. Unused bytes shall be set to 'FF'.
+	 *
+	 * - or one of the UCS2 code options defined in the annex of TS
+	 *   31.101 [11].
+	 *
+	 * 31.101 has no such annex though.  51.101 refers to Annex B of
+	 * itself which is not there either.  11.11 contains the same
+	 * paragraph as 51.101 and has an Annex B which we implement.
+	 */
+	sim->spn = sim_string_to_utf8(data, length);
+	if (sim->spn == NULL) {
+		ofono_error("EFspn read successfully, but couldn't parse");
+		goto notify;
+	}
+
+	if (strlen(sim->spn) == 0) {
+		l_free(sim->spn);
+		sim->spn = NULL;
+		goto notify;
+	}
+
+	if (dc)
+		sim->spn_dc = l_memdup(dc, 1);
+
+notify:
+	sim->spn_initialized = true;
+
+	if (sim->spn)
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_MANAGER_INTERFACE,
+						"ServiceProviderName",
+						DBUS_TYPE_STRING, &sim->spn);
+
+	g_slist_foreach(sim->spn_watches->items, spn_watch_cb, sim);
+}
+
+static void sim_cphs_spn_short_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_sim *sim = user_data;
+
+	if (!ok) {
+		sim_spn_set(sim, NULL, 0, NULL);
+		return;
+	}
+
+	sim_spn_set(sim, data, length, NULL);
+}
+
+static void sim_cphs_spn_read_cb(int ok, int length, int record,
+					const unsigned char *data,
+					int record_length, void *user_data)
+{
+	struct ofono_sim *sim = user_data;
+
+	if (!ok) {
+		if (__ofono_sim_cphs_service_available(sim,
+						SIM_CPHS_SERVICE_SHORT_SPN))
+			ofono_sim_read(sim->context,
+					SIM_EF_CPHS_SPN_SHORT_FILEID,
+					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+					sim_cphs_spn_short_read_cb, sim);
+		else
+			sim_spn_set(sim, NULL, 0, NULL);
+
+		return;
+	}
+
+	sim_spn_set(sim, data, length, NULL);
+}
+
+static void sim_spn_read_cb(int ok, int length, int record,
+				const unsigned char *data,
+				int record_length, void *user_data)
+{
+	struct ofono_sim *sim = user_data;
+
+	if (!ok) {
+		ofono_sim_read(sim->context, SIM_EF_CPHS_SPN_FILEID,
+				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+				sim_cphs_spn_read_cb, sim);
+
+		return;
+	}
+
+	sim_spn_set(sim, data + 1, length - 1, data);
+}
+
+static void sim_spn_changed(int id, void *userdata)
+{
+	struct ofono_sim *sim = userdata;
+
+	sim->spn_initialized = false;
+	ofono_sim_read(sim->context, SIM_EFSPN_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_spn_read_cb, sim);
+}
+
 static void sim_efimg_read_cb(int ok, int length, int record,
 				const unsigned char *data,
 				int record_length, void *userdata)
@@ -1622,6 +1750,18 @@ static void sim_ready(enum ofono_sim_state new_state, void *user)
 	ofono_sim_add_file_watch(sim->context, SIM_EFSDN_FILEID,
 					sim_service_numbers_changed, sim, NULL);
 
+	/* Service Provider Name (EFspn and CPHS equivalents) */
+	sim_spn_changed(SIM_EFSPN_FILEID, sim);
+	ofono_sim_add_file_watch(sim->context, SIM_EFSPN_FILEID,
+					sim_spn_changed, sim, NULL);
+	ofono_sim_add_file_watch(sim->context, SIM_EF_CPHS_SPN_FILEID,
+					sim_spn_changed, sim, NULL);
+
+	if (__ofono_sim_cphs_service_available(sim, SIM_CPHS_SERVICE_SHORT_SPN))
+		ofono_sim_add_file_watch(sim->context,
+					SIM_EF_CPHS_SPN_SHORT_FILEID,
+					sim_spn_changed, sim, NULL);
+
 	ofono_sim_read(sim->context, SIM_EFIMG_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_FIXED, sim_efimg_read_cb, sim);
 	ofono_sim_add_file_watch(sim->context, SIM_EFIMG_FILEID,
@@ -2611,37 +2751,6 @@ static void sim_free_early_state(struct ofono_sim *sim)
 	}
 }
 
-static void sim_spn_close(struct ofono_sim *sim)
-{
-	/*
-	 * We have not initialized SPN logic at all yet, either because
-	 * no netreg / gprs atom has been needed or we have not reached the
-	 * post_sim state
-	 */
-	if (sim->ef_spn_watch == 0)
-		return;
-
-	ofono_sim_remove_file_watch(sim->context, sim->ef_spn_watch);
-	sim->ef_spn_watch = 0;
-
-	ofono_sim_remove_file_watch(sim->context, sim->cphs_spn_watch);
-	sim->cphs_spn_watch = 0;
-
-	if (sim->cphs_spn_short_watch) {
-		ofono_sim_remove_file_watch(sim->context,
-						sim->cphs_spn_short_watch);
-		sim->cphs_spn_short_watch = 0;
-	}
-
-	sim->reading_spn = false;
-
-	l_free(sim->spn);
-	sim->spn = NULL;
-
-	l_free(sim->spn_dc);
-	sim->spn_dc = NULL;
-}
-
 static void aid_session_free(gpointer data)
 {
 	struct ofono_sim_aid_session *session = data;
@@ -2709,7 +2818,14 @@ static void sim_free_main_state(struct ofono_sim *sim)
 	sim->fixed_dialing = false;
 	sim->barred_dialing = false;
 
-	sim_spn_close(sim);
+	/* Service Provider Name related */
+	sim->spn_initialized = false;
+
+	l_free(sim->spn);
+	sim->spn = NULL;
+
+	l_free(sim->spn_dc);
+	sim->spn_dc = NULL;
 
 	if (sim->context) {
 		ofono_sim_context_free(sim->context);
@@ -2929,163 +3045,6 @@ enum ofono_sim_state ofono_sim_get_state(struct ofono_sim *sim)
 	return sim->state;
 }
 
-static void spn_watch_cb(gpointer data, gpointer user_data)
-{
-	struct ofono_watchlist_item *item = data;
-	struct ofono_sim *sim = user_data;
-
-	if (item->notify)
-		((ofono_sim_spn_cb_t) item->notify)(sim->spn, sim->spn_dc,
-							item->notify_data);
-}
-
-static inline void spn_watches_notify(struct ofono_sim *sim)
-{
-	if (sim->spn_watches->items)
-		g_slist_foreach(sim->spn_watches->items, spn_watch_cb, sim);
-
-	sim->reading_spn = false;
-}
-
-static void sim_spn_set(struct ofono_sim *sim, const void *data, int length,
-						const unsigned char *dc)
-{
-	DBusConnection *conn = ofono_dbus_get_connection();
-	const char *path = __ofono_atom_get_path(sim->atom);
-
-	l_free(sim->spn);
-	sim->spn = NULL;
-
-	l_free(sim->spn_dc);
-	sim->spn_dc = NULL;
-
-	if (data == NULL)
-		goto notify;
-
-	/*
-	 * TS 31.102 says:
-	 *
-	 * the string shall use:
-	 *
-	 * - either the SMS default 7-bit coded alphabet as defined in
-	 *   TS 23.038 [5] with bit 8 set to 0. The string shall be left
-	 *   justified. Unused bytes shall be set to 'FF'.
-	 *
-	 * - or one of the UCS2 code options defined in the annex of TS
-	 *   31.101 [11].
-	 *
-	 * 31.101 has no such annex though.  51.101 refers to Annex B of
-	 * itself which is not there either.  11.11 contains the same
-	 * paragraph as 51.101 and has an Annex B which we implement.
-	 */
-	sim->spn = sim_string_to_utf8(data, length);
-	if (sim->spn == NULL) {
-		ofono_error("EFspn read successfully, but couldn't parse");
-		goto notify;
-	}
-
-	if (strlen(sim->spn) == 0) {
-		l_free(sim->spn);
-		sim->spn = NULL;
-		goto notify;
-	}
-
-	if (dc)
-		sim->spn_dc = l_memdup(dc, 1);
-
-notify:
-	if (sim->spn)
-		ofono_dbus_signal_property_changed(conn, path,
-						OFONO_SIM_MANAGER_INTERFACE,
-						"ServiceProviderName",
-						DBUS_TYPE_STRING, &sim->spn);
-
-	spn_watches_notify(sim);
-}
-
-static void sim_cphs_spn_short_read_cb(int ok, int length, int record,
-					const unsigned char *data,
-					int record_length, void *user_data)
-{
-	struct ofono_sim *sim = user_data;
-
-	if (!ok) {
-		sim_spn_set(sim, NULL, 0, NULL);
-		return;
-	}
-
-	sim_spn_set(sim, data, length, NULL);
-}
-
-static void sim_cphs_spn_read_cb(int ok, int length, int record,
-					const unsigned char *data,
-					int record_length, void *user_data)
-{
-	struct ofono_sim *sim = user_data;
-
-	if (!ok) {
-		if (__ofono_sim_cphs_service_available(sim,
-						SIM_CPHS_SERVICE_SHORT_SPN))
-			ofono_sim_read(sim->context,
-					SIM_EF_CPHS_SPN_SHORT_FILEID,
-					OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-					sim_cphs_spn_short_read_cb, sim);
-		else
-			sim_spn_set(sim, NULL, 0, NULL);
-
-		return;
-	}
-
-	sim_spn_set(sim, data, length, NULL);
-}
-
-static void sim_spn_read_cb(int ok, int length, int record,
-				const unsigned char *data,
-				int record_length, void *user_data)
-{
-	struct ofono_sim *sim = user_data;
-
-	if (!ok) {
-		ofono_sim_read(sim->context, SIM_EF_CPHS_SPN_FILEID,
-				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-				sim_cphs_spn_read_cb, sim);
-
-		return;
-	}
-
-	sim_spn_set(sim, data + 1, length - 1, data);
-}
-
-static void sim_spn_changed(int id, void *userdata)
-{
-	struct ofono_sim *sim = userdata;
-
-	if (sim->reading_spn)
-		return;
-
-	sim->reading_spn = true;
-	ofono_sim_read(sim->context, SIM_EFSPN_FILEID,
-			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-			sim_spn_read_cb, sim);
-}
-
-static void sim_spn_init(struct ofono_sim *sim)
-{
-	sim->ef_spn_watch = ofono_sim_add_file_watch(sim->context,
-					SIM_EFSPN_FILEID, sim_spn_changed, sim,
-					NULL);
-
-	sim->cphs_spn_watch = ofono_sim_add_file_watch(sim->context,
-					SIM_EF_CPHS_SPN_FILEID,
-					sim_spn_changed, sim, NULL);
-
-	if (__ofono_sim_cphs_service_available(sim,
-						SIM_CPHS_SERVICE_SHORT_SPN))
-		sim->cphs_spn_short_watch = ofono_sim_add_file_watch(
-				sim->context, SIM_EF_CPHS_SPN_SHORT_FILEID,
-				sim_spn_changed, sim, NULL);
-}
-
 ofono_bool_t ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *id,
 					ofono_sim_spn_cb_t cb, void *data,
 					ofono_destroy_func destroy)
@@ -3110,13 +3069,7 @@ ofono_bool_t ofono_sim_add_spn_watch(struct ofono_sim *sim, unsigned int *id,
 
 	*id = watch_id;
 
-	if (sim->ef_spn_watch == 0) {
-		sim_spn_init(sim);
-		sim_spn_changed(0, sim);
-		return TRUE;
-	}
-
-	if (sim->reading_spn)
+	if (!sim->spn_initialized)
 		return TRUE;
 
 	((ofono_sim_spn_cb_t) item->notify)(sim->spn, sim->spn_dc,
-- 
2.43.0

