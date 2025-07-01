Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53A26E71B
	for <ofono@lists.linux.dev>; Tue,  1 Jul 2025 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375226; cv=none; b=Z4K7YzgojbcveIZE6C92UcRrdJ92EARxO0s0vrTPpKe4Lnsqeq4zy9Mfl7fAYe0EuS+DwLQWQxCNb4z4sH45L5OFlvJa9K68mSX6j12To3cna0xD9boRWMKNrplzkYjyO498AyUMI+8/ao2+KNA9ztOEbReB5tjCK2z6V0YcZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375226; c=relaxed/simple;
	bh=slif2mZ/EBxt/880yXsG5hF50NJoQmGqcA2yeie9xv0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUQTu7jhyvBXTzqGAJpnA0S/y/eyXvUw0yqmO9Tb5G0rEM7daATB4Adp+YY5lBmxMJ7rih1mWyPKhU6wZxwChoL2V6ozP+pMQFZ/UROrkpABwq1+0ZRFwrkWqH4BadEru7AkBulDL7kPz1clsyXTC9TnGxL/DFnRSMaaf3w9g+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=g8/Is4Vt; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="g8/Is4Vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751375218; x=1751634418;
	bh=it3yuEXcnHHPb1t3rJ3GEJZQtpNoW+lYVQVgEIiLRBw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g8/Is4Vtiukoc3QzNXWc7u0JIANnPgUMLmjSVD2Gtp83rv71vTcKkwzvrJlNCiauC
	 FVFoM5e4aK3zNLE18CohZuGMVIxbfvYbmNi8D2RWseEdIzwQpOhMM0Ae+30SwpGOJh
	 NG+FT1svjoaDG9WUFj+/FQojStEg4mxCUQEAHj2I6BTSQCZX6drilTTSADmcB79be8
	 c5oy7HiN/sMNON+fanGxbcnXoVN72CqO7qSmvYw4QaO0T7wKDeFWecLtKpuPTt+Yz+
	 bxX5VcC1gTrBceQVTVnZcxcbDk0ljpNRfy1rL7g32SsgNpupXYCITyZA/l2XQoUbZK
	 RIybOQksL/Xqg==
Date: Tue, 01 Jul 2025 13:06:52 +0000
To: denkenz@gmail.com, ofono@lists.linux.dev
From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/4] simutil: Add Forbidden operatator list(PLMN) fileid
Message-ID: <iqsltz227edv5f6rzhsyex2ibjj5f46xe3j3xbjytqzq7z7xlb@ptllzwsiq5io>
In-Reply-To: <20250701-fplmn-v1-1-d7fe9c901b57@geanix.com>
References: <20250701-fplmn-v1-0-d7fe9c901b57@geanix.com> <20250701-fplmn-v1-1-d7fe9c901b57@geanix.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 1af6adc0c5a736334b343d440e0fc6aeb0980232
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 09:29:46AM +0100, Sean Nyekjaer wrote:
> ---
>  src/simutil.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/simutil.h b/src/simutil.h
> index 91be5e2345d39bfe4f4f25f5f4c6b8dfd4e8c3ea..556412c4eaa089789092caa72=
fc3d8dd7ad5b00f 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -40,6 +40,7 @@ enum sim_fileid {
>  =09SIM_EFBDN_FILEID =3D=09=09=090x6F4D,
>  =09SIM_EFCBMIR_FILEID =3D=09=09=090x6F50,
>  =09SIM_EFEST_FILEID =3D=09=09=090x6F56,
> +=09SIM_EF_PLMN_FILEID =3D=09=09=090x6F7B,
>  =09SIM_EFAD_FILEID =3D=09=09=090x6FAD,
>  =09SIM_EFPHASE_FILEID =3D=09=09=090x6FAE,
>  =09SIM_EFECC_FILEID =3D=09=09=090x6FB7,
>=20
> --
> 2.49.0
>
Guess we also need:

diff --git a/src/simutil.c b/src/simutil.c
index 0fafcb7f..7cb3a5fa 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -84,6 +84,7 @@ static struct sim_ef_info ef_db[] =3D {
 {      0x6F50, 0x7F20, 0x7FFF, EF, BINARY, 0,          PIN,    PIN     },
 {      0x6F56, 0x0000, 0x7FFF, EF, BINARY, 0,          PIN,    PIN2    },
 {      0x6F57, 0x7F20, 0x7FFF, EF, BINARY, 0,          PIN,    PIN2    },
+{      0x6F7B, ROOTMF, 0x7FFF, EF, BINARY, 12,         ADM,    ADM     },
 {      0x6FAD, 0x7F20, 0x7FFF, EF, BINARY, 0,          ALW,    ADM     },
 {      0x6FAE, 0x7F20, 0x0000, EF, BINARY, 1,          ALW,    ADM     },
 {      0x6FB7, 0x7F20, 0x7FFF, EF, BINARY, 0,          ALW,    ADM     },

But I don't have a clue what BINARY/RECORD, ALW, ADM stands for :)
Is there a place I can look this up?

Br,
/Sean

