Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3A8F66
	for <ofono@lists.linux.dev>; Tue,  6 May 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530217; cv=none; b=IZcqSPFYTsKDMPCjubOEm5e4tRb4Bo6Hs/z8X5WmSnAUcrVyRBG5kbhPyQJiHNEY6thulNwaMWbHk3VsT50jIBCm1tjJqsBXwq5vT8nrDi/MpMLHt7X1zj/9VvGllEYV3QM47r5q5ZigqJDTexiDMo5XU8UYw8fGhHHsr9+i/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530217; c=relaxed/simple;
	bh=QF+54KV5MmN2DS2E7vk3WMkbaGBZRg2dncv1xQgkgSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZwsNbr7rH1iuCwX8WmVbmPDw1q7VUBWMEbnb6FzZuSRMJdV2Q1bESUo5+RV2zMQ4uD0GBqiswLEvxv5/lbuRw5O2gkDnNLSxh4Zd1Kat+VXrKpW62aZcpQKjI5RW6/nncg9mUdQD6MiF0MduZue5BoQf+kPXCeA542Ac5XmIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ksHC4Fxc; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ksHC4Fxc"
DKIM-Signature: a=rsa-sha256; b=ksHC4FxcwuT4PTtM82W0p6hq09adOijIV34muTIzgKAmvHnWgnCNg2h1CbPTEH6irJCYnexoe0CD+sRcQ00l81YOfjV4+RFuZ4v3Vn9+2y39AIwc3QUruRE73JxbRwUNxzrdQR2qolGB91VfvJcUc6sRUljsireq3coADRXVdGysDvkDy5X7XxL8R5QvlfxpaUiUzwtq66j9OzV6t1UMfd4hFQktTTB7ZKUWj2m0UcGM6VgY8K/hRlxJxqdT/x2yWOLmS3i0LwX3xYPmwbMp+bePWGQiqh1PhfL3YIX2yNf/dSgrh0XNn9gcr8ozRrqzaRFCXsM6Ce4OsceoezR0Dg==; s=purelymail3; d=purelymail.com; v=1; bh=QF+54KV5MmN2DS2E7vk3WMkbaGBZRg2dncv1xQgkgSc=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1987814780;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 May 2025 11:16:49 +0000 (UTC)
Message-ID: <aa1c91f3-8af2-4daa-925a-285c30086fac@mentallysanemainliners.org>
Date: Tue, 6 May 2025 16:16:43 +0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mbim: fetch MBIM version on init
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-4-thevancedgamer@mentallysanemainliners.org>
 <01fc54f4-a031-4050-ac20-620bb879debb@gmail.com>
Content-Language: en-US
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
In-Reply-To: <01fc54f4-a031-4050-ac20-620bb879debb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Denis,

On 5/5/25 21:07, Denis Kenzior wrote:
> Hi Muhammad,
>
> On 5/4/25 2:19 PM, Muhammad Asif wrote:
>> ---
>> =C2=A0 plugins/mbim.c | 2 ++
>> =C2=A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/plugins/mbim.c b/plugins/mbim.c
>> index e1d33f47..3a1942da 100644
>> --- a/plugins/mbim.c
>> +++ b/plugins/mbim.c
>> @@ -287,6 +287,8 @@ static int mbim_enable(struct ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbim_device_closed, =
modem, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbim_device_set_debug(md->device, mbim_de=
bug, "MBIM:", NULL);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 mbim_device_get_version(md->device);
>> +
>
> I think you need to invoke this after mbim_device_ready() has been=20
> invoked.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> =C2=A0 }
>
> Regards,
> -Denis

I will move it to be invoked after the device is ready.

- Muhammad

