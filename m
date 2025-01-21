Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2060.outbound.protection.outlook.com [40.92.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68411494D9
	for <ofono@lists.linux.dev>; Tue, 21 Jan 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467421; cv=fail; b=HuIACuVd0df6ZdLd8lXGyCYv8eIXz1t57SXx4+ClgzDquvb4kgLn/vgSgpP2xX1j+oYFjF9zIzMlAX1wC5ikGTPPLcGsEqU8BTwVESF74+wXi2i5QDl71lHSF+/34UNyFpDJakxuWp/Rbdf3lPVYGDMo02hhpO60fOMrkc9MLt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467421; c=relaxed/simple;
	bh=MY4Y/F9+FCcI4JSNgKD/1otWflcq4v7mIB6RvmI+pyA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WEeryMA/xN4oG/PwVRaLyImku3R3vB1+s20wxzAQo0HgCSjEV6kYA7sEYWmroU/pLohR4mN+xBjsipx3uRY0tMkVdn6s7by6p/iKCsCPF06oJmr9xPFgedo+dpukSciOfhrAQpAUi+MgjO/6Ken1vyW2ENKgMzeSZb1meklTNIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IubKfwP5; arc=fail smtp.client-ip=40.92.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IubKfwP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trzTevW4IBd0dCvg1c2I5MHVWh8Q2KgWfCCZJDFVQfjfjbCiMeXz8CqwKHYH3IGaIYveo2W0UYT6C6kn8Mf0KBIS0GPszJsEThsjRwvMg4XHrNFJNnjAmpXyPohb8XTCBohldX5PW2l3ftSVYMqhv4+QqWflblWYc3CgF+K5WfRKu65Txeh4BmGjf5v7gm+UjxhFoeUN8ggEn/KUu7Bg5cvU7o7hS/MGYK6e5F97q3qMRx71j3eRjtokaqKP4/14QFMLdJufRWpquUEi4DyYrurTRBsBkgKkiMSAeQCcxRgWLJTS33mOgKs27buqpGGYlZcVLAOxOqubs2SGQ536qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY4Y/F9+FCcI4JSNgKD/1otWflcq4v7mIB6RvmI+pyA=;
 b=F2Q14OOndJWU8SkhaIcOxmyyGBToPYvk/M+1cEfGOyJ1GaRl+0GpPLhF4T6+WT9fCFMAnmPzyQwsjv0PpawCOPGpPR4B3O9S4aeq/gCxYWhA8uhfrO/KIIJsCnVb8jwIx04M2pa6+OxMRatT2gjcdF8s4DbaE8rgl9xTMLk/n/KfpEkIskx1G81E8MG93HXBmL/rWVvy59XIWcGc4WSc7X+lgBZgh5KFDNRgsq3LNMhm9QaJT0Tb4xMY/JDTlz4K02OhH4BIqPUFq+Q67ygUcLv73q314QZ8X8OVkgQ9Vnj3PmrQh4tU7PICahGk9QWhlqEp3Gru8mpNR7W/3L/k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY4Y/F9+FCcI4JSNgKD/1otWflcq4v7mIB6RvmI+pyA=;
 b=IubKfwP5zyDXVdJFGbTnsQsr0pkjOvzlO6FX22NRXy2qhRQTn5pxTElOvRhpgzp16FCdm8Xxq0Mg/+tdocbrLC7bBGIwJc9q/GM4DfBsGbXP/jjAKr1CNq3TEi002RMdELsevCITMRrTtYAM69BFXkH3ybJwDzOjtmHG9/EIlEs26jYuRmqaT5Op1rkKbwZVwEl1MuKRQHeY8BZxq3kBMz+jIBulfsxDOoNiKhN3XHagWh3mjsviH9p3LxrkgIWMW6ppvmCb36R4wtCn8N5XWXN9Gn3iQkn+Cfryq2AbT9X4gmRjDA+gxfGUc0bN9rKkDq00WN6uLHsG/kYhcL0oaA==
Received: from PH7PR22MB4048.namprd22.prod.outlook.com (2603:10b6:510:247::20)
 by SA1PR22MB4770.namprd22.prod.outlook.com (2603:10b6:806:3cd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Tue, 21 Jan
 2025 13:50:17 +0000
Received: from PH7PR22MB4048.namprd22.prod.outlook.com
 ([fe80::343:962d:76fe:237d]) by PH7PR22MB4048.namprd22.prod.outlook.com
 ([fe80::343:962d:76fe:237d%5]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 13:50:17 +0000
From: Phil Phil <heidegg@hotmail.com>
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
Subject: UnknownMethod exception
Thread-Topic: UnknownMethod exception
Thread-Index: AQHbbAtbwUBuhM+UNU6rad3l2JhiKg==
Date: Tue, 21 Jan 2025 13:50:17 +0000
Message-ID:
 <PH7PR22MB4048D9330CEC266B1DE56FC7AAE62@PH7PR22MB4048.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR22MB4048:EE_|SA1PR22MB4770:EE_
x-ms-office365-filtering-correlation-id: e80aa508-29a6-4158-e77e-08dd3a2289ee
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|7092599003|8060799006|19110799003|15030799003|461199028|8062599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9gnz/R+qrNVgmmIaGL7wJ0/aQs0WxPT/Rvo6Cr9iXn0ZghCja+xc33pGDA?=
 =?iso-8859-1?Q?oxsg4HSy3emt6EccJTfXsFmrH2KixGuYg0lLpHR1RvlDeNeuBmaaaX2EDz?=
 =?iso-8859-1?Q?mSTSTQUeNNtTMAhuu7q5/2pa/V6QSc+AJK3zvmuXG3oSZEfr/X02m9XiQ5?=
 =?iso-8859-1?Q?RN1ZM4NlKWoRe2k1hU+5TtxupIQP7wYeGm+ikGjsD3IYmOaSdg9ZqaQHh7?=
 =?iso-8859-1?Q?CA1xSl9dRhyf4aAZXoYhRS+Ld3/i+e8/fV+wO5kHSHigaIaemq98e44Vzi?=
 =?iso-8859-1?Q?tM39OHGLqRbuP6Whhd9C9lNfk/Ejye60OQBloLEkUJD9118eE+Se9QuybW?=
 =?iso-8859-1?Q?5/RJJexfGR5vQ0xb8rbwpZfIe1gac3lyXNV5ZnAH1xTYebnquSwR4bgGH6?=
 =?iso-8859-1?Q?xXJy7PEKVPPtKpsM1XzDHef3toGEpVZqbzNY39GRVjD8JCzEmXZnilr0HE?=
 =?iso-8859-1?Q?xkTJ7spo++ZLIgZq8wdgTlDcuacscSs1GK2BZWT+Q6ThkE+v4IL8fc501t?=
 =?iso-8859-1?Q?0rLbto5XE3M5yAliRPQ0FZZnOr3YF9oncmR17DbvCHCaLeIl5whyrX2OIi?=
 =?iso-8859-1?Q?pvemNJa7KUsJNjqfS0FdJYY8vSxC+K99imv/qzu27TObW5MfsHDK0MaZUW?=
 =?iso-8859-1?Q?NmlD0CRCUlIH+zYMyQpGmedyPwbGD2jD5cQcA3+QimL+syNzeDYGw8iRcz?=
 =?iso-8859-1?Q?OvEeBJ031wM2IYX4T/FzrXUbLoZhjongvGZODJfx7vHRV2S7PdnaDvsabu?=
 =?iso-8859-1?Q?KevE9NyhLVSfGZ4GZEn/HS4nDGadUmT9027Z/QndUFDiRiCJ6IvFrvC1wW?=
 =?iso-8859-1?Q?W8GGu+uL5VMaO40TSkkD3IuBU1Q4hclWkKiu+WlzSMpFaF0WfAikQBlpLl?=
 =?iso-8859-1?Q?sU4/tAcqWqcnPNgECEuvpDHA3n0XYftjX4StpJmno+7aVIkd0zQffAKF9+?=
 =?iso-8859-1?Q?JDsbeg76z8Sern8OlgT8Xzxh1rvbMCk0vM49C3BLW5qTr4tatKTf22xG9B?=
 =?iso-8859-1?Q?w06N5ulq28MDM35JLbXva+qOVnuQ6qXCo43/RcQJyliKsrrRIiN2tt4Viy?=
 =?iso-8859-1?Q?pBgGjTvcX+MG9yoV9nnNNxXiPr6j6NXVB27kJUzZ4hfg+vVqrV006H9e+z?=
 =?iso-8859-1?Q?c1jzeG8wq3jtUgSJvtONA/LqwtNHM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d3exUoXrJtiynfFSEE8JOfMoY4/nwv0k7fkXFGYZ+J+XiH2fiAK4DGKczn?=
 =?iso-8859-1?Q?2W2qGAbW+9XXRo4Ax+Ugf27XFKC4/zkMh/oJJVitbzEEsflPOugWW3gdpA?=
 =?iso-8859-1?Q?L6eKm5o2mLwZViniwx+kLNgfSJPaEdtbe3Yi9tziBHwBwUD3ua177wtsfC?=
 =?iso-8859-1?Q?g11BGgb7lz8RhOQuEf1f6czIppBakvTik2VXaMa7OhJl0MN3mCIyBY/7JV?=
 =?iso-8859-1?Q?TgMqBeqdniGEsS8LiG26qcvl3808gBqpuFHANw3O9fndapdba4QI+Oqfxi?=
 =?iso-8859-1?Q?SuzBlgsYwdZ+Ebehyt1y8dK1FOO7J18H5Y4Xjw6M5HmJRlMZByC2eniNNB?=
 =?iso-8859-1?Q?JWDEQG6dZ4TwIBKPWhiqKwwkDjnWc4GtS4KROSOMH+8JtBgV1mfAT5Payg?=
 =?iso-8859-1?Q?LjTu5RG8ErQeqzYwL1qo3rwkK/Q7kCcbjVFuw4OZvPoyc3KeWegO/bDEIM?=
 =?iso-8859-1?Q?D7XSrn7bEOlepQwtmNZIhx23YSyFNioMkYxfojiRDBGh/vlxfAp0k1qReU?=
 =?iso-8859-1?Q?iZpduhP/+nLR37KvUcgyVFDqjCWE0wpInF8E1xlmWU1Tma0O7M357KZa17?=
 =?iso-8859-1?Q?M/QKOMZl3t1XDk0sY3tncG9phokB4KI6pgOoTmW2XpZ3173dUursSdzm50?=
 =?iso-8859-1?Q?83fqo6xu+hhGgzNf/oncpw2DDFEI06K1OiGkXN2qDGP+nv6MfYHTWd8epw?=
 =?iso-8859-1?Q?faFWhTueRbM3yEd8wWB+Mzw5A8tOj9iunHDfNRX7PJRn87N6KHaJ5aWgZC?=
 =?iso-8859-1?Q?AxXxcdvZ/oa4qQimgxdxhgk2NUyQBuIwCIRXzn9Tgn4ZycmAZgiE6X2iT/?=
 =?iso-8859-1?Q?DoGK6CogCE4IWVuqPRyZrcNMMdFkJrOy0WmrFNYVTZe3Y8SzEc+5/R1ifA?=
 =?iso-8859-1?Q?/DITSca5wLgQg6JznFidJcTu3n1+sBDPXX5Z0bBgENLObeBZJZxGZaQSUw?=
 =?iso-8859-1?Q?EgePig5NU26+omGLXJ5fEEbLn6CaxWYpSDvrG30D6XVvYR/u8VsV7cFSTI?=
 =?iso-8859-1?Q?80YzL8M9b2+j+TJ/xHsajtIwslkXU5oRTmcLOrw2gnYSJwQXUyXSFzJrwk?=
 =?iso-8859-1?Q?vkBBr1JRRUnfxhcw1zomZYvKVZNgUhT2q3SljB7nCIg8zOAUWqaCcLHlp4?=
 =?iso-8859-1?Q?UcClfMkDRu+FppV73hZ1k1D2lbUjOZtDoqaLUzHP6KoI8oxNMYE/l8U5Qp?=
 =?iso-8859-1?Q?fD/JC2jptZUtuqG8FbSGPwmaGMRsEGJL+j+pE+rmtxxWImIfovk/eutDj9?=
 =?iso-8859-1?Q?EzKpiwU4/I9d2BjYuYuQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-7da6c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR22MB4048.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e80aa508-29a6-4158-e77e-08dd3a2289ee
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 13:50:17.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4770

Greetings,=0A=
=0A=
I installed ophono 1.31 on a raspberry 5 with which I paired an Android pho=
ne via bluetooth. I now want to test the dial-number script with it:=0A=
=0A=
python3 ./ofono-1.31/test/dial-number "<myphonenumber>"=0A=
=0A=
=0A=
but it throws an exception:=0A=
=0A=
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Me=
thod "Dial" with signature "ss" on interface "org.ofono.VoiceCallManager" d=
oes not exist.=0A=
=0A=
Any ideas?=0A=
=0A=
Regards=
