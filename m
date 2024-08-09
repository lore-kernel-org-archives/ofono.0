Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2108.outbound.protection.outlook.com [40.107.103.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6120198E7A
	for <ofono@lists.linux.dev>; Fri,  9 Aug 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217962; cv=fail; b=oOW6edbseHESbFko+uDrBdzMckWU0gPx0GIOwWD1JoUZcLVmgX/xNhGvtwvAFEIt9+iWtT0FejHOz9K1LraUv3cY5IqD8hb2bK2DqB4DPr7QKM62TuC17/f15A3ZynAtll53SM9yNKY6l9tXfiz7yibroPsXqrioYgtGdLSZYF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217962; c=relaxed/simple;
	bh=6521sd7cFxPtF8oeJo+CQwHVWNxY1aiaIymYaBchJ70=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/RFh5ha1NaGw1ANqNc5OjYVAyUJNKeq0z1SstxxwRxvenniNFSkGToXp2VhiZJ3AGi+TNonj9FXt8SsOyot0G+gXv8yd3aS/Y3vFhLeS+7h63tB1aUGEeDk/OmWP5NvcR/Dtu6gzYisj1P7PpQk/CDy25MPUlJhEJjP5qzmAU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr; spf=pass smtp.mailfrom=kerlink.fr; dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b=05l5SOD7; arc=fail smtp.client-ip=40.107.103.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerlink.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerlink.fr header.i=@kerlink.fr header.b="05l5SOD7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCD0b+iQjMDd9brBdzVVrFI38UDOWdjp9tMry+GbiXQVF54c/OmACia1o4rXWsnLFqjdE7vdFiRgqLQWlL0+jPPzrscaC95iKcxZoS7lU0pEHHXNZJ/SqZqVey7WPIKxxF6jxYsvPoGDQHo0eNtYvQlAX55gbH/1VQ6v35CbDxIfQmVNSiSe3MPuZ7JLN3VssKQu0OaLVnWiz156KR2Q7rI1K7EcLas1pmEYxkgNVNnVojr1ATN5cODnyAYnOHgbN5B31tuWgU8xymkQoBPK0hYMy1pQG7PIijFdfF3dbyc9u8Cp+9FlfPzGm2muK9FUeu7M7JZJUWcka4W2bAKUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na/6mlbSveFuZCGgJw/d4kKGjWPFN4qkBuq4mbZiMBk=;
 b=W5FZn+efGc4ZajFsXDsY1lDvVmDJcN0qeBpdVPDaanjLSwUDbx5Mc81eLCyUP9OF3k/JN1ncWt+YLg04NDpEyxCgrgvUCf99iIzVvvzbCVnGBoaGeU7BymZIkfhppYKYZ7WahZ0cLEaxfmhxTPHv51cMCT2DL21DGP0rZQIngfWquNUwvVedEO07ZIn44F9wAlQMlLqXRUUrCV7LD6pD5gEGpm2AcMJnmTm40MNB/dOFSebyRHQO5LoQfT0b767Wz3JYSGaz7dcHUatN3nd4iKK+GA3ysIeLZ+VKcLb48vF+1ZYy6iY6Abv7chzGzf1GB7UhiiIkKtDoPd2JBns8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kerlink.fr; dmarc=pass action=none header.from=kerlink.fr;
 dkim=pass header.d=kerlink.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kerlink.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na/6mlbSveFuZCGgJw/d4kKGjWPFN4qkBuq4mbZiMBk=;
 b=05l5SOD7A3HGamWXdoZzrsl0gaeo3yOc1sxDGoN0lypxiN4Sa1quth22Pi0iq94TSsiHWNCG7RyU0XZi8jejIIDtmy6McTtyg0ljRdkTP15EB5NVH1RNalfrWxwKaOGcevydGJRSYpECOQY1GtnCGtoaBUMLEdxVuEkprF+sWz1dibcxbB/Uvix9oihBNW0L3faGQVSeHdSjgcihd1nJ8X/WjobgpG8Wp9OUa7S/CmEMYhFo5mezQVpgO1H1HuBnaAmPPWzGmo3p/B2klawwIb+wk443cf4W9PhLfoxTOyXOiTCztV7mB9vycDvRXmdzFxkkozAXnO6UI7P5KcCZaQ==
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:590::22)
 by DU0PR10MB7999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 15:39:17 +0000
