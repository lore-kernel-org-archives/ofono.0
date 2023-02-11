Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB43FC7
	for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 18:11:25 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id bu23so8259772wrb.8
        for <ofono@lists.linux.dev>; Sat, 11 Feb 2023 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eintdJZvyIx1oR+4QA461c5ZWeQ70w4xrxbtOaABqp4=;
        b=3rg4bkCsrph4E+TGYMKceAesLZrfCFT5zRq38ZZayTgK+lj+ITn9zTTEPCLryTPpxZ
         D3eoK7PMxw95UmaIHsDKn1bhSSHjvbOaz+bzARO7cBRblOA/mthcLZT3l79KLZNm9SOY
         /40WTOBBPlNTlHyxeje5dWtSRAoVJLYd+P0XTu04LwbJOu5y1KzwUehrWynkZ23oHjtO
         QQtbyCSdJNSWAUIqL3aK9EKky9nci7PgycCPvb3Rip4+i9cFfeiGJfs2rB1mCWIckJpK
         k3ME+cPXu2N2aQnbvvr3z9iLgBx/xb/zZwT9RcALvUOGqYglKDHl1QnsLI9HAlashfEL
         fYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eintdJZvyIx1oR+4QA461c5ZWeQ70w4xrxbtOaABqp4=;
        b=rZuV3zmCCP0lwpTUjNcRPOTO2MfkMPvPv/vZTbqPx3iGeJb3Qt5a5/WruBTYFJWoH6
         FDzCQrvpGeQt8lRsDfeRBjXzn5HNBjFLqw8MRssGbDWSaSGyZ8gi/gJuuc/dVPKTQfxh
         oPQPtTzH5sd+PAqRJ9CvZvewUSjgkgPDIaF+frALZ8HqyCai8Ru+h5774EkxIlBtC3h5
         Te11VLdAuHqZtR5rcFa3IlOO+OfZIkx2YqX05bLa3xwh/mRvSG5Au2SzKRM1DOpB8Hh9
         EcrUku1cIrNdy5lj2FpJNuwuIqKz27rTB8WhC5jf6jESUcaccy3A2JqqOapQyxyeVngu
         brkw==
X-Gm-Message-State: AO0yUKVmDM/aYTRhbkec/y9rDKEyUfovhNmYSa1VrRX2ebxTyn9muqON
	Mz3KZCfExdEbVEXgAnjOH2//VI+QyPodVzB6lQGsIA==
X-Google-Smtp-Source: AK7set/omFMeq48HgA/U7pEHVPATqvdvcJ8AJMDLLFVI7H5UbvU90agzJjvI6jhHwrLR318LGHkdeg==
X-Received: by 2002:a5d:6188:0:b0:2c5:49e1:b2cb with SMTP id j8-20020a5d6188000000b002c549e1b2cbmr5083257wru.37.1676139083649;
        Sat, 11 Feb 2023 10:11:23 -0800 (PST)
Received: from neptune.. ([188.27.130.91])
        by smtp.gmail.com with ESMTPSA id j4-20020adff544000000b002c54fb024b2sm1716825wrp.61.2023.02.11.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 10:11:23 -0800 (PST)
From: Alexandru Ardelean <alex@shruggie.ro>
To: ofono@lists.linux.dev
Cc: alex@shruggie.ro,
	patrick.frick@stihl.de,
	matthias.gruhler@stihl.de,
	mircea.caprioru@flowkernel.ro,
	stephanie.altenburg@stihl.de
Subject: [RESEND PATCH 4/5] plugins: quectel: re-organize code for ussd & lte init
Date: Sat, 11 Feb 2023 20:11:04 +0200
Message-Id: <20230211181105.7220-5-alex@shruggie.ro>
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

The BG95 modem (family) supports LTE, but not USSD.
So, we'll split the init of the LTE separately, and add a helper function
(called quectel_model_supports_lte()) which will return true if the modem
supports LTE.
---
 plugins/quectel.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index f933723d..464845ff 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -128,6 +128,17 @@ enum quectel_power_event {
 
 static const char dbus_hw_interface[] = OFONO_SERVICE ".quectel.Hardware";
 
+static ofono_bool_t quectel_model_supports_lte(enum quectel_model model)
+{
+	switch (model) {
+	case QUECTEL_EC21:
+	case QUECTEL_EC200:
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
 static ofono_bool_t has_serial_connection(struct ofono_modem *modem)
 {
 
@@ -1356,10 +1367,11 @@ static void quectel_post_sim(struct ofono_modem *modem)
 	ofono_phonebook_create(modem, data->vendor, "atmodem", data->aux);
 	ofono_call_volume_create(modem, data->vendor, "atmodem", data->aux);
 
-	if (data->model == QUECTEL_EC21 || data->model == QUECTEL_EC200) {
+	if (data->model == QUECTEL_EC21 || data->model == QUECTEL_EC200)
 		ofono_ussd_create(modem, data->vendor, "atmodem", data->aux);
+
+	if (quectel_model_supports_lte(data->model))
 		ofono_lte_create(modem, data->vendor, "atmodem", data->aux);
-	}
 }
 
 static void quectel_post_online(struct ofono_modem *modem)
-- 
2.34.1

