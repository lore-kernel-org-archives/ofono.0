Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1A3FC7
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:22 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id m14so8247108wrg.13
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KbCHvUxnOjBfBV1L5S8k95qdHWxF8IN19kFZqqtS3o=;
        b=NmkdoeKWNZn6onWoqXdUjePZe/Qas825O3rQbgzzC4s79GA6mZ9Gy/zLglQzb6QXhK
         0GHhvVxZ/GGha7M5Y+Ynv4aamlIHbX01nnyNQDBg9fdEqhZ8RLLihjwhDDTIabZlPmCd
         9D3ZPvzTATdSHHmYmrP+5TatYVUwNVZy45k4zRoUAT5Q8LhMzYbT2fC8EJYUhd04ZZcS
         p1QSA0e65t1+ruKlt5KCEW2fnXvbTUOxahnakUJ2Uu1I3nWqM/HefFu3RvAYcvvqeybL
         LfdAzFMlnSsHtOcAORDciUJEzRMc+QTinaZXID9bJTUgSp8hKFBqTBU0Icho11k8RNA+
         +lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KbCHvUxnOjBfBV1L5S8k95qdHWxF8IN19kFZqqtS3o=;
        b=yDYnJlZD8ZK/Pej7t/QVNhZoE9Ak1j91ao58OJf2NUXsVutLTb6k08ID9U2S//St1g
         bBfiqTL0rXq9Ib0tNyguNeo0jr11bwEaEmaXQx9vPUQW3hezAsdc79+kmHgMZex+TgbM
         enT8WT4X7FB0OC+o4XDn5uvyt79Z9k7PL5aQu04pSz65SBsoHpg2KMW3LbDtkfUVLa/c
         IbB+YwYmBeaUHyNPpBGTTAYCaLlvNCF+pHRqW+jGKKWRIkovzUrMidTADxzZJMVucQEM
         BT9iY+/mFo620SA1EjgzLBJukGKzxc/zPzj1ke7v1vtQYo69TjFxRaNzTwxnY3YmJFkJ
         Wm/Q==
X-Gm-Message-State: AO0yUKU6dS2EmkPf5V/i6prA9SRskIrut1Y9tePSNmsHSgBXEwAEz0Gf
	xZB28gmbvxurl0eq9zc/Kx7Jp3vFTEc5ZAWuzRsuDw==
X-Google-Smtp-Source: AK7set9re7Kv1oP2Sr8T/MpOvgLeAOSOIgo2+SY6Q/DCZErlHx13hgFzbpXDOowqfuTEr9OLO0MZRg==
X-Received: by 2002:adf:cd10:0:b0:2be:338f:bc55 with SMTP id w16-20020adfcd10000000b002be338fbc55mr15397905wrm.66.1676139080271;
        Sat, 11 Feb 2023 10:11:20 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:19 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 2/5] gprs: rework have_active_contexts() to check for non-active contexts
Date: Sat, 11 Feb 2023 20:11:02 +0200
Message-Id: <20230211181105.7220-3-alex@shruggie.ro>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211181105.7220-1-alex@shruggie.ro>
References: <20230211181105.7220-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to add LTE support to the Quectel BG95-M3 modem, we've run
into a bit of a chicken-n-egg dilemma.

While ofono has enumerated (successfully) the GPRS contexts (from the
modem), we got only one (IP), but it's not active.

And trying to activate it, would yield a NotAttached error (via DBus).

The BG95-M3 modem supports Cat M1/Cat NB2/EGPRS LTE.

This situation would show up when trying to connect to an operator that
only has "lte-cat-m1" tech (and nothing else). If it the operator would
also advertise "gsm" tech, ofono would connect via "gsm".

Now, this could be a particularity of this modem (BG95-M3), in which case
it may be an idea to add a hook into the quectel plugin/driver to check the
attached status.

But for now, it seems that allowing the Attached state to be reported for
any present GPRS contexts (even non-active), seems to work.

For EUTRAN, this behavior is still maintained.
---
 src/gprs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 950b40fc..4befe88a 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1515,18 +1515,24 @@ void ofono_gprs_resume_notify(struct ofono_gprs *gprs)
 	update_suspended_property(gprs, FALSE);
 }
 
-static gboolean have_active_contexts(struct ofono_gprs *gprs)
+static gboolean have_contexts(struct ofono_gprs *gprs, bool must_be_active)
 {
 	GSList *l;
 	struct pri_context *ctx;
+	int ctx_count = 0;
 
 	for (l = gprs->contexts; l; l = l->next) {
 		ctx = l->data;
 
 		if (ctx->active == TRUE)
 			return TRUE;
+
+		ctx_count++;
 	}
 
+	if (!must_be_active && ctx_count > 0)
+		return TRUE;
+
 	return FALSE;
 }
 
@@ -1621,7 +1627,8 @@ static void gprs_attached_update(struct ofono_gprs *gprs)
 	ofono_bool_t attached;
 	int status = gprs->status;
 
-	if (on_lte(gprs))
+	if (on_lte(gprs)) {
+		int tech = ofono_netreg_get_technology(gprs->netreg);
 		/*
 		 * For LTE we attached status reflects successful context
 		 * activation.
@@ -1630,11 +1637,12 @@ static void gprs_attached_update(struct ofono_gprs *gprs)
 		 * expect the gprs status to be unknown. That must not
 		 * result in detaching...
 		 */
-		attached = have_active_contexts(gprs);
-	else
+		attached = have_contexts(gprs, tech == ACCESS_TECHNOLOGY_EUTRAN);
+	} else {
 		attached = gprs->driver_attached &&
 			(status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
 				status == NETWORK_REGISTRATION_STATUS_ROAMING);
+	}
 
 	if (attached == gprs->attached)
 		return;
-- 
2.34.1

