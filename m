Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9BE1E520A
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526607; cv=fail; b=LLF3fZnOA+zDs+mcI3fh9omng5n2/tj3xGIc+QGaj4WLcQXe66kq7tLgbkSAaaKFXPAWjKyU2uI4TE1rsTEkNCG8kG4YWlGOKxDG10shnG4G7A3iczBZTBDhgvbM1gSNJlA3QLnED3Z2tpDIN7yU8lUUQclazzag8CKcXBM+IKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526607; c=relaxed/simple;
	bh=0gFjaRyO9EGkiVQkg12r9wtdk1+1/S3xhR87ALqabPk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGAlzZbcwHdD3HVxRBn+J1vhXpqVy+1+d5BAupVyCjsDbIb0svH8jLA/38arey/VQEf/OS5g9TW+yubFt3tnu3vK7ulrJ2TBf/kq3w76BMmSXp4VcfaN41gR07DD4jXkPxmBsubpsA189zKhPBb1FMcNtCW1FDOymGZ1uZ1Lygc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi; spf=pass smtp.mailfrom=exertus.fi; dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b=oTiFwKF8; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exertus.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b="oTiFwKF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vaxu53+alYz4/Trbi3KYoXoXoCHW4Hixz48HAtGkvvIaLiIXWBoP3R0p9W1fNn/AA2Xz3Bn5Rq9TxOCXB1QLxNGtgZmhxoI+vdz9Jrgx63/EmCA74LX8pPrGk9b5xKliiIH+ISinSdLOTJPjwTNCQhD97yEtUiYdiFK5kGd0bW2eHliijMIW7V5hANJJ12OUBPKZZMvIvnWoBlfLx84Ry5y64Rr7J4FlfkGu5vB1gwvp3R6eNn+UY9X2HKp2eFFHPrfKkizoMr5S2qg9SU/CxjtWy94MFmEChHWrW/i6f5TFfhp/9DPOMvZGiErfLnOVVmXf1NT5r6rVbHDYzfy1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4wz4sAtBCFPAYeIM+vXMVcNK+GEp/BGBiRmQ57BwH8=;
 b=IWGMo9a/wbuMJkI44SJyv1CXj8huj0Qa2X+y9yJmGN/2Rg5SfStHNeQv1UkSpMYhvTbuAVlfttDUVhG2Uqkp0MRMAgYnNW7HXfFO48oDajdiuQdbZCGv0twwJ1S2NFTHjFlKYpePcyhY7Zx/rsyOwKeRRTOp3CiCzOG+C8d/dhYW9ZMvB9C6k0WaUuXlYt4sS2h43/PpHcYNoFz4h7j3mvilDP34NBWJrzLe0X1VhnUUV4GUO1rvENPcH1gvWMQDDiBc6TzVDpO5jzmCoEntCUh3ilG/1YB7H3PQzdGt6+iVt58LgIu5NXn+iN3TZS1FXbckd2nuiNumFD/kRYsDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exertus.fi; dmarc=pass action=none header.from=exertus.fi;
 dkim=pass header.d=exertus.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exertus.fi;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4wz4sAtBCFPAYeIM+vXMVcNK+GEp/BGBiRmQ57BwH8=;
 b=oTiFwKF8yR0V9upzNg0diUtmjLTfHhKVujdeoEvqJdYmskLB/glyIOiOXuT5vnwkeq1MPEJuokJzbuYKqArCp0YRWBkmDgSrIXY2R3eFcG36gjqwdE61ZT1VaYkxHGLnY0hRM8AygXqrPgVDdvFcBSXAyB5NmSpFT7jQEb7joVXl+c9Opa3VXDIM2vHPDdNLXDQcc3DzZ7oZHVhlHKPVNd0qn1PQkll18pdNZQTGwX4nZMRlApE/IemM2gStkOSsfJnzzf9C+clUTrbfeW0OKheefjObGyq04x8QiGA6z9V0wB/YWQgU0+1aWRgSaD5cyE5NnK7ZzaNCYJyMquSRvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exertus.fi;
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com (2603:10a6:102:308::8)
 by VI1PR09MB3789.eurprd09.prod.outlook.com (2603:10a6:803:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 17:49:59 +0000
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73]) by PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 17:49:59 +0000
Message-ID: <d7c6986e-7337-49d5-ad00-c6f1f8901898@exertus.fi>
Date: Wed, 10 Sep 2025 20:49:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
 <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
 <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
