Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E7326927
	for <ofono@lists.linux.dev>; Mon, 17 Nov 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372130; cv=none; b=BSziixHC1pqJk5KgShogN+4iJZkvkBfPxg69gxHyUdGd+rZELNUR5QnRDbn9H3ZhLWKXxefIaeDMQu5I5fj93JZ/G0n0LrDIYy4qGjijIq6vEZrd7oc4w8sKiTwEOAJJ1024JEyaMD3BBhiKlNLGpFpGuqFuJRfuHqxBorHkdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372130; c=relaxed/simple;
	bh=6+953RdvizLQcQosyotKxR9FH14GOT7wQEVu14Vfcp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PUWCxrC36TUYLLODUz5pERaFCmJKeEH3j4kGIyPg5ZkNXZ4hQ8VQy0O9PcguL2D05FFjd4Kjd8pdTWV7UBPkEITZBLrxfaMxrQXXaNCQ06jRJYzJBz3XDwfjwrmT2o7RYD3BX96X1KUyqxDb2imSpHo1VHsDhBK6edv+dwTMwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=anihejnO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="anihejnO"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH4o4XV2910707
	for <ofono@lists.linux.dev>; Mon, 17 Nov 2025 09:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6+953RdvizLQcQosyotKxR9FH14GOT7wQEVu14Vfcp0=; b=anihejnOkdbzTYbI
	fUqEDxgAPP/YqJ1KpdbJkDxySfM5lkLa/JxfQlD9O0+3DItD88nEagajGmt1//fx
	FCEqfTLDVaBV14TTR+QJnKvIsoDckaJg3c2uoaGfynI1moVIxNpc2w+QEgzETrqi
	a0YnDTqLtemYtdjuYS1u8EKJK+WeLT4u+oWajKcoX7JqibntnDYkaU1wGNJrmm4b
	maKJNm86Kp6DzoLLYHo0hs3R/XibtLmJ4F4zK2ZwBrV3XNd+y/ul6grrTgclNl2A
	oEM3D+eiGc2Fidowc9tn1OyvgXCXuFhUpZMnfyfVXkELCnhbWmZqUCeQkevcsVBt
	tBP+lg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejgcc6a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 17 Nov 2025 09:35:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5AH9ZPTm010445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ofono@lists.linux.dev>; Mon, 17 Nov 2025 09:35:25 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 17 Nov 2025 01:35:25 -0800
Received: from nalasex01c.na.qualcomm.com ([fe80::5b2a:a496:50da:8476]) by
 nalasex01c.na.qualcomm.com ([fe80::5b2a:a496:50da:8476%11]) with mapi id
 15.02.2562.017; Mon, 17 Nov 2025 01:35:25 -0800
From: "Raghavender Reddy Bujala (QUIC)" <quic_rbujala@quicinc.com>
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>
Subject: Planned Release Date for Version 2.19
Thread-Topic: Planned Release Date for Version 2.19
Thread-Index: AQHcV6WAayZOuiwyMEupvGJ8w8iaEw==
Date: Mon, 17 Nov 2025 09:35:25 +0000
Message-ID: <062a5c25d6cf4549b9144c8453a83271@quicinc.com>
References: <20250728060806.932-1-quic_rbujala@quicinc.com>
 <175371480575.736343.10408751198800373287.git-patchwork-notify@kernel.org>
In-Reply-To: <175371480575.736343.10408751198800373287.git-patchwork-notify@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rGwq9IFgxWx5wlDooLObYXSiIC8qc_q_
X-Proofpoint-GUID: rGwq9IFgxWx5wlDooLObYXSiIC8qc_q_
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=691aec60 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=xqWC_Br6kY4A:10 a=rflSO8C6ujYA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=BYuV7Bd62dM3D-F8J38A:9 a=QEXdDO2ut3YA:10 a=j_clbiFRiAsA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA4MCBTYWx0ZWRfX4uGEd+mHMrJD
 /HdThIF8yP2ebmcOmlPFFJZfLj+h4vdkebd1ISIcgYCHUypKBh0lpkkbDPW6fj9TNIcGk453uGc
 pqr/ABQQGMCGLwTfLhwToIZv0hWbRHIWUSCNBaqKjCioSJcHMkFM08lgle/xy2eKqoKtLnvVkgJ
 croBCiwoUDgq+0jvOLQvR8/xDH+yIblIB/+oS5mpsiwWfE5NTi9ItcxfRA4Rmkw90xRwnKdqpap
 jfaUVDyZnM6K4O7IjJXOF0vZ5EF8qjkD52oSXCvevWkg/5Ygks3c5WIv3Xv5+41fW/8cPmPeD7H
 ID6zdo5Efba+Z0Zx9aLvZxgqpZ/gJApRANqXmAzQ8bhhbBFf5fZ3cRazSpRZeeN0pW4TYwz1Vi8
 VPo9APD74ymYODOsNFys1Px/+eKYAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170080

