Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022103.outbound.protection.outlook.com [52.101.66.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C912CDA5
	for <ofono@lists.linux.dev>; Tue,  9 Sep 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406638; cv=fail; b=K6s2VSuc7gy8RQ7rNQS6OvL/4lGYVIQG1BPoIyQeSH7ZVWxO6zEs42r0d+9xXFajZYcx/Bf5jNOdc7dHEp/cRtY9HeHryvpkoJAQUliX1+CCgAKpFIkKLjNWzjzfnbTzVywjw0XqiCPfmN7fU3EnHRPQjUJxKR69oMDoRtjWWIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406638; c=relaxed/simple;
	bh=+tzL14ZSKTVw16eB6z1sSJC45q9EM8jPQYn97IKm8no=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=R9rvTcWEcXjtZfuSR6F4N/v8vUDSlQyqocWhF117XcFVA0fIY4/hwIcE8C1KcIXnTZs2mUoenYsXXoNSUeJuI94IOya9vDytyR0hs+gRikj/38vBJB48iaDgfORNtO0Hw8YBbGorMRdZjux4JvhFiE+p7C0cnEh9wktyLvrQwQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi; spf=pass smtp.mailfrom=exertus.fi; dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b=NIf7PlxE; arc=fail smtp.client-ip=52.101.66.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exertus.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b="NIf7PlxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTSufvvhqFTrOiiyMJLJzvCUJJUYoJAe6QbcIn7pffh95EGo9snunVi+IpgqJ7jZTbOOJcb9cCoRD6f7oTSbozG3HOvr4LPepk/cAbJbjREIag2BAMQBu8EWCqTkvq7S+eWv40LmeiAQqReEaBXhn/5c0jTQM8CkRJYGi839JhJ1iYbv1eiXgWfRxrU7Ptp9Zk80EZCQP2Qu5va0FKYQ4MM8wbKRTFmSQQdW2/H7Wzd8FJ2shRcjRrkEZr4J9wg1OR/yUn8vTKIrKc0Ofg1VmF9T0EVAQyCaNfEkjJxU8U9Nkekgml6ZLf22q5WZlCmk2qMyScTcm+72TjPB90DoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4wNeoYGXBfOOzFWwysqFkTNE3oINjehl1WkFfJtEGE=;
 b=BaCbP6M7RTmmQJ7tiNFCffXoBD+qVPTo26Hjrhlu8jVP/Tm9PJe8sUzbn9SEJgd+8VmMAV1WuL4byya8vxgrgh7XcL/IsySvqp8UdQFWplocf4ABo2cWRZDmiNtffm/PpuYFtK+OjjBXcUoLnjhbJBLmpGIkNWQk915GQn1QhllRTkePN+7EzfEXwCWisVuTI9Yp0emHqXCDJm2oku2W8rYKMTjO5pnN3GMWUfIYKDdykyfLGuKBuDQqagYJ6BFII+HS+MnlDoqgTB/YBCStphAPYgU6Id9RPsoQ4n74DtMyutMAR4DvDU29o9gZ4qkdURrX2u8NXpxaZD+B/AQIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exertus.fi; dmarc=pass action=none header.from=exertus.fi;
 dkim=pass header.d=exertus.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exertus.fi;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4wNeoYGXBfOOzFWwysqFkTNE3oINjehl1WkFfJtEGE=;
 b=NIf7PlxECKtmrH6VLLPkfaE2MSlRY6cGaHIUdtI1aQ31TxHq5XkixLfuoG5hieKQI1J8TXXEWMmJzaNRTTHIZXF97RMsi3gQccMrcgBF5LGr2P8FzdBK/h/bmqaJb3SoGAWnxwWI0aTNdovV/kO3Vdzbs4WRLhJaqbJsGLLzOP22D4/4PtQImwbmZVkkgVHzA0HTRr2ll5YrnQknwKoKXOYlIGWOk7yFGxskfdp7rT9toT34aZ2QUpoi7sbZkKLottD+9wgUOtI0r3hgoz1Q1ks/ut8A0NluxrONuyNXY8TjleZs5kpfbXE2AFlAfYnKiUdJplDsFJhsV/GbgDkk9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exertus.fi;
Received: from AS8PR09MB6411.eurprd09.prod.outlook.com (2603:10a6:20b:5a3::17)
 by VI2PR09MB7952.eurprd09.prod.outlook.com (2603:10a6:800:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:30:21 +0000
Received: from AS8PR09MB6411.eurprd09.prod.outlook.com
 ([fe80::f1fa:258:ee2d:cd19]) by AS8PR09MB6411.eurprd09.prod.outlook.com
 ([fe80::f1fa:258:ee2d:cd19%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:30:20 +0000
Message-ID: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
Date: Tue, 9 Sep 2025 11:30:19 +0300
User-Agent: Mozilla Thunderbird
To: ofono@lists.linux.dev
Content-Language: en-US
From: Timo Ketola <timo.ketola@exertus.fi>
Subject: Quectel modem ceases working
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0101.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::42) To AS8PR09MB6411.eurprd09.prod.outlook.com
 (2603:10a6:20b:5a3::17)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR09MB6411:EE_|VI2PR09MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa321b1-f30b-4286-66a0-08ddef7b1cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODdqSkRxQ3RxalgvTnRzNjVjZmJCZGk4R1BJMmdLYUNQdHRlZklPV3gwV0hJ?=
 =?utf-8?B?MUQvSGNablJlV2tsYkRzbjhZYzR1UWFBYVRZc2ZncmFRb3gxV0Ewa1BOUkxM?=
 =?utf-8?B?OWZwWUFTYkx6dDcwQ2xRL3JRSFpId2RCNnVsMnhCZ2dKd2RTUnVoempvY1RE?=
 =?utf-8?B?V2V1cC85T0tSY2Q0YjZmVXdEUmFpRjVQYWphVlp4RXF2cXhVVEQyZkdPVDk4?=
 =?utf-8?B?bU50bXdWbjA4ZFcxL0xsMFZScW9FenJCcEVCZW02YTJqaGVhTjVYUTJCTC9L?=
 =?utf-8?B?SGFQK2xyaWtrR205bmtoVmNxZFhRUHZNQlEyMUJka3Z0dmVTVHNLZzNxMUxN?=
 =?utf-8?B?b0VGN29ZR1F5TE5aaHZHS0wrNWlEZitGeTljQjBReEVkMk4rUDFYdTlNTkJv?=
 =?utf-8?B?ZDFwWWg5ek5OSjR3L1JQMTdnazlKd0YvS3JQV3hZbjd0T3VNOUV5MEJSdml4?=
 =?utf-8?B?YXhIdEJUeG1udEJXNHZjNlUrZ0lwVDZJNDNJNndrV2hFWFVKenZOeDgzWnpZ?=
 =?utf-8?B?dUdmMGptTWt3SkFMMmhZNDdoU3F4Zm0zeXIzMUNJVmE4anVYY2dTeFNLVGZG?=
 =?utf-8?B?akYreHRxN05PaDFacWNnVFA5cis1OVMwWm1mTk51YVBSZWFnM2ZaeEc4Q2JV?=
 =?utf-8?B?LzZxME14emMwWDUyQzJDZXdLdUlRSSt2Sy80am8vdDZ5Y3lUYUVwejZpeUxT?=
 =?utf-8?B?eGhvNzd6WHlkSTlzK2RHQlhOYzA2MTg5MG9Dd3BiYVhRYjBTZmd5OWFXTVFi?=
 =?utf-8?B?czhyQVQvenpVeWZidGxrQXZDTjRxTGNTV2Nkci9YYUNjbFJRK0Z5dnVQeDFp?=
 =?utf-8?B?RkdxR0RiOVdKUlVQQVJydmpDUGdnZHFjQ2VHWmJIUXdTVitKYkNqbzNMcmsz?=
 =?utf-8?B?RUUyOFhNZ2F5bmQ5N3hqR0xkeERocUR0SmkzNFdnRFpiWkk1aXdvdEdUZHNJ?=
 =?utf-8?B?V201WEhrVzJZci9Jd3pzeHZNTVJSSjFIaHlqeWdhUG1ZdHNsc2R2Nm44QVBn?=
 =?utf-8?B?bE55blZMK002d0FCNUJ2eDV5MzhmZGFOWTN1NWNKZGV4cVMvQ3g3QUVhMFR0?=
 =?utf-8?B?T1lNUlkvSUVmTFRMNndNQ1ZrTmVPR1FGMkpPdTBxQTZuL3gyamVEa1Njd2xq?=
 =?utf-8?B?ZEtlbzJPVHlZQjZZc3VkWW1EY2RZN2V3ZitIbFFwY1pQblJ5SGZmN2FQK083?=
 =?utf-8?B?Tzc3TmNwTUxXUjhoS1hHWXRzYVZlRmo5ODNzaWJqY1FTenAzRHVFaHZCNVhF?=
 =?utf-8?B?bytYZEFvblVJRlpEMHZqM2p3WXdxd3RZV0FTeXBVZXczRDBFSlFlZUd3a3Vi?=
 =?utf-8?B?RDJQSUlFbEZhblJub05zODUxTTlBU3MvQlJPcjE2L0lmMkg1UC94SnQrOTE2?=
 =?utf-8?B?OXoremNzUjNCV3VZYW1XUGs2WmVLbVZHTis5WEI4VWV3VWJ2SDNqQWoraDlB?=
 =?utf-8?B?OThpMSs2bXZweHM3UDdSR3hjVDdmWE9WQlM2LzRsbTMwcGNYNGFGODVYYkJ4?=
 =?utf-8?B?WGxRQVlOTy8za0xpaUJpVllMcUVUVG11QXhGT2IvUjNqZWpTU1BKWWRjb2FI?=
 =?utf-8?B?YXlHWDdWVDc0MTJtdTNIWk9ZdS93NVNQUVpzRWdjVjUrVDRCbzh1VmZhU2R5?=
 =?utf-8?B?cWNjTnJoZkFWc2RCUEFCNFhlNUNXK211SzY0My9jSEdNbnVGUnA1dHZUcDFN?=
 =?utf-8?B?eUNrSEJ2SERXMVZWQWE1Z091WGp2WCtDQVZwTDhiR0R5ZW8ydkUwanJOOUN3?=
 =?utf-8?B?SWdyY2hidzQyaWp6Z2lubXprQ2NrOTJLVU5wQkt4c1p3b1RjUVdGcnZyMHZ5?=
 =?utf-8?Q?5Tqx3CEACC/X69fHypOjenv0u7MqUreJ1bQts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR09MB6411.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05QekRVR1l0UmJzeFdvWFNYRnkvR3c0RlRXOTF0ejZpRWh4K1lKT1JiQ2JX?=
 =?utf-8?B?RGMrclRpaXNjNVNMcm5tSHRLVWdyNXRFN005ajlEQzdqZEhycmU1dUJjVGlx?=
 =?utf-8?B?UjE3ZEdaVEI5c3NqY21BUUxZbHNuaXJja1lJbm5BTWZud0FTWGJqY1dqZk8x?=
 =?utf-8?B?cDc4djM1dDdsWUxIT255NEloL0ZucXVVOVU4eEo4WE5NUlNjSzN4STUrU0tR?=
 =?utf-8?B?cUtZNHRnYk9TV1Voc2d1NVJuUXpZNitlWXoyVXhadW5Ic2hiMGVsU01DbFVK?=
 =?utf-8?B?Y2RGUUduZFNFTDd6b3l4K2VzUGs5d3c2THdQMXNtL2ZUOWlJMnFSVHhnZk9P?=
 =?utf-8?B?TTEvNDZTZHJJaEVmclJFa3BwS2Z4TUdacFd2V3ZadXk5SEJDaWpnekg4U0or?=
 =?utf-8?B?UVVyNXBnMWt6N2tNZU1IaW9ULzdOLzVUL1ZueWFqUE1BSkdMNlQ0NGJOQy8z?=
 =?utf-8?B?Qnl1KzNPbnhaTWoza3k5OW9pNm5LL0ptZ2FjVnU1bkhvbG5zTUNXUjZJcklF?=
 =?utf-8?B?bkZjSlpzT2RlU3gzQ2lDRWxjS29jQ09lVy9ZOVZJSlRxZXJ0bVhLRmF6clZJ?=
 =?utf-8?B?dkw3TlRiRlRadmQzWGxGSkx5N0NxN3dxWXdrdVVLNk9HOEFqVnFIa0twWDR4?=
 =?utf-8?B?ZXc2NHZFdVcyV3h4bmZRUGcwY2MxR0FxVFZScG1SanQyVGdtQyt1U0lrVlpK?=
 =?utf-8?B?dHVELy83K1BwNm1CUU5IQUVqbWZxR2IyeDNLb3F0anYxNjBORWhtb3k0Slc4?=
 =?utf-8?B?T1A2M3ppWWZuTmd4amgrY29mWW1ncHlqd2ExY0l6ZzBYZXdQRVVqOHBtbXZy?=
 =?utf-8?B?SXdMd0xsMkVBTjlLOWdoM2lHKzBIR29aQ3k2QmhqVCtwTDNOT0JNM25vOVR5?=
 =?utf-8?B?TE9QMk8zRzIzTTNjQmFiTmdlRWFDNjdmL3BDWWlybkNuNXExWDRCUWJDTGJJ?=
 =?utf-8?B?eXhCSDcwdERpbHpQVlFsTWJlWlRmNzRKbW15UWo5a1V4cWdhWnVaODR6U1Rs?=
 =?utf-8?B?U1N2c2xoakJ0alhrTXZxSTczS1dGaTlZU0FHWklDdmRCQXBwQTRDR3VwbENQ?=
 =?utf-8?B?SEVSM2ZEM25PbGdLQkl2cnBVSExKZ0JkeStKaVZURDlncVI3Z091cFlRVE80?=
 =?utf-8?B?SktjNWJMMi84NzJmVVFLc0lTZTlROXQ4OG15RjB5ZVpmSDl6YXF1OU5kQXZ2?=
 =?utf-8?B?VnFXOFpmKzljVFFiL3JRY014UERLVDByMmxYbTFSOFBzaVdHRk40RzZLeWt5?=
 =?utf-8?B?bDVYMGtuOEYzb0VQdUNkenUrUkxXYmNCRkUyZXBFcVh3aDJhYmg1VWF1Rmk4?=
 =?utf-8?B?Szg4UVAvOUlxWkM5NUlQMmVDVmlSVHFWcCtUR0duQ0pvYzB3dzlGSnVwd252?=
 =?utf-8?B?dlZiOG1QOWRDQUlETjJHU2lhbTYvYzRTcFR0T2hzTGdCMnB3alRCWmRXVXpD?=
 =?utf-8?B?YnA3NjJ1b2plNzBnMXRlTFM2QklXR2hmZDhJN0ZsM0Z6dUdoVWNSNlVSbHQy?=
 =?utf-8?B?SE4zMFBZbnI1MUtrK2dTRU1xMGVyN0JKNjlsaWJnYTkxU0o3MXdMUXc0S2Y1?=
 =?utf-8?B?SXdLclFnSWRGZzFaWVlQb1hwcUllQndQdTUvWFlYRE13bXNUK1BWWGJ2OU9o?=
 =?utf-8?B?a1R6dGk2d2dETDdvWDh2dFRWeXY1WmxoSklVUVJQamxMd21wdENiN2FkSTNi?=
 =?utf-8?B?NklJK2QyakF5K1dDTGsxakVtNXhKVHZrTWtoVVdEU0t3TGErUFhhQWswOXRU?=
 =?utf-8?B?Nlo4NjZETHc2dCtieWpSK1BOVXdsUENhcnVCN1NkRkVrUFBVZ3QwZ3J3Skk3?=
 =?utf-8?B?cVZKWmUvdHF0SWwwaW9lTzROT2tqYWI3T0xXWW9iaWpYWk1KYWdsY1RNUTNM?=
 =?utf-8?B?V1NZYW5MQVVHZTVaWk4rODlOQUk0UnZVRmQyWldEWDRPOGcyeUFVR2c4VUlq?=
 =?utf-8?B?bWVYQi9WR0RRVFRDN0RlSTF1U01aTThUWG84eGx6WE45ZmdLU09RZFVkaUt0?=
 =?utf-8?B?OE5NalRrTVIzY3Vqei8vcVllN0w1ZEVxTkRVVGVxVGdXQ3RnWDlQNkplU0tV?=
 =?utf-8?B?UUZtOHBoQVIrbDcrQW1ORGdwZzk0S0tSc1dETnZEQ1B6YjhpbE94OVlHUVZZ?=
 =?utf-8?Q?GYjs=3D?=
X-OriginatorOrg: exertus.fi
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa321b1-f30b-4286-66a0-08ddef7b1cc8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB6411.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:30:20.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ff5ff20-bcb9-4615-b2a6-3bbeefd7b8e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EgXGbvFpjqWX7dSYWD9RrpoPNAn6hf65GQaGWjw/J/P0teRobgo5uqb1AoItOgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7952

Hi,

We have successfully used ofono with Quectel EG25-G modem in our iMX6
Arm system. But now things break due to BuildRoot upgrade which upgrades
ofono from 2.2 to 2.18. I have pinpointed the problem to commit
281b49763818, "gobi: ensure Set Data Format changes were applied".
ofonod gives an error:

> Setting Data Format had no effect

list-modems shows:

> [ /gobi_0 ]
>     Online = 0
>     Powered = 0
>     Lockdown = 0
>     Emergency = 0
>     SystemPath = /sys/devices/soc0/soc/2100000.aips-bus/2184200.usb/ci_hdrc.1/usb2/2-1
>     Interfaces = 
>     Features = 
>     Type = hardware
>     Capabilities = dbus.Array([dbus.String('lte')], signature=dbus.Signature('s'), variant_level=1)

If I ignore the error by hacking plugins/gobi.c:

>  		ofono_error("Setting Data Format had no effect");
> +		goto done;
>  	}

list-modems shows expected info again:

> [ /quectelqmi_0 ]
>     Online = 0
>     Powered = 1
>     Lockdown = 0
>     Emergency = 0
>     Manufacturer = QUALCOMM INCORPORATED
>     Model = QUECTEL Mobile Broadband Module
>     Revision = EG25GGBR07A08M2G
> ...

I have no idea if there is other harmful side effects.

How this should be fixed properly? Any ideas?

-- 
Freedom To Create Together.

+------------------------------------------------+
| Timo Ketola            | Exertus Oy            |
| Specialist,            | Kampusranta 9C        |
|       FW & Electronics | 60320 Seinäjoki       |
| +358 40 5311 244       | Finland               |
| timo.ketola@exertus.fi | http://www.exertus.fi |
+------------------------+-----------------------+
| /"\                                            |
| \ / ASCII RIBBON CAMPAIGN AGAINST HTML MAIL    |
|  X  http://www.asciiribbon.org/                |
| / \                                            |
+------------------------------------------------+

