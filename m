Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7C2C842
	for <ofono@lists.linux.dev>; Wed, 28 Feb 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111826; cv=fail; b=Umsd1aV6frljd3xUzk/MlQgleX2T1/l93fBWSDC/ihbbTuaz3EcRVz/2ufKkgGC9vUfDYMOUXWhAqjEfeMFZFVX/UHzu/yY+oRSWMZcEKWoOXsdcLLDawPDMyTLHlSjH+RgBHh/8iDrUGu/wpyv6tUd3DfzYzrd07lTK5OCizrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111826; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aEMZ+LjMbsqKRzgkRiF7e7+zqnr/41u3+/vIEqWnp/w8vCCmOaPADP/fZ+QZKEDDPAVcqHxCMeeXI5he2IFAEPJBE/wsX79FmNuXTx1vRZ9UGqpGwVcRbf5IwABqqhEmrXGk/C2seQGXhLrVQWiLFxHMqSwj6Q5Wj+JeJG30u/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=huC7q1Hf; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="huC7q1Hf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVh4nTFNXV8kG+XQR+qhCUHCFHOfMa8AEV+zNzcHYmUNPeJvMBnIFVxMtO0i6nvafKpJ4ydi3g0VIk9cr8VN9M4Z3RLMSG1HKCpbmWtcrWio8qyOuwA/EvHv3atPXaM4z9iMjN6MGMD84wFXWrQhyAptKEvzc5bdYx2pdMVqF9E0geM6eP9fr3GZo04FhsXFbMk46Baw6cb4j3FLcSCHiT9Yw8FRWXnLfP+MApPW7HnKitO9DDhACQUn6RmzQ5m5slUXbhMQlXPtJbvgJMrBCeyMlJVEeagNTT+mAyhATunJzomfoht15AsiBzhkjK5ZTd0hikFuh0HedUOFbEKjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=HpoEr43w4nccQub87e+BIcOsbMFQj8DKVxPt1KfyMgMWjpo4vvHQGkHG1RjhTNQbaAKSbcOPPURND1syCNXBt+QqGfFFZEcnYiMXSFj2JGsusW4yFvh/N9UJ0YrQzdTeesSUCGzErapPx9HJgZxbsRnS+adXGNGmNg9Kl5Fo+5eK7PxZornY9Kb1dTDWKPpWKlZb8TXeRnBm0bje0XEWP06nr1Lhwz8tWA6mYfiIdasgnPXtYxuLSyF0j2/BPZa+ItfuQDMuapFGHeIXgYaLqwen2qVVFTMRbQ0/RCilHfacX4t1UkugzjKsJHnL60uORAlk8FN4iXSHOUsq2l35EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=huC7q1HfihJn+7bmSZbKAnS0k+vf8ldBtUsiQGNIv0O4ygp8jdfAisolUJbYc0qUqArhT8qsTsEMU4vffP3ef7y7sVVs/VpYsYRrGoBFqfg+KHAadpGM6vBvyBRejJwtPt9QTJlDJnMpoGKfXDbf+rbscKycUerbUwwGT6RU5vM=
Received: from AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:416::15)
 by PAXPR10MB7951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 09:16:58 +0000
Received: from AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e52d:84d4:5410:c87d]) by AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e52d:84d4:5410:c87d%5]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 09:16:58 +0000
From: Gabriel Sanches <gabriel.sanches@prevas.dk>
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
Subject: subscribe
Thread-Topic: subscribe
Thread-Index: AQHaaibhoNQbPEg4bk+4Q/10o4nxFA==
Date: Wed, 28 Feb 2024 09:16:58 +0000
Message-ID:
 <AM9PR10MB4854891DD2D7FB80718DE7C7E1582@AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4854:EE_|PAXPR10MB7951:EE_