Received: from AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2]) by AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83b5:b6a3:6e6a:bdf2%4]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 15:39:16 +0000
From: Jean-Marie LEMETAYER <j.lemetayer@kerlink.fr>
To: Denis Kenzior <denkenz@gmail.com>, "ofono@lists.linux.dev"
	<ofono@lists.linux.dev>
Subject: RE: [PATCH] smsutil: check that user data length fits in internal
 buffer
Thread-Topic: [PATCH] smsutil: check that user data length fits in internal
 buffer
Thread-Index: AQHa6k0CeyVypbv/50OGngFFF+lEkLIfDJOAgAADXwA=
Date: Fri, 9 Aug 2024 15:39:16 +0000
Message-ID:
 <AS2PR10MB748053CFF9F60F11DDDA329782BA2@AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM>
References: <20240809111213.853665-1-j.lemetayer@kerlink.fr>
 <81655272-5b31-4694-bdaf-2a36b4ee04d5@gmail.com>
In-Reply-To: <81655272-5b31-4694-bdaf-2a36b4ee04d5@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kerlink.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7480:EE_|DU0PR10MB7999:EE_
x-ms-office365-filtering-correlation-id: e4617d98-992a-4f91-1e50-08dcb8896dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ciRCCa8/qsEAyDh7kNrClZ7IVgFE4/mFrV5za3nCeauOmLylvlUdIBgS3T?=
 =?iso-8859-1?Q?TtLKm4dxdv2qjOA8eiEN4wQ+VNe09dTZH9lajc7aTo4l2oIXLvrkkC7Oos?=
 =?iso-8859-1?Q?O9buvPeE0oViPmqB6xZJoXD+kqjx6KAbcFfit0m9W4B8wRP8Z2cwIMlcJU?=
 =?iso-8859-1?Q?TLYwSy19DpHOhpUfLJp6uAa1zDO163oGysOYRrgs+5h8IX5YJaNj+rWyxT?=
 =?iso-8859-1?Q?MrZTauzPu87OxTogo3m5czVlW1JY6UEIkcp0rYzNeqEjWCGFrse7yCpvLK?=
 =?iso-8859-1?Q?T0VmQgLSb2qjnpoI4LYRlsH/UEcBjDEPemY4xgT6C7uKqA8cLCSRuw9meD?=
 =?iso-8859-1?Q?OAl7d85hgzB03qJLRNMMSBL1czhPiJqW2XtL8mOVQV0z02I+X2h44P768d?=
 =?iso-8859-1?Q?m2041EidcMnaUdSBDO4L5rAwCydaM1pGYq0yoDKpc688/pQMdiG65Yveej?=
 =?iso-8859-1?Q?uYXyBNi+GQqhVSdEa1GwP8skzSClYd+Qt5JVTa1JarCiMNI30e1B5zon1P?=
 =?iso-8859-1?Q?L/7fd6up+GpMZonxKbOXGrLW6WkpFEsEaULp2OPtKmXN+nDpXmGMFMLU7r?=
 =?iso-8859-1?Q?ivco2vmIHGXNqaap9WJR08vFr/hY+l8p2DXqOyZXnEKJTa+B/ROlQYXKa2?=
 =?iso-8859-1?Q?Fi9fKTjpvKAllBVFyUpZLzFi9vK8tUNoAa5ryWzD0gXOoErWHWvdr8TxkM?=
 =?iso-8859-1?Q?QW8CA1rqJfKFnIWxFa7Zq2P7gScWoGA17mQvuZ04cV5eEIJfXDGNyhYUlr?=
 =?iso-8859-1?Q?T4CF0GuVpYKZMb40wR7EC7HjdAO6A11NY7xBB7PKSfbyyEhiJVX/G4x9GH?=
 =?iso-8859-1?Q?xUtuqz2t0jULyKGKwhdyIZJUSn2nvBFgRPGL+gGjUEZK3y9RRYm6sRLbLw?=
 =?iso-8859-1?Q?Ngr/vchYY4vmmwXnG7wazYH7/SCM/dROGv+Bxo4IUIYsgBLYdMI+7WzBZz?=
 =?iso-8859-1?Q?ZSeqt/kw+xrod1jusWx0G3SepGLE6XE8GhJ5uKBaV31oiHEA06ZB/faybQ?=
 =?iso-8859-1?Q?LHirEZFDhEaJE5qZbQ3QWqxMzas8QoKZEZ5S91Igd1pmfT5IG/rCtlT3LM?=
 =?iso-8859-1?Q?A4xtdBspVNErsCC7/nk05SoPPD4d5kIkefV6WBOcIgFV1iWVVqRBNP0D5u?=
 =?iso-8859-1?Q?eCKP/6DbsRlUZcLpz9XCgv9nB8K5P3nGK0/YRMVAGhjalJ4kivZ/+zL8s9?=
 =?iso-8859-1?Q?EOLLHFpoI24c71kDv2jZi47RvSF9tG3Iz76WzBJ7lg6cL9A2jpr//4V3y7?=
 =?iso-8859-1?Q?+uQ/MCASpDWdxG9sUrYjIYjBWWxcp7AR+v2PWEDtjxCmCoScfIeKZ4UvPZ?=
 =?iso-8859-1?Q?QyRBmxyF4WQVq7pLU97MNn4Ce26Dzf/oXCM6xf418nTOthqLiRjCJiXw8K?=
 =?iso-8859-1?Q?Ue/G74Y/FqOeJegic6lnIa0eBitZOFDxOK8iYS6E/Oqr5LTY2P0w5kZGGf?=
 =?iso-8859-1?Q?jA8ssDKSnVHiU0kIhZ7lnDcxJyiN8wMe3Y3wrA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GQCr/JVMhgSmtp8OwbZjeO5uy0aFc50nv5of17+GG+p7BBdcGlqAe/Wkd5?=
 =?iso-8859-1?Q?eOslYGrJc0EYYw64zVp+DnyBn2GaS5GorTE7wBMPvWWVNyEIg1Rp/37R67?=
 =?iso-8859-1?Q?W37RHvczLsH4yj7wyB68v6OCsoyieiJf9jHArRi9LAzVb48aaRlaL7MCI5?=
 =?iso-8859-1?Q?jVy499uW6VY7z/oSBO3pgxDFDAC+sXXVULlG3LZ3p3om1W31efe4KdoDoA?=
 =?iso-8859-1?Q?vCN/GTntAdVmjyKL6fBUpKp5mIca9/IvMDEP25Oi2Y8gGNEftvS0o6X6ZL?=
 =?iso-8859-1?Q?O/kM2u0DQrWnPl8PuPYzcrPFUefjnEtQFmF1Z3aBok9RmZUfiH+mkwwkj+?=
 =?iso-8859-1?Q?eezzlMyKGik5OIhGjN2Vis77SDbrWyUMMqZI5S8UA3RtsSj20a2XwbzLAt?=
 =?iso-8859-1?Q?5LMTln9aQbZepChg4fnM/A7doeNx//BsY+A10mBLfsd1KMIfvUTM3D3Hti?=
 =?iso-8859-1?Q?gsz+2ZwwmHGK3dqExmY5nv9ufz2hyregxMwuYA/yqOdh+Yd1OiIQG/lKA1?=
 =?iso-8859-1?Q?B0RXwtc+PmIHpdpjHYvbwjpQPmaAPv1MuJj0BJiGlUumKpuY86HUk990U3?=
 =?iso-8859-1?Q?TkCzOKW1zPfl0PHZY2F1ZnCOl5AdbAOPCilTSLgq7l+FuvgHedCKDzxJNu?=
 =?iso-8859-1?Q?w4hwXSt0/E7vvkzQ94T+vjAQO+PJDrPd8XJqePBBlSBUvU4r65XyiKIa/P?=
 =?iso-8859-1?Q?fYVYpjH00K8/179bSQiuw3F0d5Q+PEnun5Zkk5x+jplUkXQtDk1mPll4Xa?=
 =?iso-8859-1?Q?twagQaam51YeaBwJIvTWTClz9mmQzmc27KWZKMj+PORvvXJs2tf8Z/W8PU?=
 =?iso-8859-1?Q?8pq9Q3W7//bVA3qE7/3bqVYhCIo0n3wcsPRw8JulRvIr5ZEb22GwgdzQpE?=
 =?iso-8859-1?Q?6AvDfSscn73s+mbddvDDasUqDymPz0lyZQeP2jU/ail/leqdRzstohpspZ?=
 =?iso-8859-1?Q?OKtOg6RJtAfB59jDapbQ9Todd2oyrPcuKVNenZgO6NLtCQfE7CTOhnHcVf?=
 =?iso-8859-1?Q?ve9mE/VDbTmiL47C7SQxXxV6r1Lx9IxRhVkKhgYv1NT627YUEqncCL2RzK?=
 =?iso-8859-1?Q?VQ0nrW383y69n9zijbEnIakk9HlBrNN+GIelW/O592uma4uaydZgg9TdqB?=
 =?iso-8859-1?Q?UpUrfqZuNTuz1xS1dWwyYFVta1xvsWVIJ1Iyi5JQ5w/zwqvG6e8qVAGOos?=
 =?iso-8859-1?Q?tkP+JNz66ZdfGxgK76ueYLSIlzKNdDVv8qYC0Okh6tSzz/XyxkcJ7ubn9D?=
 =?iso-8859-1?Q?ps87Sg7UOaVlSQr+4l1n07in3NplSMJupq7cWWmJb09wVBeldTuy5eQm+t?=
 =?iso-8859-1?Q?kvtZlWJYpIQNj4bleVCYrvdKZueS/bxEwh4Rr2QhWC1VB/usq3r5yS4Eia?=
 =?iso-8859-1?Q?S2GdpJNl7nOUZVjIzvBcJLUiBII7z/Y4zrxk41LF4VQKFHga8+mjKR5X1e?=
 =?iso-8859-1?Q?1QYXiK16As6IuPMkqkTSArWC6JXaw50fdBlElfYUoK2eEjtS1kRKdsfl49?=
 =?iso-8859-1?Q?2cGSJ+f02wtBesWwT8UDGoqnxu5rZihRivbzWn/DkQIo7ASc7FjV4vy6dt?=
 =?iso-8859-1?Q?7Z2SGeu6eaMIFxYohbA2sptmYhLUQ89IrYNhSzaF4euNxRS+D+RaiU49Fy?=
 =?iso-8859-1?Q?+rsWvXf0f5aQRotEU+La4vyvVIKdoJ8JaF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kerlink.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7480.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4617d98-992a-4f91-1e50-08dcb8896dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 15:39:16.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e53a72e6-936b-4019-8ac1-596e63242dec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BB2FwCCiK++T7JQWeW7RIPi4gvR+pEQJlcxjvu2oieF+YFx2jdMbF6wsHjVOUiydDHCcE54nTr55Zo6X1LTmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7999

