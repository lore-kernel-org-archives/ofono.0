Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061B5917D
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331547; cv=none; b=PdcW42FH4ofoF9PEiUosKbGyNjkbwNjR1zOrS8qqPBEJG92lChAvISP/k5RSMhVrHBh0CKN20o8MScihQ6JGy8GdJN8PjOf2OKKiZ+swjUejhXea0q19x148LHmeKiQGOU95G0oE6ZDNxSwgtSGfXbcsC20C3hOj3rpZj7bz4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331547; c=relaxed/simple;
	bh=OFjp3otTArkITgbYBvhSvJbEiGAb5x4YY/YosncOjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY5HNbvXroU9KS/WVbEw0/6fIfhKx/cfPT3AXFVcJOQhFSLsr6pWAszVUfBpGb9n3BKatQDrLHFfhXTa5U2+QRlIpzpLHrHCcqcVIXhXKvNaq796tZ/pyRoBH6EigjoX5BbcP919juOL8SvaARlrSTXhFQRTjK8Q7RyaNCXq/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=PiqTKw1h; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=YQ6ad/5E; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="PiqTKw1h";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="YQ6ad/5E"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421EjGfI030284
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 14:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=VHGxQEgUKHkyzcY5iyGGGn
	988rqo551X8Q1oBKbeVSo=; b=PiqTKw1hcI94GyN2B9UsQc7dpF7w+heFRdSTEt
	aEMbL7c5UuvOW0xL0sroFhArlI6G9Q/0YFMqyTm4rE+OWU8dfcXKnikjRyhdWHMI
	4RkmjUvGVEmimaaXPKepOQOlwac2lJhbFiAIV9KrhBUldCbxQSyAfMqRbi2PRSuh
	Fne1h8H93irJH3xBdNyli4fkmqTFjOz7hNhkeAS2X94OvKL5QZfPp56bQbW6gSFl
	RzJSLhgRLLlyxYYGiOhfS5aF1uwX9SkZsqYZZFTgkY5yMU4uClxhQgBt49W+12Cy
	CJUMBb7wGjR3I8vgVcLd1/QNlEj0Cl7i/7eDEwy40VTIfquw==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3whamm3w28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:04 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365b4dc6c3eso27411915ab.2
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 14:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709331543; x=1709936343; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHGxQEgUKHkyzcY5iyGGGn988rqo551X8Q1oBKbeVSo=;
        b=YQ6ad/5EPiSsAwftZ7U+gHM6tB0EnXP+FFj/lx3FgcDYeMxN6M1Yeo3qc9230CrknS
         GMOEOzk+t5zCzz+VsHyGc4gl8bpU7HLDda9s0J2ckOnpyqIJK7Z5D9yWrBKVzRHEOwMd
         XOygAUUkCZG6RtSAZjfIzt+6QxVLh5CHQO9jBl5gyF7mbB4Qw36oxU0Is6ZqKIMnhiFw
         N+hhh4EbFFdOddmCkqJ3dCHJH8Y1rN4jZfb1Fo2WBDlN5CQCw0sE7CFCuPEkN+Iw0SvG
         G7Tftz7cIRCvM9w6sGE4emMcjzb22x5Ezn1dW6jKwlR1tmRSjSrZW53b3gcLPNPWhTod
         CBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331543; x=1709936343;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHGxQEgUKHkyzcY5iyGGGn988rqo551X8Q1oBKbeVSo=;
        b=TFPhDpbWOdbMSh0ZJUKfYj1RHYB5WaZt1j6ircIWuJCzVaqVf4tg+7vSJkrPP52hqM
         2FxLuwZ1koCmy982Z3PZMzdS9k30QH6OXICCqOnHcXrzknU/71t3aLNArFJ7yVQ2iZ0/
         vvfYVkEuNirUqqJBB2+LFYVGmxTr3pjYz0RfGY7qFf76skyh4aSsv97ujOWjI+cT71xh
         FJUtLOTmvhMjxjHa/d2U1rP/YGLqOMJndwL93N4eM3RNvf4t3o6Mb90CcxtSa0Jilpg2
         1S2puYBL3+5FrsZ+wjaGa007XgcWd9a5AUQh1zFqHzipBjk0Jo4Rcz8M6+58xYvDQK3j
         FQ6A==
