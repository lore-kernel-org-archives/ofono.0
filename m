Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9C1922C6
	for <ofono@lists.linux.dev>; Mon, 23 Dec 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734944729; cv=none; b=gFwEvYV+flL6ekQLeScIDq7NNttUpX6WaNeU0+7nwWV95eh3hcEb6ICUB3TZNXV7OhEG/ZAqYd4bwkhnPUh+Zo9OdTkh17fq/vCE9MF89fuHY7fOz2idSHAODdgeQQlMOKtbsoIHzGkMcFFJzXhhg7Rnby5q3N+ShXVP9XWD4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734944729; c=relaxed/simple;
	bh=hQoqJ9oMSOIVD9FALo5I9PZHHX4KaWyEb7w99ivbip0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxHnGu+UOPfc1V4pLEVVms/GXlkHQFyQxq0tVVgsyRInLHJFyTEAIKyLAozTWrEp0elOum9wOgWn5b2+mruDeTQSRghu4sz2DA/ndnJBZf1zzgmCm+MBVxtvW7aHG3qA/a4z7pL60taWbYw5O9ecUr68c+WEnT81nfGoLyfEdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJYPQX3M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJYPQX3M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362f61757fso38839425e9.2
        for <ofono@lists.linux.dev>; Mon, 23 Dec 2024 01:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734944724; x=1735549524; darn=lists.linux.dev;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NHRPRNpoBO+usSVBQyNfCUw/46vxc59VaYSQHpb0VKg=;
        b=ZJYPQX3MTplI+ZBMAAvkESYrGlyxscZkS4SuGB9NFs1fZrfJdCS9v4SW+yduHQ46AR
         8OC1LFlMG9emtFq8xlRe2eA8RBsCXHCUu9coyfEWotDKSXcvBfDH5TRHVFeO0XlQAwMJ
         aqQrAjDWv/5qkggCnjeqVbf5jPXvZt/yhGKWV4lrT2jQsUywUjAADKXQebLrOYbVKcMC
         SVFIqygDHc8cB6qFTbPFDLG+Mr9z0Sz0SNtty8OXWPJ5m3xcRwsg1T/Y0XrRIcOcYW48
         39uq9G7D1pBlnPdzeTNJ6zY4FEoxnGELw6+3T6YBnNec1C7gL89uXtcIGLPZtPOyo7X1
         Q1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734944724; x=1735549524;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHRPRNpoBO+usSVBQyNfCUw/46vxc59VaYSQHpb0VKg=;
        b=bJzP4ddsM2q1pfOBOnoB/PhbzpBKcITi7AV4WuH8b/TM1MTBacbJHvzd6nGjy+gu6f
         fwnSRUNnXSbhrNZVQ4Fd6bpvFGqVDFRwNmffWSdgLqH9Awle+7bhYw2EZdbCnmVEjcRM
         mYPACQJbwowOal0UmjNXxICkfk27YOc0QczpOMcKWPrgrzshvAUtr69o6vj1OrIQFtkr
         sh2aWBvlsoYcW8YTRLpmM2qinAl86MC2Xw6dnvlCz4wE9D6LqwQB6FIeg5CtM/p9MlnP
         VjP7cF4dsvNp3fEmttveEF7j4cYjSdU7+kO1/wv5WCQjx474PYl8l4Q1SvEcJ8rOt78L
         ruIA==
X-Gm-Message-State: AOJu0YzCFLoa5zSP5e9Tc1/WrffwWHX2gTRchWCKaUZqewrdRQzvz7PS
	e4UAPem+dru8yWuPh94r8ST/03w7CHbHIm7Oc7Mf66fsjVIkMYMIaKHOxw==
X-Gm-Gg: ASbGncs9a6DFZ18DEB8wMRVPvoFO2Bb8pgXpPnAjSJwAw5QpKDbFTUElW/5geVUTcLe
	3QoFwo+IQfqOZNeVTZYXW9/sk/3tPr2bhQY0AltGuF2ioFV1Fmpl9l0xEES2LTPkkYBNsgRZa6O
	WuSpbJ+9VwNRWJdmnaCGU2IVzyUfHbN92iKBylGUmbPqOyG6KcQLzTJ5fyWra2Slc80ECf1SLkM
	xmVRgrOS+IX7L0d8gleim9C3fKauBef7eO8xD6B8fW6H4BTT1z73+MRQQe1RZcRKTCJ
