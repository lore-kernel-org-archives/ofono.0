Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A013211E
	for <ofono@lists.linux.dev>; Tue,  9 Jul 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565454; cv=none; b=kjdV3z8dDZEn5C41nP41CE20TbS6s5iit2HJImj7Xfj4CWI2v4nK4thN+6oCNC4Qwbr6KE1u12/3AmTxJbG/Q0oCBQMeyBoYUFsT6QjnX36DBz8JSWQ3qJM5WfFjEdbgq4gBUhP0iFo7yzFE2xueUK+h8VLsfjIi2g11IjgJ/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565454; c=relaxed/simple;
	bh=0UKrj6psPpqKrHfsfXGzVkrlHHzbsnYn0x2SxeReDmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/Dnd9pu7QYD2nol7ah08GkBPHj1VP9FPD49+EE3+X+U2pOBJWB9keFThU8b1SzNpSvSTzEH/oPRfzjiALXyNuv3ZCfUrOIlHn84OtL0o6d6OsTu/190TvSi02w6N8ypk6RSbMiw/JVDR9DnZ9EN7CIC7lUrUr++6DAGnXxGd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQzvmZzJ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQzvmZzJ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-375e96f5fddso22001745ab.1
        for <ofono@lists.linux.dev>; Tue, 09 Jul 2024 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720565452; x=1721170252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=BQzvmZzJSq7EuvljSLuwpKdkeMYAGmtx+TDOc9ylDNSlo2q6rgQFrRPSf9Mxw46WS/
         vwIHAGhXF5LRaGBiUVJJC3RZWtgVNxwxZtQ1Hleb6zvvRA8LqQNdWCA6DwbIgiygT/qZ
         GIpBvZ6OGigBmOc3gmsJDzoneBsJo0uft2XMBk8/OnrNRO4p25dgJlZL9/xpY58Mv0OF
         eBrXBPSe/PyqAg+o9YkFNU2zcnxubGX9QtGYn07meb/Iy6kuVW8xh2oS8KfLiWO7cM7g
         ehYAKdStp29IrdvKXxWMaS8vB2gYS3w3zq0djtA0/q+RFRubRVkO1/NOicCt4FbEKhq3
         /YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720565452; x=1721170252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs8F02vWqEf3iOs19nUa1+NSb0ZJzw+ofar/3zu1nbw=;
        b=fcLh6gq+yxDuSXSPJRAFCQtNJqvdqPVPOR63NWXcEZMTNo/kRvg/rJxcs5dud8wllF
         75HLAkXJRQMTJTyV2eEBKlX9UL3oPsMnKgBkLDMb/Q0vUG31m/teRnPJs7txpvr/ptwj
         QAjK1+abZMrc/wx0gW8nqBa1GZAhvMzs4GC4CZI0q2pkcEC5YBUOHvqvG94rwSFyDOSu
         MhFIN0GYVqyetGCg+YHhgSVtKSEWLHo1pB1IKkQ+6gpbfu40RSQcMQS+PE/SJ8DNICm8
         CjZJNcCh7eDiXyFbxaL9sovWcgYmMKoMiNMPlRgaTVvHodza1QlaNNR7W8k9BV1Ptxba
         l4mA==
X-Gm-Message-State: AOJu0YzYUmFQdnaOl0CNB8f+a/O/uZnea+WIkp1njDRc3zc6fPoBRQbU
	Uf0EFFrETs27SsxEL1XvN5uLjQTMztOwjAiIOrrgJ2wugBEYDbxs5GkArw==
X-Google-Smtp-Source: AGHT+IGYuPU7B4STNut8rJKLR1X8UAMZsqIDPCnqUoAOB9egdFLZykxYHQk1WyQd863W2jrx7Rew1A==
X-Received: by 2002:a05:6e02:1568:b0:380:c1e5:5fd6 with SMTP id e9e14a558f8ab-38a578e3116mr46135275ab.13.1720565451798;
        Tue, 09 Jul 2024 15:50:51 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49075808sm6300075ab.15.2024.07.09.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:50:51 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/11] qmi: gprs-context: Remove parsing of unused TLVs
Date: Tue,  9 Jul 2024 17:50:25 -0500
Message-ID: <20240709225047.1427626-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709225047.1427626-1-denkenz@gmail.com>
References: <20240709225047.1427626-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The information from these TLVs is currently unused and only printed to
debug output.  Same can be accomplished using an external sniffer.
Remove this code until the information in these TLVs is needed for
something.
---
 drivers/qmimodem/gprs-context.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-context.c
index 5582a8052c0b..f29f10720710 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -173,29 +173,17 @@ static void get_settings_ipv4(struct ofono_gprs_context *gc,
 
 static void get_settings_cb(struct qmi_result *result, void *user_data)
 {
-	static const uint8_t RESULT_PDP_TYPE = 0x11;	/* uint8 */
-	static const uint8_t RESULT_APN = 0x14;		/* string */
 	static const uint8_t RESULT_IP_FAMILY = 0x2b;	/* uint8 */
 	struct cb_data *cbd = user_data;
 	ofono_gprs_context_cb_t cb = cbd->cb;
 	struct ofono_gprs_context *gc = cbd->user;
-	uint8_t pdp_type, ip_family;
-	char *apn;
+	uint8_t ip_family;
 
 	DBG("");
 
 	if (qmi_result_set_error(result, NULL))
 		goto done;
 
-	apn = qmi_result_get_string(result, RESULT_APN);
-	if (apn) {
-		DBG("APN: %s", apn);
-		l_free(apn);
-	}
-
-	if (qmi_result_get_uint8(result, RESULT_PDP_TYPE, &pdp_type))
-		DBG("PDP type %d", pdp_type);
-
 	if (!qmi_result_get_uint8(result, RESULT_IP_FAMILY, &ip_family)) {
 		ofono_error("No IP family in results");
 		goto done;
-- 
2.45.2

