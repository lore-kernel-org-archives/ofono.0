Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD04414
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405060; cv=none; b=MdQM3wzJU7vhYFwwZV0V+LpCZIk2MlC+WYACMpZcBQqc4vyfB26QLnxUBzc7j4Ehr5OjhtcMUs5c2FnadDpIKcKfPejvkeDgoEatyV57HhOFWDNShtKVRA8VHJtJB6W1Nk3/vR+2LVQjtrobR4F13Jf8NDEcA8I7bjr9PVSNabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405060; c=relaxed/simple;
	bh=jXX0AuRujJ/yr2zzm7auGjzZH7dlpox6oHXUyGl361c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jaMsZ96KB2uZwlJE9dINWaYoY+1vdOvcy+a+8Bwwjh5Wn+sbgkzcUC9bpV/8mwvPYUKirUV7ydC7DeIyKds9wlfwGBDP0ninTZdqBos4VKrx9EYQhBAnc8nWPRFtfQ6q3rcwOJnJPo7Hdwws2RwhRLg2Kvv6grCxqSu0pAvBVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Sw0QuxhN; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Sw0QuxhN"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C4BA61648AC;
	Wed, 12 Feb 2025 19:04:17 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7935B124F0C;
	Wed, 12 Feb 2025 19:04:17 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 03/10] qmi: Added structure for device options.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <2672a62a-05b2-4720-8af9-f6272d5d7497@gmail.com>
Date: Wed, 12 Feb 2025 16:04:06 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E84DA59-6E0E-43A0-8353-9A0EFDB49884@nuovations.com>
References: <cover.1739339173.git.gerickson@nuovations.com>
 <92dd49e261569657414c1e43825cbe8928ace900.1739339173.git.gerickson@nuovations.com>
 <2672a62a-05b2-4720-8af9-f6272d5d7497@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=GZRV071u1ByeEXU52+xh838WYnPlzIWww3PEBlf6SWY=; b=Sw0QuxhNn4PE7tjaGipJZYNbTmxY1Rv+XjEdMGDg9g2BWrPMVD7ytiCTPayk83XQDJ1MbUbu6Q3FP/gM1hNSHLuiUJA5qoBW60IiWxGzNKtB8e3Pz2xPt4s0uCsTZ0deS0SbxwliHBh9oI4KB/3KmoXBIG3zl8cexgZP5xXbdPsN9ZXW2S9f9BLgcemKfXfk99DVW9bDoFpdIkvQpfUv3WyuQA1llUs3j6+hD++98kO/2WcE1ee6eI0zzIAyO8wT2FNRYZ2GRQI+ytartiCuHanzzdkwLawbXaj7ZUbrYDqnRHZqk3hSyKJd1AR6OcytTQC7V929fC8awgxVjtLRnw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 12, 2025, at 11:21=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/11/25 11:52 PM, Grant Erickson wrote:
>> Defines options that may alter the default behavior of the QMI driver
>> for a specific, instantiated device.
>> ---
>>  drivers/qmimodem/qmi.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
>> index 913035897ea4..3f60e90c015a 100644
>> --- a/drivers/qmimodem/qmi.h
>> +++ b/drivers/qmimodem/qmi.h
>> @@ -76,6 +76,25 @@ enum qmi_qmux_device_quirk {
>>   QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT =3D 0x01
>>  };
>>  +/**
>> + * Defines options that may alter the default behavior of the QMI
>> + * driver for a specific, instantiated device.
>> + */
>> +struct qmi_qmux_device_options {
>> + /**
>> + * Device-specific "quirk".
>> + */
>> + enum qmi_qmux_device_quirk quirks;
>> +
>> + /**
>> + * If quirks has #QMI_QMUX_DEVICE_QUIRK_REQ_RATE_LIMIT set, this
>> + * is the minimum period, in microseconds, in which back-to-back
>> + * QMI service requests may be sent to avoid triggering a
>> + * firmware lock up and hang.
>> + */
>> + unsigned int min_req_period_us;
>=20
> Why do you need both?  Isn't setting min_req_period_us non-zero =
enough?  Also, strictly speaking this may also apply to qrtr devices.  =
Maybe just add
> bool qmi_qmux_device_set_request_throttle(device, us_time) ...?

Denis,

I had originally started with a hard-coded 1,000 us value and the quirk =
flag just determined whether that value and functionality was used or =
not (in effect, making it nullable).

However, after realizing during further testing that the 1,000 us value =
didn=E2=80=99t work past 60 back-to-back tests and needed to be bumped =
to 2,000 us, I added the ability to parameterize the value at the driver =
level and figured that quirk flags were valuable enough a construct to =
stay as-is where future quirk flags might be added.

More abstractly, I like that the quick flag makes the value explicitly =
nullable. I tend to not otherwise like =E2=80=9Cmagic=E2=80=9D sentinel =
values (in this case, zero).

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

