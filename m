Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479B63D0
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:20 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id j23so8317528wra.0
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldtkD/WS9fXzfSCIKd5PDiHY6WuBhtHrS2kY3pbmcAc=;
        b=Hp+3rsmpSPuH3zRsclLBqjd4xBxyZWl1L8RMHHlheJoXJos/dF3ff9Xpww/bOHxZEI
         ieRtyIy29tGlJQXsO8K9of+fZUSanegVf5DfOkAgy0a6YplQFE2waBJVqGzvie8T3OnG
         HJTgtrrbLCIsT7n43JFhF8LdtgB3t86m1ednZ1Ff5eBBjk2Kgf20Pzp2bbFODJtDwEY1
         Ne5bpX30lvz1YySubM3h8JRVDJ4W1fgZ4TBXXsVKXTsA5tt9ndDPc7bDUIRtbfHkq0C/
         V+UsBBgyGwljEp8Rn4ZGXaKI4PNfi9T7Z8PQ6OJFqKvkd9J3oVhylF6lucczDIzHEvYZ
         AIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldtkD/WS9fXzfSCIKd5PDiHY6WuBhtHrS2kY3pbmcAc=;
        b=qP4IipXz6L7suJ2LhuFXkjfWguCJxvIdAX1ZdwGKPlFYEr8DBR3tkA80nQC9qtNUIj
         rzq/L8jKfTIib5uvESoE2a/B42mF58XlKL45HmDtX4omIz02pA4QlakQS5baj3jNEORN
         vkvi0fyv4UaWr4TkSLBsGc3yofHYBNQ0dGbErs4MNAlApv5GgOUY99ic9S2LikX6ueCo
         ZThrC1VUZywZcaEOaMhEUHMD2QLw8gbE4WhLVybXDBk9rMPMdaDC2dAUcIUXFs91HdFg
         qS81bxAPIhfbvpn1Du5UGE8ocSQWyzmkurO9UYlmnLPlp0L3reT2nmuM7Vher8+yPnXm
         LXXA==
X-Gm-Message-State: AO0yUKVzg0lFntKV9WA6Zu5Ag43JH+SAAjYg6M2EFPkJycm8WPuoQntX
	7G/KtaLiB+iZDutz/lKrolhQ8+D0OM2Rk4LFPcGG+w==
X-Google-Smtp-Source: AK7set8afU7GYzaczTkE4jLNuQAOQWEVSfZ17neyhu7wwMHTstHdpp5ltPrtvcvdX8t0DLQmZ/J8PA==
X-Received: by 2002:a5d:65c4:0:b0:2c3:ea4d:3ef3 with SMTP id e4-20020a5d65c4000000b002c3ea4d3ef3mr10342711wrw.17.1676139078651;
        Sat, 11 Feb 2023 10:11:18 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:18 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 1/5] atmodem: gprs-context: fix ATD99 init for modems with no slave channel
Date: Sat, 11 Feb 2023 20:11:01 +0200
Message-Id: <20230211181105.7220-2-alex@shruggie.ro>
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

From: Mircea Caprioru <mircea.caprioru@flowkernel.ro>

Patch 476fab4ea ("atmodem: Add support for NW DEACT notifications on slave
channel") has added a check to make sure we have a slave channel before
registering for "+CGEV:" notifications.

Patch 8e929df4f ("atmodem: use ATD99 to enter data state when needed") has
added the ATD99 detection after the slave channel check.

In our case, when we get a modem with no slave channels, the ATD99
detection will not get triggered and modems will use the AT+CGDATA="PPP"
method for connecting to the internet (when ATD99 would be supported).

This patch moves the check a bit lower in the code and removes the
early-return, to avoid for any potential future errors.
---
 drivers/atmodem/gprs-context.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index f9f3c0ab..efc3fe94 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -449,10 +449,6 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
 
 	ofono_gprs_context_set_data(gc, gcd);
 
-	chat = g_at_chat_get_slave(gcd->chat);
-	if (chat == NULL)
-		return 0;
-
 	switch (vendor) {
 	case OFONO_VENDOR_SIMCOM_SIM900:
 		gcd->use_atd99 = FALSE;
@@ -462,7 +458,9 @@ static int at_gprs_context_probe(struct ofono_gprs_context *gc,
 						at_cgdata_test_cb, gc, NULL);
 	}
 
-	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+	chat = g_at_chat_get_slave(gcd->chat);
+	if (chat != NULL)
+		g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
 
 	return 0;
 }
-- 
2.34.1

