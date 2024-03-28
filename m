Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2114.outbound.protection.outlook.com [40.107.105.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCD41C62
	for <ofono@lists.linux.dev>; Thu, 28 Mar 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613577; cv=fail; b=pt2MpFDNK3m/QaUfJrU0ZBE2Diu19NvuP+9n1YKSjiV+2Uf3Rpw7lHsj1x+1K+It2gSXqND9kSOpDNWT1v+Ds+pXv8SEAOA2kw1TIJK7TFzaqqBIdsNPWP5ydXswCZtD73qxQHU682EdLJvWo3MCtIUFcIZ7F0zS+vJs2u/1FC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613577; c=relaxed/simple;
	bh=OS4gCmftbYQNazU0QOSePyCODSKuakH1/0X2mnNcxms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PA82wsp8i/DEC7ULtnU0MIGu9QtWk9zC+ykFa8ie3QbrVdLb3GayrbLbeZr43QaQW2OqEiGelGgg1dT4lCaWxYjagCxx19wleDpsqkDe5Z+cL8joiuo1VikycPPDqvvoBYHj1ejoop5hQgnS813JwpHLnmnoScB8bpizfZZSk0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=IFyZ+huN; arc=fail smtp.client-ip=40.107.105.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="IFyZ+huN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8p1IemAFevzGa6w6Lb52W5ZEStD2tQ21sYBrMt+rFf6mfVV3OW1xI3omUttePY8eGC5YTUsfcavWrviGHI1q+s9R4+einy95NAS/avp1wUR5XoAYGOVbRaNMHyzDF9WARg544UUi0I9zmEGUnF8mKxdnC9H+sMtttr21heH/p9JzYhHtgMSyO+LbnGPmeAGo+14on+kP5QOhAC2+/bIoGeUf8wH2BYyXx5W6mhNFgZE5uOfRKtCTCfzF5etvtF19FBr1Q8DWUOuHd3nMhayAJS4ELIxIkHoOik2TMjYCnI0evq53c1+uZdHQKph9x15lL78WiMf2m2/G6emoxts5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpV1Mfi+KHVtn/fciKdTKwaOsSC7F4GUEH94tvd+eVQ=;
 b=hCW4SIApYTe0tlEeuc820EU79MB0ezm6D6bj2E46Fnzhwxsrf/sFInIOSQCG0qqO0kEXzIPpy+iGwEKTRV2MkXJnmm/U8ld4CoAYISQqXrubg5Pr/KM5XA2pbgwCrOwPMo3YXyQ2ILaPREB+GbyNGlZh8CPZePNQkg56fpVqamAooBshqjQb41Vn0UamZd77AHf2enN0dhlPAzOM90oDhiFomHUc9k91SLJkMqWTHdVvJLi0uQs71J9/stiONfMqJlAyCeiZ55ISzBCzfKOizyfdfW6LcQNXE8hdwgPsmGykOsa4tTFsB/Vt95rGh2ScoodqkBSfz+opzN9Pi4B8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpV1Mfi+KHVtn/fciKdTKwaOsSC7F4GUEH94tvd+eVQ=;
 b=IFyZ+huNpVYioUVzSswZwrIgp6hBciJ10Xbgf27hUSZIx2Lh8Cb1RV5ITEqIYpoLhCJOgMuqk2/QI7XJkJiASHsWBJhwHGbRyfSEx0hbz27j0+7XHP/Rhz+sKNmkEE6HFiRhCdmTdlNzTE80Q+wQcGOi/d19QRtfn9JkEnkFHofjlg4n6nxgbkNP5+0gGm1OGl17iWov2ywMctcjBmSdhYjRmJpskCH/xfTP6vT+u9b1CRH5ndT0QoGrHer/k+dDCN9lteVO2do+l8ihRXeM/pqZjPtnQMW8CESK9D9YgM9jqS5t1nt4UXeDyySYpQzpSVekxXqrY6KSkks+OqbNpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17)
 by DB8PR10MB3193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 08:12:51 +0000
