Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3F16F8E9
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508878; cv=none; b=QX5M/4twcUcGJbSjdko5f9Uy3j5eqIcOMsWxSJar3hPocMXjdtwxR6sBmxxKJT6ZbdOfsuswm9uLvvrsw6x1sx4XxjIFyqkBhGSUS/7WhJK4F/Woj4B928DOyjYhLd9n7p+356jQ1ADTNJrYcYH9odjDCD6A4HJHT1NyPVL+XIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508878; c=relaxed/simple;
	bh=K77WbkcEzhan6d30lxUkm4BRruIaDafQhnNUmnirrUg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cP3C5x9rhwAvT0ibqAoEf22CE00MLLn4TEc/t70YdeZNdg14mAnGdW/wOvYl+nJLTWsTnSmdAj5Igp4xpM+ybKCkGkKYsxLM/kHC4gtlrj7aAzS8X85N/3ll1k3IROT9gXYUxbXAKrUKiFsBZp6pEhpbBtEpsf79RAhU8ezp000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Ue7t72vt; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Ue7t72vt"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1F213164A4D;
	Thu, 13 Feb 2025 23:54:34 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id BE7E6125167;
	Thu, 13 Feb 2025 23:54:33 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <500BF5FA-3998-40EA-BE10-EEB6955D8328@nuovations.com>
Date: Thu, 13 Feb 2025 20:54:22 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <57046678-4B51-420D-A4B5-94D4DC383297@nuovations.com>
References: <cover.1739406657.git.gerickson@nuovations.com>
 <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
 <5e8f1d1d-01d3-4577-b17d-c565e93f9e0d@gmail.com>
 <500BF5FA-3998-40EA-BE10-EEB6955D8328@nuovations.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=Ps/7MrGsxeZevU3lAXBTEPjvwc3ZO3PgdankfxdVLPg=; b=Ue7t72vtFt/OLCxa+tSWAQXpO+hs/3D62zw7W0VGQVAeR+fsd6+jSuzIPqu9bVYCDNToiD5KZv36w87Q49Y19vW6LHYs1fYYc+hqC8/Kd0LCcZYxFDkbwbZIfSgXAz3E34knsfsz29Yww99T5DsyBCpCrskwv1xfOivUb5W1SAw1Xrf31D42WITiSHZXEZVMvMU2JdYZRlGKuONRmmNzBkpAGTDYC2FIGKiBEbSk2KMeVK20nYbdh+Al0DPOCVWoVBZ4k1YVINp0Xt87AfsxELiwpsw5Cx3ANHqkrmqRXhnaancHT6uufDtUePwIU2SfxQ/1J1wivlfjN2g34PIVLA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 13, 2025, at 8:22=E2=80=AFPM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>=20
>=20
> On Feb 12, 2025, at 6:07=E2=80=AFPM, Denis Kenzior <denkenz@gmail.com> =
wrote:
>> Pretty sure this won't work and gcc will complain.
>=20
> Surprisingly, GCC 8.2.0 didn=E2=80=99t squawk about it:

Surprisingly, GCC 12.3.1 didn=E2=80=99t squawk about it either:

% ${SYSROOT}/bin/arm-none-linux-gnueabihf-gcc --version
arm-none-linux-gnueabihf-gcc (Arm GNU Toolchain 12.3.Rel1 (Build =
arm-12.35))
12.3.1 20230626 Copyright (C) 2022 Free Software Foundation, Inc. This =
is free
software; see the source for copying conditions.  There is NO warranty; =
not even
for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

${SYSROOT}/bin/arm-none-linux-gnueabihf-gcc -DHAVE_CONFIG_H -I.
-I${PROJECTROOT}/third_party/ofono/repo  -I./include -I./src
-I${PROJECTROOT}/third_party/ofono/repo/src
-I${PROJECTROOT}/third_party/ofono/repo/gdbus
-I${PROJECTROOT}/third_party/ofono/repo/gisi
-I${PROJECTROOT}/third_party/ofono/repo/gatchat
-I${PROJECTROOT}/third_party/ofono/repo/gril
--sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc
-D_POSIX_C_SOURCE=3D201112L -D_DEFAULT_SOURCE
-D_XOPEN_SOURCE -isystem =
${SYSROOT}/arm-none-linux-gnueabihf/libc/usr/include
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/linux/linux-dey/include
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/dbus/usr/include/dbus-1.0
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/dbus/usr/lib/dbus-1.0/include
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/glib/usr/include/gio-unix-2.0
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/glib/usr/include/glib-2.0
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/glib/usr/lib/glib-2.0/include
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/ell/usr/include
=
-I${PROJECTROOT}/results/${BUILDPRODUCT}/arm/gnu-toolchain/12.3.1/${BUILDC=
ONFIG}/third_party/eudev/usr/include -DOFONO_PLUGIN_BUILTIN
-DPLUGINDIR=3D\""/usr/lib/ofono/plugins"\" -DUNITDIR=3D\""./unit/"\"
--sysroot=3D${SYSROOT}/arm-none-linux-gnueabihf/libc -mcpu=3Dcortex-a8
-mfloat-abi=3Dhard -mfpu=3Dneon -fno-omit-frame-pointer =
-fno-strict-aliasing    =20
-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -MT drivers/qmimodem/qmi.o =
-MD -MP -MF
$depbase.Tpo -c -o drivers/qmimodem/qmi.o
${PROJECTROOT}/third_party/ofono/repo/drivers/qmimodem/qmi.c &&\ mv -f
$depbase.Tpo $depbase.Po

Regardless, I=E2=80=99ll address it and have a v3 shortly.

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

