Received: from sjdc-mailout3.udc.trendmicro.com (sjdcvmout06.udc.trendmicro.com [66.180.82.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEE111AD
	for <ofono@lists.linux.dev>; Thu, 17 Oct 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.180.82.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133161; cv=fail; b=lobdfmo3aCp+vG3AvPTsMRkB4dHVCwn/GhRaMwruwk2cBK6RkXAvTQkmuphfsy17HcKXeFCpQTkeofyteSeonje2s4AoDbNWWD7RSCfG7SZv36Z3bO1KvxFmX3mbib5M+4reUT5UqGmxCz7Vq3UqaGlmB2KoWWtB4vPe18OsQls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133161; c=relaxed/simple;
	bh=JVUkOG/a+t4dSPpA+XSrW260AXhqrAjOtY3nJQmFw40=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqneNFqgM0HUGj1uTmqLaAGVft9uec8lBCgETpcXEfwO+/1waD6U/WiJpxSonYGR2ZDjYpbrE1x7Ohs2cRKLtssTn89fg3iCOczmI7Vm09NVWEScpRTyhfaSuNtwpeICESfCwsLOPqKtfprmh5vZYbDzdf6zTD5aHlBtBNGmE+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=Tw9q8ZM3; arc=fail smtp.client-ip=66.180.82.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="Tw9q8ZM3"
Received: from sjdc-mailout3.udc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 236D25E12AB
	for <ofono@lists.linux.dev>; Thu, 17 Oct 2024 02:41:21 +0000 (UTC)
Received: from sjdc-mailout3.udc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 0CB315E12CD
	for <ofono@lists.linux.dev>; Thu, 17 Oct 2024 02:41:21 +0000 (UTC)
X-TM-AS-ERS: 10.42.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Unused
Received: from SJC1-EXCH01.eu.trendnet.org (unknown [10.42.230.32])
	by sjdc-mailout3.udc.trendmicro.com (Postfix) with ESMTP
	for <ofono@lists.linux.dev>; Thu, 17 Oct 2024 02:41:21 +0000 (UTC)
Received: from SJC1-EXCH02.eu.trendnet.org (10.42.230.33) by
 SJC1-EXCH01.eu.trendnet.org (10.42.230.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Wed, 16 Oct 2024 19:41:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by exhybridnabu.trendmicro.com (10.42.230.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37 via Frontend Transport; Wed, 16 Oct 2024 19:41:03 -0700
Received: from BYAPR01MB3831.prod.exchangelabs.com (2603:10b6:a02:82::26) by
 PH0PR01MB7367.prod.exchangelabs.com (2603:10b6:510:dd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 17 Oct 2024 02:41:01 +0000
Received: from BYAPR01MB3831.prod.exchangelabs.com ([fe80::44bd:c84:7b73:1a4])
 by BYAPR01MB3831.prod.exchangelabs.com ([fe80::44bd:c84:7b73:1a4%2]) with
 mapi id 15.20.7982.030; Thu, 17 Oct 2024 02:41:01 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
Subject: RE: ZDI-CAN-23193: New Vulnerability Report
Thread-Topic: ZDI-CAN-23193: New Vulnerability Report
Thread-Index: AdprJUpJYjxfYKT/Q0G92AISrXvfRi1GJasQ
Date: Thu, 17 Oct 2024 02:41:01 +0000
Message-ID: <BYAPR01MB38314BD04D18B80099234E1880472@BYAPR01MB3831.prod.exchangelabs.com>
References: <DM5PR0102MB3477CC4030B490BF74F083B8805F2@DM5PR0102MB3477.prod.exchangelabs.com>
In-Reply-To: <DM5PR0102MB3477CC4030B490BF74F083B8805F2@DM5PR0102MB3477.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=f20f9258-329c-4507-a38c-9b935e8e22b5;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2024-02-29T15:38:49Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3831:EE_|PH0PR01MB7367:EE_
x-ms-office365-filtering-correlation-id: c534f55e-c44b-45b4-901e-08dcee552355
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bExBNVg2amJ4V3pLcElIYW8vbnpUS0hnenovc01aYjUzTVpyUFkxcnU2QkFM?=
 =?utf-8?B?WGlqVWxDR21CbGc3MVFVUXg2RXRLRlNIZ2MyMld2Y1VIRnkxQjM4RDVsNEhC?=
 =?utf-8?B?Z1lSbE4wS0QzM25aTkQyclVpL2RNOEg0OXc4RlpDdDdMM0pybUtCZGJKZXk4?=
 =?utf-8?B?bHkxcWt0SmtUVkU1a00zYXpkK3ZQV2QyYUNZMCtlUXVrSHdPb1h4alo5blpk?=
 =?utf-8?B?ckczNWVvcVBBZ2VtYkhPV3RxYllUQUhlcXhMYis4MlZsWVlZTktObDh0Tjgx?=
 =?utf-8?B?blV2SFRlbENiWnRZRGV3OGNCZld6QWZCbmk4QnZjcTY3MzFndkVDN0tFZ1JB?=
 =?utf-8?B?ay9nN1V2ZC9GUENWbzRIT1ZSb2gvcW05TDBQOEhPcW0ra1BuRmkyT1hsRTVG?=
 =?utf-8?B?RkVOWEY5bThXcEJ6clYxN200dmY4K3VYL0NKcVN0R3JTVTdIWjhSZlcrbGV1?=
 =?utf-8?B?SlZtNUhDenNmUE1YQ1lLcmpXWExvYUZibytCWVQ3Q3Y0OTNjTkY4cFhoVlRK?=
 =?utf-8?B?a3MvaUUwRmw1UmVKLzg1YmE1RzVqZVI5QVpnSjArTlBVaTZhOUd0Snh0OHJr?=
 =?utf-8?B?aXVyQjB4Qk9EU2RKcTJGR1JoZUczTHExbzkvdWlVNEV6b25lckhvdFZPWHRE?=
 =?utf-8?B?V2MxUVpUMStEZks3NDIxUWFqakVsUjBIOWUxQ29xcWUrbUI0YmZacU8ySVZN?=
 =?utf-8?B?ZnFTZ2JYeXJJVVZsbmVlbGFrL0ZEL1dESTNpQXFJQUFhUEZac3hMMTQ4RG41?=
 =?utf-8?B?YXJhM09vTmp4eGVQNkRhSEVEdUplWXh3d3BScFU2S0s5MEV2d0lYK1cvZ1No?=
 =?utf-8?B?NTlHcktZVCtIWnpPeW00TmViejFHMnlwR0ZTMWhPNVZPbm95dmc0akFLdUxX?=
 =?utf-8?B?ZmRsY3FUbTk4UG95TTVwaThIMHpDcnNPaWl1QzRxWTIweVlmL3dweWpMVzR2?=
 =?utf-8?B?c083K3U4L21QM1dJcDk0YkZ3WHFPTjR5MTNlOE5nYlhrYkdKeFU2VlVTT20z?=
 =?utf-8?B?bitTL1ZBNzJ4b2lZU1NyL1QzaDZINmEzZUhBOFFEc0oxMlBXWWM0Z0N5TDNE?=
 =?utf-8?B?Sk1xbGlMREVTaGhOZGZjU200SE9IdmRnTGJyWU83czZXSXNFSXBMdEVSWmIw?=
 =?utf-8?B?N1NUb1pOZzBHMFh6R1JIUE1wV2wzamxUVFFRUXZXUjcvbXYzekl0VlhWdU93?=
 =?utf-8?B?b0xWSDgxcXBWb0hIUzlDblRXTVZhVU9sY0hwN1dtOUpra3RTcnZ0WUt4dnNs?=
 =?utf-8?B?Y2QyKzFHZWprbSt0dWcrS3NhY0NZM1RYbldZZU1GZ0Y0OFVockt0OWtnY3NM?=
 =?utf-8?B?b0djbk4xN2JGZFRXeWE3TlVQRGU1WWFGVWhENlM2eUFRaG5Oa3ZUU202M2ZJ?=
 =?utf-8?B?WFlsT1ZnbHZ3S2tiK0lmYXl0bHRZamVDSVRJck8zc0lGbkkrb0JxUnU3eVB1?=
 =?utf-8?B?Nlg5dVR3dE5kSGVpUEcrTUw5ZHg0b2tIUWsrRms3Tk1WdGEwQmxDcHJPejZD?=
 =?utf-8?B?OFgyQSt3VGZXWEZyMnFOMW8rb1BuT0hma3FZK3BBcG45aElOdmdtSzVDSWox?=
 =?utf-8?B?MXdkck5NbHUzRkJKcWRWZ29qWDIya3drZlI0U082aXVITm1hdllhUlgvS1lz?=
 =?utf-8?B?Y05hZGNJSU1CdExZUWZ4cDhuRHFvdlJ2QkcraU1tZkQ4ZVc3anY5a00wWWcy?=
 =?utf-8?B?dUd0MFFmeVFsczFLL0dtRGdSS25teWNERVEzWGVCZWJYQkJSSnp4bDRJWkZP?=
 =?utf-8?Q?CPdDNC6mQnkdtL3CS97H9ZvPz5FEyX8fF1JuFP3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3831.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm9KclliY1ExWTdRM01SdTlRbVZSVFkvcTE3ZncxdzFrNXdyNjIydWMwU3Jx?=
 =?utf-8?B?ays2eW1HbFpXekVFbUdnd0M5SzFPWFJMazQzUXdUOGxPMVJJTFpKdktMM0RI?=
 =?utf-8?B?RFlkbW5hcTVsNGlLbUViSXJmYjQ0Zm85TSs4UE14RGh0MjY3RElkM0p1M01r?=
 =?utf-8?B?cTNRZHlYNkZldVB0NHoxMzErYVpXcHZSdnBxMnIyMExucFVJdkdGRld2RGh6?=
 =?utf-8?B?SW1Vd2JnY0hJYTZpSG9mbWFUejFWd0dObi9DREJwNkJwcWxvbUZPSXVuT295?=
 =?utf-8?B?c2M4WkxucC9QMWVOdUhWMzB1MU9INUtkNUlUSE1XeHJmTXVqeEk1OTMzaE9w?=
 =?utf-8?B?OCtsTStFQkh2Y3FvQlBObGkwZFEzVnNpbVk5YzdwcXB4cHZFWjhNSUZIVWJm?=
 =?utf-8?B?a00xdjlhVHdPMXNoRzRRcFRML3NremZYZFpoWlMzb1JHUGFFeG13bC9MQ25T?=
 =?utf-8?B?NGh1dHNOMC9mQjdMKzQ3WkRsUUFIbC9aU1kxa1ozRGZBM2MyMmw4RXIzYis4?=
 =?utf-8?B?MUZWa0paYW1OUUF3VkRyNlhtYitXVXdzRnlReE9TK2VEWWkzYlN2eGpVZWlw?=
 =?utf-8?B?TnpiQjR4OWFqQ0tkYmp4OFlQMktyQkVEN1c1UkFFK1hSelY2Q1dhSldlc1h3?=
 =?utf-8?B?NlMzeTlUbzhwUVVWMHBBYTRzcFRRSDNsMTUxblZuaVRNYmZWNU9WRWhRZ3RU?=
 =?utf-8?B?QzV2UHJVeG9zdTRRUXJDRVc4TXlmWlVFZXNnSVQzNStLdlNFSTlPSEh5V2wz?=
 =?utf-8?B?dzZaVUJwNWt3UVNxWlh5VlE2WmVvbkt1bmJhOFBWM29Ed0xxR1RMZXJlczJM?=
 =?utf-8?B?Zy9HdGo2WVI4RUFJR0hBdmFlOWZneS9RZWhRUzNPNWxRVmFZc29QMXo4em9W?=
 =?utf-8?B?M1hJM21Na0pXdk9oTWdaOWFrbHJqUDBFaUU2K0lrNlJUNGNrWEpNTmRCWHdM?=
 =?utf-8?B?d21KdVl1amZUcGk5VEtDMVBaRkduZjF5M1BiUk9kcHlIZUQvQTVDNHJzQjZk?=
 =?utf-8?B?UEVueXA5a09SdDBPL0FQalBxR3h3d1dKOVl5elNvTS91T3Y4c1lnbzRqallH?=
 =?utf-8?B?ZHliMHlad0MvbU9acHN5KzROUG5WZmxQSnp5L0phUU56RDU5b282WGNLK0dN?=
 =?utf-8?B?bzErU3hYa0VRWlVMRnoyL2JOMTM0ZU8xVHM1UUFnTlNiSTE5VmVMY1hLcmdM?=
 =?utf-8?B?dzNXT1hZaHl0SyszWW1KcndmTVlVRlF5bU9ET1pNRGlwRXRydElIWUtXRjdG?=
 =?utf-8?B?MjZFVjhWSnhjaUdCR21DcmdaamtMdFpRZGwvMkErSkxlcWVvTEpJU2xjTmVl?=
 =?utf-8?B?cHRaUEMyMFRJYWppUVBRNzdDVnZ4QmFNeHY5dnorT01VWi9tR3JKNnlUaWow?=
 =?utf-8?B?cnR5dEp4V1lXOFJiUU5ETGthK2JqYWtFUW5KVTRqQWxMdW9GNWhMMzRQdXMr?=
 =?utf-8?B?OFhJM3dGN3lNY1V6NWhXS080Q3NvS1pYa0k5czRxRCtsZkhZY3JWUFlzdWJm?=
 =?utf-8?B?ZUtPRHNXTDJkWGNvcjNsb2tnR0Y5Y0lLZmxITjVMRlh1Z3JGZWVpaVYvUDlO?=
 =?utf-8?B?dDdBdjNTeXBhaDlBNlpPT09mODgwbVVTbHJBOEZ5dStkcitYaE4veEpyMFlQ?=
 =?utf-8?B?dGtJM0RCbCsxZzJ0S1FMZklJNkZ5aGhBLzJkZERDNkhYV1M3cHdTenBGS0hw?=
 =?utf-8?B?MmNVYjJVZlVaemlEazVyY3BBOGFSV1ozRHBtNWNVdVFRMmFIbU11eTQ0L1Fr?=
 =?utf-8?B?em1HSXlZZnZJKzJoMnFXNW9HQitoem84bVVzN1pTUkUwTE5KTUJLR3lhWXpy?=
 =?utf-8?B?MVNNa0YydzB3SEVCMFZFYjlkVGs1eWNDdlh3aDhRYkluQTRDS2FYTVhpaVl3?=
 =?utf-8?B?ZlRzWWs4VzRjN0pXOWFKR29ua01UWmhhSlovK1JHYTFQRjJnWHJNbENQS3Jw?=
 =?utf-8?B?K1ZKZ3R5YnYvWW1VcUFyb2hxMFRMQjRTUm1XMm9CZzJ5ckgwRVVwdEo3WUE1?=
 =?utf-8?B?RE9CMytvTU4raldtamFML016UGMyVGJNeHRPRXZ0WVcwYXBPK3dGRHVMS0hT?=
 =?utf-8?B?U05MM3lVNnBMeUk5aVdCNWVzVFdrRDl2UkVaVlU0VFNnODE2d3NZbUhFVGtt?=
 =?utf-8?B?Yms2Uy9WRXpSQ2R3ZTF0cUJ3ajV1aDhTT0I0QXZzaTQwV29xcit1NXRUMTQx?=
 =?utf-8?B?eHc9PQ==?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovt2oO2il5nm4EVxaqHj5koRTtV0g0KTn1CqUzWUpHeEjA/+Luo8JSzQxLmu3p66fYCgsz+jq3cyHQLB5+pzhB/FGJdWaoca222QrVpMBxMxU8irMsnFeFYBdRfHEhOqDpXoKIX33F+sKSZY+79Zn2W5ZVPJRu8JOICxfAGAE9Pp0yYmR8VTzY9Mo42vLOSd7EpLnHNoEIQeLTE/qKKY47H0+xZSdU/IZTW8OQxboQd41lO3Nfr2PYM/UBgJPjyO6X7cnXkoSwraAfQ1RMXc+gPsy2dMx/n3+YltQWPXkX58Oqn3HBwHYWyvp1gQDmrDIQ/dJ9eyGVlNwYKjKZ/0ow==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqqeRuGOWVpAEuVuW9pIZnc5/uGsUEwxRJSfFky3NB4=;
 b=ZfK6QsyZq+mWA1W3pvGOjXIbmvTCtPf6QDPC1X9WvzIyIiCYkgw/f/tZK1hUJ6oRyfGaG2liEEGt3wsckqDcY8UNYOiPDt8LI0223MSVrv+qWz6swfCgbeiE/FcdnNFMdRsdavhFjJonHa294bYzqku9N1CWuDxCYnGKXAVbQTutnH/P6tN9nmS0lRaSwQBNy3D2TVK8aoSCqZtrC85QeTaPOTfU7AhwfKpEcQwmqYWb0wLRzxfvz+egqGekp3nfeFxs4w8P8HRIBGOdm0PtrmdwgfmWWaGqfxKkD9h4Yt0ASlMa50D8kqOIm9vnd8T3V0z1d8lwpc7/c8mVa97PqQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BYAPR01MB3831.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: c534f55e-c44b-45b4-901e-08dcee552355
x-ms-exchange-crosstenant-originalarrivaltime: 17 Oct 2024 02:41:01.1964 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: KJqZa1PYzJ0y6orhzBq0Ad+KSwymj/9Ug65CSrMs2oOrNREorNoBHtf+0of6Nn/9+KKHWdLxGVxgtOkXakdmpBxN72smoN1tls7vFe0/VwI=
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR01MB7367
x-originatororg: trendmicro.com
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-28734.005
x-tm-as-result: No-10--21.043500-8.000000
x-tmase-matchedrid: FKSF4uC40dI2eFTDBkQySu5i6weAmSDKOhJ9m53n4aCZtziFUn+D+W2k
	oeLQwPiFFRlxiF1eFJsFiQEBzB3ve5QblBoaVxK9lVHM/F6YkvQpA2ExuipmWheNsIS0Stt0tvO
	wJAUGqujUIKC2z1kBEeGjRmUMYknnkkg7tOJoumsW9iCLP1TV4gv/9UzFeXIT4+xf2pXdquSZEN
	KHekISQ/so1edcZvO3pLpQOz+fRrodWKRD1iYss+adXXcOleEbG3SoAWcU42We38zXnNg9QznGP
	45Axioi1o7ZsZa7L9hOfBYc/Fbqp91RkEnBFAu+SDkh6bW+bcf57UAoHrX1+JjmdWmKHGLDTxSu
	gU04anvVk4D/KCSC7BevMnLENyDpDohlcI5IzlCXVXMu1aPavLK9NtcMoMN6kTPVZOm8uR19zn8
	GcDl7fQ8e96ZCKJlledCLvF+SmCXpbeVnoaHb6Tz6L+U/pejxYb/nLV/lbk9GMe+tDjQ3FmMYky
	rBIjoXQQ8gppP3u+J5r45ZIb/xnzIAO9uqAbGZSCtgxgcsrMpr9+Kgn2XgeEukIs3g1HjePBw4X
	xhwLTtvxCR5/5HJVrYiwbYi/H+COXyRIvc0XENAL3S+E86WTf42CnfVZVKOrfSzyLxZ/bOxXWfW
	RsFZNgZlBbstE/UB2OGe8x939AJ4GcCqxQcAiKTgd8aqvs6pDFuFwhrWhlRzG4iyygR5BNIFVVz
	YGjNKWQy9YC5qGvwXfF+EQiYcZsLeaN9zSPdmD6YPoBcLSICpygCGKFPC+BeYl5uS2QAg
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.043500-8.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-28734.005
x-tm-snts-smtp: 99272DF0881A7FD408262AD0F53710D39BF8801F96640041BB1449FAE4CC7C802000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-ERS: 10.42.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 U0pDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=tmoutbound; t=1729132881;
	bh=JVUkOG/a+t4dSPpA+XSrW260AXhqrAjOtY3nJQmFw40=; l=6792;
	h=From:To:Date;
	b=Tw9q8ZM3M2QKIrW6y1nzmZC6VBzdSc8qJCuvR0s/FDZjw5ix0jLgJs2adgfaJJqid
	 GVeAkmQPTkE2RRTbqMbAqYmW2F/gOGlJLjxF221vPNLSAGX6fHg4NSVbSo+YDm7aDz
	 kcEdm1ZerTP4VS0VlglVujk+yENQwdQNTi/5oqDE=

SGVsbG8sDQoNCg0KV291bGQgeW91IHBsZWFzZSBzZW5kIHVzIGFuIHVwZGF0ZSByZWdhcmRpbmcg
dGhpcyBjYXNlPyBIYXZlIHlvdSBwdWJsaXNoZWQgYW4gYWR2aXNvcnkgd2l0aCB0aGUgZml4Pw0K
DQpSZWdhcmRzLA0KVGhlIFpESQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
WkRJIERpc2Nsb3N1cmVzIE1haWxib3gNClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyOSwgMjAy
NCA3OjM5IEFNDQpUbzogb2Zvbm9AbGlzdHMubGludXguZGV2DQpTdWJqZWN0OiBaREktQ0FOLTIz
MTkzOiBOZXcgVnVsbmVyYWJpbGl0eSBSZXBvcnQNCg0KWkRJLUNBTi0yMzE5Mzogb0Zvbm8gQ1VT
RCBTdGFjay1iYXNlZCBCdWZmZXIgT3ZlcmZsb3cgQ29kZSBFeGVjdXRpb24gVnVsbmVyYWJpbGl0
eQ0KDQotLSBDVlNTIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
CjcuODogQVY6TC9BQzpML1BSOkwvVUk6Ti9TOlUvQzpIL0k6SC9BOkgNCg0KLS0gQUJTVFJBQ1Qg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpUcmVuZCBNaWNybydzIFpl
cm8gRGF5IEluaXRpYXRpdmUgaGFzIGlkZW50aWZpZWQgYSB2dWxuZXJhYmlsaXR5IGFmZmVjdGlu
ZyB0aGUgZm9sbG93aW5nIHByb2R1Y3RzOg0Kb0Zvbm8gLSBvRm9ubw0KDQotLSBWVUxORVJBQklM
SVRZIERFVEFJTFMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoqIFZlcnNpb24gdGVzdGVkOiAg
MTYuMC4zDQoqIEluc3RhbGxlciBmaWxlOiAgYWdsLWRlbW8tcGxhdGZvcm0tY3Jvc3NzZGstcmFz
cGJlcnJ5cGk0LTY0LndpYy54eg0KKiBQbGF0Zm9ybSB0ZXN0ZWQ6IFJhc3BiZXJyeSBQaQ0KDQot
LS0NCg0KIyMjIEFuYWx5c2lzDQoNCmBgYA0KQSBzdGFjayBvdmVyZmxvdyBleGlzdHMgaW4gdGhl
IHVzc2QgZmVhdHVyZS4gVGhlIEFUIGNvbW1hbmQgIitDVVNEIiBpcyByZWdpc3RlcmVkIHdpdGgg
Z19hdF9jaGF0X3JlZ2lzdGVyIHNvIG9mb25vIGNhbiBoYW5kbGUgaXQgYXQgYW55IG1vbWVudCBh
ZnRlciB0aGUgcmVnaXN0ZXIsIHRoZSBjYWxsYmFjayB0aGF0IGhhbmRsZXMgdGhlIHBhcmFtZXRl
cnMgaXMgY3VzZF9ub3RpZnkuIGN1c2Rfbm90aWZ5IGNhbGxzIGN1c2RfcGFyc2UsIGFuZCB0aGUg
c3RhY2sgb3ZlcmZsb3cgbGl2ZXMgaW4gdGhpcyBmdW5jdGlvbjoNCmBgYA0KDQpgYGANCnN0YXRp
YyB2b2lkIGN1c2RfcGFyc2UoR0F0UmVzdWx0ICpyZXN1bHQsIHN0cnVjdCBvZm9ub191c3NkICp1
c3NkKSB7DQogICAgWy4uLl0NCiAgICB1bnNpZ25lZCBjaGFyIG1zZ1sxNjBdOw0KICAgIFsuLi5d
DQogICAgaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX25leHRfc3RyaW5nKCZpdGVyLCAmY29udGVudCkp
DQogICAgICAgICBnb3RvIG91dDsNCiAgICBzd2l0Y2ggKGNoYXJzZXQpIHsNCiAgICBbLi4uXQ0K
ICAgIGNhc2UgU01TX0NIQVJTRVRfOEJJVDoNCiAgICBjYXNlIFNNU19DSEFSU0VUX1VDUzI6DQog
ICAgICAgICBtc2dfcHRyID0gZGVjb2RlX2hleF9vd25fYnVmKGNvbnRlbnQsIC0xLCAmbXNnX2xl
biwgMCwgbXNnKTsgYnJlYWs7IH0NCiAgICBEQkcoIm1zZyBwdHIgJXAgbXNnIGxlbiAlbGQiLCBt
c2dfcHRyLCBtc2dfbGVuKTsgWy4uLl0gfSBgYGANCg0KYGBgDQpUaGUgZGVjb2RlX2hleF9vd25f
YnVmIGZ1bmN0aW9uIGlzIGNhbGxlZCB3aXRoIHRoZSBoZXgtZW5jb2RlZCBzdHJpbmcgd2hpY2gg
aXMgY29udHJvbGxlZCBieSB0aGUgbW9kZW0sIGFuZCAtMSBhcyBsZW4gcGFyYW1ldGVyLiBUaGUg
dmFsdWUgLTEgaW4gbGVuIG1lYW5zIHRoYXQgdGhlIHN0cmxlbigpIG9mIHRoZSBpbnB1dCBidWZm
ZXIgaXMgdXNlZCBhcyBzaXplLg0KVGhlIG91dHB1dCBidWZmZXIgbXNnIGhhcyBhIGZpeGVkIHNp
emUgb2YgMTYwIGJ5dGVzLCBidXQgdGhlIGlucHV0IGJ1ZmZlciBoYXMgbm8gbGltaXQgaW4gc2l6
ZS4gVGhpcyByZXN1bHRzIGluIGEgc3RhY2sgYnVmZmVyIG92ZXJmbG93IGFmdGVyIHRoZSBtc2cg
YnVmZmVyLCB0aGlzIGNhbiBiZSB1c2VkIHRvIGdhaW4gY29kZSBleGVjdXRpb24gKGl0IHJlcXVp
cmVzIHRoZSBzdGFjayBjb29raWUgdG8gYmUga25vd24sIG9yIGEgYmluYXJ5IHdpdGhvdXQgc3Rh
Y2sgY29va2llcykuDQpOb3RlIHRoYXQgaW4gdGhlIE9mb25vIHNvdXJjZSBjb2RlIChpbiBtYWlu
bGluZSksIHRoaXMgYnVnIGlzIHByZXNlbnQgMyB0aW1lcyBhcyBpdCBpcyBkdXBsaWNhdGVkIGZv
ciB0aHJlZSBkaWZmZXJlbnQgZHJpdmVycyA6ICAgICBkcml2ZXJzL2h1YXdlaW1vZGVtL3Vzc2Qu
YyAgICAgZHJpdmVycy9hdG1vZGVtL3Vzc2QuYyAgICAgZHJpdmVycy9zcGVlZHVwbW9kZW0vdXNz
ZC5jIGBgYA0KDQoNCi0tIENSRURJVCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NClRoaXMgdnVsbmVyYWJpbGl0eSB3YXMgZGlzY292ZXJlZCBieToNClN5bmFja3RpdiAo
QFN5bmFja3Rpdikgd29ya2luZyB3aXRoIFRyZW5kIE1pY3JvIFplcm8gRGF5IEluaXRpYXRpdmUN
Cg0KLS0gRlVSVEhFUiBERVRBSUxTIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpT
dXBwb3J0aW5nIGZpbGVzOg0KDQoNCklmIHN1cHBvcnRpbmcgZmlsZXMgd2VyZSBjb250YWluZWQg
d2l0aCB0aGlzIHJlcG9ydCB0aGV5IGFyZSBwcm92aWRlZCB3aXRoaW4gYSBwYXNzd29yZCBwcm90
ZWN0ZWQgWklQIGZpbGUuIFRoZSBwYXNzd29yZCBpcyB0aGUgWkRJIGNhbmRpZGF0ZSBudW1iZXIg
aW4gdGhlIGZvcm06IFpESS1DQU4tWFhYWCB3aGVyZSBYWFhYIGlzIHRoZSBJRCBudW1iZXIuDQoN
ClBsZWFzZSBjb25maXJtIHJlY2VpcHQgb2YgdGhpcyByZXBvcnQuIFdlIGV4cGVjdCBhbGwgdmVu
ZG9ycyB0byByZW1lZGlhdGUgWkRJIHZ1bG5lcmFiaWxpdGllcyB3aXRoaW4gMTIwIGRheXMgb2Yg
dGhlIHJlcG9ydGVkIGRhdGUuIElmIHlvdSBhcmUgcmVhZHkgdG8gcmVsZWFzZSBhIHBhdGNoIGF0
IGFueSBwb2ludCBsZWFkaW5nIHVwIHRvIHRoZSBkZWFkbGluZSwgcGxlYXNlIGNvb3JkaW5hdGUg
d2l0aCB1cyBzbyB0aGF0IHdlIG1heSByZWxlYXNlIG91ciBhZHZpc29yeSBkZXRhaWxpbmcgdGhl
IGlzc3VlLiBJZiB0aGUgMTIwLWRheSBkZWFkbGluZSBpcyByZWFjaGVkIGFuZCBubyBwYXRjaCBo
YXMgYmVlbiBtYWRlIGF2YWlsYWJsZSB3ZSB3aWxsIHJlbGVhc2UgYSBsaW1pdGVkIHB1YmxpYyBh
ZHZpc29yeSB3aXRoIG91ciBvd24gbWl0aWdhdGlvbnMsIHNvIHRoYXQgdGhlIHB1YmxpYyBjYW4g
cHJvdGVjdCB0aGVtc2VsdmVzIGluIHRoZSBhYnNlbmNlIG9mIGEgcGF0Y2guIFBsZWFzZSBrZWVw
IHVzIHVwZGF0ZWQgcmVnYXJkaW5nIHRoZSBzdGF0dXMgb2YgdGhpcyBpc3N1ZSBhbmQgZmVlbCBm
cmVlIHRvIGNvbnRhY3QgdXMgYXQgYW55IHRpbWU6DQoNClplcm8gRGF5IEluaXRpYXRpdmUNCnpk
aS1kaXNjbG9zdXJlc0B0cmVuZG1pY3JvLmNvbQ0KDQpUaGUgUEdQIGtleSB1c2VkIGZvciBhbGwg
WkRJIHZlbmRvciBjb21tdW5pY2F0aW9ucyBpcyBhdmFpbGFibGUgZnJvbToNCg0KICBodHRwOi8v
d3d3Lnplcm9kYXlpbml0aWF0aXZlLmNvbS9kb2N1bWVudHMvZGlzY2xvc3VyZXMtcGdwLWtleS5h
c2MNCg0KLS0gSU5GT1JNQVRJT04gQUJPVVQgVEhFIFpESSAtLS0tLS0tLS0tLS0tLS0tLS0tLSBF
c3RhYmxpc2hlZCBieSBUaXBwaW5nUG9pbnQgYW5kIGFjcXVpcmVkIGJ5IFRyZW5kIE1pY3JvLCB0
aGUgWmVybyBEYXkgSW5pdGlhdGl2ZSAoWkRJKSBuZWl0aGVyIHJlLXNlbGxzIHZ1bG5lcmFiaWxp
dHkgZGV0YWlscyBub3IgZXhwbG9pdCBjb2RlLiBJbnN0ZWFkLCB1cG9uIG5vdGlmeWluZyB0aGUg
YWZmZWN0ZWQgcHJvZHVjdCB2ZW5kb3IsIHRoZSBaREkgcHJvdmlkZXMgaXRzIFRyZW5kIE1pY3Jv
IFRpcHBpbmdQb2ludCBjdXN0b21lcnMgd2l0aCB6ZXJvIGRheSBwcm90ZWN0aW9uIHRocm91Z2gg
aXRzIGludHJ1c2lvbiBwcmV2ZW50aW9uIHRlY2hub2xvZ3kuIEV4cGxpY2l0IGRldGFpbHMgcmVn
YXJkaW5nIHRoZSBzcGVjaWZpY3Mgb2YgdGhlIHZ1bG5lcmFiaWxpdHkgYXJlIG5vdCBleHBvc2Vk
IHRvIGFueSBwYXJ0aWVzIHVudGlsIGFuIG9mZmljaWFsIHZlbmRvciBwYXRjaCBpcyBwdWJsaWNs
eSBhdmFpbGFibGUuDQoNClBsZWFzZSBjb250YWN0IHVzIGZvciBmdXJ0aGVyIGRldGFpbHMgb3Ig
cmVmZXIgdG86DQoNCiAgaHR0cDovL3d3dy56ZXJvZGF5aW5pdGlhdGl2ZS5jb20NCg0KLS0gRElT
Q0xPU1VSRSBQT0xJQ1kgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpPdXIgdnVsbmVy
YWJpbGl0eSBkaXNjbG9zdXJlIHBvbGljeSBpcyBhdmFpbGFibGUgb25saW5lIGF0Og0KDQogIGh0
dHA6Ly93d3cuemVyb2RheWluaXRpYXRpdmUuY29tL2Fkdmlzb3JpZXMvZGlzY2xvc3VyZV9wb2xp
Y3kvDQoNClRSRU5EIE1JQ1JPIEVNQUlMIE5PVElDRQ0KDQpUaGUgaW5mb3JtYXRpb24gY29udGFp
bmVkIGluIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBpcyBjb25maWRlbnRpYWwgYW5k
IG1heSBiZSBzdWJqZWN0IHRvIGNvcHlyaWdodCBvciBvdGhlciBpbnRlbGxlY3R1YWwgcHJvcGVy
dHkgcHJvdGVjdGlvbi4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91
IGFyZSBub3QgYXV0aG9yaXplZCB0byB1c2Ugb3IgZGlzY2xvc2UgdGhpcyBpbmZvcm1hdGlvbiwg
YW5kIHdlIHJlcXVlc3QgdGhhdCB5b3Ugbm90aWZ5IHVzIGJ5IHJlcGx5IG1haWwgb3IgdGVsZXBo
b25lIGFuZCBkZWxldGUgdGhlIG9yaWdpbmFsIG1lc3NhZ2UgZnJvbSB5b3VyIG1haWwgc3lzdGVt
Lg0KDQpGb3IgZGV0YWlscyBhYm91dCB3aGF0IHBlcnNvbmFsIGluZm9ybWF0aW9uIHdlIGNvbGxl
Y3QgYW5kIHdoeSwgcGxlYXNlIHNlZSBvdXIgUHJpdmFjeSBOb3RpY2Ugb24gb3VyIHdlYnNpdGUg
YXQ6IFJlYWQgcHJpdmFjeSBwb2xpY3k8aHR0cDovL3d3dy50cmVuZG1pY3JvLmNvbS9wcml2YWN5
Pg0K
