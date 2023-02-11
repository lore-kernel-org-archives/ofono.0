Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC163D0
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r2so8262015wrv.7
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wLsfT0VcS3DrwX2Ne6aWvj9Mct0vZ6Dq3LubHcJMBg=;
        b=yBjlk8AK4CTIGbsR2iIci0/T5YxEHJFV43YX3+b1MKHxnMekNicUxRtd3M5YFJdHlQ
         zMur2GabY7aYntlYVo95rO3XSSBTxJnO8J5lDQifrbuEhS3Q6V/WKOSTqF38uWnGvnUu
         a3a0Fu0Y0gY/f9Nte21Fu7quFfc1U3Hqu7TvzOUCM3iT25SdEQnchPiom75ei8XBGoKg
         j1ypzxz+ofgSeje5vafdtWEHvo678XbybdT+uHn8B33kGsnCL2BstbTwfcERgvjyk4ek
         i9CINJwlit68Hc1L2uPFZqqHyYjKdGhSglHuDFwmOy+3tOLUBjeiXtDpWIWHh3wDMO2u
         4Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wLsfT0VcS3DrwX2Ne6aWvj9Mct0vZ6Dq3LubHcJMBg=;
        b=qBwXlpRXWgKpAVmRzJ8WfpjJsH3MiTYOClNPmXn+3Nmspas/Tp5dviAiSx7JfSkzGr
         08jEc/EdYmUueUEZFGqdQ2e3EoNVYdYAM719W5UfAUwTD7HFDIL2JjIc1D1xfFFr1FuC
         vmMV5ZE9GM6ciPxs6v4m99QcucvneJOXNw2BEtnzeZfNVvDQBtQaHRJFYoDxeTGc+/w6
         UmV0RZ19xITj2FeVZ94wxaAWSKBNweFFSXtI2vo2e11ItwslM/YzX6bU1brjql12IUZs
         VdNK/7ZTbbXYdJJKTjAxkZ/4sZXy9RuBLmnvGhXm75FzDo4cXeReR/e7ulg2pPtmzUo8
         pemw==
X-Gm-Message-State: AO0yUKXQi/S8L+6KB8P+s64Kt27OYN4QRoNXkt4E3RTK0QCeUImKJc9g
	YWLPRb7Q5m0Sr5btVdqmdcqtm1IvywZHoxu+MGKRwg==
X-Google-Smtp-Source: AK7set/Fr++Pr7TOla99ot0Ywr1A+B9sGVj+N5x+EzXTxgVmk1a1Txs6fdkM1TpMVY1HFC0zXmPIkw==
X-Received: by 2002:a05:6000:108d:b0:2bf:bf05:85ac with SMTP id y13-20020a056000108d00b002bfbf0585acmr7058990wrw.23.1676139081904;
        Sat, 11 Feb 2023 10:11:21 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:21 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 3/5] gprs: extend on_lte() to check for M1 and Nb-IOT techs
Date: Sat, 11 Feb 2023 20:11:03 +0200
Message-Id: <20230211181105.7220-4-alex@shruggie.ro>
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

The BG95 is an LTE modem with Cat M1 and NB-IoT techs.
So, when it happens that the modem registers to one of these techs (in our
case Cat M1), and there is no GSM advertised by the operator, the modem
will not attach.

Following the current logic of LTE, it looks like we just need to extend
the "on_lte()" function to allow for these techs.

Also, not checking the .read_settings callback existence. That looks like a
hack done for EUTRAN. In our case, the BG95 is controlled by AT commands,
so there is no .read_settings hook yet, and we don't seem to need it.
---
 src/gprs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 4befe88a..e2758545 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1615,11 +1615,19 @@ static void detach_active_contexts(struct ofono_gprs *gprs)
 
 static gboolean on_lte(struct ofono_gprs *gprs)
 {
-	if (ofono_netreg_get_technology(gprs->netreg) ==
-			ACCESS_TECHNOLOGY_EUTRAN && have_read_settings(gprs))
-		return TRUE;
+	int tech = ofono_netreg_get_technology(gprs->netreg);
 
-	return FALSE;
+	switch (tech) {
+	case ACCESS_TECHNOLOGY_NB_IOT_M1:
+	case ACCESS_TECHNOLOGY_NB_IOT_NB1:
+		return TRUE;
+	case ACCESS_TECHNOLOGY_EUTRAN:
+		if (have_read_settings(gprs))
+			return TRUE;
+		/* fall-through */
+	default:
+		return FALSE;
+	}
 }
 
 static void gprs_attached_update(struct ofono_gprs *gprs)
-- 
2.34.1

