Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03C256C60
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198191; cv=none; b=FbZQyY9vjb1JC6S5qa1T4dVtCGII3uUtOHz8b5Zb2rbKBtwMKbmObmNMRT8r31BF1gVfSZnZl/RJJKp2MZUF5q3FXcmbVG4CTaFOnsJwsdUuBt6JVlhr4R9yq1IDLKAT3EKXav6GDvxSZ1rXoJmgpPS8IChqg35gihf5IYGr3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198191; c=relaxed/simple;
	bh=L7O5O/YcXxTxwS2P3GtwQaMPD2YdyJvnjEXBxW3rQE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qPRxNL8VVWQW13PGYZHzVWpMN0lgHy3bipMSHo05EziGyQTtbSXfRVp563wsj3C65QHSlY0RApSDeIa4IqeOahRKbutAvsr8sv+xkfl8thnmUKujTvSS+i2b3ZBhjeCL9TEtrxfoL/wENSGaiWiY7zvfDb1XnNNsR0C8MBGU6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEz2z7cz; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEz2z7cz"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so1473483b6e.3
        for <ofono@lists.linux.dev>; Fri, 02 May 2025 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746198188; x=1746802988; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=js1tidUS5sLdn14rC8QCdoXXmRi1J3cwiZk/Vm3bNno=;
        b=SEz2z7cz225MP08UATvLVZXdQ6g9JK7PhrjownkcRcb1oT9aJRd9INbgxUf4nJ68b0
         tbOZaMlEyUv04stI0nmMazBk0OxjXbcKdNYZ9KOxAXb8U1b4K+fu5OcXYFZoRCljTH45
         4V8FG84/FfvHVVMzwUhp9DpaFSOMmoIr33IhWTzDmJfVgY7/cGklY2aYruKFC48Y9MQz
         sXKpl0ZEkSLQzwXA+6BdK2NFzKYWbBNPhrkF6qlQ/pto2mK+1bdQm64cuo0/ZiROvvqe
         SlZNyKl2K9xMOkwSTIOPgvlUEQyi1Zuddm4xcSmadXhSoRKkppF2iXW3UrmWNy7vZGU1
         NGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198188; x=1746802988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=js1tidUS5sLdn14rC8QCdoXXmRi1J3cwiZk/Vm3bNno=;
        b=Q8N5ygpFw+he9+W2JCfzipX8De/WkXdg0pG/B9ZsIO2XVuouEXA8qXzTbsi3hg5dML
         jREYDtipFT4jeQsqNJIMQkTyl490CoJRSwtDaG0ZUovJW2GfN4f8c49QRDo4lUIztwiU
         OH3OR0vZZ58Kfb1UXdoZZRzJoBcmHYYc+isbdcxnqHylyIKPAmj7tKyM1VS35h5SESgW
         OAV4nuHvAjF4bjuX0W+T6gt2SPUQkGeR0/iB8dOZq3Z9ak59f8YkOhF5fB/4iRed67EU
         m7fp7RpoXjdJ44PscIyOp3snSTBxx8S5wGKsmuTAXuqLx4of8UpZK/ce15tl/aYjv2rn
         iibQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl0MTskm7ZBD6WNljH4xZI6vXDVdXZcBGF7x34UyVfC2QR7Iw7TH9ka/iuS0GhL7b7c4d6Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHWC6+hKLuUnHL1NrmlhjAvwZH5sKZF1Mtu2gnwFrAeCpfwIFw
	AnmAPijVS/qm9owWmTXNQ2DLklDbRYTq8LX5bXNRbJWeL5RuQmQ6MnSzkQ==
X-Gm-Gg: ASbGncs0MTZJMSTIv7j3AwFrQuk9UpZer2uvCtCP7zMMtGVAuFdMCB1Yxojtu1TMGcJ
	jl40/HrpurgAbEVUye+WK5MyeRJ1qLqjxXf/uTnZI4e/jEdJKBJgKLKYH2Hk7kNcRA3dhFZHFK8
	c+tjlBHegdOB84PF3lobjNiYVJIYZqFB01laMbEG1gRWNte8UFgADCADKsEbzxi+ecBL/M6XVE+
	gBEIW09fv1+VMHWDJmnNvQcw86PnNooUDdocE4kogrmnFaDD7R+tM2AXUX2fD/jpj45sY2G+r1J
	nreiFjSOGl6WCNMHmB+Cwymtr8v7kuAHTWXCD6CmYQeF5Hlgw0hvoHJ7mh37y4SpOK4FIvNWudy
	cfzmtMw==
X-Google-Smtp-Source: AGHT+IEDiGeDdszMjFQISsv37sAE9LD1ITBcp1q32GHOchuEvreWmuDbtFGwr3STRwrJ+jdmavcRqQ==
X-Received: by 2002:a05:6808:164a:b0:401:e61b:5f76 with SMTP id 5614622812f47-403414b636fmr1680474b6e.33.1746198188274;
        Fri, 02 May 2025 08:03:08 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-607e7fe8482sm523874eaf.34.2025.05.02.08.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 08:03:07 -0700 (PDT)
Message-ID: <92709ac6-98ae-46f4-b62a-9a6ce51d9414@gmail.com>
Date: Fri, 2 May 2025 10:03:06 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] mbim: Add support for MediaTek T700 modem
To: Muhammad <thevancedgamer@mentallysanemainliners.org>,
 ofono <ofono@lists.linux.dev>
