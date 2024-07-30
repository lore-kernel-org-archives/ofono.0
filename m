Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C018CC02
	for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368938; cv=none; b=bewmEOE3erYL1SsbHWVxqqNHo48RCed4Sr2LHEE768p7LRsoEPV8Mp4zFkxSLZCF6m26OIMoaKlIoWzIbmtrobAAXOYfIJ2OZfiQbEyEWyHx1kWlXOaLoWVFRc//5rVgbarEC13yPs2fL8EXC3R6qRDgipVEH/NAYLgTbiOZHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368938; c=relaxed/simple;
	bh=9Nick7YhqgCctR7LhGSE6yafJDj/yDHjvxzUzbuR/G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ohSms1GOdQ/1ArDgFmOuUe5TCBkFjVZ3cCrsVQgp0X5bVuxuwydgNyQaWmkLOV2XTXiXpod9jZA5HbEvpDv10NW5eJ50v9SRFXnhXhWYWvjUjhd3LAfBDme4S9K1UB8ddIFiszo/cVBQNw6iTI8VLUQdxJIV//rB+3v/hir7+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXXeoyia; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXXeoyia"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso3407751fac.2
        for <ofono@lists.linux.dev>; Tue, 30 Jul 2024 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368936; x=1722973736; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JAgJuJp0DBQ5g+JmDimCqNeaHCmMhxxli0pz6zdISJU=;
        b=fXXeoyianeVH1ueNl8TmDD+drBwq5bdb8YQp4lL6iKMxXih24Fdz0PGqtle09Acn36
         DCpRoxZ43gF1caSmKSA5P2IS2scW0rdkKtemMOSSZlxCH1miElWTk6zI7qZEHBXvay5L
         hYTD2/XVrMKNanYfH+mkPXbgambogJMU0xnq7aQWFASFvBF7fs562w6VYDJj358Ua37v
         WeQAKyveeJmwIxUqKTUVuExJC4uUK8DM+r+3UUpcnDxt8Nr1AbYRBqnSKkzkq59roLPh
         MXa09iGpQibZJPi/tLNi5xh6PKWC0nygTPfvGqL9Y+Nrnq5SN6QdSwAk2FIGIttmILtO
         +R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368936; x=1722973736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JAgJuJp0DBQ5g+JmDimCqNeaHCmMhxxli0pz6zdISJU=;
        b=uSgJ0COYv1HdMbCnq58g4VdLvHLAo3aDJEveVyRsVX6tnLkZHKKXH+ZSDpjLGUUCgu
         HCwonUkWBas1I/MG4F8NjfRfrca3H0acqqFy6i1hsn+FaBrKGw7bn2dw5oE4cQWI6qoK
         84vWgCc0ucCg9sqhpeH6UGAjvooorJxTb0Vwpl3MaoF09zAzbxq8UMxzLUklsM50ocqq
         Hse5JY9C0xsRbN5RtrTQBFYlqOxqYezyhoZJQwN82LKKaeTfzOuvZY1cEUyswzfAKp5Z
         +gxcjcKi3Boy/rjMLBcd6vVZ2fLrTfpcaTBW+KG8UcSY0J5nhs/eq/aSN0FqOjuC1iYd
         9U6A==
X-Forwarded-Encrypted: i=1; AJvYcCVlZ7cvRT7is3y9krj+HObJnHKGT46uj5pX/I7ulkwYZ16m1B0/3P1nEs/5dQovgg/OFLGZaXl6YDrzx+coZPhL2kR7zHA=
X-Gm-Message-State: AOJu0YxCca2DeulhE1b5i41tnZ2C3BF/uKdBddXk2utx9KLhrT+vPbTo
	Mj06Jl5aKki+GVFGyiVne81JUibJIGWGmVDyDwjVu7eIVkDyL2OyUQbr+A==
X-Google-Smtp-Source: AGHT+IG1tGZ4hOKTzGbWTd8BHzNUjYMlBwjyZih7nOdLkimhPWU6YfUOlpUJPh30EOP6yoGeV+ZygQ==
X-Received: by 2002:a05:6871:441:b0:259:8420:8e3b with SMTP id 586e51a60fabf-267d4d8c842mr15004068fac.21.1722368935682;
        Tue, 30 Jul 2024 12:48:55 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7095ad4e8dcsm554227a34.16.2024.07.30.12.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:48:55 -0700 (PDT)
Message-ID: <0b03c25f-bf31-48eb-bc92-4a4eac783d04@gmail.com>
Date: Tue, 30 Jul 2024 14:48:54 -0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmi: Allow qmi_qmux_device_discover be called from
 callback
To: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev
References: <20240730034738.222227-1-denkenz@gmail.com>
 <2517208.XAFRqVoOGU@adam-laptop-hp>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2517208.XAFRqVoOGU@adam-laptop-hp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adam,

> 
> This certainly seems to improve the situation.  what happens now on boot is
> that the driver loads Ok, the UI shows the signal strength for a few seconds,
> but then appears to go to an unregistered state, which is supported by the
> logs below.  When I restart ofono, it seems to work fine, this log is also
> below.

 From the first part of the log:
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:registration_status_cb() /
quectelqmi_0 error 0 status 1
Jul 30 10:44:40 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify()
/quectelqmi_0 status registered (1)
...
Jul 30 10:44:40 PinePhone ofonod[2543]: src/
network.c:ofono_netreg_status_notify() /quectelqmi_0 status 1 tech 7 lac 11016
ci -1

Looks like we're registered at this point.  Then:
Jul 30 10:44:41 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify()
/quectelqmi_0 status unregistered (0)
...
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:ofono_gprs_status_notify()
/quectelqmi_0 status unregistered (0)
Jul 30 10:44:57 PinePhone ofonod[2543]: src/gprs.c:netreg_status_changed() 0
(unregistered)

Then you restart oFono.  I'm not really sure why the firmware says it isn't 
registered?  You haven't observed this before on boot?

Regards,
-Denis

