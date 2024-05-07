Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2134.outbound.protection.outlook.com [40.107.104.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BB15FA93
	for <ofono@lists.linux.dev>; Tue,  7 May 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093237; cv=fail; b=mv5kJgAyy7043KKCH16uaB17/nxJKkYxY7N1ecmCGjHs+yELoS1GkRET7D2a+WbeIVbu4Oed2sYrYWRkUnpP5cN1LnxkV0t5+ZWi6/voxJLfkYXVI5Dp6ACj7FdGMrwgNIbD+tm787bEtqZ3C21+4j4zY9InffTLk5hPdkNFjQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093237; c=relaxed/simple;
	bh=hd/W8xCjhSY4MmEmtJ13k71AX8h5DSRnc/01X5WGt3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdrVKEoDFRY5kuzUrPgMwwFgYN5u/k9NFKilwGe+PAbiqU9k91qYYTxtCcFjHNn2evpFFgj4YrCDJ54D+xzZfsputq62d6jsObJXT+k+qS9qw7sEPhCZT3auqYXHYapkuke8e7Jd1AiAeIJjJW4kr8FLCaA/GeIc0AJUqsEFMLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=WXJGEWFm; arc=fail smtp.client-ip=40.107.104.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="WXJGEWFm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWwh6vV6E9gf+ox6vr3/s+nO0IR3sFWVvG6bMaW4bAiPmA8n/9Z3ig31uzpJieWB/EieTK+vS3d7pI2or9k6ZufN5+lwiIM7171qKan6BSkoCQCLqtBUAnSrbE7mOziMARqcSS5hz59yTPbxB/txyasLpfD9kmyBFiqn057vAIPRFeDtGzNidu++ZiwlRMbph4tXuNjMWoSym3ZU01RAyp2P+POKsCuD5zeRARKvIaDJsy5bShhFAhK2EU9vE6eipWkjFNGZkgJqm5xzXxcLbEGpazuVKXa748CwMVrGSw5AY7Zz895JDv/5GJk9e8EC+ZVxeXoVliS76lIMrzw57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDHNwqn9bEvXih7wzI7H2o+nzKxQi8A6/LadOLxmbZk=;
 b=VbMoHsWATAeTWLJCNiqFujpH3mzmZeb8Wb2wZyMvBMvEjzKzNiwbJ2LUkWpKlCjHWsi0yT5b0g5CIG9EX8ntuvmpPQHiak41nkJ8ByM8R481jOBQJ+2nKlv1qfa9SE6hjf8ouBZz3NGE8N8NYlqBUKrCBENOPXKOKTZgXmV0TsfCnNupW4LPyYLk0TaY4v4V7j4mQKmT8MbDV8jl7DtTtLdBL+pwMJRreF9Ok9Z4fMx6pMrhM6BpSUf841JQLbblw6S8vM+smZdEkKuAkQmGiMBkBkvRM2kQJ5NwjdRqZq9yvI1/R02gC8cMUsfHbo3MHo1onMd0BaEo+BNKsCW+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDHNwqn9bEvXih7wzI7H2o+nzKxQi8A6/LadOLxmbZk=;
 b=WXJGEWFmJfYVkk269NEFM6WxKZBhmGo65lNJSFNwx5Cxp6h962vEGtwB2RWDXycbBgx50UzcLZq3qu1S9BkL+tUOeh7tS9dLh8+WDkBPyMJ42+ygV1z6vznuRnyi93fSrW2PSxmVKIAocJv36ouw6QNZld1t9GhSKLXKXEznYovlGjdgon6x22exK6r5K8qMcQ7TmWvyxQqph+jwcZEBJ6ot8Qh53Nb4yUSU+o9dxbDPMl/V5elKocqdqV3V+Xy1n4EWaF3DlzOCenomPKNdmTc+YQX+TsSKdd10eeRTNN73q+YFs4KGnblB03k3m4ui9mhtwwEomYoT+du4FpOuxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by AS4PR10MB6038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:575::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 14:47:08 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ad:5d06:d8b:5171]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ad:5d06:d8b:5171%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 14:47:08 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH v2 0/1] atmodem: sim: when reading sim files, avoid incomplete result lines
