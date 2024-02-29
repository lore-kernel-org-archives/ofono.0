Received: from edc2-mailout2.edc.trendmicro.com (edc2vmout02.edc.trendmicro.com [216.104.20.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8197AE52
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.104.20.207
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221548; cv=fail; b=j7GagCmlO4Q8ujtpVatjoHf5k01lvqXOnBjuF9IrrpXvxtGhNIK2lF1opus7+hDMEqogIJQMKicUz4TeWrPN4TkDn7OYQQNhDO4On0XNbN7B9WnsuHDc9HNJJufyHSQ6ALB1jpYO8z+Z45UpO7U020z5DYFdoMhCZ4hfIQAPLR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221548; c=relaxed/simple;
	bh=o0ekboIkw/xE3y70jxuh7deeeHA8XWcykApX6ZjADS8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NrBG1hKUXlntnby/fUHhPTbyK4NZp/+2zBDWyDc56J2e0dsXP/oICerRNVUZluO0U2udyPgihfvM6mEmQcgp2WgdYmTmuIPrstreimd5mwqCToq00qCPnzckG/mT25LXzZ4dtvGrA94KmjRmKd+j1gKb6ka5n74uu1JcfdZfdWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=ZWWdFYs3; arc=fail smtp.client-ip=216.104.20.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="ZWWdFYs3"
Received: from edc2-mailout2.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 264D7461DAD
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:45:44 +0000 (UTC)
Received: from edc2-mailout2.edc.trendmicro.com (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id 0EBCB461DA5
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:45:44 +0000 (UTC)
X-TM-AS-ERS: 10.34.72.183-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from EDC2-EXCH02.eu.trendnet.org (unknown [10.34.72.183])
	by edc2-mailout2.edc.trendmicro.com (Postfix) with ESMTPS
	for <ofono@lists.linux.dev>; Thu, 29 Feb 2024 15:45:44 +0000 (UTC)
Received: from EDC2-EXCH01.eu.trendnet.org (10.34.72.181) by
 EDC2-EXCH02.eu.trendnet.org (10.34.72.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 07:45:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 exhybridemea.trendmicro.com (10.34.72.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 07:45:41 -0800
Received: from DM5PR0102MB3477.prod.exchangelabs.com (2603:10b6:4:a1::19) by
 DS0PR01MB8036.prod.exchangelabs.com (2603:10b6:8:14c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Thu, 29 Feb 2024 15:45:35 +0000
Received: from DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e]) by DM5PR0102MB3477.prod.exchangelabs.com
 ([fe80::62f9:a52f:7777:ce4e%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 15:45:35 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "ofono@lists.linux.dev" <ofono@lists.linux.dev>
Subject: ZDI-CAN-23460: New Vulnerability Report 
Thread-Topic: ZDI-CAN-23460: New Vulnerability Report 
Thread-Index: AdprJkoVslblVfH/RDa+oMFcryiLjw==
Content-Class:
Date: Thu, 29 Feb 2024 15:45:35 +0000
Message-ID: <DM5PR0102MB347780D14317C7F10F52F345805F2@DM5PR0102MB3477.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=f8391a2a-bbd5-4375-9391-8f6bf6e88b05;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2024-02-29T15:45:28Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR0102MB3477:EE_|DS0PR01MB8036:EE_
x-ms-office365-filtering-correlation-id: e6571dfb-0dbc-4fdb-fd62-08dc393d7830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okS8I94TZfPTFnASZgvSPjIiEeD22EOZJPF9aP9GiolHYH5uD9LysMgGOe3dr0Re7XRD5hC/QlxmHPd3D1HkVECd8TUgjieo/uoaWdjsHOByKoqsr2dGbsVxW3MXvy69tIW8KMF15JmxNz1V+wwRCnbgk3/2RaL6NzqL9emizaJNuLJqKqEXyxjzaD6wtIh02Ux61LG6H6pe+i4wdAw/ngQzTFIKclNXlqvw6q6K70STwEiDll1U4I5A5PES5IXBlM0b7CtIxI4RQ6wKcxlYWh4NxdxTJHgKVfIyH6MYFPxrBXeCkx/qBylftE7kHSbGPW2DhsaU7nydRtRdylR08mxLuaOPFb2cR8RC1N+jqnneAC9Q+JWq/UFr+qviPlN0NAxdQgswy9R/BbbEnc8dP/2pjEry6gWOjEgUhDnrU1lvsiVPZfnr1p+WjDUP7Q/sYnasqPoAz1lmO2R1YwtF2wye51+LnBndIg5eE0Ezihdx3mx7OekuDA+pg3bRLv3XIlL+hrOIFVE7W28W1Ov4EthdN7qQxzJiN/RgKfOkLi8EnkZVGhwAVU9biaSU+isEZpeR3yKhzbML0eAiN0bQR+q2kaJBdgG+zbLLZ2GNYfc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3477.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?golskDK8nICNe/+bE+Q8VfyFM1ngOR3Vdv9IayJCHX0b/Fe3KUxImCcplPCo?=
 =?us-ascii?Q?VJ8HsfQmS3HzaKFnbFV5lB0xF3F8X64w1vLVR37wjUKgAr5btZM7Bfvnvk3Z?=
 =?us-ascii?Q?UZ50MFh+AjRV7zVXx5HJjFWUSr4RnnwOp/t+UdSpcp+bWopb6Lhpu25OgQxp?=
 =?us-ascii?Q?XZviD5qE22YvAvvzICqEJniu7iuKF4djdcU7l4vlY/n2nXHfFkLucD2vPOPn?=
 =?us-ascii?Q?f4JJdQ0Y/QAfjHqqaS+FjpBobwibTgNU9X8gpZ8qXqpyF9p+dJf5vtnIqq1c?=
 =?us-ascii?Q?9mpfuKL0RBp1WcnJ96qIwYMzobQ68QflaRikivLSOuYTtiN9cxi61jVj+BEv?=
 =?us-ascii?Q?H0HONXUvylxZybQFp9Lr1ZPnUr9Sm9STI4g7VvGrIYKyMwhbNyoKy6oCsznv?=
 =?us-ascii?Q?5Ekdr6ygzbyhgmXxBWD4l+IROYydYH9gBO8RWVVDoAW634YP5rIxDgMQ0gzA?=
 =?us-ascii?Q?IputXndSPNz4fu+pluQO8ndm60VVL+H11AsbUvN3o0iNVA7AbyEjieKT0xyR?=
 =?us-ascii?Q?0wv08KvyW4JW0+pLeaMAP2rWMauLhJiY1zdzfhjLPteUmu53IKTZ4e+RNFSE?=
 =?us-ascii?Q?te/5DLsolwrBgl/wlUPz00TK9yktwO6sLQb3SCdyv6T+s3fAJeaI++NTupZk?=
 =?us-ascii?Q?Sw94HxIaUd0OXo5BccWK1/FLGx1dkz4hrzbhckh4/k/iaXSVf6NFlGKUczWg?=
 =?us-ascii?Q?OirYDYxd4IhALPcMkammTUuxXBpLiZvpxjQQ1V+t/EB8UBdHRlszikKg/VXk?=
 =?us-ascii?Q?yD9W0sOXi/WsbMTxZf7bGoEHZOsmf3J5mk3WM2mMcDkkXG3RYu/sU/QM047G?=
 =?us-ascii?Q?eBcZlO0ZLlYfvKHZP8XNtIqPN5QYGwUWfSd7iVx1e0KxiuKWeLYW8qSHEPEK?=
 =?us-ascii?Q?nSodrq1AN4zkBSZUs6j5tdWLPlmIRgP+qJF1IGF4Dx/dI7hq868VcN4OpbZs?=
 =?us-ascii?Q?xsNGIHxqayif+qizazq48DpErdRjwMyU9AnwS+Z1Lv0hqlzh21VwjUd3eizJ?=
 =?us-ascii?Q?VpQdvKSe5OCG9DBvSaAXbpr6gMAVMjGTaovIyy+DodoXZm2neDqjFsK7cmb0?=
 =?us-ascii?Q?3PGNnxb7NyHL18A83aYM/M4kIGQxI0RcD1OhH6nUQna4IHLpEWNePIc/vazx?=
 =?us-ascii?Q?zPUAKg+4RdyMcrVoA44Dn7B7Kb/Gcgg/Zaqe/65LXQsqJXHXOlKYVArk5qff?=
 =?us-ascii?Q?IJiZX5SGwJWZljpw4lyXJnsfpGxlFgF38wQUyrU3Y0T4o2EGNQP3Q/z2h67C?=
 =?us-ascii?Q?etZgkuwpBoUT/482maVhcjm4FZsVwEgQgC5/AG3F89A7WlZjIAbpksIcWitc?=
 =?us-ascii?Q?rCfUKAtUrdP+2SSyQjI6vRdB9rVJ59NQTGk4DHd71JFZGFWk1aLaXJLV2v3M?=
 =?us-ascii?Q?BB7b+SrQciKCR5MoNdFdHxV8PyMEhyxC/uVhIBHTjGhRJcprZZAq/hsUf9nX?=
 =?us-ascii?Q?uW6Qeph/7fpCPP1+GbHrrgUvfDhsDx6B+AJZM3Gv3k5QeaILvTk2E1slD/zr?=
 =?us-ascii?Q?+Z0idnG25lQHZhMrkHppP2eD1Szq+lEtO4v2CgnsbVSK0jffZlwWsPtICVBX?=
 =?us-ascii?Q?cCqq0ghNmYQC1TOZgS3/LJ0iOEbySoOZQjZiwnFcNl4FI+886BukIOUFhJEL?=
 =?us-ascii?Q?IhLE0BypQgz+NStOy9hGqhQ=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNimxLcxWXEHgIyJsR2aweZkQK8YXUlFFbfL1xmHC+0SumQmIulUXV4zqU5ChtErPs0q/KCoAI5cy5xpvvb4ypPI7Bu2V1jYEEJVR/W6kFcjIULMJ1mZbTTOSBNK9uMWQEaYq1MiUhv631AJlXR9VqziaWLEVmKwJ93xebVIWmblPVjM+/7mT5a1tjBQYPZa2xcUqLzFQ22a5x6gPLwn3/sMpccWkR3R9br9GOcwQZZvh+xl9PzOaLFvNDNm03owcC2ENLtZqJP2mHn2xLC67xL9i4HKVJfijfFlVIRgWe6wF+8bAkaQgFD0U0DznX8iLH0s0LiqT2mRz3gLLtRCsQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVPacvg4QXIQQgjrrW8qWb/UxoECdt8OZ4CRITJol4k=;
 b=OpBo52iVgxEnl1le0S4Job31rmbsBCzCyhhVKroUtg81QAbf0GcuN3V1x/XTa0RW4y1DG+lMyxyCea+MqNM91VZOnWA7WghAHlKRqX09m/hpEtG/ObyaoUnMhi5iN4V7nk7i3Lj4+75975dzO4paH07dpdWSr5H9SIpMyL5DrTyZaxnnH2XZJhwjoJ5nqnk70Z9UbAtwEmqOD+yvy/6SOYVCzQn1W2BOphOUV+ahn2HuoyKDzprKV237YbSgJpsEJewvkAuKw0kb3GoBIgu6Dk6hCVOiRVWwY/KVTJ1QcB0tEWp5EXnVbjaOH4/Yk2Uj9HM/aYwKOBUJaLHMMDsGIQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM5PR0102MB3477.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: e6571dfb-0dbc-4fdb-fd62-08dc393d7830
x-ms-exchange-crosstenant-originalarrivaltime: 29 Feb 2024 15:45:35.1950 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 5W4IVx8x5yymwMRVTITJ1+efiMmmlQkPBjuqaBSm5Q6jQvYSJvEAXdeByyeRbEzOSJExBkaGDUtesBFbfxSTO1K7T5qYs9vjWVEhP7zO8kU=
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR01MB8036
x-originatororg: trendmicro.com
Content-Type: multipart/mixed;
	boundary="_002_DM5PR0102MB347780D14317C7F10F52F345805F2DM5PR0102MB3477_"
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-TM-AS-ERS: 10.34.72.183-127.5.254.253
X-TM-AS-SMTP: 1.0 RURDMi1FWENIMDIuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
	HRyZW5kbWljcm8uY29t
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=tmoutbound; t=1709221544;
	bh=o0ekboIkw/xE3y70jxuh7deeeHA8XWcykApX6ZjADS8=; l=24711;
	h=From:To:Date;
	b=ZWWdFYs3hJhfRJoD5ywhQf0X5iiknMjUMY+im2mkW53k3xAt4dJ5C3lc69oGkgB4O
	 88frMcKzDZ3ybtEN4lKaH6B9L9EdbLTCN8tBDIrmk3JlHpkqrLTe6O0kEpcwYgTfQ8
	 5r2ZLBMeLR5wEJyH2OPMqogq6mM2PfFp00dMEY3E=

--_002_DM5PR0102MB347780D14317C7F10F52F345805F2DM5PR0102MB3477_
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attachment could not be scanned for viruses because it is a password =
protected file.
ZDI-CAN-23460: oFono SMS Decoder Stack-based Buffer Overflow Privilege Es=
calation Vulnerability

-- CVSS -----------------------------------------

7.0: AV:L/AC:H/PR:L/UI:N/S:U/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
oFono - oFono

-- VULNERABILITY DETAILS ------------------------
* Version tested:2.3
* Installer file:-
* Platform tested:ubuntu 23.10 desktop edition

---

### Analysis

```
stack overflow bug is triggered within the decode_command() function duri=
ng SMS PDU decoding
here assumed that the attack scenario is accessible from a compromised mo=
dem or possibily accessible from a malicious base station or just SMS
```

~~~C++
static gboolean decode_command(const unsigned char *pdu, int len,
                                        struct sms *out)
{
        unsigned char octet;
        int offset =3D 0;

        out->type =3D SMS_TYPE_COMMAND;

        if (!next_octet(pdu, len, &offset, &octet))
                return FALSE;

        out->command.udhi =3D is_bit_set(octet, 6);
        out->command.srr =3D is_bit_set(octet, 5);

        if (!next_octet(pdu, len, &offset, &out->command.mr))
                return FALSE;

        if (!next_octet(pdu, len, &offset, &out->command.pid))
                return FALSE;

        if (!next_octet(pdu, len, &offset, &octet))
                return FALSE;

        out->command.ct =3D octet;

        if (!next_octet(pdu, len, &offset, &out->command.mn))
                return FALSE;

        if (!sms_decode_address_field(pdu, len, &offset,
                                        FALSE, &out->command.daddr))
                return FALSE;

        if (!next_octet(pdu, len, &offset, &out->command.cdl))
                return FALSE;

        if ((len - offset) < out->command.cdl)
                return FALSE;

        memcpy(out->command.cd, pdu + offset, out->command.cdl);         =
       // overflow here

        return TRUE;
}
~~~

ASAN report
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D7530=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address=
 0x7ffff560015c at pc 0x7ffff7870e93 bp 0x7fffffffdbf0 sp 0x7fffffffd398
WRITE of size 255 at 0x7ffff560015c thread T0
    #0 0x7ffff7870e92 in __interceptor_memcpy ../../../../src/libsanitize=
r/sanitizer_common/sanitizer_common_interceptors.inc:899
    #1 0x5555555663e8 in memcpy /usr/include/x86_64-linux-gnu/bits/string=
_fortified.h:29
    #2 0x5555555663e8 in decode_command src/smsutil.c:1474
    #3 0x5555555663e8 in sms_decode src/smsutil.c:1590
    #4 0x55555555b2ee in test_simple_deliver unit/test-sms.c:187
    #5 0x7ffff773e85d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8585d) (=
BuildId: 200be351efe83301ebaffb390ac30b652a88bac1)
    #6 0x7ffff773e78a  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8578a) (=
BuildId: 200be351efe83301ebaffb390ac30b652a88bac1)
    #7 0x7ffff773ed81 in g_test_run_suite (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x85d81) (BuildId: 200be351efe83301ebaffb390ac30b652a88bac1)
    #8 0x7ffff773ee07 in g_test_run (/lib/x86_64-linux-gnu/libglib-2.0.so=
.0+0x85e07) (BuildId: 200be351efe83301ebaffb390ac30b652a88bac1)
    #9 0x55555555af3d in main unit/test-sms.c:1759
    #10 0x7ffff742814f in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
    #11 0x7ffff7428208 in __libc_start_main_impl ../csu/libc-start.c:360
    #12 0x55555555b114 in _start (/root/ofono/unit/test-sms+0x7114) (Buil=
dId: 8578597d3d029fa411dd5f7740b8fdd713c8d322)

Address 0x7ffff560015c is located in stack of thread T0 at offset 348 in =
frame
    #0 0x55555555b1ef in test_simple_deliver unit/test-sms.c:174

  This frame has 2 object(s):
    [48, 56) 'pdu_len' (line 177)
    [80, 348) 'sms' (line 175) <=3D=3D Memory access at offset 348 overfl=
ows this variable
HINT: this may be a false positive if your program uses some custom stack=
 unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow ../../../../src/libsanit=
izer/sanitizer_common/sanitizer_common_interceptors.inc:899 in __intercep=
tor_memcpy
Shadow bytes around the buggy address:
  0x7ffff55ffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff55fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff55fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff5600000: f1 f1 f1 f1 f1 f1 00 f2 f2 f2 00 00 00 00 00 00
  0x7ffff5600080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x7ffff5600100: 00 00 00 00 00 00 00 00 00 00 00[04]f3 f3 f3 f3
  0x7ffff5600180: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff5600200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff5600280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff5600300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7ffff5600380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D7530=3D=3DABORTING
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Lucas Leong (@_wmliang_) of Trend Micro Zero Day Initiative

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/

TREND MICRO EMAIL NOTICE

The information contained in this email and any attachments is confidenti=
al and may be subject to copyright or other intellectual property protect=
ion. If you are not the intended recipient, you are not authorized to use=
 or disclose this information, and we request that you notify us by reply=
 mail or telephone and delete the original message from your mail system.

For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: Read privacy policy<http://www.tr=
endmicro.com/privacy>

--_002_DM5PR0102MB347780D14317C7F10F52F345805F2DM5PR0102MB3477_
Content-Type: application/x-zip-compressed; name="ZDI-CAN-23460.zip"
Content-Description: ZDI-CAN-23460.zip
Content-Disposition: attachment; filename="ZDI-CAN-23460.zip"; size=11250;
	creation-date="Wed, 28 Feb 2024 17:56:17 GMT";
	modification-date="Thu, 29 Feb 2024 15:45:34 GMT"
Content-Transfer-Encoding: base64

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
SwUGAAAAAAEAAQBQAAAAjCsAAAAA

--_002_DM5PR0102MB347780D14317C7F10F52F345805F2DM5PR0102MB3477_--

