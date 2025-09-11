Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020143.outbound.protection.outlook.com [52.101.69.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B72EA73B
	for <ofono@lists.linux.dev>; Thu, 11 Sep 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594768; cv=fail; b=QW0N62Yt7XqazyyGgnVWbT6ApuTqULb0CJC6S6YGMKyxWas9I1XibLKqNq6lx1vS0ee8aocl/r3GQwM2kqiWS4AHiERulcgQWY5906qS9OhUbZVkZk2u9guhWAmkeIQ+VeVyBYBDTwe1swt7cvqpYu4qkZNac8BZ34IaO99I4K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594768; c=relaxed/simple;
	bh=ybFFunHYWDIRUAJnHKLr92LBV4UuSsyicZblLuGzb6Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCD1hJRFRktE1HPuCoFBwGKUBkn8be/KAJNxys5JcoiZHFgZcPZ83Uh0YL3gAqSGhpxPubKJPx1ihfYdOKe9WHk/6URuxtSl+XoZ1xlIStyD0snZk2cE6SJ2s7L/nXoV6SDT4KazDXyPAj7raKtjy80vd7B2841VIW9phqfjing=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi; spf=pass smtp.mailfrom=exertus.fi; dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b=F3btZvMz; arc=fail smtp.client-ip=52.101.69.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exertus.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b="F3btZvMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax9nPYpQ81fGhCYgIeUJf0tw0KieBAsSDPUikERPsNBmttYRhXfKOPMdwAuOWiAOPWIIwik74Lnt6ArXeqtHKtsl2bJICN0xneZyFNCirsN5V7zkX4uSREhv4NVXQBzE4v/dKy62664xBTkh75z+gKqGYMr+TRmQO+YjsU4nu9WU3xFzH7IdcXkCYHVq+XNA4GxsLhTiVw4ZtLS8Q94kpp/4cNjmNRfdEfjw2qWQ/FEa7L6ZKHY0Y2d/reMTvFlZ45bkyeK4/+9HkeQgeVM6PFqGkgeLVCO1omqPwqV+Aw1gbZgt/0l+yitFa6YrvUmMCMsTngP4NN0ReHKnAQVWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybFFunHYWDIRUAJnHKLr92LBV4UuSsyicZblLuGzb6Y=;
 b=dREqaRG2CMW5gWXhZ3UI24VumdsU+zTAP1/j8FMiGeF/UAmrYkaKNQDylyZnBr7bM+O16qtWKfgjhFQH27geT2FiVYEZ/7oUmaL8xjlX11GvdpmZdxh5IZq7lFer1z21QlPROhl3OeOdHa++1Dh35vH0nqsVO72Cm9a/doHrzJIovjl8d/IEHGwwOGcVDm2QL3WMNH1E5b9AalKQJ1ltmv4WTY5OEJEbt+YhETK8uFkpuWfho0lnRngCFIExfKLSH2mf+504QG+pPwPaPJ6V28UIrKgDIbAEMTLo+/w+1R35qzFLAjXoDiaaFeBGv3Mk1vROQXxNsrn4zueGV8jxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exertus.fi; dmarc=pass action=none header.from=exertus.fi;
 dkim=pass header.d=exertus.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exertus.fi;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybFFunHYWDIRUAJnHKLr92LBV4UuSsyicZblLuGzb6Y=;
 b=F3btZvMzCzgnAmC2zSXBlm9ZUdB9B0SSKbXPoL2goYeuLSDnUvWTjVAM0sxO4/I1Zy1wPVEIvzTw/2LcADTd3ZbvtMI0IseboCtrjCRbj/28YZm/mqDTRci1LwZic8/dJdAkIzoXN7HRSivJ+G3RKkFDch4+3HbyN6qBYIa7ctT5xqo9SiFiwH7OEPMRs67PDZRFQ1RhpV89rpWEXxKYNZ91BhT/EeN5KKBT6k7n1WJU1Z78ijWzcG8oQgA91wbncsR4oHnUli5iwSFphMHEhs9XiziBWMdrrQadLUCc6Ue9D8izYOq27qTLPnvwGPi1e4GCb0njqrdCS4LPV4foGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exertus.fi;
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com (2603:10a6:102:308::8)
 by AS8PR09MB5303.eurprd09.prod.outlook.com (2603:10a6:20b:374::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 12:45:59 +0000
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73]) by PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 12:45:59 +0000
Message-ID: <f5606785-6f7d-4363-93e0-39696bc30bed@exertus.fi>
Date: Thu, 11 Sep 2025 15:45:56 +0300
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
X-ClientProxiedBy: GVZP280CA0089.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::9) To PAVPR09MB6402.eurprd09.prod.outlook.com
 (2603:10a6:102:308::8)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR09MB6402:EE_|AS8PR09MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2bd470-3c04-40d9-7339-08ddf1312817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xwTXFySzRNWC9icU1YVk1obnJjdmkzNjh2ZHl0UWFOc3A1UGpaTFhENkU1?=
 =?utf-8?B?bnptVHNhdlZxL2lKWkgvNFZFTm9admdtMm1kK1Rla2ErWmhuWnVCNVdNczBF?=
 =?utf-8?B?VWNmdmlTL1lQNzVHMEFhMWFBTzlrYXlGZWZmRlB6ZDBsM0tyWWIyNXhDYWpS?=
 =?utf-8?B?aFUwL2FQSU9wbU5RRm5DV2kxc3VpUDZpY0VYdUM4Vm9HZE1XT0lmendEZ2Rj?=
 =?utf-8?B?TzhOZlphK3I0VU5jMnp6b0Q2VERlMkR6cWh4SnhDNkNTS21ocVZ1dTZvVzRZ?=
 =?utf-8?B?andGNkxGV0pKUDNTc0VFWFhRZHJsOUZWRzhBOEhrclljc0ZGZWg4Ulp5RmxJ?=
 =?utf-8?B?NHJpWjJxSmNBUFdqOVgzOUpYT0M3cytDaGcwSElXUmpuUytWV0JPMjFTTmda?=
 =?utf-8?B?ckhQdis0ejZPRzZWSzVQeWZrRWw0MTUvY0tlMi9yZFkzRFo0bFJpVHNBRUpW?=
 =?utf-8?B?dzR1d3pIUnVYS1kwOThjSmprbkM5MFZIYk5Kd0pGdGZLelQveXI5OExKQnZ4?=
 =?utf-8?B?QUFFakNOc0V5eCtkMjBpckRldlRqUDEzcFBlZ3Y0cnV4QWJsVjdUMDlDUEVK?=
 =?utf-8?B?SXE4VWYzZ1JBSGJiaTM2cVEySFFWaUdZTkFPbnBDbW5zeThXRXJDZVdiRWQ2?=
 =?utf-8?B?cE9SejdQOExEWEszQlpQVnBrQ1NPeWRUbXNsUWZqamRDYmxYd2tvSkR5SWZQ?=
 =?utf-8?B?QUhSblZHR0tZQksrRXdkSFpKWk9jM3BJM2pXOWtBRk5yN1JFWHlIMFdsUitl?=
 =?utf-8?B?R05RTHNHVWYvcEJuMFF4d2RxZVJ6cFNscHRZNzhBaDlyMlVtQXkwTlYydzRC?=
 =?utf-8?B?aWEvbHRWWHBzdjAvZnc2Q0ZOdkQ0dDF4aC9Ha0VUTThkNXEvbERtT1J4aWo0?=
 =?utf-8?B?VGFvNTdpT2F2WGlXNUkycjJxTlB2eERiam15aFBWcWI2ZGMzcDNqeVRGUzl6?=
 =?utf-8?B?WUhFcHU5bW9HQUpJTVZCZXI4SFlFMFhSSnd6dk1DYlhNMUJOcnQ5aWR4OEpF?=
 =?utf-8?B?ZWl0SzM0L2tpU0xEeXlqblhjWmYrYWkxaklHVDRoRCtiRVQzUHNIYkh2S2Uy?=
 =?utf-8?B?YmdPZFAzRDV5OG9MWDBoMlYvR3l0SmlpVnhWVXpFRFliWXVGVVY1bmdnMy9X?=
 =?utf-8?B?clc0cFFXRm16M3pVWXZyamxFbDREc2xmTE83am80RlladXVCd01hbC9pQUcz?=
 =?utf-8?B?N216Rit5ZklRK1R4VTl1OS9wRjVGVVlRaHJSMWYyQjN6V29FeUowZC81b0Jo?=
 =?utf-8?B?RTR5UE02ZUxBbDBhY3lPQzRIb21nQk00d1FyZTlVcDFZaUkyb016T2ltWDJv?=
 =?utf-8?B?NW9QbSsyZlRDOXZKRWtmSjdZbXBWbUtoNkFub0pwSVdZeEQxZ3J2Uk9vVkRQ?=
 =?utf-8?B?MHQ3VjQvTnVoVE5WMVBtR3JDNDRROEo1cmZqVGo4S0ViU0hwcDdXa2hESHN1?=
 =?utf-8?B?UkVoakVmK2RUcm84ZW52aWZHUTZmMU9XY1Z4SlhSRDUvS216eXVJcitWZ0wv?=
 =?utf-8?B?NXBxN0RSeWFUeDcvaW45TkFYeVI2TjBINjBsTnRiN0xzTGw0L2RTL1dnYUZs?=
 =?utf-8?B?b3krV3M5Z3BIMCtqUlMyTmxmY0tITERVNE5GYXdzK3BRWld3QzVNVDN0TEhs?=
 =?utf-8?B?WFMvbGJFcGJWdVBVSndCcVFuY3NaT1VjcXZSZUZhLzBRTU5HTGtCcTJ4NWcr?=
 =?utf-8?B?amxuVGFDQkxOK2ZWUXl2OHc2eHpSKzM3Rkx3RUpVb1VqeS9uYkFrMU9POXdU?=
 =?utf-8?B?WU9TTElZcWkreTFxZkwwWThCT0pjS3YrcWRKSGlxYkh4cUI2bUQzbUhybkh4?=
 =?utf-8?B?U0ptcnNwRW5BRzdTV1FiS0lSMHF4aEh5T3dHRjcxelRGeEZ6MXZoVXRyTis1?=
 =?utf-8?B?alk4WTQvajF4bUtOc0RjSU9Iekg5ZDJEUUZBMmpFMUJhUk5QWS9jN0x1dHdo?=
 =?utf-8?Q?xqAG2Xoy2xY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR09MB6402.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTh4d2FWeHM5UEtoVmJ4Rk9lanJmTll6Y3hoMk1ZTUVtbTRBNWRxZlAybVZJ?=
 =?utf-8?B?NnpmeUF5akE5bVJnNG5DT2hHNVRFZVFJaFE4UWJOVnFiVXk5RWJXV3drL2g0?=
 =?utf-8?B?NHNtV0FhZ3JpZGpGSFNkbXpVV2MvVXZjVWtvZlhFKzZEOUVwQ2loSHhRVHhU?=
 =?utf-8?B?ZjN0dWtJbUtwMHhYSDFKTU9MSDZJL2dCMTZid0xvNHlFRWpBKzRnMHJiU1l4?=
 =?utf-8?B?TGYxb3FJYzdJNVJtMEVhd1ZmYVFaY0UxUlhyUmZTYlh4bVR6Wko0ZThWd2Qz?=
 =?utf-8?B?NDQxNzR0V3hoaWEzZWNRblVFWEcvZFdKN1VMTkRHTitRVGk0azR0eW1SME84?=
 =?utf-8?B?L09CWGE0TmxWVXdMMUwwVWxMdy9pdm1udTFrL1ZSV3h0c0wzSW8yMlhhaDJj?=
 =?utf-8?B?UlRubUZZbFVpdmMwaXZVMVRXWVlpWUFFYW1rTTUzbVZQZnRKekZYSFRiZm1L?=
 =?utf-8?B?RC9lK0dpNlp3M1JRU3dvTTBFTDNlZjdCck5VT280YnhBcnhTb3BOeEhlcjdm?=
 =?utf-8?B?N1FOMkQ5NEM5bndMQ1RkaDNmbTJ4TDVwQ1JOZVd5VkkweUVFNkwvRlI5VG8v?=
 =?utf-8?B?MjVoRlhHRW5LT2QxTXFCNHhvYmJNUmhhU2p3bERwdDgvVnpHTGVBNDdSUnB1?=
 =?utf-8?B?RTNLZ1JzTGI2ZmQ3elJwZVhhMXRoeGRJbjRrUWlUM0pLOE1KQStkejZIaE9n?=
 =?utf-8?B?QWMrQkc5d21NcDNUYllFNnlodElFNGpFTk5KYWYra3k3TVRmNW5VcXhQSkNz?=
 =?utf-8?B?S2tIYTM5UGdDc0FDdDFNaENxbWhVQkgxZ0Y0eWVFcEc5dGR1MG5FMWlsNmMr?=
 =?utf-8?B?RFpMbUtkYmhOL0pHOWR6d1l4enc1UnI0c0t3K0t4UlZ6NlZ5WERWMGR5MG5h?=
 =?utf-8?B?Rnhlc2FaUXlrRkxZTTR1dkRJcWp1b0ZEejVhMzhxeXBxRWhsZThpcVpGUUFW?=
 =?utf-8?B?V3RKSVhnMHhNdVFUV3E3eUtyM3lpL0g1bzliemsxckt6cFB2NXdDTktyK2E2?=
 =?utf-8?B?MGhYdk15ejJLQUYwWmR5b0pIdmVIdVBUOS9QOGRkUGVzeXlkRkc1SnM0SGta?=
 =?utf-8?B?Skk0Z2g0SDd0M1I0bG84WEFNTUZIcnN4emdydUMxK0QyNW9Cc05OS1VhbDVu?=
 =?utf-8?B?OHBGakhEY204dzVWM1NrVm5WMkxlTzBGYndKVWhoN2V6bjlZbDJiZkVvRTNi?=
 =?utf-8?B?bi96c2Y0WE9GYlRmaTZZaU5NZTZPbGNIUEhZM3p3YW9wNnl2R1lUQmhvUXIv?=
 =?utf-8?B?MzVwWVhkeU5sUnBOYjcxL0JJVHMvcExLcHVhVjM1OTZ4akdKTWp6RXNjTU1i?=
 =?utf-8?B?SFlBd1F3bEJUQzUzblV3U1ZCb1hVMGMrMlpXeHI1RDZoN1EvQXB5Y05OYXAr?=
 =?utf-8?B?eGwySnF6WVNXNDJLSFhlQjZrVWVQOHJvT0JPcHRSTTdJY0hTT3JMWE1ORFJD?=
 =?utf-8?B?QzBBUWF6RVRqMkNUa2dHVWp4UGNSa05Nb2F4ckxFMU82ZWNMQ2l5RTdDY05n?=
 =?utf-8?B?eDlJV0h0T2ZQWHR2N0N2MzZCOTIyNnNJVHI4ODh1aHI3NzBoRXQwWVI4VTVI?=
 =?utf-8?B?OTdKRWczN1BpZy9pYy91RDI5SGFCNjF0QUFRdWw2UTRRUFg3OHZidHlGUGRK?=
 =?utf-8?B?SVhrdEh0NTVldjVxaHhNZXcyellNRFNXTEtlY3dXbUV0alVGa2RPNG92blFV?=
 =?utf-8?B?TU13bHltMzNwcEpTeUZBT0k2YlNZdE8zcGpTRXlNS21UYng1TkZ0UlFnSitK?=
 =?utf-8?B?dUg3TFpsRkJ3dDlUTE52d1E5YzJUOXA0bXZYcjI4UTUxbS9rVW9GekpOWlpZ?=
 =?utf-8?B?UExEcXlFMk9aUzZSYkVsUFA5NFpOZmc4aTlRbDVxclRRT1V5V0xFT0d2cTFZ?=
 =?utf-8?B?b0R5OU02WjRRSGVib2JtTGwyVXBFRzJpdSszWjhRd2x3dGdSdjFGL2JuVHBP?=
 =?utf-8?B?NFQ4emltN2dweHBzRHJUMlVmMjZmMEg4Z1Y3T0J1QS9CeVFNR0ZmVGNkUHIy?=
 =?utf-8?B?UG9iZ3BQT01QTlhiNmNES0NqVEltRm1MNlhmWC9XWmExVW84NzQxK0VSSnFs?=
 =?utf-8?B?UllHdVFqT29RWHFQczdVU0ZndDZzVlRnU0NrV1ZsRXR3azNGcUpQMG1ibUkz?=
 =?utf-8?Q?Ap2I=3D?=
X-OriginatorOrg: exertus.fi
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2bd470-3c04-40d9-7339-08ddf1312817
X-MS-Exchange-CrossTenant-AuthSource: PAVPR09MB6402.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 12:45:58.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ff5ff20-bcb9-4615-b2a6-3bbeefd7b8e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tlg5o2BFmVyN6eS3GUzgYBsdB/Zbhrg3mad6Z/c/Hr7zWahpfS0k1ObnWU6uO1g0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5303

Hi Denis,

On 10.9.2025 18.31, Denis Kenzior wrote:
> You can try the following patch though and see if things work again.

Yes, it works! Thanks a lot!

Regarding longer term upgrade path, I'm completely on FM-broadcast-band
(finnish idiom). Is it Qualcomm/Quectel FW or qmiwwan Linux driver that
is the ultimate culprit here? Or is this modem completely deteriorating
out of support?

--

Timo