Date: Tue,  7 May 2024 16:46:17 +0200
Message-Id: <20240507144618.33676-1-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a952ae20-b8b7-4725-b3e0-848f2b635525@gmail.com>
References: <a952ae20-b8b7-4725-b3e0-848f2b635525@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: a066e456-b91e-4d5f-b929-08dc6ea491bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQZFcO6ddiysesoWNX+FNwhv3XB5AYohdsPI4OIFTDRWVlNnMPKiPiFJMT2G?=
 =?us-ascii?Q?DXB4fAHdki1oMQg6N6fXIY2omBrNBL3iB0o0vvVuBzlf1hi0YEn+IDIgaN3N?=
 =?us-ascii?Q?DNIumApJZUGsAetGV6BgRO5AH64scjF4nBLm3CnWNCDMBFIRjCZFF/orgaet?=
 =?us-ascii?Q?rLUKr50uoRFsrB2mCGNfT6m1Z2CXocOETp9p2oqWIZoIYxRgaswkrAwUqxfv?=
 =?us-ascii?Q?eeFaV1phjgQd1QF7nAXeN2ylafvx193D/jUSDwvFy1fBHXrBFH+ZQ7k8rLZk?=
 =?us-ascii?Q?4oLXMM0FHPSpP7/FZnsnfqmYVtAYVP+eHNvyzhxtD4j9ULzzQa5BlXzofU6u?=
 =?us-ascii?Q?RenouC7/KmjmdkjK7bL4BjD2N0DDHfeQtcV/B0P07MaN3joptjT5vuHirwAT?=
 =?us-ascii?Q?OA4f83u0XZLNLaNj2ehwkkC6XhuJwVUQMN41QeEZvd5fy/YebOIhgOKUBYVv?=
 =?us-ascii?Q?qK9wg+SkOsQLBJnpaLNDz3AxzLpH5OoCKBjvOVnsz5uZzSN+q6TThuMHkCGS?=
 =?us-ascii?Q?ZTShuHSn+n0RKHBmpmAo1hXRWqPZj9ukq6hibjU9ZPAbpJNYoY9hlH4u3Cxw?=
 =?us-ascii?Q?wF9xZ3N/PCUbFNTH1vfQUHNnSyr6CoZTZCkA2dxazQg0a+7QtYI6mVixzMcc?=
 =?us-ascii?Q?svfYlFwFi6nXD1Aw1I59jsdHiw9nXx78l7e1KSUdaScguz/CnR/vIbdMntdg?=
 =?us-ascii?Q?PEptNldKatDgZsao7OuXjq59nsYW2a+i5J7536L4lHzSsm5/J6wy2mFq/oWu?=
 =?us-ascii?Q?ONqP1xE7VmJNDzQ0W1RSyy6Pn38DxH2RdQPRNPwWFvKT69glXCYPwhjUpMPr?=
 =?us-ascii?Q?81336YaMAQ5/CqOCRHHh9S3Pfplf9GpeWR/2hEwpljVxI6xfsLXJzOrBhEiJ?=
 =?us-ascii?Q?UF7Mql1+PbarBTSYcSCBow6wvmHF5Dd20KJ+rk3hReU4keIRKevzKfEIsarx?=
 =?us-ascii?Q?fhDJ8xFl4lTU7iRcn03spB45iwvk/VOprMO44i9sH0eKtbX29Oy3JfFQdop1?=
 =?us-ascii?Q?9Hj0keAxduakA4CQ9kgNCGTGUwkh4Q31LHPJs/C8mBcuzdJoc3B+EXzZ+xuE?=
 =?us-ascii?Q?VcBvPOKkrCZPYCT7m7r6ryG+//yc6U0HKctrQnYSIpOk3pVb5NVYuLPj8JjU?=
 =?us-ascii?Q?B6bx8ccmHZDIbT0Oy6TJEZ3cSGAyYkLFpldmsE+raxbxfi46f3HmINOS9z4K?=
 =?us-ascii?Q?B4UFV5FaS792n1zvF/oP0YEHHY+S3e58MUWs3WTDATb/gRz/Rj7ykXrS/4lr?=
 =?us-ascii?Q?kLDuBLUf0Gv7WTjjsOvQBbhehiVpZHbRhTWKOZDS1sOUndHM1coa81wSA4fE?=
 =?us-ascii?Q?pZVtlquhZstc1Z210QnlYotM0W2vegcaO7C3zWKhSseo7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ga+Z5ecZtWI+2biE1WGYQA6ybIS+JrSKl4iX7vqra2d+U+DWMyw/1c+OLQ/T?=
 =?us-ascii?Q?tgGUXJYcO3qam1kRpZWvZzS7sxfNh47NZyYu2Ye0hQM+Gd093J1o/cunUJKH?=
 =?us-ascii?Q?GhTn/ZJpZpBjRB+IoUFVXx1INHTowVoaVpiYkAuiJIjTfkhMjnhkcVSFvGLv?=
 =?us-ascii?Q?peTEbg5qJxfTXuI0K0AXDWQkWx+9ID7ztTiOUWfD81PkH0KGEXZFhwQ7mHAO?=
 =?us-ascii?Q?YpW5ScS5kb89c2z86jVDqJbszRjkm1AKlvxLFyj7Fz2F7HMz3J4zda1J2cef?=
 =?us-ascii?Q?aDj4gZX9DSYUCiYXx+mpV9H2RMtEWSDbmMFDcUpVMt/tgsqJATBpdXTwiVSe?=
 =?us-ascii?Q?KvS2udDjwn4fHE0c/ffLDjkLrKZpOeqDYBVwtpexK3jEWEhmzAE2FYi0+pgy?=
 =?us-ascii?Q?zRAjCGpRzcgYySQtxdNW2uwYQlhpXegxv4oxcAFhkVOrn9ggvmJ5jgg2P2Cl?=
 =?us-ascii?Q?T5kqOx8RlJV/F7rdLnGLA/JbsTn22m3NAwy3VsyhLKEcChGqsuMkpD+vsIWl?=
 =?us-ascii?Q?w+GYvteQWuRBiVIDhfD8AfIBUZnih739Sv+Q8sEy1YMDU97THL9U3R1AO4Nm?=
 =?us-ascii?Q?wKJ01wZN8B/a9o1Pb3A7cxqmj5oiZf28lOJ2tncL6sZgA260R7f1wFX7jlYu?=
 =?us-ascii?Q?SgruWtNQqGTPcXLmcQjU4udo5LB8g+IZe/ueiQwhOxLTHj5SgS6at2vMzqKg?=
 =?us-ascii?Q?A91ws0Ii9U4h5O7woak0HcA9erc7PvudNg/3fYALWXfNIaInaCW2nezBldcS?=
 =?us-ascii?Q?zM7nXqVfSTJracx4gkYwNZwKSKPQv4zUPCRcV5HNAZ2k11n1oYOsFGA/yqOQ?=
 =?us-ascii?Q?D77VV15AnVQ4s2sypMj941I5O/x7Dnd3c78cJv3BWo4I0Hi2uujaQlf6Qe8p?=
 =?us-ascii?Q?qhqC+3VkCN2TKV9Jaetp7/5JMONyQ1eWbJoyrHbpWSd0chONgK8/f23lAAoq?=
 =?us-ascii?Q?TDXrB9Gn/cLRbh95JiJ4NbJEzxxK9htD0XxAiJJ7vQyQYGJr/ofkFVe2+1Mn?=
 =?us-ascii?Q?yX4143rkRe3ye6bdujleXLrqRQ+gL871W0vKzioop6yIPZqYCQ2FiazejHeb?=
 =?us-ascii?Q?AmFuYIaRPbsSL72wIhX0uzEc1tuyiaGTaIGp5EtbUiMd8FNdPD1tgvpaOyMS?=
 =?us-ascii?Q?JP4Hpwv5gVkc+7B5TJabfhd1hYtHxv8T+nPBXlrmhZBUL5RL0r0W/w+XfWw9?=
 =?us-ascii?Q?cpLbXNVZ21OboieNSAcDbnBc88MmwHEr0/oxFxGmUflSDH/FafMrRNcu6zIZ?=
 =?us-ascii?Q?5Elh3gT1g4ENTiGuqczPJlclzILtSkOs/1B4kgzPgYhW7aivSBOAaUNKnXwf?=
 =?us-ascii?Q?sQBByFTtUy/TG0btPi0X/IPXTqGt0B+iKVAo+AdHgiubo+NQgV12KEvUXTiq?=
 =?us-ascii?Q?pE9ogjEnXwR1d7S1Y0bWvSH5nfq/PDPmWC5LV23K9U0+FjjEwYplT9P7OYoy?=
 =?us-ascii?Q?Z9Y/c5Pwp6g/Gvz2aVKFWCFSaXBA2NCa3Dz3ShT0okv9wUsX2MOSp2MRVVMn?=
 =?us-ascii?Q?dLaQo0J0mGTI6NNzUMvd+BV2Mp1JicobSiUgedArzX1MR/TRceXJqw8vUA5Z?=
 =?us-ascii?Q?Awy4lEtKjoCZwzZ6Jz1iI6mjecM3sacPbKt/9wEw?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: a066e456-b91e-4d5f-b929-08dc6ea491bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 14:47:08.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H39ksQrhU+Sc08gwv757HhiLItrR56nN2lHQR4CD3p4aDY6Fgc3tIYB40Uek8lD5qJXZxUaojeIClUyP86sBgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6038

Hi Denis,

Here is the second version of the patch.

Sorry for the delay,

Christophe

Christophe Ronco (1):
  atmodem: sim: when reading sim files, avoid incomplete result lines

 drivers/atmodem/sim.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

