Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240C1D8DEE
	for <ofono@lists.linux.dev>; Mon,  3 Mar 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973017; cv=none; b=UMYB2B/Ti+c7CseaDtcAWtGBb48EytrcA0uvERptTfXf1g381kk6pPUY7DwSsREWIvZy03SR8bC1xjWXe0HAWWc2Kw25pfdyLYcOkKiAPMLi4Q2+KdO1v053M8fDsFapKjVTJMvefGZwT8+nBpoLhpPr91UqtaYB95bxRXCIHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973017; c=relaxed/simple;
	bh=30tUUaLIi0vqRd2/EEQhPkctbWf3IOireLrJkDxGizM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j6e5RHdGlslIsPe8z8edkaL7fSyH0Zn4YqKV90VCOoVwPul9Qak2ph6wMlct/+5HvdO3TSChLMlip2c1Qyo86WZnIDXxcioThWor7Pfc8FGEUySLpFUzxuH+kQDUDNy8SD+cV6PVU13VUjRngjVL4vlvN0jUgNqE+EIHecHfhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X9Q2tJwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X9Q2tJwK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5230gZK3032740
	for <ofono@lists.linux.dev>; Mon, 3 Mar 2025 03:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=2kCD/+3emKjb
	REdZpgNOeKkv1XuHZ8+LV70VHVLNH2w=; b=X9Q2tJwKvw3iXvkoOwAFHXJVa8gm
	mvNFgzDlywHFcEDO2bTTC7P3/Q0SVDVMQCeLhULyff0Hz2JojKHmTL9cA297qj/o
	Ih6mAekHPxPx8kH2nPI1DRp0faYc8T40JftFqqinAjsfqBwNdDVSqqvA7s4Yknvn
	/G4Z4312dsJUOO8Jji1LoLPTQcnpHd4Dzk5d8520++WuYmYYlWiHeR8UmaQL1YuR
	8uCsOFRB6+IcKif/pSeVtb+4aG/glc71iqotRydQ16qjCdUMzM14bnTsfXYrNu0/
	4b3Y1nbTBQIWlHRS3zvG3Z2DGG9AXne/xVQ/slj/YeNjsVpFd9AzzOfiug==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh737uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 03 Mar 2025 03:36:54 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5233aohA002129
	for <ofono@lists.linux.dev>; Mon, 3 Mar 2025 03:36:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 453uakthg4-1
	for <ofono@lists.linux.dev>; Mon, 03 Mar 2025 03:36:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5233aoAD002124
	for <ofono@lists.linux.dev>; Mon, 3 Mar 2025 03:36:50 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-rbujala-hyd.qualcomm.com [10.213.107.103])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 5233aobt002123;
	Mon, 03 Mar 2025 03:36:50 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4130939)
	id 8A939605405; Mon,  3 Mar 2025 09:06:49 +0530 (+0530)
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
To: ofono@lists.linux.dev
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: [PATCH v1] hfp:Update for new HFP 1.8
Date: Mon,  3 Mar 2025 09:06:46 +0530
Message-Id: <20250303033646.21816-1-quic_rbujala@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hdzsNWuIZZqVRzFEp1Frx10uqekKeRGe
X-Proofpoint-ORIG-GUID: hdzsNWuIZZqVRzFEp1Frx10uqekKeRGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=866 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030026
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

Existing 1.7 version is outdated/withdrawn to
do certification, so updating it to 1.8 .

Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
---
 plugins/hfp_hf_bluez5.c | 2 +-
 src/hfp.h               | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 40051480..5ad1674f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -774,7 +774,7 @@ static void connect_handler(DBusConnection *conn, void *user_data)
 
 	DBG("Registering External Profile handler ...");
 
-	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_7, "hfp_hf",
+	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_8, "hfp_hf",
 					HFP_EXT_PROFILE_PATH, NULL, features);
 }
 
diff --git a/src/hfp.h b/src/hfp.h
index e58b0d22..28600664 100644
--- a/src/hfp.h
+++ b/src/hfp.h
@@ -72,7 +72,8 @@ enum hfp_version {
 	HFP_VERSION_1_5 =	0x0105,
 	HFP_VERSION_1_6 =	0x0106,
 	HFP_VERSION_1_7 =	0x0107,
-	HFP_VERSION_LATEST =	HFP_VERSION_1_7,
+	HFP_VERSION_1_8 =	0x0108,
+	HFP_VERSION_LATEST =	HFP_VERSION_1_8,
 };
 
 enum hfp_hf_indicator {
-- 
2.17.1