SGkgVGVhbSwNCg0KSXQgYXBwZWFycyB0aGF0IHRoaXMgY2hhbmdlIGhhcyBhbHJlYWR5IGJlZW4g
bWVyZ2VkIGludG8gdGhlIG1haW5saW5lLiANCldlIGFyZSBjdXJyZW50bHkgd2FpdGluZyBmb3Ig
dmVyc2lvbiAyLjE5LCANCmNvdWxkIHlvdSBwbGVhc2UgY29uZmlybSBpZiB0aGVyZSBpcyBhIHBs
YW5uZWQgcmVsZWFzZSBkYXRlIGZvciBpdD8NCg0KVGhhbmtzLA0KUmFnaGF2ZW5kZXINCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHBhdGNod29yay1ib3Qrb2Zvbm9Aa2VybmVs
Lm9yZyA8cGF0Y2h3b3JrLWJvdCtvZm9ub0BrZXJuZWwub3JnPiANClNlbnQ6IE1vbmRheSwgSnVs
eSAyOCwgMjAyNSA4OjMwIFBNDQpUbzogUmFnaGF2ZW5kZXIgUmVkZHkgQnVqYWxhIDxxdWljX3Ji
dWphbGFAcXVpY2luYy5jb20+DQpDYzogb2Zvbm9AbGlzdHMubGludXguZGV2OyBNb2hhbW1lZCBT
YW1lZXIgTXVsbGEgPHF1aWNfbW9oYW11bGxAcXVpY2luYy5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBvZm9ubyA6IGVuYWJsZSBwcm9wZXIgRC1CdXMgY29ubmVjdGlvbiB3aXRoIFBpcGVX
aXJlIHZpYSBvZm9uby5jb25mIHJ1bGUgZm9yIFlvY3RvIGJ1aWxkcw0KDQpIZWxsbzoNCg0KVGhp
cyBwYXRjaCB3YXMgYXBwbGllZCB0byBvZm9uby5naXQgKG1hc3RlcikgYnkgRGVuaXMgS2Vuemlv
ciA8ZGVua2VuekBnbWFpbC5jb20+Og0KDQpPbiBNb24sIDI4IEp1bCAyMDI1IDExOjM4OjA2ICsw
NTMwIHlvdSB3cm90ZToNCj4gLSBBZGRlZCBjb25maWd1cmF0aW9uIHJ1bGUgaW4gb2Zvbm8uY29u
ZiB0byBlc3RhYmxpc2gNCj4gICBjb3JyZWN0IEQtQnVzIGNvbW11bmljYXRpb24gd2l0aCBQaXBl
V2lyZSwgd2hlbg0KPiAgIHBpcGV3aXJlIHJ1bm5pbmcgYXMgYSBzeXN0ZW1kIHNlcnZpY2UuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWdoYXZlbmRlciBSZWRkeSBCdWphbGEgPHF1aWNfcmJ1amFs
YUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBzcmMvb2Zvbm8uY29uZiB8IDQgKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpIZXJlIGlzIHRoZSBzdW1tYXJ5IHdpdGgg
bGlua3M6DQogIC0gW3YxXSBvZm9ubyA6IGVuYWJsZSBwcm9wZXIgRC1CdXMgY29ubmVjdGlvbiB3
aXRoIFBpcGVXaXJlIHZpYSBvZm9uby5jb25mIHJ1bGUgZm9yIFlvY3RvIGJ1aWxkcw0KICAgIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL29mb25vL29mb25vLmdpdC8/aWQ9
MWE0MTRkNGJmMzQwDQoNCllvdSBhcmUgYXdlc29tZSwgdGhhbmsgeW91IQ0KLS0NCkRlZXQtZG9v
dC1kb3QsIEkgYW0gYSBib3QuDQpodHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29y
ay9wd2JvdC5odG1sDQoNCg0K