X-Gm-Message-State: AOJu0YygSRuHv1O5ZjLAfzC/O2TuoSG+DW8J7kWAYGLkGO9ZDXvtqgp1
	vi6UpkniuBz/zwnoCWcW6P8xVcNITqfcsFEcU/F7+ZP6YJasfncNR+8iPK2lmbCPYwzvUcZLXz7
	yEcyEm+aTGJPaAfGH8fitUXivOIw1B0w6p/fKNyhv4qema7793o4mmIcrcwokTGBvM492bsIEe5
	YAG02nwr4JqIh71k3uPbZ7g8m5uMV9R1o7YM0dQPB7GLgArHY=
X-Received: by 2002:a05:6e02:1e0b:b0:365:b29:3fda with SMTP id g11-20020a056e021e0b00b003650b293fdamr4124814ila.24.1709331543531;
        Fri, 01 Mar 2024 14:19:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE281C8MtNoIC1d3X7iJQ9ruV5AMP62I8pmW7b0Dn2FDU77rTlzRHYdbj2xvHJvTr7QHIBwJw==
X-Received: by 2002:a05:6e02:1e0b:b0:365:b29:3fda with SMTP id g11-20020a056e021e0b00b003650b293fdamr4124687ila.24.1709331542735;
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id g13-20020a92d7cd000000b003639d3e5afdsm1127808ilq.10.2024.03.01.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:19:02 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v3 3/4] qmi: Clean up the __debug_msg function
Date: Fri,  1 Mar 2024 16:18:47 -0600
Message-ID: <20240301221851.1445586-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301221851.1445586-1-steve.schrock@getcruise.com>
References: <20240301221851.1445586-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: HEcyEopC9_ISvykwmPM3d0YK8ZFLoAtz
X-Proofpoint-ORIG-GUID: HEcyEopC9_ISvykwmPM3d0YK8ZFLoAtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010184

There was a lot of redundancy in the function and it was also not
ready to handle QRTR messages that do not have a QMUX header.
---
 drivers/qmimodem/qmi.c | 140 +++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a2a715e9..c65860ce 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -527,94 +527,49 @@ int qmi_error_to_ofono_cme(int qmi_error)
 	}
 }
 
-static void __debug_msg(const char dir, const void *buf, size_t len,
-				qmi_debug_func_t function, void *user_data)
+static void __debug_msg(char dir, const struct qmi_message_hdr *msg,
+			uint32_t service_type, uint8_t transaction_type,
+			uint16_t tid, uint8_t client, uint16_t overall_length,
+			qmi_debug_func_t function, void *user_data)
 {
-	const struct qmi_mux_hdr *hdr;
-	const struct qmi_message_hdr *msg;
 	const char *service;
-	const void *ptr;
+	const void *ptr = ((const void *) msg) + QMI_MESSAGE_HDR_SIZE;
 	uint16_t offset;
 	char strbuf[72 + 16], *str;
 	bool pending_print = false;
+	const char *transaction_type_string;
 
-	if (!function || !len)
+	if (!function)
 		return;
 
-	hdr = buf;
-
 	str = strbuf;
-	service = __service_type_to_string(hdr->service);
+	service = __service_type_to_string(service_type);
 	if (service)
 		str += sprintf(str, "%c   %s", dir, service);
 	else
-		str += sprintf(str, "%c   %d", dir, hdr->service);
-
-	if (hdr->service == QMI_SERVICE_CONTROL) {
-		const struct qmi_control_hdr *ctl;
-		const char *type;
-
-		ctl = buf + QMI_MUX_HDR_SIZE;
-		msg = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE;
-		ptr = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE +
-							QMI_MESSAGE_HDR_SIZE;
-
-		switch (ctl->type) {
-		case 0x00:
-			type = "_req";
-			break;
-		case 0x01:
-			type = "_resp";
-			break;
-		case 0x02:
-			type = "_ind";
-			break;
-		default:
-			type = "";
-			break;
-		}
-
-		str += sprintf(str, "%s msg=%d len=%d", type,
-					L_LE16_TO_CPU(msg->message),
-					L_LE16_TO_CPU(msg->length));
-
-		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
-					hdr->client, ctl->type,
-					ctl->transaction,
-					L_LE16_TO_CPU(hdr->length));
-	} else {
-		const struct qmi_service_hdr *srv;
-		const char *type;
-
-		srv = buf + QMI_MUX_HDR_SIZE;
-		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
-		ptr = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE +
-							QMI_MESSAGE_HDR_SIZE;
+		str += sprintf(str, "%c   %d", dir, service_type);
 
-		switch (srv->type) {
-		case 0x00:
-			type = "_req";
-			break;
-		case 0x02:
-			type = "_resp";
-			break;
-		case 0x04:
-			type = "_ind";
-			break;
-		default:
-			type = "";
-			break;
-		}
+	switch (transaction_type) {
+	case 0x00:
+		transaction_type_string = "_req";
+		break;
+	case 0x01:
+		transaction_type_string = "_resp";
+		break;
+	case 0x02:
+		transaction_type_string = "_ind";
+		break;
+	default:
+		transaction_type_string = "";
+		break;
+	}
 
-		str += sprintf(str, "%s msg=%d len=%d", type,
-					L_LE16_TO_CPU(msg->message),
-					L_LE16_TO_CPU(msg->length));
+	str += sprintf(str, "%s msg=%d len=%d", transaction_type_string,
+				L_LE16_TO_CPU(msg->message),
+				L_LE16_TO_CPU(msg->length));
 
-		str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
-					hdr->client, srv->type,
-					L_LE16_TO_CPU(srv->transaction),
-					L_LE16_TO_CPU(hdr->length));
-	}
+	str += sprintf(str, " [client=%d,type=%d,tid=%d,len=%d]",
+				client, transaction_type, tid, overall_length);
 
 	function(strbuf, user_data);
 
