Received: from mx0a-003ede02.pphosted.com (mx0a-003ede02.pphosted.com [205.220.169.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BE28F1
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.169.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551600; cv=none; b=MPvuBTLrIr1Ohxk5m1T1JqwB7xfDpgucf/DOLre0UKMNn5SEA3fnR7USxhWKKSsJuJR8yaFvmnZfwAYDA0NN5rw/Nxy51S7jESolJShVqW0Ag+G4ok/dtYBu6Dbk+DJ+MPSOwnco46unXZC0esHC0luqLyuczfrN/pLGBzJUuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551600; c=relaxed/simple;
	bh=S2Npq790KoVr9SBUQNmDHevKLkFEAYrvG9OLx6xZtao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKqJ0P+L3U9OJqhl5wv+I2iKmhkqTBjAsVKTO10xmo4yZNgrJyw4JeDopPjNIvK1fBhE8st7jVZKkDqxKsKTWMFwecBF9kuY8x12UdqanVzFPVB/bW1Q0ZIeEGufJ/OVjuKFWHAqkDteqJxwcBs0ugrhEMpxFQGkL2IV/tljsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=BPlcWS1D; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=iA9/WBN0; arc=none smtp.client-ip=205.220.169.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="BPlcWS1D";
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="iA9/WBN0"
Received: from pps.filterd (m0286617.ppops.net [127.0.0.1])
	by mx0b-003ede02.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JCq7PM017058
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 11:33:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getcruise.com;
	 h=mime-version:references:in-reply-to:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding; s=
	ppemail; bh=S2Npq790KoVr9SBUQNmDHevKLkFEAYrvG9OLx6xZtao=; b=BPlc
	WS1DKzRcLExmMNZNg+c82xrA/DXMbxNaogIJozxCMI7q+hyzDxXU0ypAPzpVEn5+
	D/+fWJ0/A/jPvz2VTKqmmzDy8teISNuAXHz+TujEJ3MhFf0tuaHWTWrUTMp4fKXJ
	1Ytp+sWg71K5yWgcWBuzBXgrm/Ab7e1jsodu/dzUyFDWvffEt7RhlscqGZJguJFg
	hmo7MHPIKpPL7b3IpsMcv+8kIOJPPWkGZXbxmIiuk10TKjVqR0r1YqMHCJKZaXU6
	XymbAi0BWLoL+sFkPCSvgf0d+tMvs6/bM79B7O7hAtyUi/8ngss/dMkmD85YGbxy
	T1UDLulfAxg7pb950A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-003ede02.pphosted.com (PPS) with ESMTPS id 3xjf47jdhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 11:33:17 -0700 (PDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-437090005bbso21508791cf.1
        for <ofono@lists.linux.dev>; Fri, 19 Apr 2024 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1713551596; x=1714156396; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2Npq790KoVr9SBUQNmDHevKLkFEAYrvG9OLx6xZtao=;
        b=iA9/WBN04ZcR1Lz+Dexnc60lH/44ZUHoYtpgDARzuAQOYMdikGfEkARg4IJbu5CPJi
         mZ8IFHhM67NxSPYD+6z3lnqklsK43MZh7aNKuQ7ZAb1haN3PbYIIEoYk/+Wl/Xo/bVl2
         AGLuHy5HpZkArVUu4I3JTCEKKREFtQ5zSp34Qo4VEIWtXQxN3wXUdg26gxQCGRhcMnkz
         2NK09HLk49AeU5leq/M9fNySDn1Wyb+z9CigGVw1YIJcblIga4/oVRrn8FEkzxgX2YZ+
         9JGhN+gAdh8F4oDxgPN85DryOIdME9tsGkK/jtmxWeOd5i6qtsKp5GIPew62Q3DI+mpu
         oVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713551596; x=1714156396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2Npq790KoVr9SBUQNmDHevKLkFEAYrvG9OLx6xZtao=;
        b=hOKdS5MPNt9SLWinQ1QjeEwMSYfDRlu0g8N1tJa7Yn/dxATaEoaa8SC9KhsRZqYxHP
         QHYsbQub4fQ/2i01u4lAe9K5hmKGJGa6uPYl3bcjqGQbgsxcjRXSITKsyHXeX1GamJ17
         vsgSE1pXgQtPu9APTC/6CjADLm8MDZHHRzheCavEx0hi07lWll5fmNOYUyV6Fu+TQP9g
         uI2ndUhGUusXCQArxijWtrX6JfjTTv/K3y3rRnvez/35IOiRs41QtcOxmYsmp3DutH57
         Q7KXVxU8gxcHrg18qRY1hA+GiWA4XOeOAtyidAW9OIbwJW9Mojz2FMl60hktsfHWJKuH
         85Rw==
X-Gm-Message-State: AOJu0YyswhFDZi+gHhOgFYX6rji+weW9CmnLHwkBKF50T7V1pmm485zX
	XBRwQ1RrvtVhgXS/+3NyA3UBQ4KbvxA8s1dW/3BLTWdYesui/CfFFU6rcipxAbVS8DhXc6V8EMF
	HwkE+pocyAIKaPY36tLxtTumDwhEDtz/BMskNehfYYU2oY9ZvleMOwp/Nr7n95py04kry9nK1wX
	ThhqI7CAsFVDTGcBFnMx/P9VZC1kEYhBBACB8=
X-Received: by 2002:a05:622a:34f:b0:437:97f4:3f56 with SMTP id r15-20020a05622a034f00b0043797f43f56mr3646201qtw.16.1713551596411;
        Fri, 19 Apr 2024 11:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIkNrkkqOk4o/TAlFtct4Y4u3PVI3REwIO8HPKu+Ax/bq3QwiNcxTL+9ovLKtM4MO2Aot62OY2CtfveuX3bWA=
X-Received: by 2002:a05:622a:34f:b0:437:97f4:3f56 with SMTP id
 r15-20020a05622a034f00b0043797f43f56mr3646188qtw.16.1713551596098; Fri, 19
 Apr 2024 11:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240419164458.36078-1-steve.schrock@getcruise.com> <F63D5489-0513-4705-A7AC-D5F484AA6E79@holtmann.org>
In-Reply-To: <F63D5489-0513-4705-A7AC-D5F484AA6E79@holtmann.org>
From: Steve Schrock <steve.schrock@getcruise.com>
Date: Fri, 19 Apr 2024 13:32:39 -0500
Message-ID: <CAPUe8X8uj5v7g4FbhuwPZPEP_5AWxdnf0vfM97xLzYOLda0tbg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/8] qmi unit: Link to dl
To: Marcel Holtmann <marcel@holtmann.org>
Cc: ofono@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9gTtOfOLA8gosdQO02b9nJ1Yi2ZjsC3Z
X-Proofpoint-ORIG-GUID: 9gTtOfOLA8gosdQO02b9nJ1Yi2ZjsC3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_13,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190142

Thanks for the explanation, Marcel. That makes sense -- the VM that
had the linker error is a fairly minimal installation.

Steve


On Fri, Apr 19, 2024 at 11:53=E2=80=AFAM Marcel Holtmann <marcel@holtmann.o=
rg> wrote:
>
> Hi Steve,
>
> > One of my VMs was getting a linker error when building
> > test-qmimodem-qmi in maintainer mode:
> > undefined reference to `dladdr'
> >
> > Add -ldl to fix this.
> > ---
> > Makefile.am | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 9a6f82c39552..a4880036eaf5 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -932,7 +932,7 @@ unit_objects +=3D $(unit_test_mbim_OBJECTS)
> > unit_test_qmimodem_qmi_SOURCES =3D unit/test-qmimodem-qmi.c src/common.=
c \
> > src/util.c src/log.c \
> > drivers/qmimodem/qmi.c
> > -unit_test_qmimodem_qmi_LDADD =3D @GLIB_LIBS@ $(ell_ldadd)
> > +unit_test_qmimodem_qmi_LDADD =3D @GLIB_LIBS@ $(ell_ldadd) -ldl
>
> this depends on HAVE_BACKTRACE.
>
> Regards
>
> Marcel
>

--=20


*Confidentiality=C2=A0Note:*=C2=A0We care about protecting our proprietary=
=20
information,=C2=A0confidential=C2=A0material, and trade secrets.=C2=A0This =
message may=20
contain some or all of those things. Cruise will suffer material harm if=20
anyone other than the intended recipient disseminates or takes any action=
=20
based on this message. If you have received this message (including any=20
attachments) in error, please delete it immediately and notify the sender=
=20
promptly.
