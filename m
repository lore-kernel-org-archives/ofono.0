Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF154FAC
	for <ofono@lists.linux.dev>; Thu, 28 Mar 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613579; cv=fail; b=g6eNNJrxGds9+V3jvDNvKme9AkewOF59YC+GGq9f1defqMznY0El6BS1MxzmP3pWSRIWIuUxs7Nr/r9ivHtfvdiati4ClLZ1W0MHw22FQGjr/9WIoHtUYrJ9B4xPDdRQj+neEdrdXGA8MDoHf3CpHj+VMdvRKlimKpO5uk8YWhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613579; c=relaxed/simple;
	bh=//RS0geRk4/BOFXUN8r2CpcxBTsnlHl4h0OweVOWFi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHQk5VgOgxB9+QBRRM6iAlmcL0Z+bDjiYDmhYxeS325kiymaK6G61aUvh1qOrH4gsnRhS2+KHjdO2LHgvMOZnY9EfMT+QOcWW0HTMHwO4+4YfLk2Vc17gkNL6pnMcXbeg0jDpOspR8SS2uiV7LvxiTr5eBSEVFr1PhGr7KGlWZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=IImPGC+i; arc=fail smtp.client-ip=40.107.105.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="IImPGC+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6aL8X9BL0BRP7+ZBGSeqlaEtaR78ls5woh9bAS8VbkzXFDgMaoJjrhzICKm59d96Zi+KLfnQrxKRGYuudJyzqaV1x4V6An0nBadLDFTuldEw36eLQRADySJXVKYYi9GcO6ZVnNSW44K0YxIWKYs5/QG7b9vALN0GBAxs4D77nWt4Qi3goZzIcZKVxS6tqLnD8D/TLOJ5iKj/YLfcLZOeiAZvgyuny8y5r9tdVdZggMA9+XfN7FgjWhQeo6ctQdFc16gC1z/CrvCw6ztbfIJIvMhsS4eX4edQuUwO/chUhEeAQP2cJ0cKBKDWhYc9qfFr1DlaaCNOzt2lFDi2mdy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPTP6hv0SiveiXwn70OAayljJc+VuxQI0xlj+KPav7w=;
 b=kFWuXHLHVfFc7ZZTX1j2svtSjsWGRG8tUPK4dydHXi9UFFTEzqUsHcIoakHQqMh7pHRU6CR3+cTngieSzqKvMgOloFgGs4JKffxYnnlOOf06rCfd5J+5yhqDh1XgRyuMCjxotbU3GxPBpjltCoi0hmeyxdIfpJMuoQ96QY59m3KKRi5+wJb02JMGx/0uw1Q9FZgnPtMfyGmUijeZTCYglQo2fRpP/1U+8DYHNtG9nQn87wrWpxIgd46fE7/+YwIYccBt/T19LpzO6Y+RlTau68bPLvFw8c2eybV8KL9KTCk1UiSPoZDROFNGjrEHiwIRgtswVEnwcFFaoHPEJOt0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPTP6hv0SiveiXwn70OAayljJc+VuxQI0xlj+KPav7w=;
 b=IImPGC+irEOPiLie582bX4s3V/aQJmEyjqj0CZrndetx3opjIfNh5v53k47imIPmio5roh+lWuSUUgH3k7zJ6EL/bmGETyA7hl54kkSN348E2vrIIBtJ6a7ns900LR7QgBqffnVOOKzakFK0KHzeNwXzJNHKkuAZMVERAm+BI02Bj6X/GNZdWJBwjD7VAczhMHQ3RCQuK8bLLha3pZ8W8W8y56zn5MXc13A7cactWvMNVARuC2F2L/S0g34oFJtNiQOhWBK4vE5s4z/iThBypVSgs76bqoa3U6WMChN72LjCPgjfv8zXYG06Cze6znKgl4jxRJ/eaCPqoQDRKSJWAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by DB8PR10MB3193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 08:12:52 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:12:52 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] atmodem: sim: when reading sim files, avoid incomplete result lines
