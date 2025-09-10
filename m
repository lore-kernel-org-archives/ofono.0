Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023112.outbound.protection.outlook.com [40.107.162.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A5317718
	for <ofono@lists.linux.dev>; Wed, 10 Sep 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501963; cv=fail; b=PN6buHYslIlqZAhoO2a9M2JkzXNG/W4EZMcJLeVmmeEMuq+Vh45SROZ92vC1LWuEZ/c8771XqLt4dm6RrPnnI+rr1m3m0wU5w82NZWRTgscyfQEzG7KZyizA7WThWo1U1MO6++SEPZM5LnvSYcPjspkZWSVn0RYCIaTL5g+airs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501963; c=relaxed/simple;
	bh=F4Z9yz/m0OJMMqwJsvn6oICAVxLUi1ItR+NNnPq/NXU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QiaO4wv7AWFP2DS+Ydv9QppOcbEJ+ni9ci+1UE+zNVS9t21xnLMxgh0Ngx+mzvMVkqWAY5tUASc58dMy1m5UGoIRqEL/PepcrVMdnd0dI9pLYZnuF7QOJuj7e7GgVQIAe5lP3UV+1kMK1m7XfDwpeoDlZ56+cvx6EmMk4pYsBv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi; spf=pass smtp.mailfrom=exertus.fi; dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b=OMhGJ0IF; arc=fail smtp.client-ip=40.107.162.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=exertus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exertus.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exertus.fi header.i=@exertus.fi header.b="OMhGJ0IF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9Q0y5a6o4KjB/eywQkhkMs56t9aL17UHZ1ePk6mqt2pk0Ff0Cw39KP08byw2F8pTWh4Cnev/o7UrLmK6lutxmCArgdo2KvgBUPb87mEpn17BdEaXV4RvSKasO00WOpoigG0v3NPuYq8YQXG23GORmrsBv7KqCJLDvK+Yefyx+EyQBUo+gl/4QxRGsyBIjtz8oE0E/xcvDcX1FmOYIPC315D9l0AElWS1YgvjZ8Qwm8zxWvu0oqiJTWc94rRRNSH9wK/2MWACuAlvpsyewa7tzlcl2M2Kc1u1nUVNZljGcfkRrfSkpTqZ/OkZSxQ2vyXCJst4KDJ3YhaPGU8tgcijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhWww9EzCIur2/AJhEQaACM60rLt9CLQt/YoZ7k0w1M=;
 b=J7crmsd9mn3hDWLwEyt1HVhtiti0B8XH3kY+wNEB4lthfXxIUCi2rO72iAtqSofCsMxYwej+Ez3AsEY+5fbAXl9BO6BXmAOeLFJc7KdZfPybzWvDScW7KEshtN9gq4UmVQu9g8baHbCsifJkmiStRh/UgW0ANmrKpo+w0ZmsF9LYL1l68BlrzrOZhPiASK+eEShmtX6iUOWuBdsiu9K2iJfEVJBRF7rBUPEOZnA2AHG/c+MzpAXR0ndV2iz1VdOXkZ4ibDQpSpdXbdMD+oJnKjlNogyCbR6n+RiMacA4v5coGeo9pK4GqnJjKNb/Kcukm62blm7jM31ZNhhpR2SQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exertus.fi; dmarc=pass action=none header.from=exertus.fi;
 dkim=pass header.d=exertus.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exertus.fi;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhWww9EzCIur2/AJhEQaACM60rLt9CLQt/YoZ7k0w1M=;
 b=OMhGJ0IF6HFyax6zkWBOxgw9zy0eDH56PCNSQI4xDO8H93EpBMCeJTbLH1gNqMTvPOKwFnqvH2WeJvzSVddSeLhW27gsGePOwfbvqw0UgrNkcIrrO9vxZCqqLHP1Cw2C7WfHQqopHpKg3ElRB95Oxa44UQGQPf17IIIATgGOaWItpR/DTdgwWLlOEtikcW0YBfFr5VtkHYJFZD7Cs8u3+/PY2E3bpWZLDVc0v41KY+yAwleiim0GR+WDU+0AHODrL9GLiCusVgbncTIqj4tLr4Mviyf5H7qJT1lke2bQdcEOGPHwHTPrSQK2XQTaHKCZFqPyc0/VzyfsNsiCRr3A7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exertus.fi;
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com (2603:10a6:102:308::8)
 by DB9PR09MB6791.eurprd09.prod.outlook.com (2603:10a6:10:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:59:14 +0000
Received: from PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73]) by PAVPR09MB6402.eurprd09.prod.outlook.com
 ([fe80::f210:382:c71b:ba73%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 10:59:13 +0000
Message-ID: <e400c04f-1550-4263-9f21-ce1476e12c80@exertus.fi>
Date: Wed, 10 Sep 2025 13:59:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Quectel modem ceases working
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <3be9ef7c-fb1b-4caa-802b-93f02eaad1d6@exertus.fi>
 <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
Content-Language: en-US
From: Timo Ketola <timo.ketola@exertus.fi>
In-Reply-To: <e87a92d3-3e5b-4e5c-aab7-2310697b9fa7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0401CA0097.eurprd04.prod.outlook.com
 (2603:10a6:7:54::26) To PAVPR09MB6402.eurprd09.prod.outlook.com
 (2603:10a6:102:308::8)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR09MB6402:EE_|DB9PR09MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 05223f5d-b895-4f61-988f-08ddf05913c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTRxc3JjdzFpN2o5eEM2anNUaS9naGZVeFZKdllKNjlSV0tER1JNeHlHd2tF?=
 =?utf-8?B?cTFsb1E0aTYrWnBoLy9DQXArZk5CcEs3cXpxVlI2R2hFRWFlSFk1YkE1NnNj?=
 =?utf-8?B?Nk9OUWRsWmF6WU42aXVjUFFzY205dWd2SnNjTWgwa1Y4L1k2VnJVcjZuUFZE?=
 =?utf-8?B?VE0raFhhTE03T01uazBxaFJUVjNUZmRack9oWHFZSEJMbEtWemxZdktRMHF3?=
 =?utf-8?B?YUNRby9BNGtrWkc1dnJlNko2dUNLVnVNUmdnWnY3bmVIMW9LbWxlWUdKRXJV?=
 =?utf-8?B?N2hhdXBzWHNPYXdNZXhETzlWdUxNS3hHNysyUU83RlcwZlBZOS9EZ0Zjd0Rl?=
 =?utf-8?B?RFZabDRwWk9jK2pyRFRGQ05kcm5aMTFtUC9nL0lUYlRtOEZuQ2Q4NkU2VG9Y?=
 =?utf-8?B?RWJmTW1CUDI0dGJjb0hNM01LVXFVeDhGeXJDWG16R012TzYzLzY1RktsTzBj?=
 =?utf-8?B?NGdJRlExUndIaVZPd0lmTXZlbmpXOHphQWdPWDlzRFpzQVFWYWJzR21sZnFZ?=
 =?utf-8?B?TEM1aDhpNzlvclZNa0R5TE0xSDZoY00vekdzUy9NbnEyeGlsbVVWY1RWTzFX?=
 =?utf-8?B?VTJ5K3hNTmx2TjFCc0VadnNvdmRVdGJNZ3Y0QU5VOENva29VUlI1S2V6YmZG?=
 =?utf-8?B?cGp3YnIwZXpRSDFQbXdRRzFlYUpxRHlmNE9HbHpZU0VpcVE2K0RIMkFNS3VF?=
 =?utf-8?B?WU9qUk9jTUVKS01XbDBBdzlLY2dsVGNBczljL1JQU0VpNHVscDJ3VGZScUt0?=
 =?utf-8?B?eWt3WDZKMVJaSHcxL3A5N08zbjdwSjlUMDh2RGtRWmVYR2VpTnRrOEFqRUZw?=
 =?utf-8?B?N3ZSM01QTDN2R3VpM3hMMmtGWTdWTjZjQ3lHa0hIRTlIaWFwQlk3K0VrRzBz?=
 =?utf-8?B?T3h3QWYrVm54eWpMbmZsdVdEbUNtUnNwSHJyUWh2U3dqenlsdFNsbjdNa2Jz?=
 =?utf-8?B?OEZBVHRkaEdTejFiVzZVbTBSSG5laHZBTTNPOVF2R2l3WmhVbGJxRldmbWtL?=
 =?utf-8?B?VW5PTmc1VmRRMUdLZWNqSnA4NGhlQXhyWHNQd3hmSGpjSllaRzZKakt0Ulgz?=
 =?utf-8?B?N1h5eGVUdUk5ZlI3NlRYcTdLeE5EY0V1dkJrTERQMnk4V1RCbzRrWndmUmtQ?=
 =?utf-8?B?eWc0Skl5NVB4TDdIT2ljNUlrYThuQ0x0MnUvV3NwbE9KMjVYZlRYR2ErTkN1?=
 =?utf-8?B?R3RPQ3JRVVgwTzdHOExhcmF0a0czVjQ1VTVrRldKOVNzKzNxU2RKaFVaVnpL?=
 =?utf-8?B?cndnalFyRFRhb2l2SE5HMHdZRHB0YXFidmY0K1JzVVZpNGNRcHI3SUxzY0Zo?=
 =?utf-8?B?OWFHY3pGRDVTS1NlSW9MdGVlZEo1Vlc5bzI5TU1RV0Y3U3dFWEg4cUdQOTQ3?=
 =?utf-8?B?SFp3a0c0ZVdRbHpEeDR6LzVlTkUzUCtaZHBiR0NMR0VRV1hMeG53VFpRVk1Q?=
 =?utf-8?B?WkNLVGFIS2dWN2ZqU2JjNEJwY1ZiOVpJZTdDQUtRQ0pYWXUzUmpOOGtvRWVh?=
 =?utf-8?B?SHBpY0Q4T01lVTNXNHhHNFRFUDhrOGQxMHcwSEp0OFNuZzIxVnlUVmF0WDlT?=
 =?utf-8?B?UDNENEw0SHdVUm5hb3hXYUtSOXhHWU1FRUtXbkpFTkVNUGZIOTk2d0N4YUF0?=
 =?utf-8?B?bDU4SHlsU08zMkRkR1VYR1J2a0EySDFjZmZWbUEvYjlVUVdyVUw3bkxVOGdq?=
 =?utf-8?B?SHo5T2RiUldMYkthM3pQV0lUK2ZFL0l4ajhJc2JkSktQZXFGMDFCTWd1YmpE?=
 =?utf-8?B?OEtaTGI2aHJTT01tRkhWbForak9NMCtsSUpJWC9BRUVOdlJ3Y1pmc2pKa1NX?=
 =?utf-8?B?c0tZVDJlOFJBbFhOWU5MSG1zSWhlNmhPeWFlOGRHMDZVRExsMFQyeUpKNmRE?=
 =?utf-8?B?WkNqMGVQOFpLNzYvditaWS9seFY0TFRWUEVoRm02bWx0TGpPK2MxcUZyU1JD?=
 =?utf-8?Q?pjOxwoxUeic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR09MB6402.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkRKaFNORGVPa1R2d3pKZ1pHSWlQV3oyT2NVN0tBejVOVVNobzBPQ1BmTTk2?=
 =?utf-8?B?MkdScjFKK2ZPWHpIVDdjTTBYa1dSSmpmcG5ud1Q5UjN4cjBMVVFtWVZGVVQy?=
 =?utf-8?B?aWhDUFJWYWg4V1lvNEZURC8zbm84WEdkbng1WWs0cjZXS2RUYU1USitOc0RU?=
 =?utf-8?B?Uy8wMzJITWtSbXh1VGJjUWc1RTNUMWZKZ3pteFR3V1dOeFJoSnRMQ1ZteS9O?=
 =?utf-8?B?ak1pcEhSbVdlL2I5aHlzQzg1NjNYdVdCM2FzdDg3STB2SnlQQzRaTEZFWlhs?=
 =?utf-8?B?c1luQy91YkxJQ0d3Rk5jcmpHZXowY3pPRkp4bE1IeGhKT2xqVGxwSHUvL1dN?=
 =?utf-8?B?MTlxZG5OVXJVVWtiY3lpOE1jMVQ2d24xaHU1WnNqRDZMS3hFVm5EWG94b1NV?=
 =?utf-8?B?UnJKTXVtUTQ4MDI3SUZJbzdIS0FET3p5M2VhbXlkVk9ISk5selhxVEwwZkIz?=
 =?utf-8?B?V1J3OGQ5RUJodVBGNVdkdlIxeE5xMXRzdVNXNzQ2ZDhQWnlKSEtZVUJSWWNT?=
 =?utf-8?B?b3p0eFhzeVp4NWV5bTdnMitQK0VFeW5oSzcxOUxiLzRZRWZFQU9lL3NvR3Ba?=
 =?utf-8?B?L3lReGJTMUwrT2dJY1B6cndYd2tHSzdQVFp6bFk0SldzdWpUTHBEZzh4TjdI?=
 =?utf-8?B?cUpibFJvYkhqV2pNV1EzcU52Y1NHay82YzdXWTNmZHpXSktuaUkybzZYME52?=
 =?utf-8?B?L2g5bFlBMmJiWmxQODJJd2kvYUMyckx3emt2cStpdUw3aTRCU3IvMkdxTW1s?=
 =?utf-8?B?UGc5cjZvMUhCUGxUY3NXVmxTNjVRVjh2cndJV01aczdrTjJINHdsOVpnTG1q?=
 =?utf-8?B?Q2VOMTdkOElCMDN2eGEvUEVlNjFmZm1jbHFweXRDMFNhUTFRUUljRSs5ZHhN?=
 =?utf-8?B?VzFHQmRxVm0wSlFLbFg2TVZ3N2R6a3JRbktHWWU3TnJ1Si9TQU9DRVZmSmdm?=
 =?utf-8?B?elNTNHJMUUFseHlDSGdTRzZMcnB0SjhNVlhjRW9OM29XWFBKeHNuWk5yQXlx?=
 =?utf-8?B?VmM2MDRvNFFRVTZQVmhLU0NzS3dsbUJRMEhLLzBMaHpuSnB4MisrTU1JL0lQ?=
 =?utf-8?B?SjhwS0VQelRqOFJBVUN6MXdmYkwwQ1djZVJEWGtWMnJFNzVVRTluZkwrQUhF?=
 =?utf-8?B?eVBLY1ovRVl2NFJib0NGMXFVQkdMRXRzdTgzMnRQbHhKOXFSaHhLVTRUSGpM?=
 =?utf-8?B?clJhNUV1aThLY0ZraDdvU1NRazN5c2QxSlQ1NVdLRDdtdGlmQVNGMUtRZCtn?=
 =?utf-8?B?ODYvbjJtWElrOGRFVUtub25QQmpMTWpwTHkxdVNUd05MMkhKZzFqSXUrdE1h?=
 =?utf-8?B?dXZ3a0VnZGJva08rNzc0OWRQRml1THFrL1orNGJ4c1dOWnVoV3FVejJ1TWs5?=
 =?utf-8?B?UHA4MFcxa0ZKRTVIV01KOUVzVllWSVFRbiszZUd3OCtGMEE0akJSTTdzSXBw?=
 =?utf-8?B?M0sxcWdjWUh2NGVHbWpjWDNjZFRIcHpWSTl5STJGUkRlNk8wa1JsR0Y3cU9N?=
 =?utf-8?B?dmhHUFdodmwwU2tvK2xQd3FqVVBZSEhsT0h5U2NyOERHdEw2RG53R2RHb2dX?=
 =?utf-8?B?c0dqb3pIQUkxclJvS2tVc1JRYysvTUZqWG1GZm02b0VhU1crZXdKcENrc1g5?=
 =?utf-8?B?WnVMdGxyL25UNFNHUEg5MXF4N0JXR0tTcDhsMjZ2UTJ0M1h0Y0NGenlFUHFT?=
 =?utf-8?B?NmRXU29wQzI5ZW8yaGhvNFJPWHYvcjNGd2hYNHBNRiszaVpXVkhVd25GMlhT?=
 =?utf-8?B?SFhhazlzOVR5ZEZEdzB6c1JZcmdHOVlCK1NKL0RmWHlzUUJmWWFwZ2JUZ0JB?=
 =?utf-8?B?WTNEYWtSeWNNaGZmcTd0ZS8zOGRMdWwwS1RxUUREbHREMzlCZlg2ZHFkdWVi?=
 =?utf-8?B?SWwxUFpFRys1QkZreDZiSExSVzdRengwaWRwek1HaHp3SEJjSmJ4MDN1c3dV?=
 =?utf-8?B?QU0wekVsK0R0Nm1qZDgvTVM4UzZXWGxXYkFmdHFnd1RlaDhKN3dBVnBpRkVQ?=
 =?utf-8?B?WVF4dTlSK2o4NGlFSk9xbUR6YU5uT1Z5dnI4L3BOUEpaQ0xrczU3dTF4YlVW?=
 =?utf-8?B?dUtwbnhMV3dZRWM5U245Vkd0eFR0L2FvWWpkaVVDalloYzhZYlpGQ0xvc0Rr?=
 =?utf-8?Q?SYqQ=3D?=
X-OriginatorOrg: exertus.fi
X-MS-Exchange-CrossTenant-Network-Message-Id: 05223f5d-b895-4f61-988f-08ddf05913c6
X-MS-Exchange-CrossTenant-AuthSource: PAVPR09MB6402.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:59:13.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ff5ff20-bcb9-4615-b2a6-3bbeefd7b8e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEWj99cp0HCpFF6GMcTICYw9O5oDrV7ZfpjByKCAhW3hO2R6MvKTuVsmPfN0B7jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6791

Hi Denis,

Thanks for looking at this!

My further testing unsurprisingly shows that my hack does not really
work. list-modems looks better and the IF gets IP address but actual
traffic does not work.

On 9.9.2025 18.23, Denis Kenzior wrote:
> Can you provide a full debug log?  ofonod -n -d '*gobi*'

Sure. Working 2.12:

> # /usr/sbin/ofonod-2.12 -nd '*gobi*'
> ofonod-2.12[588]: oFono version 2.12
> src/main.c:main() Using configuration directory: /etc/ofono
> ofonod-2.12[588]: plugins/gobi.c:gobi_probe() 0x19bd18
> ofonod-2.12[588]: plugins/gobi.c:gobi_probe() net: wwan0[qmi_wwan](5) usb
> ofonod-2.12[588]: plugins/gobi.c:gobi_enable() 0x19bd18
> ofonod-2.12[588]: plugins/gobi.c:init_powered_down_cb() error: 0
> ofonod-2.12[588]: plugins/gobi.c:discover_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 3
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 5
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 9
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 11
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() 
> ofonod-2.12[588]: plugins/gobi.c:request_service_cb() All services requested, pr
> oceeding to create WDA
> ofonod-2.12[588]: plugins/gobi.c:create_wda_cb() 
> ofonod-2.12[588]: plugins/gobi.c:get_data_format_cb() 
> ofonod-2.12[588]: plugins/gobi.c:setup_qmi_wwan() raw_ip: Y, want: Y
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() 
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() service capabilities 4
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() sim supported 2
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() radio = 4
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() radio = 5
> ofonod-2.12[588]: plugins/gobi.c:get_caps_cb() radio = 8
> ofonod-2.12[588]: plugins/gobi.c:get_oper_mode_cb() 
> ofonod-2.12[588]: plugins/gobi.c:gobi_pre_sim() 0x19bd18
> ofonod-2.12[588]: Requested file structure differs from SIM: 6fb7
> ofonod-2.12[588]: plugins/gobi.c:gobi_post_sim() 0x19bd18
> ofonod-2.12[588]: plugins/gobi.c:gobi_set_online() 0x19bd18 online using_mux: no
> ofonod-2.12[588]: plugins/gobi.c:powered_up_cb() error: 0
> ofonod-2.12[588]: plugins/gobi.c:set_online_cb() 
> ofonod-2.12[588]: plugins/gobi.c:gobi_post_online() 0x19bd18

Hacked 2.18:

> # /usr/sbin/ofonod-2.18 -nd '*gobi*'
> ofonod-2.18[601]: oFono version 2.18
> src/main.c:main() Using configuration directory: /etc/ofono
> ofonod-2.18[601]: plugins/gobi.c:gobi_probe() 0x19ff88
> ofonod-2.18[601]: plugins/gobi.c:gobi_probe() net: wwan0[qmi_wwan](5) usb
> ofonod-2.18[601]: plugins/gobi.c:gobi_enable() 0x19ff88
> ofonod-2.18[601]: plugins/gobi.c:init_powered_down_cb() error: 0
> ofonod-2.18[601]: plugins/gobi.c:init_powered_down_cb() Setting QMI_WWAN to 802.
> 3 mode
> ofonod-2.18[601]: plugins/gobi.c:discover_cb() 
> ofonod-2.18[601]: plugins/gobi.c:create_wda_cb() 
> ofonod-2.18[601]: plugins/gobi.c:set_data_format_cb() 
> ofonod-2.18[601]: Setting Data Format had no effect
> ofonod-2.18[601]: plugins/gobi.c:set_data_format_cb() Set Data Format succeeded,
>  try to set MTU...
> ofonod-2.18[601]: plugins/gobi.c:enable_set_mtu_cb() error: 0
> ofonod-2.18[601]: plugins/gobi.c:start_service_requests() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 3
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 5
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 9
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 11
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() Requesting: 1
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() 
> ofonod-2.18[601]: plugins/gobi.c:request_service_cb() All services requested, qu
> ery DMS Capabilities
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() 
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() service capabilities 4
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() sim supported 2
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() radio = 4
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() radio = 5
> ofonod-2.18[601]: plugins/gobi.c:get_caps_cb() radio = 8
> ofonod-2.18[601]: plugins/gobi.c:get_oper_mode_cb() 
> ofonod-2.18[601]: plugins/gobi.c:gobi_pre_sim() 0x19ff88
> ofonod-2.18[601]: Requested file structure differs from SIM: 6fb7
> ofonod-2.18[601]: plugins/gobi.c:gobi_post_sim() 0x19ff88
> ofonod-2.18[601]: plugins/gobi.c:gobi_set_online() 0x19ff88 online using_mux: no
> ofonod-2.18[601]: plugins/gobi.c:powered_up_cb() error: 0
> ofonod-2.18[601]: plugins/gobi.c:set_online_cb() 
> ofonod-2.18[601]: plugins/gobi.c:gobi_post_online() 0x19ff88

Pristine 2.18:

> # ./ofonod-2.18 -nd '*gobi*'
> ofonod-2.18[622]: oFono version 2.18
> src/main.c:main() Using configuration directory: /etc/ofono
> ofonod-2.18[622]: plugins/gobi.c:gobi_probe() 0x19ff88
> ofonod-2.18[622]: plugins/gobi.c:gobi_probe() net: wwan0[qmi_wwan](5) usb
> ofonod-2.18[622]: plugins/gobi.c:gobi_enable() 0x19ff88
> ofonod-2.18[622]: plugins/gobi.c:init_powered_down_cb() error: 0
> ofonod-2.18[622]: plugins/gobi.c:init_powered_down_cb() Setting QMI_WWAN to 802.
> 3 mode
> ofonod-2.18[622]: plugins/gobi.c:discover_cb() 
> ofonod-2.18[622]: plugins/gobi.c:create_wda_cb() 
> ofonod-2.18[622]: plugins/gobi.c:set_data_format_cb() 
> ofonod-2.18[622]: Setting Data Format had no effect
> ofonod-2.18[622]: plugins/gobi.c:shutdown_device() 0x19ff88
> ofonod-2.18[622]: plugins/gobi.c:shutdown_cb() 

> What kernel are you running?

5.4.78 with RT patch.

> Is the modem a USB device or directly connected to the SoC?

Quectel EG25-G MiniPCIe module with USB interface.

> Assuming it is USB and the device gets detected at /dev/cdc-wdm0,
> what does the output of: qmicli -d /dev/cdc-wdm0 --wda-get-data-
> format look like?

It fails if ofono is running but otherwise:

> # qmicli -d /dev/cdc-wdm0 --wda-get-data-format
> [/dev/cdc-wdm0] Successfully got data format
>                    QoS flow header: no
>                Link layer protocol: 'raw-ip'
>   Uplink data aggregation protocol: 'disabled'
> Downlink data aggregation protocol: 'disabled'
>                      NDP signature: '0'
> Downlink data aggregation max datagrams: '0'
> Downlink data aggregation max size: '0'

--
Timo
