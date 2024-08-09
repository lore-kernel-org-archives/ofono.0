Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2126.outbound.protection.outlook.com [40.107.249.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E216CD05
	for <ofono@lists.linux.dev>; Fri,  9 Aug 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201952; cv=fail; b=njXkRWMmHBWMFOYDArDAT4+ZHa3HSmo9ndHchNXndjhBgGBQxqCshWdaKwUDdZ1E4W1uWKjyiP1uR78xOC4KgvjqYJRSo8Zm0jhrWeUsWWIGLuNsqdYmNLOFy8WwJN4bFvm7ibsqultIjptYVsvEpgfoK2ebOAeSyeFMfvUZFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201952; c=relaxed/simple;
	bh=NPxgPOMHiy1r5EP+VvtRpO+jNQv/m2zvKtuZSTr6vFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OXJwKP7NC3Uq00cP0NgJeYEZeVRTleOTjE6CF+9IdFCDdptEzI+P8YumB5GCdzK1N2C3CMCYUTugGxkfbYZwP0QZ22v/DpIrBFi0c7acdYFUd0hz4i5aKYuquRfO1IvNwSpI9wj7qYO7kWsPoJgSSxYM8gCwIHI/XhCbPE+/Xto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=Hsia8Y96; arc=fail smtp.client-ip=40.107.249.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="Hsia8Y96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEc++ckvvzg6rcBz/dyOWm4949nKnEg3iLYWmg4fj+ewXYXbj9rwPI3FeyY/Pj8vVnfEcp/eRUn6o1fuw7hEoaO63LLBRN9VN1cY/XPvRT1ZtPaqWrWC15d4/BIsOFZjm+RxP8IKhjqc4oapf2lhKGZiowP/rp2/NdshRK/8zp6mzgiHJjH/fqQDWzjvVb4H4kI0YqGlzS9gqBdj0MxxyJ6JatFSUHVHiceUcWYDNvQc/vIHB0mFgJQenkDJ0ULMZkPaLDK+l7w9G+j8gXHAZSZoo1xGJe4gLfIUhODbCyRcBYn1sVTTRYik+dId7sKYk5C9EjYDxtik6zewwEiBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZuRkD2LMb+ZSBge2Nfuv8oDFYYPg6KEA4ZkObYconk=;
 b=NCyoV27B8EgDg3LiRqIVG/PcF9dcRGcZAcV4TkJbW16M3uLbgabsvAetiw0M83PVT9NU7MAIvC0kAHIRMoFa9AUGGdiJfOjbYytXTEBM0dZykLpbELng8iBJnKwRXKzoRfUB9P7RhH5mgmFCns7uRJn76ApU3kMtRUXcXXK4mhY3Yjxh1eK205pMq6GlwC979NLSDaQe/YgEmNsnp8668D/qmjtVoH/sp1asZyBIWWkNaavetp4wJjUetWREJNDrxMMLEZ4HZScdYty2u5Ea9Xq4P+RT6DF1M4VzIRnAIJ8m/9ZyMAWM5bTZxWzOw14ijk+zQCgHXCzSXaCD8xGjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZuRkD2LMb+ZSBge2Nfuv8oDFYYPg6KEA4ZkObYconk=;
 b=Hsia8Y961k15ELh1Ptiqf0G8nUhzGaHTx+RAiTKltXFjvLtRWhs/vKaKOY3HA5uT7g0v4huuJRKwqTP1RNjbr4iEPgSxbPy0475cJbO8omtn1XQ6kgBJ5U3qhJ4IulYhtjGufRMpQBLeTm0TowcN9KuvXLfRzphKOh5uFoBPPZOBfQq7XzxfowF6QNtYdpWzVvx3MTztgDGYAQkkx5aeGLdZut3P7IsykF7EUSDILvgByEK4b8RmBGjjVyZYQK+T26BzYfbW4PEEcoRbfrQmc/Fl4hauZeINgVdF5Th2eoCv1pWRtXmNEDmx8TEXk1fSBKx4P0WMLVczhDep7srhdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22)
 by GVXPR10MB5791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 11:12:24 +0000
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2]) by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2%4]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 11:12:24 +0000
From: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>
Subject: [PATCH] smsutil: check that user data length fits in internal buffer
Date: Fri,  9 Aug 2024 13:12:13 +0200
Message-Id: <20240809111213.853665-1-j.lemetayer@kerlink.fr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0443.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::26) To AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:590::22)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB7480:EE_|GVXPR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 63904375-f200-49d0-c846-08dcb8642538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9fziGYlVShSQSbulL0PV4ou+GMI2vmzpYZCdOwFrDZ/5eFvin8eEBCPSHMKU?=
 =?us-ascii?Q?KPzrKtjvITyWA9vA8IKGnihTTuNl6J/AQ7KHLtRjuw19gNt9dc1WF2IobBco?=
 =?us-ascii?Q?VT0R58m2EFi0gCZy9cNgoYMQumZ3b5k400o6WcxY24J2rqBOts19N12BC1U1?=
 =?us-ascii?Q?wiu4kVOUDQG4RV1klRM6Bnk354wozjQERxpE1fiadw9zCdMosicOtJhD9Lw7?=
 =?us-ascii?Q?mjQ9kEf7cRcxwNV5Lbgz0ykC65A91XjVI8oJR5UUAGic+lONb18y6HoOFvTA?=
 =?us-ascii?Q?4PZU5nJj8GrJsO9zwpbV73jTpshHrlP9y9pOrRi4BHroEMIZrwk0nUyru91o?=
 =?us-ascii?Q?jFlpwYiU3qZTGFXrGcqRRnQFVRPdhKbOCM1Q7A87oLzTpLWgtwefxAVsTelZ?=
 =?us-ascii?Q?dUsAlW/BIZ2Bc+uPT924ITLkF5XglW4VhJOrIFHt+vm9D4FTahsPqYWGt6mk?=
 =?us-ascii?Q?N3vzkJ8IbMgp833lAKwqhYYLIybVS86Hm9GgHyJFyTTPYGr+7S2iw0dsl4Cy?=
 =?us-ascii?Q?hD0M0IoU62PRjqHf61OPJlEaS3QkOUD3yGduqh8QyB8hrtacWGdQHsqKFs+W?=
 =?us-ascii?Q?6rna0IbQeJVcehNvj8y3ltHGjy1uNkYnwnygbewLWFjyhbKjKoh5K8bE3N3g?=
 =?us-ascii?Q?hwAUPVvNPw7j6w6eq0NreBizHnUMezvcfQZE7x0lv0lP+gfJuu/nR7bFPuGc?=
 =?us-ascii?Q?fF3GhToz3Zo7qwy0V2t57t8w8PR36uqS2veTnafQYV0tAOuXukGkNZXk1ktB?=
 =?us-ascii?Q?I0XJLbSwPP6v+80dl3JJLVpXY78ImJiLV/xk7enT/xgv4URQHCFIQb5yuzjJ?=
 =?us-ascii?Q?g7wmrV78/m0PaZXjE/L9aywRvQWY1mbo2iy8ZEK+7IqZHIn8+0sXqPVKQuS1?=
 =?us-ascii?Q?LyKmvcst2rFpTzKJNDnlZpPNeZwb/NiSHtBktpFrBwh11/aGdOk4r+XEQ1NM?=
 =?us-ascii?Q?fYKgmCTKTfCkxEk347o9WfNEeLyZJ/M/nGcbc2zGKlrBpyAh3gzUeRHSxv0G?=
 =?us-ascii?Q?Q3daKrusrHBD/LcFzdGNx5gIlS59ICP8K0XEJSM+nDxUQQYG/zgPYP+k2PNU?=
 =?us-ascii?Q?zoLx/wYYZQyS19SomKUHH1b2WxF26UbU+Jmt+rUAJ6NdnewGnltqKFNAN41c?=
 =?us-ascii?Q?S0gmX1acIQca3Op2nyJnSoQnxsZzfVKOsBR2Oha+vvJMIiC9+3xnaR9b/zDf?=
 =?us-ascii?Q?wp71mNbu6y/nYAv5ssQGM4pbPeJ8+AQAZqbqzmLK7Le3WO3MZJtisidTn4jH?=
 =?us-ascii?Q?GdAqzp/tGRLE75nl8mH2Fsm9NgIaMorWoOlAy9ThSpdvsJwFVn3P7eLQ8gqR?=
 =?us-ascii?Q?OXlUoMtbUsHbX6JqxNzMQceXFIEXMkSq8+NIwYpx9WdcV3eB2c9aKSoxHqrr?=
 =?us-ascii?Q?ClhegsZJ0Iglx9V5Dk7541Mu3yFEfZPS59HQfhG/fm655vZnBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b5/NWKcV14F65aF/C/Ful5gGNUJZjgKi1Xgdu8gSpGXTgAjzVeks4EPObHKo?=
 =?us-ascii?Q?X1WBG80rgCajY2fpadKMqzo/l9Go7a7vMaTsADPFOJXEXxzy6oA73KX+8L2d?=
 =?us-ascii?Q?yj3vGr5NzuuB20ZIrJrTmH52Hd3lB0j14C3fIBjqZQeH9r0sBkFOce+Hoj/b?=
 =?us-ascii?Q?t2waRi0GVdB3JLLYOSuDSAV4q+jWUxwzhNEQupWgAvVSdzO4FI6NUKbChC5t?=
 =?us-ascii?Q?rXnfMj3FGxLv7AMn19EiAQ0BUMmsbVktgs9c0nXr67fXS3tZq3uOcthIpf4P?=
 =?us-ascii?Q?1qPwPlwRb73zKZ7KEGJ9oR2uL1vEzbD3Pu61/1nd2F/S2D3be5xrD47yL45d?=
 =?us-ascii?Q?sVtoiA7QIC4wxqpmBSXjHbcYIhmSDqPZ8SFEatnz1oQE39EdAiZunKHXTNpI?=
 =?us-ascii?Q?kIMfbjcwxDXhrVypfzLVSAZRGH9JeHDCUKSaSm41ZajUX/82a+VKo9re9iQ2?=
 =?us-ascii?Q?cEh4Hst0d6fFj+Dv2sFYhNNCbN0VKIx2D9gtXn/RlwPt2a90Oph1jq3E1G/c?=
 =?us-ascii?Q?+xUFmFqTpoR52ohMegHFKfVK7RkX6PwYH30Aq6EhbBPPnkzybYJVIAKR0XFB?=
 =?us-ascii?Q?OgG4N8wzidqYciqGrcoKobKWTvlfon8vrlsMxC1VsdCYEQZf6HeEVEMqDvWR?=
 =?us-ascii?Q?b55nF1beqh5DzFIaoym/y9YQ3v4LJZUGh/+n9kziLjjZfrqgdhgQPmas+/1+?=
 =?us-ascii?Q?p2t9e4l0RbctVeBGjFoq0n98jOcynd9QRs+mZczaQpsFf9Xk0U0Dbzi45M9f?=
 =?us-ascii?Q?32n1hVLi323XALQkUuszXfJXZQc8+8lXWN7tBbFN+2Lx2F7Wn23DrDwhyucs?=
 =?us-ascii?Q?vJskgGERmyI6dOiyAM4A5TGAfTWbKRidWgUP+cQ9dWnNuXSJJ038zCw9efc7?=
 =?us-ascii?Q?iWjK4jZVS/H07GUlfdHigRtyOiVNukpFaIaUrfUpA3Blt1qjYdGZrLepKVGu?=
 =?us-ascii?Q?2TvPiWQmVZ3RuUJpb5WxGCRjoyhOJqPWaVtRflIW70tuFNlmGJx2BAigJkSN?=
 =?us-ascii?Q?hqkegAtZTbk/yfkGMoRCIiaAO8o1vcrm3XIMWk+cTbz1w34KtVBSjgnDjIZX?=
 =?us-ascii?Q?Jidx5qgTF+JKPvBFc9Y2PwGhz38VG5F5eTc3l87LtckbjrBGCbeRFOUxl81a?=
 =?us-ascii?Q?+gApM+ZbWcA3TmsP+NVpRLC70UuZt6PSABW++MhrnnbZf1laMFHWof04De2L?=
 =?us-ascii?Q?XERXu3EFjsjpHWtlAwwt3yjWPAcetTUaJIDJQ1K/56IfkB2hv+3PXq2JSaMM?=
 =?us-ascii?Q?zQyF7YlGbHZ9w4AaKyYE2sB8nbMtDEKFD3GSyEGJtsEOyOXNIMID59q22zQ5?=
 =?us-ascii?Q?7r62OIgcwMeMx0euP1qgW08Xz+cHN61BwbIwBEDBlA3wucLCKApfJX6nr/uQ?=
 =?us-ascii?Q?MJA4wFjGGP/LkDuObNXKD08bHqQAsK9a2VFtmtdtTueP1aSaeALxCKevxr0j?=
 =?us-ascii?Q?tLBft4imdiHpmXcZc82NZRAjN/jHE1x3eTcFAM989n3YcbqEALRmE7D4KruC?=
 =?us-ascii?Q?GKyHLyKMfMxsY2J/FLvVuUR46IU9HeaYgHpB8hQTcPZIEqkMnNsWfx/V4fHW?=
 =?us-ascii?Q?9h4tsv59UacF+gIe+INQIEtpp2bXeEfZVoBr/3Dn?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: 63904375-f200-49d0-c846-08dcb8642538
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:12:24.2095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSy6BElwCUZVm5YhF44mikImdE1CiBkPVja8d7C4Nra3i9hNy7ZjMeV87M3UFXdwCzlwcXgomwGXc3lSe30bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5791

This addresses CVE-2023-2794.
---
 src/smsutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index 39f0ecc6..7f065d9d 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -773,6 +773,9 @@ static gboolean decode_deliver(const unsigned char *pdu, int len,
 	if ((len - offset) < expected)
 		return FALSE;
 
+	if (expected > sizeof(out->deliver.ud))
+		return FALSE;
+
 	memcpy(out->deliver.ud, pdu + offset, expected);
 
 	return TRUE;
-- 
2.34.1