Received: from VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09]) by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35ed:39d6:ac6a:cd09%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:12:51 +0000
From: Christophe Ronco <c.ronco@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] 
Date: Thu, 28 Mar 2024 09:11:56 +0100
Message-Id: <20240328081157.4586-1-c.ronco@kerlink.fr>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: d23cdf98-2f5c-4692-a049-08dc4efedca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KBwT+t5Mf7ZBYolW1ycxFEICe/psnuZ04KpvtmbujdYHpDzEdo5vLwWpVF7TaOtPH5NlbLCBxOUWv1t95imJAHDbCXO82Rc46H3zyUCPqJkyN7XWza22AIDEgCofBN/zjfsCxYLgWbEVmNCKq/9gN8/yAliwbdj/omU4vQ+L5E4nwLajzJBEUAT5QhinQ3igMNZ6fUKL3Sn6lBA3ueZ1ktNAVJIH4ssggzmMtlXcaf7E5fiwWqGZX0zkIA2Gl6e5ZhBuOqwGeorEbBPjhw9nQ4jTEQttETtl5A8i2dVzPwN3tOyAHWdA1BhdgvaGv+uxRzggdYhacvzF8i6xwq33P/AFojIUiUBdJ4lJPJ+2187h0u0DTvAaGtDA3fj0hGuPDahw4d6mpphz3XPbCoOlsvBVIP/gTL445p+2ENDQC1aIta+21Mak+UO+8dbP3vgm9ClXwcH7ykheu9CE+yWoba4JLJivPjg5V9zUtzIqUBvWmKeB3alvix5N2Cu1aSkrQb7cNOAf1qy+Hw21AJy6/GDqvg5h7aPHWVnoWOPAhXu6yugEGiXiXeDxC6Jqs4nVxi5Xauj5HpQdjMttGHhltPmFqR3qMpLWfKc2dopSh7zE67OWspXTVHfMy6G3s1w4RiTfpdtskvsO884us5W2VRAwSLBpftDyGW2kXXYB1VRfmIDrm2J2aVSr0zm5YD4WG1VvJciKzW6tzbiPzWxgAXrBGBx5rBdZjk+olIyKJY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VAHyDWm5h/5F9oUijLzhe7fNbZov3xtahrL5POgX4CfT5aoCgdTIl+3Ig4J?=
 =?us-ascii?Q?6PtUnQIja4qfJki9z8nOzyg23csbTmpOYhSYuWyWz6cNwK/BNuy8GLCNHAPi?=
 =?us-ascii?Q?ycdAkCMxpOkSEShZvLWFHaZfa7sU8RLK30uue9w0D4ROl/ASpT42p9EuGiyf?=
 =?us-ascii?Q?gQ07OlKyq3p3MJ/tpTVM7QZth+vIaqxniiUN6AlpaBgjidQTdrUuQ/AbZkEy?=
 =?us-ascii?Q?ISHKlNBh39wLHmHOaBcLGBLTbvVOJY6xSp7Qkd2Sf6pUXaMpLLBWaevFqZRc?=
 =?us-ascii?Q?taZX7NZMrOSh7gfsYxyNAq5NZIatcLYbMGs10ZctBJQCi0jO9GPBOb/llPLY?=
 =?us-ascii?Q?wvHODuXN3y2aVevR6wql17gtKVcyrisDoxwr9d0/lkG/4X1vMlbclQior48T?=
 =?us-ascii?Q?+cwplTBvhcu3c94+nxjFkbWIzNZbjPI9tTg9SYHdvP+bctJYwvHrOVdB/8i6?=
 =?us-ascii?Q?XQmmZuiOgLsjW0zbpvXCWRFngPvvjjoBrU4J7cT1Vz8F7dRxwwNqG1VNskit?=
 =?us-ascii?Q?5pwIUihuMuv2VRKqmHdkGPtVjJt8HV9w70aymqkvogPOd6VUqSTF/oT/UtXB?=
 =?us-ascii?Q?x1xzgZiCW09a/ySYwKQklF18iUjwlL+JezjScHVzZ+YUWUggWJ49X2SeTH6E?=
 =?us-ascii?Q?8zoUrGa9hT0u4bK9fNQ0ViNio0foOYFBHzn4uFPPAMfbY2CeLlM6cMfQ1sQe?=
 =?us-ascii?Q?y1lAvtKXLn3hz1nDXtTzhL8INbCBW8JskQk+J40Nl08wyf2GDQjXgm+dfe9c?=
 =?us-ascii?Q?ocQrDSrnmFlMm1EKA5zxBkFOfr4GPZ97vXeYytIsBUcservbXsDKWx8A44lY?=
 =?us-ascii?Q?UnfT/xcUPLXHha1csZG6qBivMrbuK7FjrX1Tl2wZ0cQ/N7FypGI/cM93djvf?=
 =?us-ascii?Q?MIjp6YsND6mRC8WhNYriK/Cs1IPOrBF0YsgMs44Yk0tjFuEA7y3h7M8W+czC?=
 =?us-ascii?Q?vHqJ3pWgv5dReNmOKlr21JR6bsTFeCMto5LpTimcZjaQRO3zf4iYOAzYc1OB?=
 =?us-ascii?Q?nMZhf0imITy5bUBIg0T7Xce3uYlQ76A86SLOFXKfiPxLqAWwWgHzUJggnW6U?=
 =?us-ascii?Q?IX/m+XOJrIwr0cNIbbl0Grn6JsXKH9/gmF8dLmGAI9q9ZEKeQfv/pDASpy82?=
 =?us-ascii?Q?0c/fuq9MvAVIMyBIC08/1pqVbqrLySiuNXRQ2QXGe3CR/yaqxZOl4iP/BFYU?=
 =?us-ascii?Q?hVKJIn7u0af6R9tWJ+6+HV8/2oiVMaLyF4E8M2ioN4GdWcBWyXlJUsVKz1BW?=
 =?us-ascii?Q?Ic/gCeA+4SAlBk5FihBZzHa3th/QMOvnG86QkIS/eqYWutz8vzwU8G5SC7Yg?=
 =?us-ascii?Q?iPt30BSASUp9fgiyB6mrIgwYxHtszc/1vPnw3bWQHMTCsBE1ZcHlWk4MD85r?=
 =?us-ascii?Q?lSnstft+G3Dc0VoXl0FBL2vyuVU9aDkHgGIIwC36GR7BOUCrhREP85vmiCZc?=
 =?us-ascii?Q?80608vgRvmMpgR1pvV2olBIkQDT1CqPSN8BFqOF7bGa164Uiko8cOB1M7+2t?=
 =?us-ascii?Q?yMlo9xvWgVUQK7VVZanCkJ6fgo76sFPzyFM12/PeOX7CQaJvAO3R9K6dg7KT?=
 =?us-ascii?Q?CUcpz74g2IVo/6vWOakJYdn/VI1pswf+MlcVFRKD?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: d23cdf98-2f5c-4692-a049-08dc4efedca4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 08:12:51.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TONr75tybVs7NOhw7zKNsDmrv50dxF3QC4MWPSSg7XyOjl58ZFj5JVHnOK4BT+FGaiC7SLCNnec87Vqtey2Zow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3193

