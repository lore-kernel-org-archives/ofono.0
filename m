Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A3762F5
	for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649759; cv=none; b=H7Rez5DKkqqUTlYvzThk+5IbiDJzfdR/j+D5cqyue6mqSR7n+Gye0H4DlLQR002X3h9sO9+CjjL3hFpzZXlYBsLkDy2VLUjahhxRTTXm1gHG3kthuCoeqqD6gQCpBUL5c6lXn4vRCyGiD+j0btOwYxxHfhlxPc6+B+SB1C8qfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649759; c=relaxed/simple;
	bh=X0vrAGIBKKFDTAps+KOrfmw2qO86PQaIDc0Ihh/rDvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtzbW4pLaHeJQg1lVxppRjgHVjFCQi6OuAzJbJxmioO3w8jqSlPYsQ/GR53kMbhpoTjvPPLozqsMG354U1e5NmQ3HvULzuPiL7VXbPczrDL2UQotdQXA2ZB09i192tNCfWjc1alXzY6ugGbZR01hAC1re2w3ZBB8LZtolr/WaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsOUcyNR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsOUcyNR"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2185a9966bcso123813fac.0
        for <ofono@lists.linux.dev>; Tue, 30 Jan 2024 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706649757; x=1707254557; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eKAng6k2Govtm1grkqVM5DJwcbaIUMW2LdH0r3DYNg=;
        b=dsOUcyNR1lUf1iMoz6kBwY9nR9DcDqOT7V0xccQxqEY0oogsc/o0dYBCcaOeV3EUGG
         4QtedFL/rcS6IkMKBwVZNJwqVphNCqTcg84pQRcgVKMPfPdOaQVm2auTMGAmTiNsDDIk
         wuBiRk4CzCLW8tUtFVkt7ztx1K2SuY4ADdSKjOfXhvYxXnQDyzGs/q8JXmz5F3aK+XBO
         enIxoxUBrytgptQqXOzIS6nTgoh6dDZL1s8Uy+PkbHtv2HFAETncUrHhzqvGWgOXodhI
         N24WQ5WZCP4lrj5Z23zMeHiCNgkFsYkxcTHaTfvpQBWZoSvAkT8jF8qIdw2Fg2CzekRQ
         dFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706649757; x=1707254557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eKAng6k2Govtm1grkqVM5DJwcbaIUMW2LdH0r3DYNg=;
        b=seUsgTLfhrCdw3LhXiw0OfBcIXbfj9/vpUprV57yTUPTvyhx/96oouW2F9LVA9+a3j
         AmO+0vGhtu2Hj0OY9q+2xEF3IFZtCssFaqib6IqK5Dp89+HCs4ZqOczttq+E90vqh7Po
         UXZuOxhwDbeU315e/8l75Dmrm7rHKaaMsDOXJAE96wlVFUeycuZNqzW6Y5i3nGnoGbwq
         8N+YPzZKUU48WcINysiOl05CobwGmnsAkOc5gKnlGs+HAQVuRJGw6poNNLgj7eVmbZ31
         POqXp3JOhRnzaY7jdkygUMrDanv2mbyp6g7Gp5a9LbUD8xWhXDp+uEn5IjjNAQ7F4cgl
         kflA==
X-Gm-Message-State: AOJu0Yw5N3TiMuRQZurCqob77EBurVz1x/C2fQudIbIsQGGBXqRFvQL5
	m/cKr5WRC8e/a7Kb7dAgWK7J7JKWJQ0sGn0vmP6vPH/7yjr+mFpBEoB+9rXx
X-Google-Smtp-Source: AGHT+IHHU/BpxkO8qY3jCQ3fWJDVJt5kr8HXiYDqOlfbQm8Hmo0d31n2xit2U7i5rUzzARn0IHIMIA==
X-Received: by 2002:a05:6870:b253:b0:218:54f8:b9aa with SMTP id b19-20020a056870b25300b0021854f8b9aamr885914oam.15.1706649757212;
        Tue, 30 Jan 2024 13:22:37 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2105786oal.0.2024.01.30.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:22:36 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 17/17] lte: Write provisioned info to disk
Date: Tue, 30 Jan 2024 15:21:22 -0600
Message-ID: <20240130212137.814082-17-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130212137.814082-1-denkenz@gmail.com>
References: <20240130212137.814082-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If provisioning succeeded, then save the information to disk.  Next time
the modem is powered, the saved information will be used instead of
being obtained via provisioning.
---
 src/lte.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/lte.c b/src/lte.c
index 433b18956468..c3decc5c891c 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -451,11 +451,37 @@ static void spn_read_cb(const char *spn, const char *dc, void *data)
 	struct ofono_lte *lte = data;
 	struct ofono_modem *modem = __ofono_atom_get_modem(lte->atom);
 	struct ofono_sim *sim = __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	bool r;
 
 	ofono_sim_remove_spn_watch(sim, &lte->spn_watch);
 
-	provision_default_attach_info(lte, ofono_sim_get_mcc(sim),
-					ofono_sim_get_mnc(sim), spn);
+	r = provision_default_attach_info(lte, ofono_sim_get_mcc(sim),
+						ofono_sim_get_mnc(sim), spn);
+	if (r) {
+		const char *str;
+
+		if (lte->info.apn[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+						LTE_APN, lte->info.apn);
+
+		if (lte->info.username[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_USERNAME, lte->info.username);
+
+		if (lte->info.password[0])
+			l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_PASSWORD, lte->info.password);
+
+		str = gprs_proto_to_string(lte->info.proto);
+		l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_PROTO, str);
+
+		str = gprs_auth_method_to_string(lte->info.auth_method);
+		l_settings_set_string(lte->settings, SETTINGS_GROUP,
+					LTE_AUTH_METHOD, str);
+
+		lte_save_settings(lte);
+	}
 
 	if (lte->driver->set_default_attach_info) {
 		lte->driver->set_default_attach_info(lte, &lte->info,
-- 
2.43.0