Content-Language: en-US
From: Timo Ketola <timo.ketola@exertus.fi>
In-Reply-To: <379c6d32-28be-40ac-a055-0ebcf13613ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00004588.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::44f) To PAVPR09MB6402.eurprd09.prod.outlook.com
 (2603:10a6:102:308::8)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR09MB6402:EE_|VI1PR09MB3789:EE_
X-MS-Office365-Filtering-Correlation-Id: 05eef87b-503d-4fdb-bf64-08ddf09275b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blRyQWJ1MGduS0d4TmpiK3k5Q25JZU5KZ3pGN0VWQW8zYXF4aytJeDlPTDFW?=
 =?utf-8?B?T2diZXlTUmtLdzE5ZS9qV2FvVHlXeERIcjJGUHhWenZlL0NKRDRRV1ZIcGpj?=
 =?utf-8?B?REhtdTRrQk51VDE0TkRlQm1vM1dBS2NsZmIwSXhyS0lseXc1SWQyQnIweVVq?=
 =?utf-8?B?dm5TU2FjZUpBSnBCQW9FSU02S2J4Y0ZCRUlWenNoRG9zOWNlaWhGL3lQOStP?=
 =?utf-8?B?K1JmS0RXcm1DYzl1Nnk1SU1GSVNDYnpqQ0d0T0tMbkRpQlRjUTdLQlVBUGtw?=
 =?utf-8?B?RHh3UXUyN1Z6STRsNUtINXh3ME1IOHd6cU5GNDA1aDh2M3J1YTQ1djZ4b0Z0?=
 =?utf-8?B?ZkNGeEJ4QmgwYTlQUVFJVTMvTkcyREdIaERhTWoxSS9rdDRLOGdqWHRzOHQ2?=
 =?utf-8?B?U1k2WlRHWHpvRnNUMXJCNUhROE5JeDdyL21vOW4yamFadW9LRGdtbWVlbFBW?=
 =?utf-8?B?SzhtVVoxMHNIUVpvZ0IvQm5TcVZ6bFVJdFZSNlRvbUZINUlMMWxnczZQdzd5?=
 =?utf-8?B?RVRHcUtnMkoyWE9VUFR2Sko3V0VNdHBPdS9GSmJUbVl6azdBa3RnSUU2bW55?=
 =?utf-8?B?MEV0dnVrZFhvL3NFdEtCak9oZ1J6cURXVVp6YTY5cUlNNURMc2lyVTRUNTZi?=
 =?utf-8?B?YnBraG1CRm5Ia1RVSXlaMnBEcG5GTW5xWVJmSHNFU2dNL0JuMmdCUHBYUjcz?=
 =?utf-8?B?dFkxWlRTcU1QbWJTRmxMQi9wZ05MOUxjek5KSTRlb0ZsajI4U1RESm13Nkt2?=
 =?utf-8?B?VGxKKzB6ZldtdnJXLys0Q3ZkUlAvbVd0NThudERRUlVjYzB2eUs5OU1ZTGg0?=
 =?utf-8?B?U3Y0RGJTZlU1VzVLeElkSmt3VllPRUlkWWZ6MWVhTkd3ZmVLVWtPRkdKNFpV?=
 =?utf-8?B?b2dKZWRyTlpwMElub2gzMHFOQXhJMUh5V0Z3Y3pvYjk5bDM2OXlHNXJPc3Y5?=
 =?utf-8?B?MnJ0aTRDS1VCaURGWERxc3pORDhPM3c1S2NvUFNiT3lSMEltLyt1SE9ZWVhh?=
 =?utf-8?B?T3VqckdHL0d2eXRsdU55SnVGSHB5aDJHdE1qN1RFQ0lGMWsyUVVkSDRxZExa?=
 =?utf-8?B?akFVak9jT0ZKbGdQRFNQSC8wekN2aEZNVC9OTmc3QlhpYTNPbVI1TzhwTWgz?=
 =?utf-8?B?M1puTEpiVC9scnY1ZWxUQ1RNRjdMdUVRd3JHdjF4bUpiK0xkeTI0WWNmQklP?=
 =?utf-8?B?Q3JqU1k5MGZobkNNbUN3c2puNFBrbEt4MG9XYUZEQ1hMR1hYK1dQVG1RT2Ix?=
 =?utf-8?B?M3VGOTc2b0JEVm1rT2xmS2t0b2FwY3pNR2RMOFQ4eEV6Q1NVcEEwbEFSakpD?=
 =?utf-8?B?WGdWV0RYZjhlb1I3c0pQdkdORFI2OGxoNlVMbm54V1hzbWc4Q1dJQjV4bDdW?=
 =?utf-8?B?aCt0QmxiVGw3RlhGVkhTTVl2Qll4cm9mcGhBQS9CZzloeWJ3UDVYMTltZmVa?=
 =?utf-8?B?eTZITkc3ellTOVhISDJ6bTYvZlEvNlBlb3VWRTliNFRiWVpyS0tQUTlZS1pI?=
 =?utf-8?B?cTZncWJKSWJBTUQ2bnFwKzZvcDNqWDdJb2hKem1GS1R5NTdpVGgvL0dzQnZi?=
 =?utf-8?B?UUpGbTEvalBYVnFWTVFka2tBV21Cc3BiTTVISjVvQVRCOCsyRGZodVlRekZW?=
 =?utf-8?B?NzZXalNoVk8wL3JnNmRUVU80YURjbkZzOHNsOCtDRkZqeUIyU0lTRHF3NFMz?=
 =?utf-8?B?NlZtYlRJYkpqWXdqd28wTkUzSHllZFU0ZEwwdmhCQVhicC9GMFJ0U1Y0N0ND?=
 =?utf-8?B?ckQ2N2NTVitCWDR3dVBhRkRNM3pUdlJvend0aW5FVVQyUDk3ZXZ5SVBwMFZz?=
 =?utf-8?B?RlFqczRmWmk0M0xsOGZWZktRV1UrSHlwbDBuRW05QVpCanFPcHBCSTFWZFNY?=
 =?utf-8?B?UTA0Q1h3L3lVaUNZK0prdWZ5VkNXV1ZPcDBZK0YySXZEL3hZdEFiZ0xNWDRD?=
 =?utf-8?Q?Z/WObHjeQNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR09MB6402.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHkxa3djSFVPYVh5S2E5WmFOaHZHQU1wZDRWRDRnRG9xVkpiNWd3YWc0MFVJ?=
 =?utf-8?B?MTBLdGJBVTFUbDFaUlplTUZnNmU3c0dxZnF2OWI2RmQvT2M0NXJmWVMvRHhq?=
 =?utf-8?B?ZjlPT1RpTi8wVzFLb0tYN0QrcXZpSmxMaGtvY2xubThrWkMwQmZGM0xoSVh6?=
 =?utf-8?B?UTk4c05udTcxUXJkY3B3TEg0Vm1nZ2Zua3oxKzQvSFczYnFIa2VxNHR5ZXdH?=
 =?utf-8?B?MEFSM1BmWU9zb1hJdCtsUW9HTVVVTzY2U0QwMTJ3cWp0Y1BlbUNDUGlLY2N5?=
 =?utf-8?B?QlVNWk44dEZtdldhaTgvd3FiVVZVeFVNTnZQb2tZNEN2NVRCL25tZGJYbnRT?=
 =?utf-8?B?T2ZuUGJKaGRTeFdnc3poYjZYS25FNkwyWmFIc1hiTDFKbnlkajdLYldFQ0w0?=
 =?utf-8?B?UEc3K2VYYm9KNmpZSmgwYmN3eFBoeFR4VGF6cHdIRit5MS9xeTZBUlJpWDhx?=
 =?utf-8?B?Y0NMQ2xkcC9JVjVkOEpyV1VXWUxmcm4rcDNlSU9wazIzblhURmhlbCtTcUN6?=
 =?utf-8?B?SFArUEVvQUNZLzFuNjBKZG15citYdnBuYm9xVjZOR3ZPdXNsNkpjc0ZCcmVI?=
 =?utf-8?B?M2NLYklLSTFTMHdDK1Y4a0plV1hmQmxsZ0ZLMzduS0JJU05nOThMaXhBdVN3?=
 =?utf-8?B?STBvanQwUTRHY0gxTTM0QWhWeExTMXFkYXFPVjJqenVvUFdkbHZwM2pnRzlW?=
 =?utf-8?B?Y2M0MGc1R3Z0eEQ4U2pRMnkxRmEyZVhxbno5WVRMdS8veFZ4d2RkNEl4UTAx?=
 =?utf-8?B?S1RxN2FYdUQ2bmJTbGtDYnk3amVFWGl3VFNIWFFnT3pGSEpjQ1d1eTBjbnRk?=
 =?utf-8?B?eG1FdThQUUpubUo5YnFnQ3JEZ251Um5RQnkwSHZ6RVdKRDlZUkVNczZ6Mk5l?=
 =?utf-8?B?VUM4dW1uN0tLREZmaFIva1BDVUpUN3VneGduTzgyaFZhaVVDYlpQSS9SK0I0?=
 =?utf-8?B?R3JRZTF4TWV0SkFickdKcjlEYXBidDBlK2dYVit0OGJtU2R2SVlYWDZ1Sitz?=
 =?utf-8?B?WTZHd3hZYTZaOHcxSWtOendEUm12SU5pMGVtYy8wSlo5d24vTEplNmdEOWlQ?=
 =?utf-8?B?ZEVIM01nYS9lMjg1QmNjbjRkRGZqSFRwOXJVK3Fpc3NObXBCZ3pHOXVjNWpw?=
 =?utf-8?B?cHFyK2psYU83TGdqY29ZL25PVHVIaUlsQmhEUEdqelJkbVdRZmRwYVpVT2NV?=
 =?utf-8?B?NWN2d0dPcXhPbkNPR2hoVFFqb2VXSTMvY2dDNlJOaHRmNEc5NHZvckxBM0Mx?=
 =?utf-8?B?UUVsOHBweTRKT3Z3QW8zWWhoRzJ3RFpaSzEzcDE0NDRJdHh3VzdXWVkxL1dP?=
 =?utf-8?B?ZEcwY2l5Y0lZTG92ODFsSVJRRWZucFIvamdKQjZVZVU1RFhlc3NUQmV4TVJL?=
 =?utf-8?B?NDlRNmFkR0FXbDBkc0dZdnB5em44WjkwUmhvcjZmT3J4WnliaHNiZEhZMXA3?=
 =?utf-8?B?V2xRSHNpaXNlandZbFZUS1drQTY0S3NhaFFxMnMxd0QvcjV2cXdQb3hRcEUv?=
 =?utf-8?B?T01lTCsybDVJRGJoNDBXZE56TXBHVUgxbHkxc1pTNVMxUWZVZzdXVE04emNi?=
 =?utf-8?B?aWRKcDVjZjhtemxGSFl4ZHBKTG90Q3BaclFxZko0WS9McHM3ZStnU0xZTERh?=
 =?utf-8?B?S1BjNGwvdXlyZWlWcjRuMTNhRG90clQxSWkveU5YcXU5TkJsWVhzU2hORUJo?=
 =?utf-8?B?WjBITGJickZaamkxbExGYStORm9FbmtPYVV2aUJlVTdGYkVnVWpYWnY0WlRV?=
 =?utf-8?B?NzNQc0ZNWXJTZ0lkT0NBOGlsVXNDZ3VEOTdBL0lwbWFBR2t4TXNLa24za25N?=
 =?utf-8?B?bkliMlYvY0RTN0FpNFIwdTNrSzdnV0xtdjJCZmpzY2hJUk9hcmh6UHRybXlG?=
 =?utf-8?B?UHU3clp5OG9mQnUyZlhGOHJMS0t2VEdSbzRpRG9BVHl3cmtIQWZGZUxRVXJG?=
 =?utf-8?B?QnRtYjFrY3laWGRiOEJ1VUIrU253ZmV5SDB6alBZeG04MjA4NzNWdnczWVRw?=
 =?utf-8?B?M29DZ1JYYVdMTXlhZDFoaFI2cmZzUGUrZjExdVhleU1XOEUxUGtKWGZkSUpa?=
 =?utf-8?B?cm5UYmQrS3M2Y0R5NmtnMGFRY1plQllzNk4zZUtjT3pxZlhnT1o4NFdrdjBr?=
 =?utf-8?Q?i3Mw=3D?=
X-OriginatorOrg: exertus.fi
X-MS-Exchange-CrossTenant-Network-Message-Id: 05eef87b-503d-4fdb-bf64-08ddf09275b7
X-MS-Exchange-CrossTenant-AuthSource: PAVPR09MB6402.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 17:49:59.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ff5ff20-bcb9-4615-b2a6-3bbeefd7b8e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFm1xhLArmlHXMU+5nh9EhHEDrtmmF5j64GILBLHMLEtwPWDhcQsq7E+22w8TQ3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3789

Hi Denis,

On 10.9.2025 18.31, Denis Kenzior wrote:
> Ugh.  I really have no desire to support kernels pre-5.15 when the 
> passthrough capability was introduced...

Are you saying that if we had 5.15 kernel or later, latest ofono should
have been working out of the box?

> You can try the following patch though and see if things work again.

Thanks a lot! I'll try it tomorrow and report back.

--

Timo