Hi,
I use a ME310G1 modem (from Telit). With some SIMs, Ofono is not able to give CardIdentifier property.

This information is normally read in SIM by reading file 12258. 
This is the first AT+CRSM command send to modem.

When not working, it's because in AT command answer, there are two lines
starting with prefix +CRSM. The first line is:
+CRSM: 0
I don't know what does this answer mean, I though that two parameters minimum
(sw1 and sw2) were requested. A correct result line is also sent, but it
won't be analyzed by AT modem driver. It stops at first line with correct prefix.

Here is an extract of traces I have when this behavior is reproduced:
2024-03-26T12:27:22.721536+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CGMI\r
2024-03-26T12:27:22.730407+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\nTelit\r\n\r\nOK\r\n
2024-03-26T12:27:22.731175+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CLCK="SC",2\r
2024-03-26T12:27:22.831416+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\nOK\r\n
2024-03-26T12:27:22.831805+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CGMM\r
2024-03-26T12:27:22.840647+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\nME310G1-WW\r\n\r\nOK\r\n
2024-03-26T12:27:22.842950+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CRSM=192,12258\r
2024-03-26T12:27:23.101668+00:00 klk-zcel-04000C ofonod[1268]: Modem: < \r\n#QSS: 2\r\n
2024-03-26T12:27:23.165293+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\n+CRSM: 0\r\n\r\n+CRSM: 144,0,62178202412183022FE28A01058B032F06068002000A880110\r\n\r\nOK\r\n\r\n#QSS: 2\r\n
2024-03-26T12:27:23.166088+00:00 klk-zcel-04000C ofonod[1268]: ../git/plugins/telit.c:qss_notify() 0x1856a00
2024-03-26T12:27:23.166664+00:00 klk-zcel-04000C ofonod[1268]: ../git/plugins/telit.c:switch_sim_state_status() 0x1856a00, SIM status: 2
2024-03-26T12:27:23.167472+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CGMR\r
2024-03-26T12:27:23.176251+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\nM0C.200004\r\n\r\nOK\r\n
2024-03-26T12:27:23.178463+00:00 klk-zcel-04000C ofonod[1268]: Aux: > AT+CRSM=192,28421\r
2024-03-26T12:27:23.929127+00:00 klk-zcel-04000C ofonod[1268]: Aux: < \r\n+CRSM: 144,0,62178202412183026F058A01058B036F060E80020008880110\r\n\r\nOK\r\n

The aim of this patch is to ignore result lines that do not contain at least sw1 and sw2 parameters.

Christophe Ronco (1):
  atmodem: sim: when reading sim files, avoid incomplete result lines

 drivers/atmodem/sim.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.25.1

