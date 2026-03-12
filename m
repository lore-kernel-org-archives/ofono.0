Received: from refb.tmes.trendmicro.com (refb.tmes.trendmicro.com [18.208.22.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C718401A1D
	for <ofono@lists.linux.dev>; Thu, 12 Mar 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.208.22.189
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345960; cv=fail; b=EglDIR2obhDXOhoPuHr75aNk96zBPWopUSZLT5NQkJWgivKPLZ2zT5wo1nEbwhhkiN0wOSKpaUxpPSVaYGr/tuRLpN1F8Pwb5s8E+WwGGSRx2UR5iAAscqfe8re8kRzpM8APxRsTp3hGTrXqmEtZ1+ON1PPBmQAHvgbNtMDc408=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345960; c=relaxed/simple;
	bh=mIx+gRPBxmE2zhcu3r90VPJ7nwMtWr3dmTIrCUHtUeg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ma638bF2HugzzG/GL/4fys9UHBcMy16+Ora46wHLsq1C/JOI7dnrZN5L6JCi/edDtqtc9fK4umy1HKmSMXavR5XGzt4D+srPksZpK1RB8NMe2KSt13NQ4eTKIhfRKiKevpJzoTT/DJx9NzmyIHI9XJAy4c/pSB4WsFLk0eUR4HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (2048-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=etkbcQkC; arc=fail smtp.client-ip=18.208.22.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="etkbcQkC"
Received: from 52.101.46.20_.trendmicro.com (unknown [192.168.10.82])
	by refb.tmes.trendmicro.com (Postfix) with ESMTPS id 57A87104C83DE
	for <ofono@lists.linux.dev>; Thu, 12 Mar 2026 19:13:31 +0000 (UTC)
Received: from 52.101.46.20_.trendmicro.com (unknown [192.168.197.144])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 8167510000A9A;
	Thu, 12 Mar 2026 19:13:24 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1773342803.129000
X-TM-MAIL-UUID: 329b3b4b-8b9a-4d9a-b33f-557bb46c4ec6
Received: from CO1PR03CU002.outbound.protection.outlook.com (unknown [52.101.46.20])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 1FCA410000316;
	Thu, 12 Mar 2026 19:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avQXiIwLeE8up2J6tQMvUoGyalJICtGBDkOk14TsK2tJIlo2QDAy/X80lU5lcPoJAyyA7iwEl6lmqkgxtDXmLrolxpds2gE8+ZC9knxmxXCoDjJgdIeIk1mGfL8vbSAfJng/rUWs/SyZfwb6348+T2Wqb4z8prOlLQex8OnRavutzy2QA8INiidXarYqhkYs70sBlDLUTGcbgnezIWX6NClFGj0A8Yu5d07U8ft+Up1oIEJ6GMij4CUB6SHNCTwnNQ45DkStOYd6gFdi6WCOvJfqraphFDnRiuGIna/0L9w0lZ5fApihIycUEKKIbFAZSSOQgBsilaCBv1S9lOUpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sewkbVXnzdShgeHTlB0dZeLIu1BVYL3i01f0Uev428I=;
 b=VeHK9hPsrjZU8hRYvV4vpWLXAx3hprN+ihT247ViMgy3mCCR3L56Fdx2oU7CIyNxSEBUOyah8pyacqyI6uUMksot0Tzy+FmvQFTp2gpbzBRz7Xh27XfN3vMniD0XgUMd/ukalWf7LyOohlJ1W5VO+gyXmcyDyxWllTcZWfI8ZeahA8xTx+8j0oZNiNZkmIc5GJtVIF3aTo7QmCO9P1gvDXccUZJa/qiB4aKW6u1dCA5zIEL48ssssmt+5mTheB5PoC/ATuwjRAb5janBoKbtmuW0b26+Ne2zsOPjqym8BvaeR3TNUvcme3BtDPzKMxqH0+kQl6xoxtFwxeKDwLnfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 DS4PR01MB994160.prod.exchangelabs.com (2603:10b6:8:321::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.13; Thu, 12 Mar 2026 19:13:20 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%6]) with mapi id 15.20.9700.015; Thu, 12 Mar 2026
 19:13:20 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: Willy Tarreau <w@1wt.eu>
CC: "ofono@lists.linux.dev" <ofono@lists.linux.dev>, "secalert@redhat.com"
	<secalert@redhat.com>
Subject: RE: ZDI-CAN-29089: New Vulnerability Report
Thread-Topic: ZDI-CAN-29089: New Vulnerability Report
Thread-Index: AQHcmq70Cui7NCNU3E+maLQC7zjOrbWrci8Q
Content-Class:
Date: Thu, 12 Mar 2026 19:13:20 +0000
Message-ID:
 <BYAPR01MB38300A127FB5267EA5A6846E8044A@BYAPR01MB3830.prod.exchangelabs.com>
References:
 <BYAPR01MB3830BD5C9755FDDBA5ADE0FC8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB38303CF32A86888EBE5918DA8062A@BYAPR01MB3830.prod.exchangelabs.com>
 <BYAPR01MB3830E1E9E11FC8716A722A588062A@BYAPR01MB3830.prod.exchangelabs.com>
 <aYtkc7oTpBivYUZ1@1wt.eu>
In-Reply-To: <aYtkc7oTpBivYUZ1@1wt.eu>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=075bd49c-3af1-42eb-9753-24eb61f6c951;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-03-12T19:12:44Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|DS4PR01MB994160:EE_
x-ms-office365-filtering-correlation-id: d1936103-5e98-47ba-81bc-08de806b6c5e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 lh8yIpxVIYpgWbTQ2Sz5SMkAKfBNc4Zv4dtb0GkeLi18HxGAdZ2sPVtbmO0StOQ2zZ5NzcgC2LonTVdqTrSXApvl7dcEDMy8LVyV8yxHVvLUUqjrZSlTiuCZvRlYNGTgq46TLc5kfZEcczkZRHy0nAoXht6YPU7VtT0rDs/Fcc0dNqfLfgTF970/kwNExOGp8qdoHVD6sCJ/r9ZYKFAVicqMWU5SppVPyaU4TH1LyeOUSkAPJcHtLSe0T2J1YMuogeDWFPmFLBUwKDABzOn5QkiDYRnyRojx/2l7UApDQKCOcTvsnDkJghszb26xS6EKoZ6BfYqJIn2yuwmxy1nfixgGGk7JQNE/ulWAgqQKR5wPUMP4CTbITVT3swjgVEWCUX3LduGvc5usLHFKNNRpFrwjh3zrihCf3vttw94y23LhhllZID2H26Qle3vxrzXA2EjFwm0O5qKaIH/EqeQyAlfkqHx97sUqi3rZJ+x3IEYUm2YmT/PuFOwhm5g8/rEkKr6yKb7hN11XXNyBdAjFoLDUtVp6bXm709DF+MjBERaTlsdZedFpuXstyRBpDPzpzilT6/CCcEuR/FCW2LLvoygFJ8GKFGGCdMsYOF3kRha1jN8kQcLjpy/53c6QDmE4duDKNOZDl63JLo82hSBEh6SICtNLLWeDy14VOofIeJO4cRpYk+Xo5Lyk5Kglj0stIyYr7WL4UqEDEEgVAjJmAeySzZGgiFKEQyDliLwOBiNYJceQOhr6lstlNsXY2BZkIUIA3MnwLl6Li4qdNgmpvdn9PWi2VcR4xOoTiI5UwZg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AmQWZdtDrj9Bpfly7fgZmuFjeYCajN/hHweg0DPFMyx2lohwd9vjgwL+f7Kw?=
 =?us-ascii?Q?G1ZZajrqlD+vt8/s10s0R+t0nhY/OwK7hVeP1GW1jbqyB+8yU7xmG5Af7Had?=
 =?us-ascii?Q?xmQRKyJSpvIii7+zLZOBsy6KKhCtmOnmpvzh9G+ufSTcl72FtNs1xW4bt/vQ?=
 =?us-ascii?Q?OsDnLpvXddvSi9/THsBnHNirUdNhY3JswpMgwmTLXsvjvgQRAmcMGyk2xa9c?=
 =?us-ascii?Q?ZQDr7S+4Fvp5hP+FUpNGXfCGSc8HYURJWIdGHwMYmLFJeMX6zpYmnFwdTBX9?=
 =?us-ascii?Q?1/QdOAVcNYqyzThnEeiYnz+r2Qdj2XmDys47sdQaKVETHAfY/yhXyaaMyiUU?=
 =?us-ascii?Q?nlZIOy1uDGagd4se7FT0oD9y8O0A1t/mEuoKD351m8OvWnsDtoB3sv8SUMG3?=
 =?us-ascii?Q?hQ5HmHx7DU43im97AuBzqyhiLeaABuzv0mgnCJYjTYLr3/Sbl+wsRn9rxs7Z?=
 =?us-ascii?Q?r8hiQ6SSrU2LjE/pF7A8R50OpVSVhBk2pv2qn2uDHOQvf+BQtH4Z4gaWIykZ?=
 =?us-ascii?Q?kxVirbSVNTSsmONnHHBKvDGSCpzn09+0V6IsDzrgBlFZdbdIIZRt8T4ZEdkz?=
 =?us-ascii?Q?HAhMu9q+JJBPpo284JjALx9yCRJRj9FrVSS8ygtYmzdqGeEjemwEE0Z9u0RR?=
 =?us-ascii?Q?0T2xAi1XRnqPIiMHZzHE5LUXPPb8aY8kn8ecQGFL3S6rZ6y3GpVd7YT5veKa?=
 =?us-ascii?Q?Xb5VN2/VYmEVEFRANIo1k11YYJ8szm8iCi/cPLtki6phR4lRvcQiCWTKS2jG?=
 =?us-ascii?Q?+UieEZQ5WO3f8TipztidbCpuH+sZWeW8uuF97aR8Kf/Ae/u2QIBXO+76VHGV?=
 =?us-ascii?Q?YrUZ+eS2eBXAk018l56siTpWySaNWqY2cyebe85M5+sr7xYeu+nYhg5USH2I?=
 =?us-ascii?Q?/LOEjIQETw4ncV9eTRNSJSa2t0sVHFwZsPOzjU00JxGPcRcXq98+EvniJxOh?=
 =?us-ascii?Q?hxfBeO60pNSgS4Igb+/ufVnNopuynQc8BwmJTuzK7uyC089AhMrrSRbhEruf?=
 =?us-ascii?Q?+UJBKPLCYHvjG95CwLrnDsoCqtg2l3ngYODOUhrkNStnwxqIRGA+BJOmQTyb?=
 =?us-ascii?Q?96b22ZFIsmEsVX0wGISQTyKNclx078bz704W7ovBO0cloQWY8uZZDREq261l?=
 =?us-ascii?Q?EJ/bEn7CrNQNP+zEeVT1mbpdowNrmaJN5zkHu+oa9BJNakuOqfwnxHEYFX0k?=
 =?us-ascii?Q?XbB/OpLUnTfIvqUAhuQAoThKt1TdsVPwCVyagdNm0DROpp5cHoMFpycYZbXZ?=
 =?us-ascii?Q?UbYBplfUQq8OoJhrpMy0NVL1Nr4IFJ80kxkQBf5EVN3zo0RF2n4Ny+GL43mp?=
 =?us-ascii?Q?0rQFF/x6owmfnEKrZljK9hM6o6A2JldN7iU14UsX0r/2O5rHD4UUwB9jgwya?=
 =?us-ascii?Q?zjsE25i7oEJKH6GN2Rs0ILLJJ6QYFI0xNyuwcWfN/fn+L9f/LJGu++YmsYWh?=
 =?us-ascii?Q?jmNW1GkOGIfD52fFmYKxXueQtZn/g2j1RXDIh8kvlhxHhU87Cu29cKj9oYPn?=
 =?us-ascii?Q?ztxefEZfAC2/URMI/nC5xp+3jrDso1cy18gJqD1KNFn3aAMR2Y2szgerUH+D?=
 =?us-ascii?Q?MrTXw80elBXDA9xoZHxx0FdiiFBzCh3nIuqf6xdEJSkfTKypGHZJRcFghnp5?=
 =?us-ascii?Q?xibFbDjx5doXi9WyuV3NVGzXuP0tp7P7SOg8PyOVPqiznQ4Q7TvS1Rtb4wV1?=
 =?us-ascii?Q?TTZEu+uqEM5UiuZoKm6cupKLYeW00Q39cBZld39jqLPJFG7EDaar94ACGtEg?=
 =?us-ascii?Q?dQpwZTcaWdk4rqfcS0TJPIbVzYKwqQg=3D?=
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ro5RrA4r01+JPicNsp+z1FRA5/3LX94oJp2KNf4GkdRgwyBYFvKsii/zRUpwGfvOJETB+EpSapwBZdEssgx+oeTaqRpFCzRnwFt8wdopUEw2jHCJT7dagMGRTHQl1KnmNEs0ZJMQz0NaYpxxHEhLchbCNLdzA+oinxHEEfEodZD6UsrPQFimWXaQ1dRQh8wlT8DPfSf6P8T8IZ5+36Bci1GXpexEbn9SavxEYeIBPD+GRExt6naJiHzFSEPmlPhyx9F+JoRf8sl08DGp6AMBaSjvTKof/Y2tFk3PfXUsR2Er9qFTr4Ix6o9xM6SvmwaCJezmPUMboKhUgZqyHZbmlg==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1936103-5e98-47ba-81bc-08de806b6c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:13:20.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5wvy7HXsx+/4ldLoonmTMBNar6yvPDOyvNS1jNFP50p/FAWVykH6pRLtWNR5qJAsSP9qhOKimuF6tcHPJJXoFNG02ORyofaGpfWSg0/1jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB994160
X-TM-AS-ERS: 52.101.46.20-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1011-29814.001
X-TMASE-Result: 10--25.288000-4.000000
X-TMASE-MatchedRID: pm4nAsXEPp49AUcVR4lIKSyIz3xZbkbDKyT7/ruNQc6A/R4QfleZcwK6
	5A+Zu1pdBfjOQebUfKCej+cXnB9pgq/oymx5pkWxYaJJSv71gZ2JnltxZVUTwKzU/PXAxei45ZR
	cN+vVlBUvvcRzebSb1d9iOH5TDj6muNbliGy44uEMOAyFr9Y0lW1Pl2xWLNcSDw3s11kzaLe9ej
	wahYHjATiAo2Jx9V3kxtBIxiyCCv1wlgVOwbMLlBZu3Ax5Ngq81hQK4p3mSnBeI9IT4juaffTRS
	qyCF4F8GHyzQ/D3grC0XIQ6FFtGKvBowhexpCYwEHWvu/qmRAqjg0lrtKMWyq0GdruKzoUY+0Vx
	+T51OhmN4P4XksxlVxnDQ9S33/iLWjsaYI4lh3U7nRP0DvgcK7YURQHAp3zKlExlQIQeRG0=
X-TMASE-XGENCLOUD: 89817f1f-fd5f-4643-aba1-3dcee10c4e02-0-0-200-0
X-TM-Deliver-Signature: 59054F09EAD2F2321836C0F8246A4ECD
X-TM-Addin-Auth: O2Ckrqvcf7W6aubndERJvAucXpf0ylI5DGtjtl9vCZR3gd7f2dWrGSNLESL
	zC/j91Z7E84cPihWwcut4a1F9SDQGaMjDq7dizFlZKDhSjUQDfSpHcyCh0CSHMvFhwy6iMiEwQA
	/mmNFj6MNFAH1yNGYcQFt7JXyPz1qX2VfjClWkQ/wM21+dmRDEw6Sd8wSdTvXn9NOx1fnr4IiTB
	VCvEzNT4NZTXkDeoV6j+p5DizP7d7l0PQ35j/ceVrTaEH6XUP+s9G8rlOUBG0qQ2fv733Junl9H
	7esNiW/Qfk0wZNo+Q/bLBULdbUfa9fFTEB8ozt8VNsSuYJ8GWyA4Hykh2g==.1doASWCjSKl8ig
	XIAuVmUWOyU7xO0ZM/7jacpjDr5g9gUFYhUZ0cFI4gNGvryz27rHl5eQEcgHLylmCEXZ2Ey/DDV
	uwxXHxI6Iw5seLj7pYnADGAs2bYltuW/J0PhZTrNYwjtRxeWZdf3DGSN6u+bYsWyLbvo2OW9BuZ
	sm7jP57fFnfTjGBDKRltpptrMW5pYrS4WAZgyKAA5Cuvjdd0MWytJaIFIeL27lnSOZ9Hb4Bbzpa
	OEeGDkJmteM20OtRrWRWXwivDw6LvrmPFh3a8PAbHH7+ogIdHPBEJne0eccKYT6X6ZCMBBYoT9m
	9eu451uw9okg2aaqMMmtAH8nN8zA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-20250722162133; t=1773342804; x=1773515604;
	bh=mIx+gRPBxmE2zhcu3r90VPJ7nwMtWr3dmTIrCUHtUeg=; l=1782;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=etkbcQkCuwa3Yagh73aOkIj49cmfcFHZEJh8lErmxGWq+R3Xu1iLfxbcm3wpJoKr9
	 Wt2pxrLDclh6Zjuk58t3G+nRvrehIfLYaKjfpecBBeYSnv6dE9ylVf1msdLK2QEkDj
	 E8WNZM5naJyCGochdGEniILbKkjEBQRlNuRdSQpIuDScnEG7zbNuNZVNU8xa3/MKZL
	 nixhkDJV6sJJ/xACErIv20v+EDzkMQik/twTcRWDcGe7dbW6vMv8L53McWc8CgeaH0
	 PCakUawFfy03IT0sZ9pqDI9AjbvVq93izaJg8sgNHv4Q/D29uJTkdmmEYoWuFmgJ/a
	 IFcdHfpcqUdNg==

Hello Willy,

Noted thank you!

Any updates on this issue?

Thanks,
ZDI

-----Original Message-----
From: Willy Tarreau <w@1wt.eu> 
Sent: Tuesday, February 10, 2026 9:02 AM
To: ZDI Disclosures Mailbox <zdi-disclosures@trendmicro.com>
Cc: ofono@lists.linux.dev; secalert@redhat.com; security@kernel.org
Subject: Re: ZDI-CAN-29089: New Vulnerability Report

Hello,

On Tue, Feb 10, 2026 at 04:54:46PM +0000, zdi-disclosures@trendmicro.com =
wrote:
> ZDI-CAN-29089: oFono MBIM SMS Handling Heap-based Buffer Overflow Arbit=
rary Code Execution Vulnerability
> 
> -- CVSS -----------------------------------------
> 
> 6.8: AV:P/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
> 
> -- ABSTRACT -------------------------------------
> 
> Trend Micro's Zero Day Initiative has identified a vulnerability affect=
ing the following products:
> oFono - oFono
> 
> -- VULNERABILITY DETAILS ------------------------
> * Version tested:20.0.3
> * Installer file:agl-demo-platform-crosssdk-raspberrypi4-64.wic.xz
> * Platform tested:Raspberry Pi
(...)

Please note that none of these 3 reports concern code in the Linux
kernel, so security@kernel.org can be dropped from future exchanges.

Thanks,
Willy
TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidenti=
al
and may be subject to copyright or other intellectual property protection=
.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mai=
l or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: [ https://www.trendmicro.com/priv=
acy]

