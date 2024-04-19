Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A321350EC
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545181; cv=none; b=pttYGo45kc1fTzY3OnNVP+572FV33vFqqSA0RS0vw0dzZk2dD6LPMwOu9Qem86XtK57MEP1esEhpwAtl/PV9tyyYoOnjWCkddjuKS0VxY9mJsb75t880OePQdFZxMwx+UTRRpS9rwfBcibg33Tpq6xZgCqzb5tsGhzHTtokvlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545181; c=relaxed/simple;
	bh=WTJz1WTzOJbuxskxqKmHdjjOHQd7HJQHAFA4KY1j02M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYOAO1rvr7m7mgX6JQm+OjIO0/WUaJaLCtBjhLGjP4XJ58GO7TeFbNtyaXJxs27FeNgKOfWwM8lgRqiTJOZ1RXwsafm5nshSjukxwE+VTie2kU3X9y1HNqk+Q/R6xhdkQr6UWVeAWPmQCY5N51tMs2PdUsyCBei6H9nH4x3RpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=eGDVFdi3; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=lAmV/MCx; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="eGDVFdi3";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="lAmV/MCx"
Received: from pps.filterd (m0286618.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JFCepp029692
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=ppemail; bh=hVlhSepVLn4/Vdgim3iwMr
	W2j3tsdB8sU+KBpR2barA=; b=eGDVFdi3xVctxOIxzOHFNa29Dbjt8miOmOTfLP
	OrtaejWl8RWBKRDAUIVEuVM1Wd6jCPVeeI46E6WyKJiii1B66J2q529HV/+l0RV0
	VazszgWjr/yq1NBsfhjYLnuwj/V1jf3RxNXijrJMYJC1/4j0O/bZJBFmgP9UtcJt
	pu7cJbtzvz64EkN2ULbDDudLpxoE1w3KlWBZ6aG7idb6UGmsvfP+K8U+QMPSpB2+
	z4T/I+tExtNDWAXaj2r2+bj6Sx75B1MXoBzBEzlpp4IkQTNcAr1xhV44Jj6crh2M
	Ya6xsKgcxdoVl0CzRTukHl2iDgoK6CZRpnb3fla8htHMJK+A==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xk8m70wk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c5ffab3db3so2835337b6e.3
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713545177; x=1714149977; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVlhSepVLn4/Vdgim3iwMrW2j3tsdB8sU+KBpR2barA=;
        b=lAmV/MCxvA8K3UX5xBfwljuCF77v7aBb/uqLAciXH4gxsc43B4ef9xH85/jgmaJBJX
         E0d38QN7utgXMOSI8+iZwtm6a3O3GETUuHaClNIurkeiy5kNWFtEIyyRLZmTE6hPSywn
         s5Nh7KhC0GwT0mmcGG+XQuVPC3kBJOy0cNl1LN2gqTzfPhcpjesSzJslqgkV8eeejt1k
         o1KUYZTJvV2ckoGa5lcFTPFJp1f5GANOxUJYn9MYto6kgnr6LHF5YGUk0LalZmxg1H+a
         jJZ34lFyQ1JB10L3RrqJaURhuU+tMVvb4jHBEgbtaAw7flpc7JHM68uVFKHY/D8kiRJU
         9kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545177; x=1714149977;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVlhSepVLn4/Vdgim3iwMrW2j3tsdB8sU+KBpR2barA=;
        b=jcmZ1tuoN87I/x+MieXLaIXgUqQQ1uRMJEFVnX1wIhZreR83YpG2/8opVEKf81Jrnb
         MB7W5iLUSYOuLQNIT+VLmZ8mCkXwl4vA0QhICrGFiOU6+8fl4p5+zhBIrAxfSrjStCjj
         CK5vp8a9TeJ9qIX+p1G4GrWVMsgRQANlw0zu8fC6lNeDDodah4UNivNYTM0IIFrMw89B
         RpDjqWdkrz4JAzhAhkHG6F0MBdzgEH7AKfybHRNaahr/R2UZf/MJG6WgKbyE9T4ThHDR
         NT6+rpEewaS0Zs82Jo48O0THWQijLlbgBhUVILAfXv3P8WJ8wq9r3r1F3jXa04zbuz0U
         oEqA==
X-Gm-Message-State: AOJu0YxS9u0QTjGNmypNgtoiEQyIJ47YkK+96JlxWD9M4uwkaF2v31bW
	0BIHMdKQgRc539K1YW9vlUsKFJwdx9x53vvuKXGiSPScPWXKmXZZY4cXlxupvUoLGRjBtTm2jXr
	oNXXz6C2wfHXRBvX00XP1RUMQNfXaLyFcBFG0b9U8Xg5yt9lZ8Hs/WC7MvsJL8iR1sTg738lPrF
	khOiv98RUSqmJD4KS4s4CuqYa5y9gDKarI0MDx0C2MMNsig4c=
X-Received: by 2002:a05:6808:ab8:b0:3c7:39f5:d3b5 with SMTP id r24-20020a0568080ab800b003c739f5d3b5mr2892510oij.58.1713545177218;
        Fri, 19 Apr 2024 09:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE09Y59vS3T3/VyniTzWx6K/b/ZBV2a2JWxTxZ0AheM0Bv8bjJsVLvKoikwe57PkfOOyzV1xg==
X-Received: by 2002:a05:6808:ab8:b0:3c7:39f5:d3b5 with SMTP id r24-20020a0568080ab800b003c739f5d3b5mr2892477oij.58.1713545176773;
        Fri, 19 Apr 2024 09:46:16 -0700 (PDT)
Received: from localhost.localdomain ([140.141.181.78])
        by smtp.gmail.com with ESMTPSA id n9-20020a05622a11c900b00437a0c8e662sm1577295qtk.20.2024.04.19.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:46:16 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH 4/8] qmi: Eliminate unnecessary casting to unsigned int