x-ms-office365-filtering-correlation-id: 3474f23a-147f-41f1-eb92-08dc383e03fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zS8Kzkh0uwzpInja2RiKnbr8FCtQSGLZcGiTSh3ppfyJRSJxMaPtPDiIKshg82ow+QZ7pRdoEY8Smo+Yq8r1GnVvlQ7ANfoPO0q3/nRIeeofS66rOWK+QE1LNwcaFQEWvbLM1enroLh6yW9lc/cMPo7pyQ1Xh3yQz3j54FLs8lHyxZKEc4C2VB48XoRiotZKLJIo6Zv+pb9xn0YCzHaadwgjF6StPYnAqLwKtYZdb+twhb9S189gBh/iQ+4fcsJn/L1fderz5Co/JjA4sCI7exAKMsFdNYs9KfTeSnSQl6vMH3MuUEEMi4W3bwhgrp41pYJg4CSVSriLliFOVgYGZBQHWP/huNJNv/UAZNSRY3enZ+GMxBnDGgvId2+cr02wfUcUBUpG29doWnxvwIwNj+gxpxjtAh7bex+ZcPHY4DYIZ98ZlI3X13ynToECXi1iVARTiggK1rw9Lut6jY16hQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PBjr1eFkf1wdLwt+qTVLFb3PeGWCqCaDWVxl710lLOJI586Qj5xJ2dN2v2?=
 =?iso-8859-1?Q?j5dPW6Ydmz/JiUFsJHh/5PdVonKZutcqjuWpJgKUU2Ri5JhCAUY3+T8+Rv?=
 =?iso-8859-1?Q?ojLosASJicgVwLgbS5xFxsewYGtJvD+LdEx8ejh5G9FPVs+HVZ1lk7RzSc?=
 =?iso-8859-1?Q?3dMIH43B6MFPOY8ohgErkBo9S328kTo4nRsmPBcKA8KDLmvlek/EAK0lZB?=
 =?iso-8859-1?Q?40xwUMk8Q2bu0RgkFOi/apz7GTKFgIA16bkAde6FYJa2GvEcIdllLQJuW0?=
 =?iso-8859-1?Q?NpnJKP3l42CJyHfcvNxawASvyQbfWkEz+JAiqruYoyqKeT6h1020gllqcP?=
 =?iso-8859-1?Q?06d2olpniEmDOyWrFaMFAo8IXYnDo1pfroLY9SpWJ+2FxV8F4KpK1Qo0eQ?=
 =?iso-8859-1?Q?UPT+pTxcSPCc1i9+HNA9vr+223iCpTsOae0jfWcXLTZm07nRZGi8RoP9Oj?=
 =?iso-8859-1?Q?rQY7l/eobkYAOrXC06aymeIwG1qaEYSN9XiP/PzKbAsrR9sFoTNjdUF11a?=
 =?iso-8859-1?Q?qSNzxDRX79rtIx2N70m4gW0faQKibARyGjw4v7n7zHPQ+G/AqHmuc0o1AG?=
 =?iso-8859-1?Q?qFCUDz+hW6YGaxd9+0FA0lQNbW3LsBW92vsguSxofIRZkUtG2Gd5l/pxZ+?=
 =?iso-8859-1?Q?E6jWG4zQ5NOS3n4Tk02zqhNikFgv892uZMdGAsqSf5IbLGvf1MA5teKa66?=
 =?iso-8859-1?Q?pSJQ7jnAaLgMDKDUqdr1r7AWDp44tJJ9pXX8PV/wVH9WUe1xHoxRkn9l1Q?=
 =?iso-8859-1?Q?Jwc/f7AGZbC+FecpnVx+UNiqLUChnak5TGK7qcBIvE4D3zje4yZGKp7A3Y?=
 =?iso-8859-1?Q?LWWgQpq7e7Z4R7PBS1ZCRTCQ9NDp0cQ9YCoXHRmZ/Ux1vkNNDuJPODFQsh?=
 =?iso-8859-1?Q?rEZwRZyT6ILRPA67UCMby/qLtBLpRwqBHsoVYEdMkY+A2TP94wxlKNgn7I?=
 =?iso-8859-1?Q?APNX5uhB7mNSOeNz31E+szFTW8ewniq2WIXgwWrD8zuCsPlU7penBgw5QD?=
 =?iso-8859-1?Q?4sTrqbYMCNlPHeWufRo8Ij1d4sdVG0wNfGWFpyahR/lSgKbyEUIruIs4rX?=
 =?iso-8859-1?Q?8SErbeUKv7MhrgIbxWDtDJj7WVulIWkOJUyrPLx1xRxlnOb6Q8CglGlf9w?=
 =?iso-8859-1?Q?7heLam8C6BgzD5s66/kOL6CbE65qqxx0pH3UkiAnH6zMMBUlmLZOdhMPXA?=
 =?iso-8859-1?Q?3zLgQfKxWSZne2UwmEWdDjyoT4OehlFHM00Na+X8rEdpTjO8/CgVmJPnNJ?=
 =?iso-8859-1?Q?orPgSt+sMqvcOIGKxgSW4Z88JCWRLlixsYDaJ7+PfezlSMaCJUsM3alAaa?=
 =?iso-8859-1?Q?gj3nLfeqUTFRj9TYTB7o42MNae2ubAdYVvSvds/LxoVDw/ZnE4zLSelUJl?=
 =?iso-8859-1?Q?/dT6kKvpTFReskCUM8MJyybb9ZYQH/K6/5ckogjfH+LJFAfbfiuJthFHim?=
 =?iso-8859-1?Q?1f/CdLBxnAHdN+HksGHUERkswqPBfyBi1ikiCKBNQKHNs1PqXwg7b9ljSm?=
 =?iso-8859-1?Q?NRJshJ1A39MooUW5bc83p9WIDnhtKrun101ndSEZt8wMQzB9mgPgwpSO3w?=
 =?iso-8859-1?Q?+pJJbBF3Du25ShH+EKPzUB66wcT8tJAvj4h6iGAJzpEqKfBToVUcNJ/PvH?=
 =?iso-8859-1?Q?LhCQmAGvqod8M2/tMs9Gl6HtM/V/S/61T2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4854.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3474f23a-147f-41f1-eb92-08dc383e03fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:16:58.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUgkNhVo54/I/CYh7SjSu3mMDOGH9T8Sn7C8W0eSXGqimEFr0j8QiILjGInwUrMCymRGDorXt8rmjUsz46oIKGHPEy79pvew4o9TnMTBpLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7951

