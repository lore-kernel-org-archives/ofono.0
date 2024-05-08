Received: from mx0b-003ede02.pphosted.com (mx0b-003ede02.pphosted.com [205.220.181.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856C8625B
	for <ofono@lists.linux.dev>; Wed,  8 May 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.181.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179200; cv=none; b=rek4Slyn84ZfEgacYC0IGW6u45+Cm5cpUdXw3540XUIyJZGuNxf9XPC4gcDLlJrmqlMlxjKxHSX+2X/v4/yjyUrqplpDwUUBJgeHurV0j92QDxjLjAPrX2lKd9spE3LLpPF7ZZ9WfIL4f7+QMs0iamVoywltLw9uLqnIw0RK4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179200; c=relaxed/simple;
	bh=MLF2OL9DNWYowIECqbRPq33jiVre429HgPjr9slU2j8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGEc37B0uo2qA73x9o0jWX3YjsZyPOTsPVW4a8ny6piVz3q6vNlK7qZWVtr/b47eN/82IJaL0FsK09D4cbNWu1UgwBk4j9ssNOKFLlZWNB7xkwihgAJs7VWJqVHmsg6LeN0BXyAodZtReNj0uqCJxliSjImUs0GEwkUYmVKI4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=Ct05jT/e; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=JLyHuSat; arc=none smtp.client-ip=205.220.181.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="Ct05jT/e";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="JLyHuSat"
Received: from pps.filterd (m0286619.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448DMojW017929
	for <ofono@lists.linux.dev>; Wed, 8 May 2024 07:39:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=ppemail; bh=rEIBjiuvM9IhM4oUHv1Sif
	fNKyrTAh41z4mgLYaxa8w=; b=Ct05jT/eOHAsjZE57iVEB8wwL9pKphpnL5FsxP
	C51PuQL5pum+vlUXQXsfn2vlGIFvqU/6k9U6j1UDKo8sXCTgUuzzEq8aoz8jazM2
	k3K0f2yiy2FDMqGW0KMb1A2wd/JNjafUxkmtLRLM/W65I7ejpg+88bjfzpWa11yw
	mGJMhbn99974dfKmX3szHGIYEZXJKf00pHJmHLcQaogPER+cza1HMR6JBxC7nJEI
	zsDCfLImRtAGnpoBbKJRnyKuC/dZP8qUC2g5Qk47nDAme0KfKGbEpgplvBa9XKHv
	Ex2TmHcU9CEJ8YvywTMyQH6zXmZuh0G2HKFPl4ZwNG3CrY/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xysfcgutf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Wed, 08 May 2024 07:39:57 -0700 (PDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43d38a00d4fso47835681cf.1
        for <ofono@lists.linux.dev>; Wed, 08 May 2024 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1715179196; x=1715783996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEIBjiuvM9IhM4oUHv1SiffNKyrTAh41z4mgLYaxa8w=;
        b=JLyHuSatReLEeo2q0xBdMbzIJggr4yHo+cI13CTXaofwHjBkcAD/1Pw4nAGf3j1VkQ
         wbXxAcR61OQwI40kgXULcQ3MrQYF53yI+7dDY7IdbrgHmiB6XUOsw8kfiL/DTxYhjCsz
         blQjDMtmZj19TnZRfZ+9QEtfZRIMVQbit8KEMDfp0MQ2vZxSbJRvILM6zOaD513CgDSM
         MoZSPuQYYjgVITpHeMVMu+MqC/JWyq4hEbPibJOrdHEAOSf6xWzeoiM4pt2qUBE9G2dK
         xoVnWHB0QotGCqSdCHxxIkhx2h6PTUHzzsFkz18dEXaWnunzkArRZB1IQSF1AbrnY3D4
         A5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715179196; x=1715783996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEIBjiuvM9IhM4oUHv1SiffNKyrTAh41z4mgLYaxa8w=;
        b=LYxoZWBtA3JDTSvHDlhZ8mtxDxARMseA5c5EHQ+1y6dcFXOkXfaVt3tBzo3pljStlT
         33pEgaK5ndH0gAE1vIcjf6ylDB7zQq5lKVN5hKJbsIgZZQWjaleepC4rkeW9YE4hBT4S
         fJJzDyLiEwzaouHPNIWiRYgaBwg81MyTs8jweHpYksSF1npvXBiHzvRUgK+2NQ4AQA3/
         dOQjn13i4IAjBtqu8CLnYbTdyJpR3eZg8gffOZFBKjbmUTRFq7S10NafdSYBXbzsFTO+
         NENqz20Y/gcSdceNUKVFNJq/DamqYqobqZTuYHqpUSEPDQXGuJZJ1vByCoKbJX4zeXDB
         PEmg==
X-Gm-Message-State: AOJu0Yz9ZKrhhUfK6xKZ69/Hod7LEetOJwADPjb3O1rJBsY3/4YONQlO
	GX1LTTK7iM/Q2vCkN8k0fP4EnHXusB8zG7A2pr2rIm28mXC2TbCHsALhQj3WtTncsAw+dCyIr5l
	XQI14ZSYMBWwY7aaxfa1VJmMkZx86lmtdwGTnSg1AX5G4a2MIAolSRm9QJz+UrKyvZpHWtMcTB7
	dS7JIb+n+8MivLSFbR4E7MgS1UGgVXQW2OM+AF2Hb4i4nNfDI=
X-Received: by 2002:a05:622a:164d:b0:43a:9e4:1689 with SMTP id d75a77b69052e-43dbed17639mr28866961cf.19.1715179196532;
        Wed, 08 May 2024 07:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiZAkffVbhAPsglomTUPgj1pLctjtOs62+KNlDQkIj2bM9aK7/I+ZtbgJEV/5I+S+s5k/5sw==
X-Received: by 2002:a05:622a:164d:b0:43a:9e4:1689 with SMTP id d75a77b69052e-43dbed17639mr28866761cf.19.1715179196121;
        Wed, 08 May 2024 07:39:56 -0700 (PDT)
Received: from localhost.localdomain ([140.177.141.179])
        by smtp.gmail.com with ESMTPSA id o18-20020ac86992000000b0043d4245dd4csm4403757qtq.84.2024.05.08.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:39:55 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: ofono@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] log: Handle dladdr failure
Date: Wed,  8 May 2024 14:38:44 +0000
Message-Id: <20240508143844.42060-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XwXRXkZX9lWvgw9ytoTlWHmjKbf7IYHj
X-Proofpoint-ORIG-GUID: XwXRXkZX9lWvgw9ytoTlWHmjKbf7IYHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=776 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080104

If unit/test-qmimodem-qmi times out while running under valgrind,
valgrind complains about an uninitialized value being printed during
abort signal logging. dladdr fails on the valgrind address
(0x580BCE37 in the example below) but print_backtrace still tries to
access the Dl_info structure which is not initialized. The fix is to
handle the dladdr failure gracefully.

==36318== Conditional jump or move depends on uninitialised value(s)
==36318==    at 0x4A862F8: __printf_buffer (vfprintf-process-arg.c:408)
==36318==    by 0x4AA8067: __vsnprintf_internal (vsnprintf.c:96)
==36318==    by 0x4B1D62B: __vsyslog_internal (syslog.c:220)
==36318==    by 0x4B1DB83: vsyslog (syslog.c:100)
==36318==    by 0x407C3F: ofono_error (log.c:92)
==36318==    by 0x407FEB: print_backtrace (log.c:201)
==36318==    by 0x40816B: signal_handler (log.c:228)
==36318==    by 0x580BCE37: ??? (in /usr/libexec/valgrind/memcheck-arm64-linux)
---
 src/log.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index a8b4ef10eaae..fdfad362cfd1 100644
--- a/src/log.c
+++ b/src/log.c
@@ -171,11 +171,13 @@ static void print_backtrace(unsigned int offset)
 
 	for (i = offset; i < n_ptrs - 1; i++) {
 		Dl_info info;
+		const char *fname = "???";
 		char addr[20], buf[PATH_MAX * 2];
 		int len, written;
 		char *ptr, *pos;
 
-		dladdr(frames[i], &info);
+		if (dladdr(frames[i], &info))
+			fname = info.dli_fname;
 
 		len = snprintf(addr, sizeof(addr), "%p\n", frames[i]);
 		if (len < 0)
@@ -199,7 +201,7 @@ static void print_backtrace(unsigned int offset)
 
 		if (strcmp(buf, "??") == 0) {
 			ofono_error("#%-2u %p in %s", i - offset,
-						frames[i], info.dli_fname);
+						frames[i], fname);
 			continue;
 		}
 
-- 
2.40.1

