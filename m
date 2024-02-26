Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48115ACB
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918655; cv=none; b=rn9EEe89imNr5eABde/V48I6i9DoFUznzhYOjIC6Q0KijwjwgdUR1QzFu2rn84lhuMFAkZaTAhVMPlUmo5Dx5yPwUO5IWwmWxgJSGezr1XdSRGln+zg9j9BJeGFYPydOATQDmBPf3ROl6PnCCfkU1dspVy7HCjRj0dSHEqLzqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918655; c=relaxed/simple;
	bh=EeAVPglO9HFH1Y/J3+HRJP1EugqVaCyhJf6KvzsJUGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTEj0WNLX363BurAZZGZkXlxSXJCQIp/+ojKG6YWY8R0kWq/3B9rBrU/3KqOodwC8ELvrCmM8UftHHcG7tpqcMMtVh1NIyOlhaM48aglj2bcjXY3/Xx5HfqriblVRBcw6m082cYZ95BGV4O9k/PgaNTrln2jIW5gycqagP5IUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRjCMd/Q; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRjCMd/Q"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e45ef83c54so1692736a34.2
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918652; x=1709523452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZFPxTyv6haRgogEhOYv9s05kEjB+b3MvYxemJGngPU=;
        b=FRjCMd/Q1BNOHMoqiQTefA1KUQuw7I8Jgq5gp3myZXxT73ICIdj7UHGhQ3T2VA+ACS
         RLRoKJ8RQDraW1zB5gN1tMlWAuRiVn6VyrEwEqHnIzY5BhpGTXNl7680MuQKI4Wmv7gX
         J21xFrWG3Pb4aY+WJWjMP1dPLAyDDslrBnbX79WvSaI01S6YOIHdMgKOGaVSv1+Mz2nw
         eZfMe6e4hbg6z3luPVaE5GYwSDA7suftB+uLcjkQwsTRoTIuRzOTWZZJOMXmeiZTBROv
         6y6+eXpaWBztDgltVnfaNpJeJQqWEKrKes4YbCnGKPMCTwJbK88UTdtZIOQryH9i27f/
         ELdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918652; x=1709523452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZFPxTyv6haRgogEhOYv9s05kEjB+b3MvYxemJGngPU=;
        b=Bt++wOYiwORZOcbae5DZUqek0oa999bgjmvlLwd8rpb2Yt50xUh/eXqvYOySb4O8C0
         Hhsl+LmBdGVljFAch/D9wqAejdoYDfD6eXmq0UQlDt6InV7cNkSQdHqqQy61ea5Zaw9g
         ZZzmS43ySha4GbR8LMViD2iYDM3T57p8Nj+ZhOK58bKdQuw14BjEqSTm+SHAJozKCovk
         pH3GTsqAXaej4CVQmdUHrR8dKhLi385Imn/LAxlTsg57FBLOs/A6SMknf1sB63qG0mYL
         ki9VFpCUqR5LAtlSVQ3OnKhisdQpidAbw+Yt9nfWkWqGd/lQyzOvW13UZU1PO1wMymd+
         yaeg==
X-Gm-Message-State: AOJu0Yy4OtXeeXSyX03CeVjOQOx/uHTsRsArUVabVFg7xgker/DZhi7g
	K4/STgoDjrL+1WfxZ887JkBXkfs31AaTi/7fmP+Tw1BAOULzeOgKBbPaeNkX
X-Google-Smtp-Source: AGHT+IHRpS4GMTePqPBce1/fgXcXQyyRFDfif2vz1PppU6z1xEdHPnwhnzAmMqlPjdSz22nS1Bpg2w==
X-Received: by 2002:a05:6808:3088:b0:3c1:5312:6de2 with SMTP id bl8-20020a056808308800b003c153126de2mr8401553oib.47.1708918652713;
        Sun, 25 Feb 2024 19:37:32 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:32 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/22] smsutil: Remove g_strdup_printf use
Date: Sun, 25 Feb 2024 21:36:53 -0600
Message-ID: <20240226033724.1460079-10-denkenz@gmail.com>
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

