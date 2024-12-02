Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B111442F2
	for <ofono@lists.linux.dev>; Mon,  2 Dec 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167029; cv=none; b=PmOEtAzLhxotwAuKFzifMcloPv3IREEz0/pGlqwgOuzOPmy7ZZik521+nyM9Nepkf33EaCuK3umcYiFYzPkLtVyr6OjLx+wgETT+XmLV9iUqUZNLDgdefAXWdVP363+6Al6ZhXsnMv/nKe5TN0uAcJEj3h6FAPl53lkBT90L1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167029; c=relaxed/simple;
	bh=3hG5EmQ/ELqXvjKeAnfqr5rOBZnaadfGMGTrsYC5JPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsXfdZh38oRF1xnUrjwnuI98V2lijhLksx2e2YXtJll2n1hTq4iCBN4cL0WtNO0rchAKZj/oBb4qsRwXaecZXTnqg29iapop8iJhGIOUROuS0vreOlXfhJX4ZZ9yG3oX4Hhh9aDTuYS8DE3gykbUReuDz5/ENUzcS2mE9urVfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPrph825; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPrph825"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso5456067e87.2
        for <ofono@lists.linux.dev>; Mon, 02 Dec 2024 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167024; x=1733771824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuqV9HfYlVhJOV/RLJwEMnZR1zBahnDIhb/AyxGIvzM=;
        b=mPrph825SE8aFUhZOSkzCSAAF5m54XTWJxUrN3cm40qc+QyVrZNVdulAVPpW3bBHN9
         WbfFW5E9HHHDcpHvpupyklJqhbymNmnuC7usrq/EdJODLrP5mSO75j6Sdq8zH+gi/FTB
         fCmhIlNNbxm/WQR3fdhZ1K1RO7/daED0mH/kw2wL9OY1UhuPfZjqBYu9xSU31X46PPHl
         E5xr07gJPPycVjTbEoTAbzxRGCxNwU0NjCJpQeQAQWh2xSaIUhYGQr++0T+D8EqQslbW
         GwzCw27GHkSZXW0RNu2T6XJynY9/nKvTuIDuyOemumxU890b837d+/UGYFtiGUV+ggAv
         3FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167024; x=1733771824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuqV9HfYlVhJOV/RLJwEMnZR1zBahnDIhb/AyxGIvzM=;
        b=avHrjHlchkW8gcq2mwZvz3uSoNTjbzXjQk+sPpbfkSaH0WO1W2FzZTSHFW3g9pWKnN
         /uigeCBMvkrsNOTMo3ACW7MXugWmqf/W8aE91tuG5zYf+x461wZArv5J8ZQ0Ks+aG/48
         zDm+NzyS1aaKE/s3w0N8aTClCZ6T7lqbBgl2RHcPsj33pn2EOId2FLTJTvsegOF9iK1M
         gT9JW8UxyqjJF9Qo4KdQ099q/58fW71xqwXf9yob8vCPzJdxOQl59S7IRzxUUAXgbvuI
         OlKAgyWzNxg9Z24bNfC1LaPd/a4HGGBdB+aIHfxw4yRgB1W5uOWOc5Ivmw7O1IRwRxeS
         8q4A==
X-Gm-Message-State: AOJu0YyV/s2+ZyEH7KoLGAfmK2txbYz7WGZJDQWOKIrkbBW5JHCzMozm
	N/isX+agxZfuVlLc90BOGghmLRopfWyj4maqgcqlFngwmnJe3MahspHlnA==
X-Gm-Gg: ASbGncuT50tKk+0ysm7qkZKrsVD4Vb+N+eI5eG9qgisUZEGFka5TJmRK4xiNCYo7BE/
	OvphesADnAvn/0EwSehm4DeL9FmohGidTjflCWvnJJTbhURNhbJJ8iajUV2pFfiinD8qmzieHtk
	8cMj9X26JKXwQhUgu/mpxO/kUlMmbyJWzobVJ6/5Mc5G2j6ORtBI48YrJiZRsDLaRJfHyqR6v1q
	4qe2fruE5lylhlbVMdvEh4I5vu1y0NL5ByVYWt20shFH4XJY1CjreE8gUdV7w==