Date: Thu, 28 Mar 2024 09:11:57 +0100
Message-Id: <20240328081157.4586-2-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328081157.4586-1-c.ronco@kerlink.fr>
References: <20240328081157.4586-1-c.ronco@kerlink.fr>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::25) To VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1cd::17)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7810:EE_|DB8PR10MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: b67359a0-4967-44bb-26d0-08dc4efedcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GII13jNS8yCoLaL7CZ2fFx3FFK3mOkPouDQmqLJOpHDEMksFevuNEoLoEMZVugR5yZE74/fB4k8cynwXAvTN26riK/1DXFHOMp/8NLoWdS0EBfNT5DebrIoNqZDSVZjxbV3bB0JiGfgPBqgEwbDbdBEgJAEqtmPsSHPRi1ukl2fKjpeeO5qf/iHqHoh7qnw/xeqi9IyYiCeDtoa5P85U+RtLB2fzDGU5kb2XcV/snx+4+xxa+A0nvRLiAzW9f9wY1Mo3IOcYHYGBWpzXAK2otL8YrlMEokRtwjg+EiDQF7wAX0QRhSXUKGN8CD2+PKdei4ZGz/lLN+BpOf0vRui9lx+db3GyQn3WF0VcVcsS9fGI2ZYP0SrkJNEC1Q4/LItmkg1W6CBYNLXs96r9hM03/+AfFxU0LznZr9Zt/8sgFU/X3PbfIFtJvqO0YkqU28P0XfJmXz6nq9eEnqjcfNOVcU/qSbexnz6V+zOtYDrEUgG6d5uGPFKvgiFqIO76xX/wl87zl7GWCien0EanzioVIU6ElpHcKsAR25ADUvidgpPxScV7t8/0xugCimqiWKCXaTZCfdT8jIbIxC3cxjoXTJgnO84IPwtzDBAMhZOSK1d1PBwfbgftQZclvrDRRZu+OAznQAWalQJCE5rywZImSZrcPdGcgv0hWaGvwfCv7/roihGpBV1+Y3tmmJTcPgtMhjA37Qi/YwgcDhyP/iZ98HEtowazcCu2xylaIgTlQng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEf13MpjJLgbYfU2TjnBgIHFHp74Gxxm0yyq4QyiXyfX/O/HeklJ9qCOXQLX?=
 =?us-ascii?Q?jhhnaHxhXdR5WqKufigWPhs0PnyovCqvh/b4PX3fpu6jCum1XGx+DJcFVq/L?=
 =?us-ascii?Q?txmRTTGne+qCdtS32LPx1sUtQbaDmQ0yX6827ZEO8BfjN1K0M9lYy06WQv//?=
 =?us-ascii?Q?YbaFO4249n3NC8MXv5R+QNkHfWX3fiKCc6GLA0SLOJcIZhTlWVtzhYv2CJ1Z?=
 =?us-ascii?Q?aYzSuwSpRhzHCtb3nAN8NwJFSXj5ddRLZYsBJ7A9DKOx93mqyQsyZPBhfdng?=
 =?us-ascii?Q?Nf43Vgm3JZyqrb63mwEj2vyUVldcJRK9q1QvMV7Fptak5yD374pwu88yLWBd?=
 =?us-ascii?Q?yhsvjiVe8LbrGF2FJ3TuidGUBXSfhMzUZNesp1goFI2/2Xpmc4CG0LTTFqH9?=
 =?us-ascii?Q?Cgy1hC0xnOjT0ts1P7Hy1tXqJ0EoUQ/lO4pYbZEJ0mlFozkVHTJhdvHY8zxj?=
 =?us-ascii?Q?cjpAawKA4bPBX/AYM4yZXVL6pn9ExYXdkvKtaAkMpaCltS11HFUDWieIBZgD?=
 =?us-ascii?Q?rVSq+fkfFfYNUt2rltRpwSP4f3ErguoIiXXk92acxVH34thdV/3Umk8q8up0?=
 =?us-ascii?Q?M3WQR5LEwHXta+JBjALU2imbadJWyUOw9919tBzMQwarSdq+ncFANwmPpKVT?=
 =?us-ascii?Q?oA43UVgV6x0wS++PPAUIA5TeTY1vKhPGSXr9rfs3bAckI45CWMnyr4uwRKMb?=
 =?us-ascii?Q?f0cmGBDHI8S1oqMNqJ/GU9I5NuhF7S1bXpncGeqVwkIl0fZeQXMtQphIk66T?=
 =?us-ascii?Q?xSW4iPAO3Lr4LVQb9u1YYFqsnzYRexXXEU09fgPoRzG/eKW4XkvmWGsn5P/G?=
 =?us-ascii?Q?ao2nQMyQgSdkGDGXp4FIPBY6JA6s5m4ybXCbQLTcBxlhvTNDTCZCgVH9Hofe?=
 =?us-ascii?Q?IrbmmHnkbuRx0cB4fOMJRzeeeu4xJBf2xTKKJHHT2bLhTCSUoX8Lh1Os9/xM?=
 =?us-ascii?Q?NhQRMSLc5tTdez9yMNPiusD7QVDwb2ee9gdGYTi75Zef0dbZSoLW4nWv4rmf?=
 =?us-ascii?Q?b+CqfnMy2vE3yKTKRLqEDpohMbkG8JKCL5odOCchf46ZKSF1Sl3f1Nz2HXNW?=
 =?us-ascii?Q?+aXIisGiJAh1TJh8US9sb1P0y9W1pSU0kAyvC3CFzudzb3K3Radysw3k7c0L?=
 =?us-ascii?Q?lCWHYXx3H935kmQER8aHl/4RaUA3wT0ONfpOeXam4TMokC+XlRkma9429srj?=
 =?us-ascii?Q?0ICb4FptlTE9PVCRswIGgPrD1JETUPUh50iuwQPv0CWrgfAuYHXrXrZgmTiY?=
 =?us-ascii?Q?5X1FduPEDgU9XS/Jx7BsqOJXYy/PaMhR9+Hb+dXuaiY4EhcKpHd66aq8eKrf?=
 =?us-ascii?Q?e04bbJ9YJ8wBT7g/CDRIeOYExMYsgEuu2c1EExl3HaL8rsYqHxebQ9AdPVSw?=
 =?us-ascii?Q?v5Xs0X4Z9/c8DmjPL9e3QLQY6d4bbEhXrfEBdmK/7M+06Lzc7VSXmzyFZGB6?=
 =?us-ascii?Q?DGprwpxvqPf8p5oGXZHSO5pp600FneBEAN+nXs1VVSRsjdUim6C7RZJf+75A?=
 =?us-ascii?Q?cQTsp8NX18tIQ71qh18UcjrS/d6rcZj9nP2GocLnq444wurB/aWvE0fJ4v5/?=
 =?us-ascii?Q?Au66Ilh2BCpKLJ9qbW01jQRulhFZuAD2IXItS79T?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: b67359a0-4967-44bb-26d0-08dc4efedcdd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 08:12:51.5285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmfCy/NgnJXVyAUzF4gvzi9Jt2ixlNk8Pohfm9MyTBKa0PKzdmEnnaQyx5uwd1b1oP0vvUcIuFVeclSQX3jg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3193

