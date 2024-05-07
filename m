Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5C747F
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093235; cv=fail; b=Oq0xdawgb/aY66TmCVXLUhT3OqJ0jkt7rzOVY3RtDBkk1ys+Ukmw6hCDxZiM12Tq1gosm/cbK2H8J76YpDGzuZt5JEegVDP02wJqIcEHbJ3UbH+32pktXuwmdy8lk7jy2ApW6pNkoHkIyhcNLV50k4CZ13ilI137Duw56GMk4mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093235; c=relaxed/simple;
	bh=w4aSegqtsuxEVgBKDDdF0BY8aanbpQEmjFUVjGjdDlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lrn+6IyEppIEjGssaWFDDx/iME03fL71VMpaQU7EqFqCk3miL22XpwmjZPzs94Bi4UEzA+lXiB9+5E4AiDmrhxkiQ+zugwhHjxCl43Y26P89SUsAWpHCDBLuUlFwnSLP1ORwPI/6oCL4UyScvKl+dXiv4Oi735VsHRY+U00QNyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=CsbXa3lp; arc=fail smtp.client-ip=40.107.104.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="CsbXa3lp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKv/DgGDyLNadBDXfTNPffgcCzT5T+EphSxnMDgQbl4R0UjSWrca7eLS3T87TrgywMXlzCZkfCV35xJzonsuzCgQz7yjQojHa2TBixV3mqDHQbkqkTXcBRYLFAP31cOIRvdqtCDCEjbv1f9s+NhqkeV8tfYFXH15gxHa8aCf+n+CdQr9hP8Dqbq3BLlkfoHsDihbG7YfY9t8clTR7eWnwlM7ydFOVOlv+UstOtJydM1JDtCUOhnmg92YQWSYcT4cDyLrbKADsdW9Bsy6n5+sxOVh/LVZYcc+vXl8jN26DGGgvr+6XeacbgxfYU36kQpwlDc0bneWAdn9nK+LQIA60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf2YHylOt/dBfCDK1EFWAda+vaNp7QbnR1ifleMtgYA=;
 b=OY5kFsXpcMlC8qMwqYJXRMrp5EPxDxYeIfXgERGV0+XdnXciLy6fiSkwobpx9qNsZSZsNCZ5FJMyidD5CrqsWgeN4gW2Nr+CyOA/2hXR0oM8j6pln0kayoeSPHfyYgLHjZ8jPmkinvUmSD1n8hBfdcg5dIatx+zb3NhM4nW3t3tGYGOWzxvX/yOOiMR9gP5OVEQs1Mw3FU85BLJfPTsTLYZr16+374Vwv7eE3L+pSnmC+aC4UETAo1JAzHpn7IXfgbqBv+KAVlW2K/FWAZmTxvBNBOkvvkBgv6rT9ZWAv0v1jVFGlCYUc+YG/xl+Fc42H+51AH+sV4AWHHYrxJuK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf2YHylOt/dBfCDK1EFWAda+vaNp7QbnR1ifleMtgYA=;
 b=CsbXa3lpPCGs6kuI33cC1+bpYWSdfmFKykC2Ks7r0CKBa7+c/iqKxfGz9NEzs/mPhy6S7ZBGPBKYHe61PEx3qCK8Bw/sBm9frM4qHopeRH/fhdo6pc30613zheLFUiK5oeo6JIzPFVPF+tTHzJB+h1wEaVyR6PTZbF5Wu1fZvdP4WZay14U+tm57HnHkEJwAK9VEr29WRxnae1OeIv82wgWhWOcsgnCOghKmfBpS5/Lpd3c3uWT33DSL8lx9D2j8qFmb2kUPgJertQm2NSPXKGqby/UToTniGGwX+w8RICsLU8YY5vVmd8Q9ybr2uP3EPGujTuXpylzOAvahLInU/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by AS4PR10MB6038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 14:47:09 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ad:5d06:d8b:5171]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ad:5d06:d8b:5171%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:47:09 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] atmodem: sim: when reading sim files, avoid incomplete result lines