X-Google-Smtp-Source: AGHT+IGAGpOA7Knrkmq+Z9YinGCnfldOESsSSMNt7+lRI66wO/UAsWkpMw6ZRZAmRkq4QNGMVG8VaQ==
X-Received: by 2002:a05:6512:3c99:b0:53d:abc8:b6d3 with SMTP id 2adb3069b0e04-53df00aa00bmr14320811e87.12.1733167024010;
        Mon, 02 Dec 2024 11:17:04 -0800 (PST)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:c2f:5c01:9ed2:c18c:329:f12e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763a59sm194252865e9.11.2024.12.02.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:17:03 -0800 (PST)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Pinephone Issue in 2.13
Date: Mon, 02 Dec 2024 19:16:59 +0000
Message-ID: <2292663.Vs0nDVz2aQ@adam-laptop-hp>
In-Reply-To: <d9fdd0f1-3231-4f0e-9775-270ca31d71ce@gmail.com>
References:
 <2830691.vuYhMxLoTh@adam-laptop-hp>
 <d9fdd0f1-3231-4f0e-9775-270ca31d71ce@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Dennis

On Monday 2 December 2024 17:55:18 Greenwich Mean Time Denis Kenzior wrote:
> Hi Adam,
> 
> On 11/28/24 11:41 AM, Adam Pigg wrote:
> > Hi Dennis
> > 
> > Myself and some users have an issue since upgrading from 2.12 to 2.13.
> 
> 2.13 added multiple simultaneous data bearer support, but they should have
> been backwards compatible with those devices that don't support them. 
> Guess I broke something :)  Sorry about that.
> 
No problem, its hard to debug devices you dont have access to, I know the 
feeling! (i support an app that interfaces with various "smart" watches)

> > The logs on my own PP and PPP, and from another users PPP show the
> > following code path, with the device being shut down:
> > Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:discover_cb()
> > Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:create_wda_cb()
> > Nov 28 17:35:59 PinePhone ofonod[2557]:
> > plugins/gobi.c:set_data_format_cb()
> > Nov 28 17:35:59 PinePhone ofonod[2557]:
> > plugins/gobi.c:set_data_format_cb()
> > Trying next data format
> > Nov 28 17:35:59 PinePhone ofonod[2557]:
> > plugins/gobi.c:set_data_format_cb()
> > Nov 28 17:35:59 PinePhone ofonod[2557]:
> > plugins/gobi.c:set_data_format_cb()
> > Trying next data format
> > Nov 28 17:35:59 PinePhone ofonod[2557]:
> > plugins/gobi.c:set_data_format_cb()
> > Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_device()
> > 0x2088ba20
> > Nov 28 17:35:59 PinePhone ofonod[2557]: plugins/gobi.c:shutdown_cb()
> 
> What oFono tries to do is to cycle through three currently supported data
> formats:
> 
> - RAW_IP + QMAPv5 -> this enables multiple simultaneous bearer support. 
> There's also in theory RAW_IP + QMAPv4, but I don't have any devices that
> only support this format.
> - RAW_IP -> Single context, no 802.3 framing overhead
> - 802.3 -> Supported by really old Qualcomm devices.
> 
> Looks like the firmware is rejecting every single format we try to set it
> into. Do you know what format PinePhone uses?  Do you have libqmi / qmicli
> installed on the PinePhone to run some commands?  Something like:
> 
I dont have these packaged, but I can look into that if needed, or ask around

> qmicli --device=/dev/cdc-wdm0
> --wda-get-data-format=ep-type=hsusb,ep-iface-number=<InterfaceNumber>
> 
> where InterfaceNumber is what is being passed to gobi plugin from udevng
> inside the "InterfaceNumber" modem property.
> 
> For oFono 2.12, what do the contents of
> /sys/class/net/<netif>/qmi/raw_ip
> and
> /sys/class/net/<netif>/qmi/pass_through
> 
[root@PinePhone defaultuser]# cat /sys/class/net/wwan0/qmi/pass_through 
N
[root@PinePhone defaultuser]# cat /sys/class/net/wwan0/qmi/raw_ip 
Y


> look like?  <netif> in this case is the QMI wwan network device, something
> like wwan0.
> 
> Regards,
> -Denis

Adam