Date: Fri, 19 Apr 2024 16:44:54 +0000
Message-Id: <20240419164458.36078-4-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419164458.36078-1-steve.schrock@getcruise.com>
References: <20240419164458.36078-1-steve.schrock@getcruise.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: RskWDl3c96MeSMWUtD3Q_cxPIle2bR1g
X-Proofpoint-GUID: RskWDl3c96MeSMWUtD3Q_cxPIle2bR1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190127

uint16_t values were copied into unsigned ints before being passed to
L_UINT_TO_PTR. Perhaps this was necessary when the glib macro
GUINT_TO_POINTER was used, but it is not necessary now with the ell macro.
---
 drivers/qmimodem/qmi.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index e1091b872f23..f406d01a8df6 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1330,7 +1330,6 @@ static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 	struct qmi_request *req;
 	uint16_t message;
 	uint16_t length;
-	unsigned int tid;
 
 	/* Ignore control messages with client identifier */
 	if (client_id != 0x00)
@@ -1338,7 +1337,6 @@ static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 
 	message = L_LE16_TO_CPU(msg->message);
 	length = L_LE16_TO_CPU(msg->length);
-	tid = control->transaction;
 
 	if (control->type == 0x02 && control->transaction == 0x00) {
 		handle_indication(&qmux->super, service_type, client_id,
@@ -1347,7 +1345,7 @@ static void __rx_ctl_message(struct qmi_device_qmux *qmux,
 	}
 
 	req = l_queue_remove_if(qmux->control_queue, __request_compare,
-						L_UINT_TO_PTR(tid));
+					L_UINT_TO_PTR(control->transaction));
 	if (!req)
 		return;
 
@@ -2860,12 +2858,11 @@ uint16_t qmi_service_send(struct qmi_service *service,
 
 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 {
-	unsigned int tid = id;
 	struct qmi_device *device;
 	struct qmi_request *req;
 	struct service_family *family;
 
-	if (!service || !tid)
+	if (!service || !id)
 		return false;
 
 	family = service->family;
@@ -2878,11 +2875,11 @@ bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
 		return false;
 
 	req = l_queue_remove_if(device->req_queue, __request_compare,
-					L_UINT_TO_PTR(tid));
+					L_UINT_TO_PTR(id));
 	if (!req) {
 		req = l_queue_remove_if(device->service_queue,
 						__request_compare,
-						L_UINT_TO_PTR(tid));
+						L_UINT_TO_PTR(id));
 		if (!req)
 			return false;
 	}
@@ -2965,7 +2962,6 @@ uint16_t qmi_service_register(struct qmi_service *service,
 
 bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 {
-	unsigned int nid = id;
 	struct service_family *family;
 	struct qmi_notify *notify;
 
@@ -2975,7 +2971,7 @@ bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
 	family = service->family;
 
 	notify = l_queue_remove_if(family->notify_list, __notify_compare,
-					L_UINT_TO_PTR(nid));
+					L_UINT_TO_PTR(id));
 
 	if (!notify)
 		return false;
-- 
2.40.1


-- 


*Confidentiality Note:* We care about protecting our proprietary 
information, confidential material, and trade secrets. This message may 
contain some or all of those things. Cruise will suffer material harm if 
anyone other than the intended recipient disseminates or takes any action 
based on this message. If you have received this message (including any 
attachments) in error, please delete it immediately and notify the sender 
promptly.
