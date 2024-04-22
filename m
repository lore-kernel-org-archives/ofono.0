Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568A1BC44
	for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822065; cv=none; b=GHJo3Jo9TGcOCfMyUXj/FBv/MLuyOFFlcXY+Xjbd1mUeZcxfuqtbOYazkryBjk7b+2qRpnEruMNwLwlvRldSoMhw8j2H5wEPqV3KPXSreAKIqRH7aDJKlk35u1MIbXUNHOAA3fCkuTEDsrvvpbQ4GevlPnEb6DpCmMi8DautM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822065; c=relaxed/simple;
	bh=I2XICPGZPSILAeK/ST0vP2aXF2Q0BKcHn0/gvYAkqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqBf4et6EAUyzADgJ4yvIM2zwiU+eM2//g9kDldf8YPYfO+tYPcrfr9na8x1Mw1tI8eJP5a9QTBIK54dinGoNp2ZywdCDXHTPMeaVCl4zH/vf9PXHJtfh5IkI5ImfURXQUnC0omve0zqMOHhZiwNa86h3be8Db02CuEqPUNZaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKv9MA1F; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKv9MA1F"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ed3587b93bso736159a34.1
        for <ofono@lists.linux.dev>; Mon, 22 Apr 2024 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713822063; x=1714426863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XMp9M5TqqhEjlUEJb1E7rTHKf+n0kuBR9Gvq/J1/aI=;
        b=BKv9MA1FfHk5/3AoP0ZhZGswMKR4WmqUFy6YtMpJfeMeAKxPzqgvNfUFwp2vn0oBch
         1fz1SnFQcIi47JYUUP9/9zvaXPiK+EsW7Oz+fqfiLkXa7CORT5kKtfZ1d7ctdpIntjz7
         gMsMvv/nlFfudXaDROTZc3VL2x3z/qZufaqUYj4Isy1nn/AyPQ+s2CmjLVQg0hFasQwp
         36bKAjfqb5jWWlHXmsCxIpNzgXHewRpCv4NkPYg3JYUDF+qF9WCA3qDlZLmpUofn8+9N
         BrBvVgWCLcJ3Qi+2FliR19VehPRnihK2zt7VyM/SEm3UCxcIF5VnoxMZzH6kqXonAEva
         ntGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822063; x=1714426863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XMp9M5TqqhEjlUEJb1E7rTHKf+n0kuBR9Gvq/J1/aI=;
        b=q+ZMYFyPsqvBAzpwre+x8SI9dOg109jNXA7wEo1ocTq4oh40zMgg3orftX0aIXVhtw
         GYqk998hR5tVox1pcdMicm1xuJ4LCUOEjfL+yfA/iKsw4e+6FJUnoEPKFlpfWrOgffac
         kx+ZqT04kjBIVZ/1cDaySv5MvNXBFl6N8YwIgWY8sOcCXmCfa2KS0A5Sn/rsR6yRTzT+
         lU9noremV0QrdizlojKp1SFZbTqhBQfwTWMpbZGoTq55jmrqNTawO9PBVb6szG6XVlVg
         lwl7d5bs6KGoIoNixV3vK6gqnUUL1lC02P+JptTZT/FN3XvZf33hXCtyc8pjfiocZEvW
         75wA==
X-Gm-Message-State: AOJu0YzXo8uFcN3lU0d0DE+LlH1EAl07v5Kzkzce5hvs8rA+lC/BbgrS
	NQQx4qK88ZinfJg2zZa2Z/u/h/s029TisRrwbdm4sfNjQhFq3t5Tk9B+jQ==
X-Google-Smtp-Source: AGHT+IG0M+dualy8ujIpKt7W5MD4TA4JitN1b7HmsGztldu/rLCkMMC052E+hxh5AJK2mxgHSwXIfw==
X-Received: by 2002:a05:6870:a799:b0:22e:8907:e7bf with SMTP id x25-20020a056870a79900b0022e8907e7bfmr12492468oao.40.1713822063065;
        Mon, 22 Apr 2024 14:41:03 -0700 (PDT)
Received: from localhost.localdomain ([70.114.247.242])
        by smtp.gmail.com with ESMTPSA id xm8-20020a0568709f8800b00239b3c03b8fsm1076122oab.42.2024.04.22.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:41:02 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/4] qmi: voicecall: Remove redundant initialization to NULL
Date: Mon, 22 Apr 2024 16:40:46 -0500
Message-ID: <20240422214058.3411417-4-denkenz@gmail.com>
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

param was needlelly initialized to NULL in answer() and
release_specific().  Since all error paths free both cbd and param,
declare & initialize these variables at the start of the function.

Handle dial() similarly for consistency.
---
 drivers/qmimodem/voicecall.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index dcb91c642c0c..b66f1ae7d56d 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -434,7 +434,8 @@ static void dial(struct ofono_voicecall *vc,
 {
 	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
 	struct cb_data *cbd = cb_data_new(cb, data);
-	struct qmi_param *param;
+	struct qmi_param *param = qmi_param_new();
+
 	const char *calling_number = phone_number_to_string(ph);
 
 	static const uint8_t PARAM_CALL_NUMBER = 0x01;
@@ -446,8 +447,6 @@ static void dial(struct ofono_voicecall *vc,
 	cbd->user = vc;
 	memcpy(&vd->dialed, ph, sizeof(*ph));
 
-	param = qmi_param_new();
-
 	if (!qmi_param_append(param, PARAM_CALL_NUMBER,
 			strlen(calling_number), calling_number))
 		goto error;
@@ -492,27 +491,22 @@ static void answer(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
-	struct cb_data *cbd;
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param = qmi_param_new();
 	struct ofono_call *call;
-	struct qmi_param *param = NULL;
-
 	static const uint8_t PARAM_CALL_ID = 0x01;
 
 	DBG("");
 
-	call = l_queue_find(vd->call_list,
-					ofono_call_match_by_status,
-					L_UINT_TO_PTR(CALL_STATUS_INCOMING));
-
-	param = qmi_param_new();
-	cbd = cb_data_new(cb, data);
-	cbd->user = vc;
-
-	if (call == NULL) {
+	call = l_queue_find(vd->call_list, ofono_call_match_by_status,
+				L_UINT_TO_PTR(CALL_STATUS_INCOMING));
+	if (!call) {
 		ofono_error("Can not find a call to pick up");
 		goto error;
 	}
 
+	cbd->user = vc;
+
 	if (!qmi_param_append_uint8(param, PARAM_CALL_ID,
 			call->id))
 		goto error;
@@ -552,22 +546,20 @@ static void release_specific(struct ofono_voicecall *vc, int id,
 			ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
-	struct cb_data *cbd;
-	struct qmi_param *param = NULL;
+	struct cb_data *cbd = cb_data_new(cb, data);
+	struct qmi_param *param = qmi_param_new();
 
 	static const uint8_t PARAM_CALL_ID = 0x01;
 
 	DBG("");
 
-	param = qmi_param_new();
-	cbd = cb_data_new(cb, data);
 	cbd->user = vc;
 
 	if (!qmi_param_append_uint8(param, PARAM_CALL_ID, id))
 		goto error;
 
 	if (qmi_service_send(vd->voice, QMI_VOICE_END_CALL, param, end_call_cb,
-			cbd, l_free) > 0)
+				cbd, l_free) > 0)
 		return;
 
 error:
-- 
2.44.0