Date: Tue,  7 May 2024 16:46:18 +0200
Message-Id: <20240507144618.33676-2-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507144618.33676-1-c.ronco@kerlink.fr>
References: <a952ae20-b8b7-4725-b3e0-848f2b635525@gmail.com>
 <20240507144618.33676-1-c.ronco@kerlink.fr>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1cd::17)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7810:EE_|AS4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6c9237-a5d1-4fef-45d8-08dc6ea4920b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6feEmLhPtI5M2fltGA/c8AOcbkdkZUv0s6k52Ft5UStlaeYkwRP6jlbK62iT?=
 =?us-ascii?Q?qjDSfdfDw9AATy/k3OoW1PSYDL4ZfTcbqwfYmwEttVyphpBKWRD/O0eWu7ZO?=
 =?us-ascii?Q?HvVBlV9p1WwTNctiIHN386w1Nt23jLXFD4noTsoXKkarFq40x8Dzv81D/slz?=
 =?us-ascii?Q?Qzn0S+HDJOj9aRYY9sMY9yBPATE4UHlDybOJ4GeFrKE0jUA4aIl7SijI9uKd?=
 =?us-ascii?Q?maM1rMobp0mLDp5/0hzaAeurmuY0J+46vEI3sw5Rlqwl/YyxiqHC0g7HcS5H?=
 =?us-ascii?Q?dQYkGwvpKvSXBynfY3lg3oUEfxb0BnRT1NFyJrJ0z+w7pdIcHnoXv1UM3bns?=
 =?us-ascii?Q?42xp3L4z5KcmIU+Z06kVzRyVFvKX/bcy3TYDiCIplYTP8tngmIKRHQHhOxTq?=
 =?us-ascii?Q?a5gfjAHvgrIE/fCykMjirRWC2rCR8GFL31SrL/GYM0DZF78Yuit6Bfz8MQM0?=
 =?us-ascii?Q?z0N/2FBM+JltwjFjL+ZrzLXlEkxywwNX44FPGh/P+xX/sSCmjWxanvAJ5hj2?=
 =?us-ascii?Q?d0ab+mhw4kwx6cu7DNq2MxT4Llz1iYk75EA76ZlFlWEC6TvT0M8FmUORXnsx?=
 =?us-ascii?Q?SbSCPNBz1Wfm5EKTgjuT4y9cHHGx91CIHj/GBLkQcUOBI6uDMXC8FOSNEeCk?=
 =?us-ascii?Q?oyHSbUuEfatCSCH1PQh8lFJAzf2OgCb+iOrhPy3v4JgVfQT9i7ikJJ1I/bmi?=
 =?us-ascii?Q?03IO8qaDJks3FK2Q6i0jK4XB3FRiCZ5Bru2/aAw96flyK+CDwfRe5HYPk0qd?=
 =?us-ascii?Q?sg9TUB1BhldqqnxUFupo5K39S0VeFjTvoy+o68VQxdIRuaBi68WCys5m7W4q?=
 =?us-ascii?Q?Fec2L+14LEREIz5FlqrUlxQSBsn2O6ra2GPHNtDhPyNloe5loTm/1UOXzb5H?=
 =?us-ascii?Q?Ud5Ut1mnf4XPkFyANsLNWECz6U5nvX7G+29Hh/0Ta8lrpUixLl1GGLj+fHso?=
 =?us-ascii?Q?9uW17C45EvWhmkXk5dIIFlUEfdx/PlUFvGPz5yIQg1lVGE3MrFK3A0DZeCKh?=
 =?us-ascii?Q?v+F+jKTRT1r45xT684IJROrpbThDXOxu8DMc3mAFTZhojQHWxz0DU8FIbDwk?=
 =?us-ascii?Q?1fyE3BGTOh3w8788Dpt/M68gNqCT5dbZ7Ob5QLY+xb5MOVqudkXacWDtthLv?=
 =?us-ascii?Q?beXJZrOrEmEwK91Y9G0ovbwdzyIB2DXXt2RiPrEyu7u/YeWgBQb3y/yuNwSz?=
 =?us-ascii?Q?dZMdFv7jUHfch5oFO60vU3KcOEFL5LVnTPzmHWDPu7yKuCbObFIGGfBXMZlO?=
 =?us-ascii?Q?vIZIeSSpF4wFEoFMGs/b7iP/CO4+KWRLwpJ0p2McKaOp4JTEXquXc+wyghzh?=
 =?us-ascii?Q?lAQHq8UorFxAN8JcFu3+pMiswuqeBNLzBLJ/saefVPRR0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqYmPP84Sg7tVv7M03xKg18FGRDqtO/ZyNmdEl/IamDimBFyNytXeOfmzLqO?=
 =?us-ascii?Q?trCDTGu5tQuQsOc0PDcMT2EDP07eN2i+s8tCMidZ+XW4SFHnjA+UX1Bk9prH?=
 =?us-ascii?Q?JmqIlWzKCUG3dVGOttvCDzX1PG3v7VyqDFsI4k8q5TpovAuKj1MgsOx0rTgy?=
 =?us-ascii?Q?FJ1+rZGL0Wgu3/4rRLstkzfyBJ85MAbAtvBpSd4NBR/tsgDHALHovO/YV2+a?=
 =?us-ascii?Q?O/SNDv9ZsdWeRh+JXQ4397MpgxnI/8MjHyzwHA9ZYZ5Deyz6CsuMWUbzrUAU?=
 =?us-ascii?Q?cfGSVR83qjc4lQRoQsBwesVCddn0C0B2MK4krkkAv9ic9Dz5ANg9SBqko5Gw?=
 =?us-ascii?Q?1gzem2Kr66g2T+aGLwUh25fW/RNWdCDWg+Ljf39sSLwVikQV4fgq21izBMjz?=
 =?us-ascii?Q?9ZWku1/OyABg0icu3yMbaluQqQHzXHQjuHVYciaDLwjHXKIwLuUCQ3z8Dz57?=
 =?us-ascii?Q?AKxKi8fvYzFpVsjDcefkqwX8klzPyVzs3NV8DeOi74ULWxdivLYpk+yy5oC5?=
 =?us-ascii?Q?957NK7kK0/1egdA66RuMvcR4T6POhKm8iHTvgMqJmOC7uAIXQHTvvsbwgpK0?=
 =?us-ascii?Q?/1uRrQ+k/wFptl5B9OaS1/yTkjE96N+CjdD0dN9FV6WsD3tBDT9urJPH3UrK?=
 =?us-ascii?Q?+AYru0JfsOqsAPPAD16cZ8NmpwouMGNLzHtkJ7d7MWT0mfF+BWsOvvs6gWhU?=
 =?us-ascii?Q?Jd9VC1LXUhOQ9DVtfFKsJHl8MRfmfoH0/dUFYOU2NGcIsmGu1/7vNaVQux87?=
 =?us-ascii?Q?efd8380H3oiwY4eBCQ9FdDITg1mf0aoxUlG0CwMdNlbaOjBJl3EtoDQMK6gW?=
 =?us-ascii?Q?fw18noxiJED3aXLAaaciw4ANF+cz6r13AovWGIZPMxmn3R9boxeYQRH6aVgr?=
 =?us-ascii?Q?lkxoo9wvzdIztORgPZjoq72K96Ida9wc6CnrETCiKBOMb5bnJ43L9fPdJNzw?=
 =?us-ascii?Q?RvqYymqD2ujXft2AKA5q4/ev4FlweqTgEkyzEnRv0jsk9zfYzBsNHOOoierg?=
 =?us-ascii?Q?m/UHKASfILa/howyOrQ/4EoEhbune/AWqxtHbIh1ua29BkfjjmOqaJnJkdEs?=
 =?us-ascii?Q?FbxB894eoptyhU163M9c7vJyo9CvQuABvAv+di/qAkwkEMKIQuM6NajAafQf?=
 =?us-ascii?Q?VPCQDEW2yT94Anq4vkzw+34uFnXv6Q2xWFWP+LMdGN7IUR1Hvk2RkYUJVAax?=
 =?us-ascii?Q?T76pao7q9Cc7YgiQu+y0PLuxZm4VuWdhkIf67seHAoPEITrLP8I4aSsXnciM?=
 =?us-ascii?Q?En06yqKj7WZQr8slKqmC0lCF+VHJ7/tp5F3mrx9ii4G6R4qx11Tg2LXT4nbY?=
 =?us-ascii?Q?/07moMt3BbeGgRZgsoA/CcVeA1P+WWERIhand1Ur/8gnlRyZ7bEeWTIyHmWE?=
 =?us-ascii?Q?WfD8nGHjZ4e3ISajdAOgn5Fh7JzoxK6Si/EEelG3e83YfmbOBtEA+KOY/6IP?=
 =?us-ascii?Q?2f5dE7G3Gxpb6XGCSVPSeID34NsuSKVVUuWbhIxGgmX9iyJPdX/7s4veV+Da?=
 =?us-ascii?Q?fF06nbmZz7OPmeuv0EhNmdp8J2n79w3GpCzTBn+Uttt+nRhaEy6bCOwlCUsj?=
 =?us-ascii?Q?3giFwe7zx3HxQN3Y3GdnIdsc8zpCckCXf+Cf6yZn?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6c9237-a5d1-4fef-45d8-08dc6ea4920b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:47:08.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4ey38iLF0+kyA1hEVyVg010Z2uU1Xq0fMoUSGU0HyqZhIWdu6/bXpWalziH/oCpTA40Jn9kOw77rtxiXKZl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6038