Modem ME310G1 sometimes add incomplete result lines to first AT+CRSM
command. Example:
AT+CRSM=192,12258
+CRSM: 0
+CRSM: 144,0,62178202412183022FE28A01058B032F06068002000A880110

OK

Parse all result lines starting with prefix until a line with at least sw1
and sw2 parameters is found.
---
 drivers/atmodem/sim.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d75a09c2..46f21758 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -107,6 +107,7 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
 	int str;
 	unsigned char access[3];
 	unsigned char file_status;
+	gboolean nb_found = FALSE;
 
 	decode_at_error(&error, g_at_result_final_response(result));
 
@@ -117,11 +118,14 @@ static void get_response_common_cb(gboolean ok, GAtResult *result,
 
 	g_at_result_iter_init(&iter, result);
 
-	if (!g_at_result_iter_next(&iter, prefix))
-		goto error;
+	while (!nb_found) {
+		if (!g_at_result_iter_next(&iter, prefix))
+			goto error;
 
-	g_at_result_iter_next_number(&iter, &sw1);
-	g_at_result_iter_next_number(&iter, &sw2);
+		nb_found = g_at_result_iter_next_number(&iter, &sw1);
+		if (nb_found)
+			nb_found = g_at_result_iter_next_number(&iter, &sw2);
+	}
 
 	if (!g_at_result_iter_next_hexstring(&iter, &response, &len) ||
 			(sw1 != 0x90 && sw1 != 0x91 && sw1 != 0x92) ||
-- 
2.25.1

