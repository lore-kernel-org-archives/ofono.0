Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AE142E77
	for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455942; cv=none; b=CLk0YwRlQxYnXBe/2j4ZfnefCrDm6pIQvKCWGz8tVcelxk/7nafYS/CwvNeS+sbpkEkb5oBgIBz51umEag4W01Fqk9KjwJTP+p+I79frNY8yzu89gmpKy3+9o4OV9BpQZlDRImXf/s+WDloCFZ/e2SFSsWwUIqtArQxbnrDQv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455942; c=relaxed/simple;
	bh=DTifQpvCLqGbOTcesfHemchkP7l4oQuXh89bFOU3ooI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf1QQm/hpNRe8hQPvV8ZTimOzsv26v9ZRh0s6Qg2obuz5NabKO2O3K6wvngsI65kLG0HtplTX0fbv8UvbnEUcgKtPEUW2esehrftVrihGmJFX05E2saC/6XKL6deu7Q88xONobxnOh/BJHnsTf75Bo9vngF+4FPW6DcMYjBcXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOaej5AE; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOaej5AE"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f340d6db09so1243977eaf.1
        for <ofono@lists.linux.dev>; Tue, 17 Dec 2024 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734455940; x=1735060740; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wH25pEdT82vh3OsWfJVd95quYvJ/1lldSQsDK53ecVM=;
        b=XOaej5AEfxahHoKIpDd2MhgeBFIh/1W6FCPHTQKLjaCt4U+ghjT+O1Ks/fuNYrmqJs
         dh22tJpRZ3OZYglIy4L0ZZPC2sEyN3dMBPGnz4KyYoRoNHuoWnJDOlKY7zSwK+I6K0Zm
         5AAQmTljmRe1eDD+WG0EpnwOAAOYKc7E4vGeG3dYvFZtUdCuFpvMfsCbQOKm9AjrtNkr
         1Lha0JX3Vve1jBBK7EFVkXafkeAYtg3CDf96ublc3D+uvR+wjKbm3w/BCwzkFlYC2tTz
         3iwjzJuPEt02UKOYgk95iRKXC5NuaFBiACTkjYPyqX78xAOIzRrc59aVW0sL1xLc9D5h
         UuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455940; x=1735060740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH25pEdT82vh3OsWfJVd95quYvJ/1lldSQsDK53ecVM=;
        b=AR3Cxf1AIY5VUdRXCWp7yAloC8H5Gnzl+8N737Ctlu8V83MSaO+aVju0DLhzBp3X49
         GZ7kSHjuAqZb2hgRlBHLSGCRkKscneq/CsFmcgO/YbS7GrpntJWNE6cgDhB/LD67dlFX
         fMxWq09hzotBBEGEQILss5+8sxA5iYxqf46QTCZLGnM7hCzm8B+bBVyTHMyENo7Bo/8L
         Hir2GOcsajD+TPk5B3I9Dkwu6/IU4uaVzSDWpj0AqNQo7zdj5VT31DvfZsjJzk7Y6G4x
         0uNKId6NEXIp5DrfUptqZq1kNaSVViP+Uv6OtsOPdKs4ahIkHoaQxKOqDsFK63IcbHuE
         JCmA==
X-Gm-Message-State: AOJu0Yzgtg1GIwZi7SoWorXeIdQWRJmLbXbiQL9mDw7iOCZINXpzpSER
	SV+YCfgnCnXR4SELqjcWDZMU97fNak6UrzMMezH/NEraaod/3m7G
X-Gm-Gg: ASbGncsZ2ngfQtDpez6RbpXItSEn8e/6lqJz3NRsMGLd8wZKgQpM3GUIcC/AeVMepgV
	zkfRhuYBgQfQnlv5Z8/S+kMtzwGXV1tJyM8c+qfF4Nc+Fs9LV7FdgceIwoFTT50NUNIvxX2QX6k
	NWOevyXlI+3usbp/vFEEQykTc0Y4wSEe3CyQxMxS6OEginXTsPrke3Euz0NwQz+EWoyBt8Q1z16
	Sl1d0MYsGSuZiq1+RfAn8gs9xJpfsWRl3BKQARMwD1UWZiCtJR9sGzmJw==
X-Google-Smtp-Source: AGHT+IFaSx1vjbIvXqRriP0VseIhHblUjUjrRq0dcC7NF8OQzq0WhFCZMO8rGMsVQz2CFXnIFmQz7Q==
X-Received: by 2002:a05:6871:82a:b0:29e:62e5:9b55 with SMTP id 586e51a60fabf-2a3ac6b8fd1mr9895693fac.20.1734455940360;
        Tue, 17 Dec 2024 09:19:00 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2a3d2913c3esm2911359fac.38.2024.12.17.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:18:59 -0800 (PST)
Message-ID: <10a65597-9ba7-42f1-af9a-c9bad09cbb4a@gmail.com>
Date: Tue, 17 Dec 2024 11:18:58 -0600
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Forbidden Public Land Mobile Network (FPLMN)
To: Sean Nyekjaer <sean@geanix.com>
Cc: ofono@lists.linux.dev, =?UTF-8?Q?Martin_Hundeb=C3=B8ll?=
 <martin@geanix.com>
References: <0B16BA07-4A2C-4FF7-AB06-3D670BB40A91@geanix.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0B16BA07-4A2C-4FF7-AB06-3D670BB40A91@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 12/17/24 4:57 AM, Sean Nyekjaer wrote:
> Hi Denis,
> 
> One of our IoT providers recommends us to clear the FPLMN list.
> We have been running out-of-tree patches, that clears the list when we go offline.
> 
> We would like to share it, other IoT providers might have the same challenges.

Sure, feel free to suggest something.

> Could it be a boolean set via dbus to the SimManager?
 > > 
https://help.onomondo.com/en/articles/233768-how-to-clear-the-fplmn-list-on-the-sim
> 
> Br,
> /Sean

Regards,
-Denis
