Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5215EE79
	for <ofono@lists.linux.dev>; Fri,  1 Mar 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336756; cv=none; b=svVHwolgi114KpamG3pcE7qPuMS5K2zDg9uEPsbF65KIfgeojZWIs7pQM6nFCL5O1uJ3hXXSQRPjo+oJXiqj2+YJasb0fqkDvEvN9gdn9VKxp7LUKcZglbqklpEe1KFe+Gb0AWHnV+HGjHAG/PSdi6jcnwsP5RNIKrGtaJlAEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336756; c=relaxed/simple;
	bh=g7xlCgjqnaEMd7JhRVndY4regekVz7tGNWIR+aGqL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shvNhP04WcKyugKKTaXJyOM84K607V2GW8e3C8eD8K/STWQmLR5IVfcj6iCTRnUMqaXHTOUfY49dSaMBG3yN1naQK23huQHyAxZw5UgSiP5Boe/XpkFK+PXuc2lyIik6x69LYX6YZ+Sxd/VYq2R2e7jChG7pEMWnhjD9U42VYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=a6/ftjtY; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=UaIjK8LZ; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="a6/ftjtY";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="UaIjK8LZ"
Received: from pps.filterd (m0286615.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421DpPqg031343
	for <ofono@lists.linux.dev>; Fri, 1 Mar 2024 15:45:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=IXJUebPoBUF5FYeLfz81ZW
	ORpZ3xJwzCgXZ2xI1fBx8=; b=a6/ftjtYZDwrsw7Z0uieqOlgqUCRP72PPDFI9p
	QW63is76by6R+bvxqSBaI2NVBvP+lcheVnLheL87g7Djrzdn/sUVJQRsMKioGnlb
	BhGzfRD0TCu3I/mgo0bTVCImgxv1Fjt7OJjBpf1Chk2cSvSy1JQCVoD1ZUZ71PUi
	0DVJbrTj2IISEFwToyA0WHsVnn9pvhUuxARyLwZCxJX3pROLa7SiXzlj2t5Ki4de
	WH13JG91zuigHNh79EJUdmPNFWgfWgGgwwCAu0VEdAPaeaDR7KuzedFlAkHsKQl9
	PTzOAAUgsDdxJrEtFu0IV7+AtILogxU4rZCmSM/mYaMl08sw==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3wjbv9a9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:53 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3652d6907a1so35912335ab.3
        for <ofono@lists.linux.dev>; Fri, 01 Mar 2024 15:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1709336752; x=1709941552; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXJUebPoBUF5FYeLfz81ZWORpZ3xJwzCgXZ2xI1fBx8=;
        b=UaIjK8LZEVehigq5Bn9i787wH9mN/bsB1NSuojPRd6J0H5OouiF+E8s/S4355vX2VS
         l4dIida3ft4hfKP60qMkN41Qxlr1QQ5yiaFQeiqo5FtNI4J+qrhuHJmacMkbRH+Wydtz
         Q/MJnPyCDHx72k/VHns3JY+FmSPkurXR5minBr9OzLkTyfw+HWtYXSaq9d+RaHCYO0oT
         zGK5fIjf/J+150BcDUtRDOROJBr+U73EO4mCu+nChm83CUTxMcD1puEQpojlyBJ1P+By
         sPbwvfWkVIYmbOooJStm+BegIImaul2CiE8ge+WIfKY0s0PXmAd6EPVec83FB5GfXFan
         gVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336752; x=1709941552;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXJUebPoBUF5FYeLfz81ZWORpZ3xJwzCgXZ2xI1fBx8=;
        b=FCsQ0mixrvy8b+LmCYwn3B/Fr5A9H6L8vQgj3G9JGS8T9N8cc+BY66/DbtOVNeCfLY
         BtJaaZQFJ46p9KWbT0WtksHv1NTip9YHYbpOegyHWWk4PpN3nxQEWH7+4HY35XejPSmE
         5Y1ThGDWZ2nITSGvyCFwl2UogR1NjQJIG5aMgIWTG8B3a0965I3Kew9HBL26fK+9eGm1
         imvQnXclNwEbGJG0TobD8X4JOMKX/M9lognUSGOXn+OThx7mGW8o1qJNxrNx7cLJjfHx
         BgMUHWbAl1XxNdwgeVxckovrJ4lqtM/9PCyO958pRbq89WruobiN8/gRNcCijrxff/m5
         1LKA==
X-Gm-Message-State: AOJu0Yys9vgYGOHOeUGyN4VRFrX5cE/nsnGLsY9o/Cs/RkMaYhA19XiP
	G5Fo0oglr0VSk6hPTasss2TfrZn12n7dk6WSLmPPEmeXJXkVfkH8mrMPh8g+AqxYHIMkCqNYntp
	XFb0dvSNlXIxs7hkgQ0vprmEYTtEls8C9gjaInmyMQIO07nLa9G2GvnWqXEJUr22uV3HrStdIoe
	0PSGlvJXtOCV1Ykr6lONQF1ZgEMe+dw/9jwU9YHQFs9M8ISwo=
X-Received: by 2002:a05:6e02:152b:b0:365:4004:83bc with SMTP id i11-20020a056e02152b00b00365400483bcmr3390627ilu.14.1709336752166;
        Fri, 01 Mar 2024 15:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ06KxRk3dd/M1wXNBOF8dr+0iUWZ2RQXBszXWF5MWGmzIQew0F4RftmXw3IYj/0ijx4IRhA==
X-Received: by 2002:a05:6e02:152b:b0:365:4004:83bc with SMTP id i11-20020a056e02152b00b00365400483bcmr3390615ilu.14.1709336751834;
        Fri, 01 Mar 2024 15:45:51 -0800 (PST)
Received: from cs-1zgl0npt-heavy-homedir-303475.corp.robot.car (122.32.128.34.bc.googleusercontent.com. [34.128.32.122])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b00365bd7f608esm1137012ilo.40.2024.03.01.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:45:50 -0800 (PST)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH v4 3/4] qmi: Clean up the __debug_msg function
Date: Fri,  1 Mar 2024 17:45:34 -0600
Message-ID: <20240301234539.1581017-3-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301234539.1581017-1-steve.schrock@getcruise.com>
References: <20240301234539.1581017-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: lmfhRQHNv6WRtiyicLHzTKVX65hWNwNe
X-Proofpoint-ORIG-GUID: lmfhRQHNv6WRtiyicLHzTKVX65hWNwNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010194

There was a lot of redundancy in the function and it was also not
ready to handle QRTR messages that do not have a QMUX header.
---
 drivers/qmimodem/qmi.c | 140 +++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a2a715e9..570d9bfd 100644
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
+	const void *ptr = msg + 1;
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
