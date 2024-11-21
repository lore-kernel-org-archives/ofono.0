Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012B19D080
	for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202995; cv=none; b=dJwqj0yipdtMCL4TR4BykwnnS8hpLnEV1VmAvbcZ6AbD4SUUogRNn5Xn77T84+ueMauYrp5zauevprNqTZa52lCKgb1bJT83ogGjlPZwR8dJYN01KwmqnWRHuTGCaBEa6LroJ0oEo87PJTjUQxTOl/AbCDlo/CHsODyZs78yHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202995; c=relaxed/simple;
	bh=03kej0DJIYKoyJcnjc3zcbawUpT3XMl36zMCabZEu9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NADGiUcm/JsBTkYXbVple2ldb21p0h6EksSUtFdvBIFNe6MAPRlNcyZAukTmiE5/uyPVLOaKHZvVJTUVyHrgnjl8Zm3WlDgs5jyIWMqxfxxFyD9cX731vT/b1Ao/HZ73WHriNbg3MJxHRyeEct+mY2r/dw5XENy3EFsgbeheQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFg9ugax; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFg9ugax"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27d0e994ae3so521859fac.3
        for <ofono@lists.linux.dev>; Thu, 21 Nov 2024 07:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732202993; x=1732807793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D9yGc+TQp7y7oE5+UbznEG/33kXPLILwm5UOL6H50M=;
        b=nFg9ugaxRA6uEsjqawj76NKAQPT+ahq5jzwk/2hem62vtZ31fZ5HKnIYweaGYuDYv/
         fVvT/37K2dBgRXk4AYyZSJ/VjSCpCwGK/QX14QS1XhqyRYIKeH/wodHLS10sYK8dcABS
         rQ4m9Ni//1ajRC/GHjHtbJs4QHtbvy1AP8vQV5g34lH+aiWxcApoWBR7CGOG8NYt2k/d
         NxekGd2zdrOT/7IQwO5s3D58fV+hYPcJE58LKZJhgpwXDI+QST6oHVeI9fs6Hv3UkhgT
         ZwzmTyEGroIiQ+YgqbVpD7cttU/RjYiuENaUSOh1K2CQGs6egu48b1g6SnGg/Ax7X0aw
         cDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202993; x=1732807793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D9yGc+TQp7y7oE5+UbznEG/33kXPLILwm5UOL6H50M=;
        b=hFStiROsENGD2ds7n1Q+iEXlUVy2Ut1VnlywBD7oPMD1sPsIynL0QiTn2cbxj/zGd9
         ZBCuwRoqVionLxgv9rp0Mqd9FRRwXuGLCnpelieh3Amv6YVeNBaMAAYH5jBzEvAzGWoC
         EzHmWc7zx3l6UHxu2ynIfJyqXGVcAVVf3ze72AACqxZGeKcuP4rCWyBwTtNw1kQNfAa/
         AaZ9LefGEo+5JgFbOTL/sKkSCNbJmwMy13IN2hN0I85nM1iank8/PVJV7jIi8v8gA/LA
         4BAFPCLd4xDn0h98d5cgBv/tnVcIhqr+P/qjtmijflyStQq1eMAOFUfUvRVcmEu14GvO
         H0ag==
X-Gm-Message-State: AOJu0YwcPbVlra9Kqp87ek/lTrZ2Bne/sIrXklSt+1FKbXwT7yjz7Ggq
	JlCISztJkOMeGx3FDdeMcQyuKNJOts/gOfC6kttWsvy4xAdNpaXZGQ8BVw==
X-Gm-Gg: ASbGnctMZ9oVruI6wbsw90hqHaHR4X1G3/Mbkd/54xuFWtVDMgOiFnr3DhWIM69sFqI
	OzRpz+AyO22iDLhH0/Ab8wajstuK0mNVhZrmaFVcYhmp+jMAAjaym3jsm7GYkkbXc9wfsHsfVd5
	21l13RByBhnR+mdKbzYuBFRxdxgjRylTfHIkOOjWjoKMiclKYIJstVnqxoxsu9OI8ECa5VZGlcH
	IJnkhl8cu+rU+RLsUVyFGj+gFgIYlgEjrPaQwaQVlrlLCkpHzWX2zE3o9JIJT2L8955Vz68HYCF
	nzj1SJvjhjDOhasR9CU/D4lC