@@ -664,6 +619,41 @@ static void __debug_msg(const char dir, const void *buf, size_t len,
 		function(strbuf, user_data);
 }
 
+static void __qmux_debug_msg(const char dir, const void *buf, size_t len,
+				qmi_debug_func_t function, void *user_data)
+{
+	const struct qmi_mux_hdr *hdr;
+	const struct qmi_message_hdr *msg;
+	uint8_t transaction_type;
+	uint16_t tid;
+
+	if (!len)
+		return;
+
+	hdr = buf;
+
+	if (hdr->service == QMI_SERVICE_CONTROL) {
+		const struct qmi_control_hdr *ctl;
+
+		ctl = buf + QMI_MUX_HDR_SIZE;
+		msg = buf + QMI_MUX_HDR_SIZE + QMI_CONTROL_HDR_SIZE;
+
+		transaction_type = ctl->type;
+		tid = ctl->transaction;
+	} else {
+		const struct qmi_service_hdr *srv;
+
+		srv = buf + QMI_MUX_HDR_SIZE;
+		msg = buf + QMI_MUX_HDR_SIZE + QMI_SERVICE_HDR_SIZE;
+
+		transaction_type = srv->type;
+		tid = L_LE16_TO_CPU(srv->transaction);
+	}
+
+	__debug_msg(dir, msg, hdr->service, transaction_type, tid, hdr->client,
+			L_LE16_TO_CPU(hdr->length), function, user_data);
+}
+
 static void __debug_device(struct qmi_device *device,
 					const char *format, ...)
 {
@@ -1284,7 +1274,7 @@ static int qmi_device_qmux_write(struct qmi_device *device,
 	l_util_hexdump(false, req->data, bytes_written,
 			device->debug_func, device->debug_data);
 
-	__debug_msg(' ', req->data, bytes_written,
+	__qmux_debug_msg(' ', req->data, bytes_written,
 				device->debug_func, device->debug_data);
 
 	hdr = (struct qmi_mux_hdr *) req->data;
@@ -1371,7 +1361,7 @@ static bool received_qmux_data(struct l_io *io, void *user_data)
 		if (bytes_read - offset < len)
 			break;
 
-		__debug_msg(' ', buf + offset, len,
+		__qmux_debug_msg(' ', buf + offset, len,
 				qmux->super.debug_func, qmux->super.debug_data);
 
 		msg = buf + offset + QMI_MUX_HDR_SIZE;
-- 
2.43.2


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