X-Google-Smtp-Source: AGHT+IEuqMVD26CMRMQpx8wHE9XjsD5M/fA4JrNqG8VVnTzWEaF4PVv8ZYJBZMFaS+V4Urb5HncTOA==
X-Received: by 2002:a5d:6f01:0:b0:386:2d40:a192 with SMTP id ffacd0b85a97d-38a2220191emr8451294f8f.34.1734944724237;
        Mon, 23 Dec 2024 01:05:24 -0800 (PST)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:57:9d01:dbb1:75c2:cc57:79be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e140sm11080431f8f.79.2024.12.23.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:05:22 -0800 (PST)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Pinephone Issue in 2.13
Date: Mon, 23 Dec 2024 09:05:18 +0000
Message-ID: <2735105.vuYhMxLoTh@adam-laptop-hp>
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
Content-Type: multipart/signed; boundary="nextPart4930613.OV4Wx5bFTl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4930613.OV4Wx5bFTl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Adam Pigg <adam@piggz.co.uk>
To: ofono@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Pinephone Issue in 2.13
Date: Mon, 23 Dec 2024 09:05:18 +0000
Message-ID: <2735105.vuYhMxLoTh@adam-laptop-hp>
In-Reply-To: <d9fdd0f1-3231-4f0e-9775-270ca31d71ce@gmail.com>
MIME-Version: 1.0

Hi Dennis

Apologies for the long delay....

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
> qmicli --device=/dev/cdc-wdm0
> --wda-get-data-format=ep-type=hsusb,ep-iface-number=<InterfaceNumber>
> 
I checked the interface number from the ofono logs and got 04
Dec 22 22:14:48 PinePhonePro ofonod[1346]: plugins/udevng.c:setup_qmi_qmux() 
qmi: /dev/cdc-wdm0 net: wwan0 kernel_driver: qmi_wwan interface_number: 04

But when I run the above command all i get is
[root@PinePhonePro defaultuser]# qmicli --device=/dev/cdc-wdm0 --wda-get-data-
format=ep-type=hsusb,ep-iface-number=4
error: couldn't get data format: QMI protocol error (48): 'InvalidArgument'
[root@PinePhonePro defaultuser]# qmicli --device=/dev/cdc-wdm0 --wda-get-data-
format=ep-type=hsusb,ep-iface-number=04
error: couldn't get data format: QMI protocol error (48): 'InvalidArgument'

> where InterfaceNumber is what is being passed to gobi plugin from udevng
> inside the "InterfaceNumber" modem property.
> 
> For oFono 2.12, what do the contents of
> /sys/class/net/<netif>/qmi/raw_ip
> and
> /sys/class/net/<netif>/qmi/pass_through
> 
> look like?  <netif> in this case is the QMI wwan network device, something
> like wwan0.
> 
[root@PinePhonePro defaultuser]# cat /sys/class/net/wwan0/qmi/raw_ip 
Y
[root@PinePhonePro defaultuser]# cat /sys/class/net/wwan0/qmi/pass_through 
N


> Regards,
> -Denis


--nextPart4930613.OV4Wx5bFTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr1aGel3+a3VM67n3d+rfHu07OYAFAmdpJ84ACgkQd+rfHu07
OYBXqQf/SH6JHxKAE5AfF1nbMauMjLty6LZSApLgzPAxChXnmF5iKBfwsUgpjzE9
o4PMyADXcpnwIOOfozcNrpDlbFbO29qRoFYAObWblY+AtqYSsfwUxwdnvbdESuWv
IexsTUDrNQ735msjFhxAOoPaauq5nrHv1cZBrCZ58hXTL5HFQWTnVJ1zN59zSQnz
KsAo0gFM5jqjyNcfrHCDztYkNxvtGjdITNS1JH4BkcQXn38Xvo8NoEKZEVuNAJYU
iIruRUdS1evncrixlv/Trc3xdo4+AFXFBHNJjtkht0KcB8R6AA/ErT1hwNdWfRpg
DowMmpq9Na+S7BDzBnmEkHTkCdROCA==
=RW98
-----END PGP SIGNATURE-----

--nextPart4930613.OV4Wx5bFTl--