X-Google-Smtp-Source: AGHT+IFacn/FwXnCEfcp5JzsL41ZtM4Ao8KZZyx+0Wca5ciuYiA3OkBicFepfnNhBtYWgeV+PTTGhg==
X-Received: by 2002:a05:6870:d10e:b0:25e:d90:fe70 with SMTP id 586e51a60fabf-296d9f25222mr6747192fac.43.1732202992652;
        Thu, 21 Nov 2024 07:29:52 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651ac5ff9sm4856831fac.42.2024.11.21.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:29:52 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/10] qmi: wda: Add qmi_wda_parse_data_format utility
Date: Thu, 21 Nov 2024 09:29:30 -0600
Message-ID: <20241121152949.56962-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152949.56962-1-denkenz@gmail.com>
References: <20241121152949.56962-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This utility function parses the response from WDA Set Data Format
result message, and from the WDA Get Data Format result message.
---
 drivers/qmimodem/wda.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/wda.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/drivers/qmimodem/wda.c b/drivers/qmimodem/wda.c
index cf32aa094d69..0ba8914312da 100644
--- a/drivers/qmimodem/wda.c
+++ b/drivers/qmimodem/wda.c
@@ -16,6 +16,42 @@
 #include "common.h"
 #include "wda.h"
 
+int qmi_wda_parse_data_format(struct qmi_result *result,
+				struct qmi_wda_data_format *out_format)
+{
+	static const uint8_t RESULT_LL_PROTO = 0x11;
+	static const uint8_t RESULT_UL_AGGREGATION_PROTOCOL = 0x12;
+	static const uint8_t RESULT_DL_AGGREGATION_PROTOCOL = 0x13;
+	static const uint8_t RESULT_DL_MAX_DATAGRAMS = 0x15;
+	static const uint8_t RESULT_DL_MAX_SIZE = 0x16;
+	struct qmi_wda_data_format format;
+
+	if (!qmi_result_get_uint32(result, RESULT_LL_PROTO,
+						&format.ll_protocol))
+		return -ENOENT;
+
+	if (!qmi_result_get_uint32(result, RESULT_UL_AGGREGATION_PROTOCOL,
+					&format.ul_aggregation_protocol))
+		return -ENOENT;
+
+	if (!qmi_result_get_uint32(result, RESULT_DL_AGGREGATION_PROTOCOL,
+					&format.dl_aggregation_protocol))
+		return -ENOENT;
+
+	if (!qmi_result_get_uint32(result, RESULT_DL_MAX_DATAGRAMS,
+					&format.dl_max_datagrams))
+		return -ENOENT;
+
+	if (!qmi_result_get_uint32(result, RESULT_DL_MAX_SIZE,
+					&format.dl_max_size))
+		return -ENOENT;
+
+	if (out_format)
+		memcpy(out_format, &format, sizeof(struct qmi_wda_data_format));
+
+	return 0;
+}
+
 uint16_t qmi_wda_set_data_format(struct qmi_service *wda,
 				const struct qmi_endpoint_info *endpoint_info,
 				const struct qmi_wda_data_format *format,
diff --git a/drivers/qmimodem/wda.h b/drivers/qmimodem/wda.h
index 4facc0cb6677..608c04947d6a 100644
--- a/drivers/qmimodem/wda.h
+++ b/drivers/qmimodem/wda.h
@@ -34,6 +34,8 @@ struct qmi_wda_data_format {
 	uint32_t dl_max_size;
 };
 
+int qmi_wda_parse_data_format(struct qmi_result *result,
+				struct qmi_wda_data_format *out_format);
 uint16_t qmi_wda_set_data_format(struct qmi_service *wda,
 				const struct qmi_endpoint_info *endpoint_info,
 				const struct qmi_wda_data_format *format,
-- 
2.47.0

