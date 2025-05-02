Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3480A2580FF
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200406; cv=none; b=rXtNsR2jklU8PoJ1EIi2V6byuc7MjR9W9fRqc8dRGbiX3fUepNgRnAuXpJqdcLjlGDQ865aPLHlSW8HbMQr1BWKZI/PXZUKHEd7i/tZ0LU7vuOoSFPrybhr5pOv5fu/6PMs9oUesBj2x9tU7AyvhyMXyv2JR0YhAJYHK8cJG8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200406; c=relaxed/simple;
	bh=aUAyyMBkO5MOPvnym7QDdYIY2AZb6QIZ+nQeu356dAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bEcscxSy6t5VAo7/rIRui2gFRJ/W4x0cmdgB1ixVsths3PQYoyBAdoHBMVTZkmRp+3aZp60sFn+RBsLAV5jfOdht8k2R2KbcBPqxKFPzbVhI0rumSnkT5fPu01qiB0/696+7f0bo2yAZgn3Vur5T/WbIALNLQnWYok8Pu/75p6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OgwkGeja; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OgwkGeja"
DKIM-Signature: a=rsa-sha256; b=OgwkGejaqRpdHUHV1oLH3gLMgeVaQeYdMZUFc0sDXGPRixSZpeD86FL1k055kncQVj1hzxgwrb74Wip61wnfGW8nSgqdDFfLkP/uYQDvLOXDjnt/r+E9vX/TY0/NStcTzBQ3MP8pJ8xv2rDDmLB8+kgGd5NYz6gLZ6Af2KrprNUtnD6BpQcZxf3OH8nXbVNVtEA5327mbRg0Bhi6uv2s+wJNykA1R+6QOLQ5sRhg26ylyZ/F5TSxxIEued7/AQMqvN9iec9/wrdkQ5juZ5wvrnuh4592ZA3kdq7x+FwqMMZpCi0SNGiXKxOwe8B5M8Zhp/4vzpsmnW2jYmzfkUQrbw==; s=purelymail2; d=purelymail.com; v=1; bh=aUAyyMBkO5MOPvnym7QDdYIY2AZb6QIZ+nQeu356dAY=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1549552685;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 15:39:47 +0000 (UTC)
Message-ID: <96c98808-a751-41ee-b76e-bdcc2f23300c@mentallysanemainliners.org>
Date: Fri, 2 May 2025 20:39:43 +0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] mbim: Add support for MediaTek T700 modem
To: Denis Kenzior <denkenz@gmail.com>, ofono <ofono@lists.linux.dev>
References: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
 <92709ac6-98ae-46f4-b62a-9a6ce51d9414@gmail.com>
Content-Language: en-US
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
In-Reply-To: <92709ac6-98ae-46f4-b62a-9a6ce51d9414@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Denis,