Replace with l_strdup_printf.  While here also replace use of g_free
with free() where data returned by the invocation of standard C
functions needs to be freed.
---
 src/smsutil.c | 71 ++++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 05942d6fe56b..954f92df2c0d 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2442,10 +2442,10 @@ static void sms_assembly_load(struct sms_assembly *assembly,
 	if (sms_assembly_extract_address(straddr, &addr) == FALSE)
 		return;
 
-	path = g_strdup_printf(SMS_BACKUP_PATH "/%s",
+	path = l_strdup_printf(SMS_BACKUP_PATH "/%s",
 			assembly->imsi, dir->d_name);
 	len = scandir(path, &segments, NULL, versionsort);
-	g_free(path);
+	l_free(path);
 
 	if (len < 0)
 		return;
@@ -2467,11 +2467,11 @@ static void sms_assembly_load(struct sms_assembly *assembly,
 		if (!sms_deserialize(buf, &segment, r))
 			continue;
 
-		path = g_strdup_printf(SMS_BACKUP_PATH "/%s/%s",
+		path = l_strdup_printf(SMS_BACKUP_PATH "/%s/%s",
 				assembly->imsi,
 				dir->d_name, segments[i]->d_name);
 		r = stat(path, &segment_stat);
-		g_free(path);
+		l_free(path);
 
 		if (r != 0)
 			continue;
@@ -2529,18 +2529,18 @@ static void sms_assembly_backup_free(struct sms_assembly *assembly,
 		int bit = 1 << (seq % 32);
 
 		if (node->bitmap[offset] & bit) {
-			path = g_strdup_printf(SMS_BACKUP_PATH_FILE,
+			path = l_strdup_printf(SMS_BACKUP_PATH_FILE,
 					assembly->imsi, straddr,
 					node->ref, node->max_fragments, seq);
 			unlink(path);
-			g_free(path);
+			l_free(path);
 		}
 	}
 
-	path = g_strdup_printf(SMS_BACKUP_PATH_DIR, assembly->imsi, straddr,
+	path = l_strdup_printf(SMS_BACKUP_PATH_DIR, assembly->imsi, straddr,
 				node->ref, node->max_fragments);
 	rmdir(path);
-	g_free(path);
+	l_free(path);
 }
 
 struct sms_assembly *sms_assembly_new(const char *imsi)
@@ -2555,9 +2555,9 @@ struct sms_assembly *sms_assembly_new(const char *imsi)
 
 		/* Restore state from backup */
 
-		path = g_strdup_printf(SMS_BACKUP_PATH, imsi);
+		path = l_strdup_printf(SMS_BACKUP_PATH, imsi);
 		len = scandir(path, &entries, NULL, alphasort);
-		g_free(path);
+		l_free(path);
 
 		if (len < 0)
 			return ret;
@@ -2843,10 +2843,9 @@ struct status_report_assembly *status_report_assembly_new(const char *imsi)
 		ret->imsi = imsi;
 
 		/* Restore state from backup */
-		path = g_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
+		path = l_strdup_printf(SMS_SR_BACKUP_PATH, imsi);
 		len = scandir(path, &addresses, NULL, alphasort);
-
-		g_free(path);
+		l_free(path);
 
 		if (len < 0)
 			return ret;
@@ -2912,11 +2911,10 @@ static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
 	if (encode_hex_own_buf(sha1, SMS_MSGID_LEN, 0, msgid_str) == FALSE)
 		return FALSE;
 
-	path = g_strdup_printf(SMS_SR_BACKUP_PATH_FILE,
+	path = l_strdup_printf(SMS_SR_BACKUP_PATH_FILE,
 					imsi, straddr, msgid_str);
-
 	unlink(path);
-	g_free(path);
+	l_free(path);
 
 	return TRUE;
 }
@@ -3232,9 +3230,9 @@ static GSList *sms_tx_load(const char *imsi, const struct dirent *dir)
 	if (dir->d_type != DT_DIR)
 		return NULL;
 
-	path = g_strdup_printf(SMS_TX_BACKUP_PATH "/%s", imsi, dir->d_name);
+	path = l_strdup_printf(SMS_TX_BACKUP_PATH "/%s", imsi, dir->d_name);
 	len = scandir(path, &pdus, sms_tx_load_filter, versionsort);
-	g_free(path);
+	l_free(path);
 
 	if (len < 0)
 		return NULL;
@@ -3287,7 +3285,7 @@ GQueue *sms_tx_queue_load(const char *imsi)
 	if (imsi == NULL)
 		return NULL;
 
-	path = g_strdup_printf(SMS_TX_BACKUP_PATH, imsi);
+	path = l_strdup_printf(SMS_TX_BACKUP_PATH, imsi);
 
 	len = scandir(path, &entries, sms_tx_queue_filter, versionsort);
 	if (len < 0)
@@ -3329,24 +3327,24 @@ GQueue *sms_tx_queue_load(const char *imsi)
 			continue;
 		}
 
-		oldpath = g_strdup_printf("%s/%s", path, dir->d_name);
-		newpath = g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
+		oldpath = l_strdup_printf("%s/%s", path, dir->d_name);
+		newpath = l_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
 						imsi, id++, flags, uuid);
 
 		/* rename directory to reflect new position in queue */
 		rename(oldpath, newpath);
 
-		g_free(newpath);
-		g_free(oldpath);
+		l_free(newpath);
+		l_free(oldpath);
 	}
 
 	for (i = 0; i < len; i++)
-		g_free(entries[i]);
+		free(entries[i]);
 
-	g_free(entries);
+	free(entries);
 
 nodir_exit:
-	g_free(path);
+	l_free(path);
 	return retq;
 }
 
@@ -3382,7 +3380,7 @@ void sms_tx_backup_free(const char *imsi, unsigned long id,
 	struct dirent **entries;
 	int len;
 
-	path = g_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
+	path = l_strdup_printf(SMS_TX_BACKUP_PATH_DIR,
 					imsi, id, flags, uuid);
 
 	len = scandir(path, &entries, NULL, versionsort);
@@ -3393,22 +3391,22 @@ void sms_tx_backup_free(const char *imsi, unsigned long id,
 	/* skip '..' and '.' entries */
 	while (len-- > 2) {
 		struct dirent *dir = entries[len];
-		char *file = g_strdup_printf("%s/%s", path, dir->d_name);
+		char *file = l_strdup_printf("%s/%s", path, dir->d_name);
 
 		unlink(file);
-		g_free(file);
+		l_free(file);
 
-		g_free(entries[len]);
+		free(entries[len]);
 	}
 
-	g_free(entries[1]);
-	g_free(entries[0]);
-	g_free(entries);
+	free(entries[1]);
+	free(entries[0]);
+	free(entries);
 
 	rmdir(path);
 
 nodir_exit:
-	g_free(path);
+	l_free(path);
 }
 
 void sms_tx_backup_remove(const char *imsi, unsigned long id,
@@ -3417,11 +3415,10 @@ void sms_tx_backup_remove(const char *imsi, unsigned long id,
 {
 	char *path;
 
-	path = g_strdup_printf(SMS_TX_BACKUP_PATH_FILE,
+	path = l_strdup_printf(SMS_TX_BACKUP_PATH_FILE,
 					imsi, id, flags, uuid, seq);
 	unlink(path);
-
-	g_free(path);
+	l_free(path);
 }
 
 static inline GSList *sms_list_append(GSList *l, const struct sms *in)
-- 
2.43.0