References: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 4/19/25 8:22 AM, Muhammad wrote:
> This modem is a PCIe MBIM modem, found in a lot of modern laptops,
> like the Lenovo ThinkPad X1. Unfortunately, oFono does not support
> PCIe MBIM modems out of the box, so this patch adds support for them,
> as well as MBIM extensions which are needed for newer modems.

Apologies for the delay in taking a peek into this.

Do you know if this modem is available in the US for purchase?

> 
> Muhammad (4):
>    plugins/udevng: Add support for PCIe MBIM modems * Parses through the
>      sysfs tree and detects MBIM control nodes, net and   AT nodes
>    mbimmodem: add support for MBIM extensions * With MBIMEx 3.0,
>      arguments for activating GPRS changed. Update as   needed.
>    mbim: fetch MBIM version on init
>    plugins/udevng: Add support for the MediaTek T700 5G modem * Found in
>      the Lenovo ThinkPad X1 Yoga Gen 8 as the Fibocom FM350-GL   modem *
>      Works perfectly with ofono now

I had this cycle through the CI, and CI complains quite a bit.  Also, if you 
really want this to be applied upstream, then I'll need a a last name in the 
author information.

Alpine (musl) gcc optimized
===========================
Configure: PASS
Build: FAIL
     plugins/udevng.c: In function 'setup_mbim':
     plugins/udevng.c:1203:25: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1203 |                         DIR *d = opendir(path);
           |                         ^~~
     plugins/udevng.c:1214:41: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1214 |                                         char wwan_path[1024];
           |                                         ^~~~
     plugins/udevng.c:1217:41: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1217 |                                         struct udev_device 
*wwan_device = udev_device_new_from_syspath(new_udev, wwan_path);
           |                                         ^~~~~~
     plugins/udevng.c:1221:41: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1221 |                                         DIR *sd = opendir(wwan_path);
           |                                         ^~~
     plugins/udevng.c:1231:49: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1231 |                                                 char sub_path[2048];
           |                                                 ^~~~
     plugins/udevng.c:1234:49: error: ISO C90 forbids mixed declarations and 
code [-Werror=declaration-after-statement]
      1234 |                                                 struct udev_device 
*sub_device = udev_device_new_from_syspath(new_udev, sub_path);
           |                                                 ^~~~~~
     cc1: all warnings being treated as errors
     make[1]: *** [Makefile:4090: plugins/udevng.o] Error 1
     make[1]: Target 'all-am' not remade because of errors.
     make: *** [Makefile:2405: all] Error 2

Fedora (glibc) clang optimized
==============================
Configure: FAIL
     configure.ac:25: installing 'build-aux/compile'
     configure.ac:41: installing 'build-aux/config.guess'
     configure.ac:41: installing 'build-aux/config.sub'
     configure.ac:10: installing 'build-aux/install-sh'
     configure.ac:10: installing 'build-aux/missing'
     configure.ac:8: installing 'build-aux/tap-driver.sh'
     Makefile.am: installing 'build-aux/depcomp'
     parallel-tests: installing 'build-aux/test-driver'
     ./configure: line 12804: awk: command not found
     ./configure: line 12874: awk: command not found
     ./configure: line 13443: awk: command not found
     ./config.status: line 1300: awk: command not found
     config.status: error: could not create Makefile


Checkpatch Output
=================
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:8: WARNING: 
Missing commit description - Add an appropriate one
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:22: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:26: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:28: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:36: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:38: WARNING: 
line length of 124 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:39: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:44: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:45: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:48: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:53: WARNING: 
line length of 102 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:53: WARNING: 
Missing a blank line after declarations
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:55: WARNING: 
line length of 130 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:56: WARNING: 
line length of 114 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:58: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:59: WARNING: 
line length of 125 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:61: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:62: WARNING: 
line length of 106 exceeds 100 columns
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:63: WARNING: Too 
many leading tabs - consider code refactoring
0001-plugins-udevng-Add-support-for-PCIe-MBIM-modems-Pars.patch:64: WARNING: 
line length of 108 exceeds 100 columns
total: 0 errors, 20 warnings, 59 lines checked
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:8: WARNING: 
Missing commit description - Add an appropriate one
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:27: WARNING: 
line length of 101 exceeds 100 columns
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:134: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:135: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:140: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:142: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:143: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:144: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:145: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:158: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:161: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:163: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:164: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:164: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:165: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:165: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:167: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:168: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:168: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:169: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:169: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:172: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:175: WARNING: 
line length of 103 exceeds 100 columns
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:177: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:178: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:178: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:179: ERROR: code 
indent should use tabs where possible
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:179: WARNING: 
please, no spaces at the start of a line
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:193: WARNING: 
please, no space before tabs
0002-mbimmodem-add-support-for-MBIM-extensions-With-MBIME.patch:211: WARNING: 
line length of 104 exceeds 100 columns
total: 6 errors, 24 warnings, 181 lines checked
0003-mbim-fetch-MBIM-version-on-init.patch:7: WARNING: Missing commit 
description - Add an appropriate one
total: 0 errors, 1 warnings, 8 lines checked
0004-plugins-udevng-Add-support-for-the-MediaTek-T700-5G-.patch:9: WARNING: 
Missing commit description - Add an appropriate one
0004-plugins-udevng-Add-support-for-the-MediaTek-T700-5G-.patch:21: WARNING: 
please, no space before tabs
total: 0 errors, 2 warnings, 7 lines checked

Regards,
-Denis
