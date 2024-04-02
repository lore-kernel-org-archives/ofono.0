Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44C3234
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097060; cv=none; b=FwIQHRKWVM84a//8Zk3atfMeydIkPxfUCE4Wlh8C138JExd4boMGuHZ3nGS1G8QKw0/jhVBi5bF1484j+tlurShukcxJQrIJYsBwEUQ4EjRF+SumuOKjAlNJXNlgWYCCgp+WH+t325M31IfICkOHNmrewgt4ItPm2UTlqI662/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097060; c=relaxed/simple;
	bh=FyWc1Q0mtKOGVJ/yFXv3XkiWnhZ7+UwTfCoLIL0KW7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSjESlGERZQkWMiwNg0IOsNtB5nfnsAnSnmPFRhO/DTv2UuzBpOAWMJQsY/0u/1uCUL88cFTOW7TA4mACdm7ypAPE17OhSaTr1X8OoOjGpkrfMRarjmEJw4XceYVccWB0LRYzeGz56Wjrpw7lyKORXPp/DXmdoCZQlFgERSz/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abFEIR47; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abFEIR47"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a4f7a648dbso3653137eaf.3
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097058; x=1712701858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc68nD8Sb1qaFbkAdFK1A6KnzHAVOaQGteOyPMwLjE0=;
        b=abFEIR47sNeDlzsiNeXuBhOOd0ULK5HNbzdkrbWbDdLzuIwyhiig/+cKWX6RBoQZJ6
         uoYTP59obAycDvDf+DlY2hJa02QHVsp5xuQpvQcpRT2TwyjZlzTu7qvX69j5iP0hcEBi
         Vsy3OUQWzx+YHefsgNWkHYF8Hg5nZR9fCa+cGVTgC0I2LO6XJBqhK1JWmiWmWW3I+X+f
         N/7gi8En3X69lKy8ROSaMYlvVoVcQvt++NwUskwVRTgxz6vd0kWO5aE30RziobpTCPOg
         8jQp21etOU5dlkh1gdwBzlYIbe0iEsU2F00AGJxd3Mnnkc/l63Jn6wjFWPhebmWhCHTw
         fX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097058; x=1712701858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc68nD8Sb1qaFbkAdFK1A6KnzHAVOaQGteOyPMwLjE0=;
        b=Adlh0OcxTU9QJJS+jaUzaxpmD6xck4X1ezLtOm/wnH5HdHMHlQyhYGHLgiZPC2eo9v
         1wwIAEpU4WtiQErZ1z+SzTyrZjpSavWgA4I4XdJ/UF1MPMZ1oRmzCRPqbVWAjPm7KjwA
         Sqgebp+xhHAUeKlgHSvTsSFdEkqivsvU37RSyQMIaOVo23OmgdUwszdRNBSfX+vZ/fKx
         1mQbf6SPVIsYbwxQWHY0LNaFVAdz2QdQple2pSXZy0y3MoaM2GmSI0KkbZdOFfkoz0NZ
         4cktKD8WpDFJFEGV10Rm54d6sRb27v6Mg+Z0pYb7ZVrjnyKJ+/suY06fT2FZ+gouSPN2
         0M5g==
X-Gm-Message-State: AOJu0Ywnx4hvU2AE6LaFt9mkWnQRTZxA5fatrUKAavJ7iE9l+KyckysM
	gGIGCNjAvMPKy49CJGD04s46Is9AzR9mczO1hDoWUBuP0UPyfA5TH03enW7u
X-Google-Smtp-Source: AGHT+IHdSnR2AWT0X/YKQKbRnZkUr9Uew/NhLuHOTx8oCmCbh+NFf9oKD+58mIUkAdQPaDvnKzNWEg==
X-Received: by 2002:a05:6820:2903:b0:5a5:16e1:beb3 with SMTP id dp3-20020a056820290300b005a516e1beb3mr14831822oob.0.1712097057591;
        Tue, 02 Apr 2024 15:30:57 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:30:57 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/13] sim: Simplify SPN management logic
Date: Tue,  2 Apr 2024 17:30:27 -0500
Message-ID: <20240402223054.2819526-2-denkenz@gmail.com>
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

