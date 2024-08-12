Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2121.outbound.protection.outlook.com [40.107.21.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E816BE25
	for <ofono@lists.linux.dev>; Mon, 12 Aug 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452802; cv=fail; b=DeWYiZoKZi9DONxWlOFkbF6+Md/f9BNMGF9bpXEHu+iVeWgw5bye1w8O2H7/vBRjUlp5WBJauFfmYfSkrIcwuBS0GzqC4UvXeHc7fJAkGf4gy1FuV93WetHx0dtH/GIXJouOuAILu0ozwTBnbyjMm31+PYONfQhYrmbqKvGhAT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452802; c=relaxed/simple;
	bh=oJh5zJojcYkQ/yVJ3aeCqDU9OHMA2HcN0rtaHWbfNrA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a2NEOzzi6KOEstuNjRqn83Bop2NiL9s9BK/SZgZ35uryVmGeeVFWP3EGSXoF0uaEKaU+8pAZtVV6GC519NHVD6hC3vjc8b1E5YCGjAZDWy6maHeWjmG1G2B+Rvo3k8qUQ+eDA/LVrw+PQG9NU5R+IDJuCdivYMgUNDAvaGgaRzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=LxINC1Os; arc=fail smtp.client-ip=40.107.21.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="LxINC1Os"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBc8d4GklB4eXVg0iZAC9k8bEeQublm8TVcJlOEEKBqWQF/8QJHaBNukssF0HjPb+z4X4kadnU2ysxprqUpLv6I83v8+gDcBaRQrv3zXgCyiHrPNIvCK+VOIA6gvu5Ah7SV13G8sQqvFgvO2FHO+5ABA9VMipI7+enqsxQKafmrDg+0m6rXafHlCnejSrel2QvcIMcVXe9ekgwg83EHsMF3RavVVLjxfTPpdAZxkMNteKwfXBZSS+PpB5IEZ2wu5KmENs1517dRlYkwECl4+XgrjTAWWkaVwqAO1VEsJIv3N6dCgwjIORDKAdeB/JPJDawWdSht9KXKBIOmYMi10wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLrrgL52tOulJF4sVldh/+YUGWZkmuyvZV5ePcRYEzg=;
 b=E3vVTiCO902oQGGzED2rHkvWfrRBMHIaOSMvNMJBLmBgBZDHJEDxfnch83lG5VXhBZMccESYOLfnSPxIBrb5OmztElHdjFZ4BDPqPy1sA7KREVZ+rt6X8NO56n5uN5wIzNV46Sw/2RluoaMvNaSMLmlRDxf9JPeTuBPSCT+dTMJG3aFNU+rya73nbpxlwYtL/s9a/Ptmq26aP/dkNjNIELCEa3sF6iEs8+0rHbAkW0egtb+ljDKIn/rqTP8+2vX3btktdCvOoDQWbuHcj5mappTiYGXy0ZZVvHeyz3cX8Ny63GMZJU1iRZLJ/CbyeCJ+w9YNNbr+mh7/rfYXmdh19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLrrgL52tOulJF4sVldh/+YUGWZkmuyvZV5ePcRYEzg=;
 b=LxINC1OsO1Az8LSlbA+zIBHPuta7rrKwzJ7TEW+Ne2dPz7LLIto/OF0lx4OeqLp6AkqGMnlYxDVZtJl2bcVxTmIrw1EaL0nrLM6KZsugnb8JGk9dId857UaGJRR0HwYJYN5uk2p1ozwWt8yubwKAKePvTta086bNmiBkVHpj55tO8nK9ceNiPcSf2M1VJSTa6LzdGzDW+pZVn+Np1o0QwbxRaxMn9hSf5S04Cd56ZJynXor0hjiF4JL2yKQgok/LvmxLusRVt1L4nH1JtHHvdNyUgIkDRhrOj0qTmGFHzf/0LjWtr1vvN+owX0+JJu4eKGoJ4MGq+ZVHb2UizCwswQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22)
 by PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Mon, 12 Aug
 2024 08:53:16 +0000
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2]) by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:53:16 +0000
From: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>
To: ofono@lists.linux.dev
Cc: Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>
Subject: [PATCH v2] smsutil: check that user data length fits in internal buffer
Date: Mon, 12 Aug 2024 10:51:34 +0200
Message-Id: <20240812085134.74064-1-j.lemetayer@kerlink.fr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0331.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::15) To AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:590::22)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB7480:EE_|PR3PR10MB3802:EE_
X-MS-Office365-Filtering-Correlation-Id: edfc9a7b-1817-4dff-c7b0-08dcbaac34fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wlsrJQqKLUKi4k0Ipn0EeuyM3YL54WiizKfBowQhG84QPxYozZqrcjHIDG8C?=
 =?us-ascii?Q?vADv0EsA/g1oDDJJfqCtdO/bpu4f0Q63qOzQEK1lSM9ILNVgNih6himMdYPd?=
 =?us-ascii?Q?hkaJijzShIN8DbTY2fBR/Q1/uS6cCHSZSdFjjqSur0yHJUjn89sziCmbfQ0y?=
 =?us-ascii?Q?gSK6LQfu1vlIXFCKGd27ON3NI7Q11se5MGKwTU8kSsZ0iM8snN+8nPbPpDCa?=
 =?us-ascii?Q?rIXHeMOe/GKXaWcwQR6vHtuh4GY/T0qeROI5dXoBttznk/nQOj47dO3dOZi1?=
 =?us-ascii?Q?tNEMGUlPtSRZ+SO+FGQhB982is2mWP0TciltM7Ii5haq5KQMNSVFfHM09x/3?=
 =?us-ascii?Q?VngJFcnJW6lvCL/PiG14JxB0XJCCxpelJw8uL37KMoOPuKTuRPvxdHPJ5ZB+?=
 =?us-ascii?Q?F6tpVsNbwdajs8RQyaYN+/+NkP/keJ5okvMDqtzfzUZe1tl6yI1ACJd7ltQE?=
 =?us-ascii?Q?cAbPmVPxLwuGwbHarNBPAyPx1b51V2bfJpjjCsCWvQ9nat1XWHKHnphxsw/z?=
 =?us-ascii?Q?5ebFf1vVbPq2vAbn3xuXcTFsQ36wm5uzWeNAP9SEt32fSdJfRY79AtiylV8Z?=
 =?us-ascii?Q?bJfVXtJyczQXrGQXp4baa0Vv7u/6hxXgOrFxHBjYpSebCXFk4180KncSzhvB?=
 =?us-ascii?Q?TgJIM6fr9GLlVrq3lu8iUVR51Ojn4DWh1pFxKrUMlM0jaVqihUUAFuNyoR1a?=
 =?us-ascii?Q?no/+PZhUlcoIZAVt33gjTJ/f3w2qDegKZY0z3gybXZMPUr7SFXmzrNKch40/?=
 =?us-ascii?Q?AQuvaLcKzG/I1AAWcK+cQoxK8QJYMENoKikEVej8dk0lyciL0FGcF2q2obFP?=
 =?us-ascii?Q?g4c0Ww/ugytWOYSm5eqJuIJ9y4VLdrnGURGnhw9DQZ0Yf33wGkT/PltOm+vz?=
 =?us-ascii?Q?ppUP8AvAGlsMbnEWfT2FsPl2dP2Wjt9nzA4t7vqMOj/H92hKq4L1WKkivgGI?=
 =?us-ascii?Q?7KZz4xIofRbkbR/u+S1PEpxHHLsPuD6PLZTOheuBF2cauZ+w+Q2DwtYzWhnS?=
 =?us-ascii?Q?/kQI6EegO5DSrk+OuOi6XWFhU+npwxK/aNONQiI8esIXXCRKWL9NC0MqlLm2?=
 =?us-ascii?Q?lUz5PnFv2GafXVtM4zji+6/IxEpDDR8pfgN4JdIRhTynOeueg129NxvLm422?=
 =?us-ascii?Q?3gd7A9flNTUZek4BmcCJuHPXiRGxSQyNU8MvycA/0aujpp0JNi2mszDT0kYz?=
 =?us-ascii?Q?RaAuBz/gzIW2YStrerYlole4r3B2VXF6Yr/wQcRN7UElJB9qNfuD+2M515bg?=
 =?us-ascii?Q?cXN5eolJ8PxODnloKHsUwJEzAS1HhByene3PPEhk9h7MMkDogI141fTV0W34?=
 =?us-ascii?Q?i1d9OGLFU+juQnbQOMymdVYpqqP4mVDtchHxz+PS5CKUW9V5qDH/DlIGTqme?=
 =?us-ascii?Q?zMJNniI1WtUDGqeme5ldijGibfgPsDBDZFUioSaJR1W2Grvzhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdGeaEKSnC3SkN7i4gyl+wUCv2ml1PpyPWXdIVPkmrIvnvsn+bkOccB8Bo6b?=
 =?us-ascii?Q?WfBGeJ5AA2s5Q1CzbvGECOpXmFcmdWebZ1Pwwkta8MxD8H0FXssKX1UfuJ/I?=
 =?us-ascii?Q?kkcvouKVlEz2B4B7pQ4FgaExkjHe1hY7/Y67Jlc2XGnPjl4AG2gHp8J7c1JW?=
 =?us-ascii?Q?Olv99TonFiBPrpYENwBCrGAfNZl/mpgIMnBToAP3OEoP4nunf7mWyh/bN/Yq?=
 =?us-ascii?Q?2g38JRCQNDAlGx4XfUz593qA0YgiLLVCm32roO2/CUnaXGjVjTcRbFdk0qFs?=
 =?us-ascii?Q?IOIM//IJ4+fMERDovVvLYAXQXQC00auL0XIOll6vmrXlidbmVM2QrsxMA6zH?=
 =?us-ascii?Q?PhHcT7iIjpMTjBObhEHtgpE3NMQbnZDjsZtsl7UuzE3S7DbPzcMgRQb8wmxj?=
 =?us-ascii?Q?04Ejy6LoAGoKZf5Z0Z9rrmtAFg3gmCi5RiGPDjsDpAZUtwD0wvyKf2hQ9YDo?=
 =?us-ascii?Q?2OD+cCknSs2TTT2s7KH/GkNjNB8JB29q8pgWq+UvsDulM0anWtruvHQg3tXX?=
 =?us-ascii?Q?vXD6JhgYM9wxIz4ir6eN9reHbFRJWl6dkwhCiet4tg5Qq7/qpJNfS3Sh6ijs?=
 =?us-ascii?Q?Cmc1sLfBqVBTLHy4/WnwOBCedq9PC6wvLDFbQOSd8fKzhGIjD3xOW9dpxUG1?=
 =?us-ascii?Q?A/BOLvfrlEJ70Sd9PdRj4H7r+zVTitxxNdFkOhxy57RlX+Kv5bokNKET6Tc7?=
 =?us-ascii?Q?NvuhIEMisF2Z1jXIYzoUJZWz3pl9kWyYLVvLgRiRP9ReQQXZHLAO3zAuRNCT?=
 =?us-ascii?Q?s4Ou5Dyl19coYFdR6ZIGyIXqMk1hZgx/QYt8eZQJXxx+rypBAm3Nr4aSTycT?=
 =?us-ascii?Q?oVgGU+LkuOhciNuYvuhbeiNEyICY+hmWcE1nX5bwecJkprBVwp4gGrZvX3gV?=
 =?us-ascii?Q?MbM5P8pSEQ9f3Vqm/OznEHs6JnpYs//lBAsF4xmUgLyE65swqA9ZKjU/Cx4Z?=
 =?us-ascii?Q?IKD9SjKSaKVqgLanbrh29fBq8+WR0E9CMfgdFinnuB2WlvUo5RdrfEMSKP/U?=
 =?us-ascii?Q?xAFvKvb1p9w9iSYYjHU85kAjK6gKNj9wQZX+oHMCegrneja5TWZ2c7GMIhPX?=
 =?us-ascii?Q?MYINoTrDJU+ibLGu2z9D8OhP27uN/fUpuQJ3Kmcn52DtH6/PC6F4H4qTUWgC?=
 =?us-ascii?Q?CYsdBEj1t6kwxzvY24BD63I7+Hwk6at5p7e833LgtarUuq/Ch0mWOtNKReSD?=
 =?us-ascii?Q?iNe5tdb0k1bYBy+PY04ziZvCDzeqpDUZE4LqrVvbbSpgboAtFVrZa7F66Nzg?=
 =?us-ascii?Q?50yxRfXkDRFo4ydx5zwX3QDPUCq9S4fA/iVmv3CLrXiHCv867KpQkjWTVf2r?=
 =?us-ascii?Q?WvO5D9DVtPdP+JX9M2Vffhy2VlZiguDxisYeD9kfFq0776FcR1bRsH8gOD1Q?=
 =?us-ascii?Q?OSebvByGrQ00pZE1vlmuvic/Gs9ssv87SPLyTI1n8QPJ6DQhZDktR0djVRqj?=
 =?us-ascii?Q?n+RM7JlbPgzBWJYb2Z1gTqLqaJ84pbfhpD2A0jploIXznWdIo7JMzNuZt8yl?=
 =?us-ascii?Q?EZnjBiK1ya3KIoEpeXQYZjCH8b78624kgsUV2/wkcSVBva6l8GHs1qssqp4L?=
 =?us-ascii?Q?FacFCxEzzKeSzXEjQgoitcQNO0RNXYtYrRwN043K?=
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-Network-Message-Id: edfc9a7b-1817-4dff-c7b0-08dcbaac34fa
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:53:16.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbTzDmmmctDDfDZPpb3kk7GAGgZbuJWcluSvhxSKrzvQBhQtJVecyzs4EWvJRHI96nlM87O8FEieufKj+ABAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3802

This addresses CVE-2023-2794.
---
 src/smsutil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/smsutil.c b/src/smsutil.c
index 39f0ecc6..92d7f3c8 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -770,6 +770,9 @@ static gboolean decode_deliver(const unsigned char *pdu, int len,
 
 	expected = sms_udl_in_bytes(out->deliver.udl, out->deliver.dcs);
 
+	if (expected < 0 || expected > (int)sizeof(out->deliver.ud))
+		return FALSE;
+
 	if ((len - offset) < expected)
 		return FALSE;
 
-- 
2.34.1