Hi Denis,

Sorry for that. With my local GCC I didn't see anything...

I will provide a v2.

Best regards,
Jean-Marie

________________________________________
De : Denis Kenzior <denkenz@gmail.com>
Envoy=E9 : vendredi 9 ao=FBt 2024 17:27
=C0 : Jean-Marie LEMETAYER; ofono@lists.linux.dev
Objet : Re: [PATCH] smsutil: check that user data length fits in internal b=
uffer

Hi Jean-Marie,

On 8/9/24 6:12 AM, Jean-Marie Lemetayer wrote:
> This addresses CVE-2023-2794.
> ---
>   src/smsutil.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index 39f0ecc6..7f065d9d 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -773,6 +773,9 @@ static gboolean decode_deliver(const unsigned char *p=
du, int len,
>       if ((len - offset) < expected)
>               return FALSE;
>
> +     if (expected > sizeof(out->deliver.ud))
> +             return FALSE;
> +

This doesn't compile cleanly:

Fedora (glibc) clang optimized
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Configure: PASS
Build: FAIL
     src/smsutil.c:776:15: error: comparison of integers of different signs=
:
'int' and 'unsigned long' [-Werror,-Wsign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |             ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~
     1 error generated.
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Fedora (glibc) clang debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Configure: PASS
Build: FAIL
     src/smsutil.c:776:15: error: comparison of integers of different signs=
:
'int' and 'unsigned long' [-Werror,-Wsign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |             ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~
     1 error generated.
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Alpine (musl) gcc debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Configure: PASS
Build: FAIL
     src/smsutil.c: In function 'decode_deliver':
     src/smsutil.c:776:22: error: comparison of integer expressions of diff=
erent
signedness: 'int' and 'long unsigned int' [-Werror=3Dsign-compare]
       776 |         if (expected > sizeof(out->deliver.ud))
           |                      ^
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4073: src/smsutil.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2383: all] Error 2

Regards,
Denis
