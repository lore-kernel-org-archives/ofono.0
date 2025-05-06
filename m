Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5F278E5A
	for <ofono@lists.linux.dev>; Tue,  6 May 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529965; cv=none; b=bweeoGFPnoW/5uoAaEg2FoPgHFJz/JugadMBlKzsnRU78h5kMGfxX8Ci0POXgjNEFptYrnPB5+eZw35gbkbYhTlri0sh6D6m4QfgrC53MGva91dS5ERB1Vsd30kDccZ9N6NezQltFxTLe0v/iWxCNYlIqD2LnnQTB/8RYWqZlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529965; c=relaxed/simple;
	bh=pIj2VKP7hdrzWzlS9XEv2EcfQuZ6ynVRDArVU5RKWBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLevO4mNF04fwbxc0Ga7k2tfUWmvxqK6LJDaF41bGA655yCqynAvIM75fCLnpXG/KjQJL21OHp/ImzsHp8YED5Eanx8mmFMJLPxVf5S2HAhdTLgwrPT38xHE/wXHhobjrid1J+3JQ+JELxvQHhuc8UExyb2pJmH2hNU64bdFs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=W104yQvQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="W104yQvQ"
DKIM-Signature: a=rsa-sha256; b=W104yQvQY/8GGkcE2u57CwEDr6lZHvLC8wrFpDX2+buZC9Mq1ntajuGuRogdsJy2g0TgkQGui68hnMAPCsogN7p05CkqWBHzZakPeq7tfIESp7/7rGIzg8xtiYcAXKwCm+qvqqF9L8BqE0SjD3L4fbSN4gvfa085pCpUF3ndq2Qzwo/XqgCI70HtHerTJJL00dWCavER1yuvhvT1x/JX5RlBmst0AQOzt4dsXHEvXSvKS9CTt0x7VC0IfgcmLgw1q/ftCXJCL9ZOmIcd450Sw7dHth7Kkvu3ypLHlay9TZ1o8hD8oEJL7soQ9Pv54r0FQ8uEDYPgLjkS4n8hnwsisA==; s=purelymail3; d=purelymail.com; v=1; bh=pIj2VKP7hdrzWzlS9XEv2EcfQuZ6ynVRDArVU5RKWBo=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1886636460;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 May 2025 11:12:34 +0000 (UTC)
Message-ID: <3abfeafa-1a03-4458-b371-9bd9a5c3ccec@mentallysanemainliners.org>
Date: Tue, 6 May 2025 16:12:28 +0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] plugins/udevng: Add support for PCIe MBIM modems *
 Parses through the sysfs tree and detects MBIM control nodes, net and AT
 nodes
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-2-thevancedgamer@mentallysanemainliners.org>
 <b227dde1-b41e-46fa-98ee-24c4afef9ddf@gmail.com>
Content-Language: en-US
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
In-Reply-To: <b227dde1-b41e-46fa-98ee-24c4afef9ddf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hello Denis,

Thank you for the reply.

On 5/5/25 20:46, Denis Kenzior wrote:
> Hi Muhammad,
>
> On 5/4/25 2:19 PM, Muhammad Asif wrote:
>
>> diff --git a/plugins/udevng.c b/plugins/udevng.c
>> index b8df66de..09c916db 100644
>> --- a/plugins/udevng.c
>> +++ b/plugins/udevng.c
>> @@ -1176,7 +1176,13 @@ static gboolean setup_mbim(struct modem_info=20
>> *modem)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *ctl =3D NULL, *net =3D NULL, =
*atcmd =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GSList *list;
>> +=C2=A0=C2=A0=C2=A0 const char *sub_subsystem =3D NULL, *type =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 char path[512], wwan_path[1024], sub_path[2048];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char descriptors[PATH_MAX];
>> +=C2=A0=C2=A0=C2=A0 struct udev *new_udev;
>> +=C2=A0=C2=A0=C2=A0 struct udev_device *wwan_device, *sub_device;
>> +=C2=A0=C2=A0=C2=A0 struct dirent *dir =3D NULL, *subdir =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 DIR *d =3D NULL, *sd =3D NULL;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("%s [%s:%s]", modem->syspath, =
modem->vendor, modem->model);
>
> I see that you added "mbim" to a list of pci drivers in patch 4. This=20
> patch and patch 4 should be combined into a single patch. Can you=20
> provide a log from 'ofonod -nd'?=C2=A0 Especially after patch 4, oFono=20
> should be detecting all nodes related to this device. Or, hmm...
>
> Perhaps there needs to be some additional logic in check_wwan_device()=20
> as well? Right now it only detects MHI devices.
>
I tried this actually, oFono cannot comb through the nodes because the=20
subsystem shows up as PCI, not WWAN. So I had to manually parse through=20
all of the WWAN nodes.

On 5/5/25 20:46, Denis Kenzior wrote:

>> @@ -1196,6 +1202,56 @@ static gboolean setup_mbim(struct modem_info=20
>> *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (g_strcmp=
0(subsystem, "tty") =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (g_strcmp0(info->number, "02") =3D=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atcmd =3D info->devnode;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (g_strcmp0(subsyst=
em, "pci") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spri=
ntf(path, "%s/wwan",=20
>> udev_device_get_syspath(info->udev_device));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d =
=3D opendir(path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!d)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>
> Hmm, so you are detecting some node (I assume root) of the device,=20
> then open coding custom detection logic based on the wwan subsystem=20
> provided sysfs links. What if the WWAN subsystem isn't enabled in the=20
> kernel?=C2=A0 Can udevng be made to work without these links?

Without the WWAN subsystem, the kernel does not enumerate the WWAN=20
nodes, and also does not include the wwan/ directories in sysfs. oFono=20
will handle that and report the modem as unusable.

- Muhammad

