Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A81CAB7
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822064; cv=none; b=fZCbeI23z9xP1FhtMVOJBby7CKRK6rKuDROmFx6ykbARrPpnrQPDw3gx0lqf/3ueDVZWExDPu5GeVxjixNNIwRBvxN9B7aKhBx4q+HBS1MKodnRqhY8C6jtx9Zf28LBIExLQw3eFHWf+zs+4KX985C6hkdQEHDjb4hjbF4koLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822064; c=relaxed/simple;
	bh=BRovDsNwS+DbhyDfsxN1TbvjlC1r1FNB9UNWNktVG0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahdpKMIWo1EToT7Im71wccWM4aFL1o74pTmkDxkIjEBSXr5V7evHH85yKUf+JZhMcYORTltwkuic3ly3Uw6tA15WBBkU4JI3tgH/Hp8zoQyyAE/EPXOqvjXgQV9OmKie7OaKSPkFPypNuiITj8VM8wvnqSJvRQGXNCvmn9JzV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKIBdn9a; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKIBdn9a"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22edcfcd187so2166374fac.2
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713822062; x=1714426862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WroYfUW4gOb8twfDMkhWhpPLg5tVJyRCgzrQXtoqtSA=;
        b=mKIBdn9aiSTDdW/MmIzlxSkup5RQ3b4bK6jh/WmlAu9gXXQ3vkp/4VVfUFA5BPfHjp
         mB+puJgdlMwQoK8U5BmK5/myce6QCZXiYn3CR720bqBE0pLuLfc5xoxGXXm9YFq63eXP
         MSi8pkthA51jWaK6U2Fq0Ta/rPz+/rxWM9VxRXnS2+d5Rsql8W8M4h3eU8rGvLc1SG0z
         EYpdXV4WB1q2VsUIiJyhGmEKbEZ63qFso1w3/daPpUPaTokeM7EbR+7RpF/hnfgaLsnl
         wZ+F+St0/1K+nJnlvjsjqPhnOK+UzjROtzaLsmOuAgZg5LY1Nd9Lu6hvRNSUhgjxq05y
         WEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822062; x=1714426862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WroYfUW4gOb8twfDMkhWhpPLg5tVJyRCgzrQXtoqtSA=;
        b=NgV4BLNcOhFxudvqNiNqQAiNJehfMEXyIW7CMRgAPR11kMj4ssSpAgdVRRPayz/fWs
         EegS/1hGyAKP/zGA1qRWKPDn/sOFfSxkZIT+SVNUSzs66Xdd+RkUmxIgLgZN8/51Pcle
         xkyLmhk8xc4YRXwPbQyMvHDIfeFH3ux3Cwp6pl4leOQlnv7dtRGPaf5LEv1BUc3IkFZt
         OLb+QOXgDF7bSOkGUecRlanBxeUw90+fb7jZfUpxl2mcWx1svhwYzlr62lazLZH7i9Po
         bNivUAJi9kwLNJ1FNQ5u3FUmE2V7R/LCzPT2dJXf94PBaqvMCxhfFMDjtMqTg8Vkwi8n
         dfKQ==
X-Gm-Message-State: AOJu0Yyewx5kdWWnacacng+qPt2vmD1KnNx2fXW4hymF7pvpBi/RLos9
	NdaDHUfVgBKzdeQXo30UpSYgk6aA7AIhe3YsxN2GsjENrKSTWPHNfwYGlg==
X-Google-Smtp-Source: AGHT+IFtPY8CJ3Eu22npykQJdgVdqi9+e1Gq1eGrF9xBxiRtYXvvUV0XzKvYeza7Ouu7IMT8QRPblA==
X-Received: by 2002:a05:6870:cb91:b0:22a:9ea4:c18 with SMTP id ov17-20020a056870cb9100b0022a9ea40c18mr15920833oab.15.1713822061994;
        Mon, 22 Apr 2024 14:41:01 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id xm8-20020a0568709f8800b00239b3c03b8fsm1076122oab.42.2024.04.22.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:41:01 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/4] qmi: voicecall: Fix up code style violations
Date: Mon, 22 Apr 2024 16:40:44 -0500
Message-ID: <20240422214058.3411417-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422214058.3411417-1-denkenz@gmail.com>
References: <20240422214058.3411417-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix up some style violations:
 - > 80 character lines
 - Redundant parenthesis

Also, while here, fix up a typo: "informations" -> "information"
---
 drivers/qmimodem/voicecall.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 24c4f3f175c3..5afa3a057a71 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -90,7 +90,7 @@ static bool ofono_call_match_by_id(const void *a, const void *b)
 	const struct ofono_call *call = a;
 	unsigned int id = L_PTR_TO_UINT(b);
 
-	return (call->id == id);
+	return call->id == id;
 }
 
 static bool ofono_call_match_by_status(const void *a, const void *b)
@@ -294,7 +294,7 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 	}
 
 	if (!call_information->size) {
-		DBG("No call informations received!");
+		DBG("No call information received!");
 		return;
 	}
 
@@ -370,9 +370,11 @@ static void all_call_status_ind(struct qmi_result *result, void *user_data)
 		call->direction = qmi_to_ofono_direction(call_info.direction);
 		call->type = 0; /* always voice */
 
-		number_size = MIN(remote_party->number_size, OFONO_MAX_PHONE_NUMBER_LENGTH);
+		number_size = MIN(remote_party->number_size,
+						OFONO_MAX_PHONE_NUMBER_LENGTH);
 		tmp = l_strndup(remote_party->number, number_size);
-		l_strlcpy(call->phone_number.number, tmp, sizeof(call->phone_number.number));
+		l_strlcpy(call->phone_number.number, tmp,
+				sizeof(call->phone_number.number));
 		l_free(tmp);
 
 		if (strlen(call->phone_number.number) > 0)
@@ -489,7 +491,8 @@ static void answer_cb(struct qmi_result *result, void *user_data)
 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 
-static void answer(struct ofono_voicecall *vc, ofono_voicecall_cb_t cb, void *data)
+static void answer(struct ofono_voicecall *vc,
+					ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
 	struct cb_data *cbd;
@@ -679,4 +682,3 @@ static const struct ofono_voicecall_driver driver = {
 };
 
 OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)
-
-- 
2.44.0