On 5/2/25 20:03, Denis Kenzior wrote:
> Do you know if this modem is available in the US for purchase?=20
According to Lenovo, this modem is not available for sale in the USA due=20
to it not passing FCC certifications or something.
>
> I had this cycle through the CI, and CI complains quite a bit. Also,=20
> if you really want this to be applied upstream, then I'll need a a=20
> last name in the author information.
>
> Alpine (musl) gcc optimized
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Configure: PASS
> Build: FAIL
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c: In function 'setup_mbim':
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1203:25: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1203 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIR *d =3D opendir(path);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1214:41: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1214 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char wwan_path[1024];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~~
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1217:41: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1217 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct udev_device=20
> *wwan_device =3D udev_device_new_from_syspath(new_udev, wwan_path);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~~~~
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1221:41: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1221 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIR *sd =3D=20
> opendir(wwan_path);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^~~
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1231:49: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1231 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 char=20
> sub_path[2048];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
> =C2=A0=C2=A0=C2=A0 plugins/udevng.c:1234:49: error: ISO C90 forbids mixed=
=20
> declarations and code [-Werror=3Ddeclaration-after-statement]
> =C2=A0=C2=A0=C2=A0=C2=A0 1234 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct=20
> udev_device *sub_device =3D udev_device_new_from_syspath(new_udev,=20
> sub_path);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~
> =C2=A0=C2=A0=C2=A0 cc1: all warnings being treated as errors
> =C2=A0=C2=A0=C2=A0 make[1]: *** [Makefile:4090: plugins/udevng.o] Error 1
> =C2=A0=C2=A0=C2=A0 make[1]: Target 'all-am' not remade because of errors.
> =C2=A0=C2=A0=C2=A0 make: *** [Makefile:2405: all] Error 2
>
> Fedora (glibc) clang optimized
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Configure: FAIL
> =C2=A0=C2=A0=C2=A0 configure.ac:25: installing 'build-aux/compile'
> =C2=A0=C2=A0=C2=A0 configure.ac:41: installing 'build-aux/config.guess'
> =C2=A0=C2=A0=C2=A0 configure.ac:41: installing 'build-aux/config.sub'
> =C2=A0=C2=A0=C2=A0 configure.ac:10: installing 'build-aux/install-sh'
> =C2=A0=C2=A0=C2=A0 configure.ac:10: installing 'build-aux/missing'
> =C2=A0=C2=A0=C2=A0 configure.ac:8: installing 'build-aux/tap-driver.sh'
> =C2=A0=C2=A0=C2=A0 Makefile.am: installing 'build-aux/depcomp'
> =C2=A0=C2=A0=C2=A0 parallel-tests: installing 'build-aux/test-driver'
> =C2=A0=C2=A0=C2=A0 ./configure: line 12804: awk: command not found
> =C2=A0=C2=A0=C2=A0 ./configure: line 12874: awk: command not found
> =C2=A0=C2=A0=C2=A0 ./configure: line 13443: awk: command not found
> =C2=A0=C2=A0=C2=A0 ./config.status: line 1300: awk: command not found
> =C2=A0=C2=A0=C2=A0 config.status: error: could not create Makefile
>
>
> Checkpatch Output
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:8:=20
> WARNING: Missing commit description - Add an appropriate one
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:22:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:26:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:28:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:36:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:38:=20
> WARNING: line length of 124 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:39:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:44:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:45:=20
> WARNING: Too many leading tabs - consider code refactoring
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:48:=20
> WARNING: Too many leading tabs - consider code refactoring
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:53:=20
> WARNING: line length of 102 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:53:=20
> WARNING: Missing a blank line after declarations
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:55:=20
> WARNING: line length of 130 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:56:=20
> WARNING: line length of 114 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:58:=20
> WARNING: Too many leading tabs - consider code refactoring
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:59:=20
> WARNING: line length of 125 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:61:=20
> WARNING: Too many leading tabs - consider code refactoring
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:62:=20
> WARNING: line length of 106 exceeds 100 columns
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:63:=20
> WARNING: Too many leading tabs - consider code refactoring
> 0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:64:=20
> WARNING: line length of 108 exceeds 100 columns
> total: 0 errors, 20 warnings, 59 lines checked
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:8:=20
> WARNING: Missing commit description - Add an appropriate one
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:27:=20
> WARNING: line length of 101 exceeds 100 columns
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:134:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:135:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:140:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:142:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:143:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:144:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:145:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:158:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:161:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:163:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:164:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:164:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:165:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:165:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:167:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:168:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:168:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:169:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:169:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:172:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:175:=20
> WARNING: line length of 103 exceeds 100 columns
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:177:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:178:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:178:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:179:=20
> ERROR: code indent should use tabs where possible
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:179:=20
> WARNING: please, no spaces at the start of a line
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:193:=20
> WARNING: please, no space before tabs
> 0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:211:=20
> WARNING: line length of 104 exceeds 100 columns
> total: 6 errors, 24 warnings, 181 lines checked
> 0003-mbim-fetch-MBIM-version-on-init.patch:7: WARNING: Missing commit=20
> description - Add an appropriate one
> total: 0 errors, 1 warnings, 8 lines checked
> 0004-plugins-udevng-Add-support-for-the-MediaTek-T700-5G-.patch:9:=20
> WARNING: Missing commit description - Add an appropriate one
> 0004-plugins-udevng-Add-support-for-the-MediaTek-T700-5G-.patch:21:=20
> WARNING: please, no space before tabs
> total: 0 errors, 2 warnings, 7 lines checked
>
> Regards,
> -Denis

Thank you for the insights. I will reformat the patches, fix the=20
warnings and send a new revision.

Regards,

- Muhammad

