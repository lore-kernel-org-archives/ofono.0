Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA24C676
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682894; cv=none; b=TDK7V6pHdsKUdV5qdu/enIsMMqE34nz0PB+E6F91U8Y7e1z1TIHux5t1XTCCAQZNuH2zdlzvwk5uFoJQUnMgXSBgQBjEnx8ZSelMWj6rpa/jAiwG/hZgwp2WUmMeOPtH0IurJDicKiFf8PVEcJsYBZN9o8Iwyme+3t4g4qZcy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682894; c=relaxed/simple;
	bh=c5sjWeXgQrSmZZR1dtxJucBNey/J6tFqPYy5og+KgZg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FVuA/Ztsssh5Du6tBymekBISkHMQs1iy6hC7zaTmWOAQbWbMLoxb35U4aWaL6btzwlxaTnvwIkzkettBVGDkOJqq3XEUqOMuovM3QCD+F9+wKtld5OQg2BRiokoON48ntnK0J6lukEg2ZMN99JD8t/IJqBiL6O2iXznuET32tGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KWLwllU+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KWLwllU+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rKwa023311
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=FSXz9eeMS3m5
	5erQdsGMs08j4LUfsPqDWF9YbvrSR/w=; b=KWLwllU+yP3NaGAgaZpklii1HTzD
	mEJ3n5d6dZTFzKW83zY3Dz+obMHP7Cw01jKxk/x0thvUywLAFgG8CZRbz+1/A+3c
	ARVnTmpR5d7D8xvMC4TbHlPKyqfCjPCMzulS0SrjOL8iCFciUWxGhgWBQPTW14/y
	rS/PoJiFHofUkTZiJew52lCFwBjRrorC1vGz7VXGChM2vx5KcFVC7b9IbE8wo41S
	mVshfnmausncmk9WOjVA/bDDGEizY4WD9ttc/ZpPMiilOjcgCvKog++QUe19oaMG
	fUUth09ZLU2zhzmyJ/kQuK2V0xQl66nr0kQfZP1h0RuYrc+wmJFmOnoPlQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr3kbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56S687Y5018579
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 48591dr4p9-1
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:07 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56S687vR018573
	for <ofono@lists.linux.dev>; Mon, 28 Jul 2025 06:08:07 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-rbujala-hyd.qualcomm.com [10.213.107.103])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 56S687cT018572;
	Mon, 28 Jul 2025 06:08:07 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4130939)
	id A15A85001B7; Mon, 28 Jul 2025 11:38:06 +0530 (+0530)
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
To: ofono@lists.linux.dev
Cc: quic_mohamull@quicinc.com,
        Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: [PATCH v1] ofono : enable proper D-Bus connection with PipeWire via ofono.conf rule for Yocto builds
Date: Mon, 28 Jul 2025 11:38:06 +0530
Message-Id: <20250728060806.932-1-quic_rbujala@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0NCBTYWx0ZWRfXzO18LzKnfXXd
 Ni/lEY5mdn5jZ/kdhMN+iz1SBNUEsDiFjJvQkBCZnLDXzzOjSA9SZWzLE9gflVvjTgJC0RqvR31
 c+AHwWdVdAzv2ZRRfCLgu6bRHEGBwePgVX7J3CuPzHKLez+IIkyAGy6RcI9pbsmj1UwvRv3GyfR
 mX0NRr7znAucjtf+2MAlIm4QNdJJLyGkXkJtjLI+g1oHfZJV9dNqHRoggzTzg73ipr4z86CMcER
 fw9wl/4c6Xlj+EzuFw6opPKvhm/hGk+zF9lcvbqMlMbgysYwlP+5R/14yLpU2cTZBLz1HaSYGTV
 cxtWmOwpHYVNdxfK0tuX9aE/3G9XnG7LSxilXOR467fz1ROBfAFv1kGfxcIIXrNyTodCRlvhJDE
 535o3zkF621P93P96Etq/KauX5Zv3iKpaC3c6ffRhv4Y7UgGNINlu/pLp0nN6NW/HlhDqvIM
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688713ca cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=YA1bgfa3cMmosXX2zMUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: c-pTWdOSr9M6sVUReNBRlBjG0OXzonCy
X-Proofpoint-ORIG-GUID: c-pTWdOSr9M6sVUReNBRlBjG0OXzonCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=868 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280044
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>

- Added configuration rule in ofono.conf to establish
  correct D-Bus communication with PipeWire, when
  pipewire running as a systemd service.

Signed-off-by: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
---
 src/ofono.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/ofono.conf b/src/ofono.conf
index 45cb15c1..99de9a2c 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -27,4 +27,8 @@
     <deny send_destination="org.ofono"/>
   </policy>
 
+  <policy user="pipewire">
+    <allow send_destination="org.ofono"/>
+  </policy>
+
 </busconfig>
-- 
2.17.1