Modem ME310G1 sometimes add incomplete result lines to first AT+CRSM
command. Example:
AT+CRSM=192,12258
+CRSM: 0
+CRSM: 144,0,62178202412183022FE28A01058B032F06068002000A880110

OK

Parse all result lines starting with prefix until a line with at least sw1
and sw2 parameters is found.
---
 drivers/atmodem/sim.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d75a09c2..1f63090b 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -107,6 +107,7 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
 	int str;
 	unsigned char access[3];
 	unsigned char file_status;
+	gboolean result_found = FALSE;
 
 	decode_at_error(&error, g_at_result_final_response(result));
 
@@ -117,11 +118,18 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
 
 	g_at_result_iter_init(&iter, result);
 
-	if (!g_at_result_iter_next(&iter, prefix))
-		goto error;
+	/* some Telit modems sometimes return incomplete result lines */
+	/* get first result line with mandatory parameters */
+	while (g_at_result_iter_next(&iter, prefix)) {
+		if (!g_at_result_iter_next_number(&iter, &sw1))
+			continue;
+		if (!g_at_result_iter_next_number(&iter, &sw2))
+			continue;
+		result_found = TRUE;
+	}
 
-	g_at_result_iter_next_number(&iter, &sw1);
-	g_at_result_iter_next_number(&iter, &sw2);
+	if (!result_found)
+		goto error;
 
 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
 			(sw1 != 0x90 && sw1 != 0x91 && sw1 != 0x92) ||
-- 
2.25.1

