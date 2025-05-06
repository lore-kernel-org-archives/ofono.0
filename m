Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC801DED51
	for <ofono@lists.linux.dev>; Tue,  6 May 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530156; cv=none; b=GbPyxfEzw0M9MlIALrasih9rHDFnEIFvVC0UHzmzdYdakJ8yyewcSsQJ+pYHv1OM/eY5o83izZRFw5DQae94WHUkvZyRc+8Axg8WRigdKKNCnjtK8pyC3qCbLCGnL8t6JXJSlvmWWR2H+3yiMLOyrG70JrMix43Cgn8+BI5bk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530156; c=relaxed/simple;
	bh=od4/nu/IHfoMQiAsczD2G64oSZmeR/Pyp4JTCcU5C4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ARqeNIvuqlu2xWNdiKZjt2t2Eh3kOxN/Qiye1FG2ivW4x/ex+W3gKk6TeifRjLYFJ+9NOL+55eNc/g/cyYlOCG6zktVEYxINvyhR0oTyG6dyQp7XYK56A2Rfpe8G6lyTlodQgk+jdEDBDv86rIYgzJJS+GRSQahAevuP/pdVMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=naDdWJUy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="naDdWJUy"
DKIM-Signature: a=rsa-sha256; b=naDdWJUyiMAIV82avK7hrrtQPc3rMslZ8qu+4BqlXJYUqkpDB1rRFJrV3+C02WcxKhX9JM/vMqF1OM25ajUq38imZmoJbBcwu1JiZkwZdEwUwuT54Uwk34iZXYouhmF4UmQs0cdcsXYub1enZ8+Gqxxbztxns4ZxOjAF3Tzl37SXQEpGsm6pPBKIpXgX67V/7rK15TSW3gCoo1qbhofB1Ontck41t3/PnGK+hDyTWBBIzO9kacp1Zfmn8/PiLut+eb6fPSPJFAy2+xTdhdE/HC/0pUzOm/cXNZcIuKMX1XXoiRHPJ9/Yl2rGjn/IBdjbKxtCt8MR+lNBOuq5aDaWDA==; s=purelymail3; d=purelymail.com; v=1; bh=od4/nu/IHfoMQiAsczD2G64oSZmeR/Pyp4JTCcU5C4Y=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 628470206;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 May 2025 11:15:51 +0000 (UTC)
Message-ID: <fa652e65-6868-429f-864b-82e57c52a117@mentallysanemainliners.org>
Date: Tue, 6 May 2025 16:15:45 +0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mbimmodem: add support for MBIM extensions * With
 MBIMEx 3.0, arguments for activating GPRS changed. Update as needed.
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-3-thevancedgamer@mentallysanemainliners.org>
 <802f94b3-a288-4c6a-a8c8-df2fe8f4c116@gmail.com>
Content-Language: en-US
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
In-Reply-To: <802f94b3-a288-4c6a-a8c8-df2fe8f4c116@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Denis,

On 5/5/25 21:06, Denis Kenzior wrote:
>> @@ -253,6 +258,11 @@ struct mbim_device {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct message_assembly *assembly;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct l_idle *close_io;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 uint8_t mbim_version_major;
>> +=C2=A0=C2=A0=C2=A0 uint8_t mbim_version_minor;
>> +=C2=A0=C2=A0=C2=A0 uint8_t mbimex_version_major;
>> +=C2=A0=C2=A0=C2=A0 uint8_t mbimex_version_minor;
>> +
>
> In the current design, mbim_device doesn't really manage such state.=C2=
=A0=20
> This belongs in plugins/mbim.c instead.
I will move this to the plugins part.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_ready : 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool in_notify : 1;
>> =C2=A0 };
>> @@ -875,6 +885,22 @@ static bool close_read_handler(struct l_io *io,=20
>> void *user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> =C2=A0 +static void parse_mbim_version(struct mbim_message *message, voi=
d=20
>> *user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct mbim_device *device =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 uint16_t mbim_version =3D 0, mbimex_version =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (mbim_message_get_error(message) !=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 mbim_message_get_arguments(message, "qq", &mbim_vers=
ion,=20
>> &mbimex_version);
>> +
>> +=C2=A0=C2=A0=C2=A0 device->mbim_version_major =3D mbim_version >> 8;
>> +=C2=A0=C2=A0=C2=A0 device->mbim_version_minor =3D mbim_version & 0xFF;
>> +=C2=A0=C2=A0=C2=A0 device->mbimex_version_major =3D mbimex_version >> 8=
;
>> +=C2=A0=C2=A0=C2=A0 device->mbimex_version_minor =3D mbimex_version & 0x=
FF;
>> +}
>> +
>
> The version should be obtained similar to how capabilities are obtained.
>
>> =C2=A0 struct mbim_device *mbim_device_new(int fd, uint32_t max_segment_=
size)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mbim_device *device;
>> @@ -1035,6 +1061,35 @@ bool mbim_device_set_ready_handler(struct=20
>> mbim_device *device,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> =C2=A0 +void mbim_device_get_version(struct mbim_device *device)
>> +{
>> +=C2=A0=C2=A0=C2=A0 // Version is formatted as (major version) << 8 | (m=
inor version)
>> +=C2=A0=C2=A0=C2=A0 const int mbim_version =3D 1 << 8 | 0;
>
> nit: static const?
>
>> +
>> +=C2=A0=C2=A0=C2=A0 // Always open with MBIMEx 3, devices not supporting=
 it will=20
>> fallback to MBIMEx 2
>> +=C2=A0=C2=A0=C2=A0 const int mbimex_version =3D 3 << 8 | 0;
>
> nit: ditto, also please use C style comments
>
>> +
>> +=C2=A0=C2=A0=C2=A0 struct mbim_message *message =3D=20
>> mbim_message_new(mbim_ms_basic_connect_extensions,
>> + MBIM_CID_MS_BASIC_CONNECT_EXTENSIONS_VERSION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MBIM_COMMAND_TYPE_QUERY);
>> +
>> +=C2=A0=C2=A0=C2=A0 mbim_message_set_arguments(message, "qq",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbim_version,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbimex_version);
>> +
>> +=C2=A0=C2=A0=C2=A0 // For some reason, sending a message will return an=
 error code,=20
>> even if valid
>> +=C2=A0=C2=A0=C2=A0 mbim_device_send(device, 0, message,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parse=
_mbim_version, device, NULL);
>
> Hmm, this is suspicious.=C2=A0 mbim_device_send should never fail, unless=
=20
> the device isn't open.
>
>> +}
>> +
>> +bool mbim_device_check_mbimex_version(struct mbim_device *device,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int version_major, int versio=
n_minor)
>
> The naming needs some work?=C2=A0 Perhaps=20
> mbim_device_mbimex_version_at_least()? However, since mbim_device=20
> doesn't really manage this part, consider using a modem property=20
> instead?=C2=A0 Or pass the mbimex version to the atom driver directly. =
=C2=A0See=20
> for example how QMI drivers do this with the new 'probev' driver method.
>
>> +{
>> +=C2=A0=C2=A0=C2=A0 return (device->mbimex_version_major > version_major=
) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((de=
vice->mbimex_version_major =3D=3D version_major) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (dev=
ice->mbimex_version_minor >=3D version_minor));
>> +}
>> +
>> =C2=A0 uint32_t mbim_device_send(struct mbim_device *device, uint32_t gi=
d,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mbim_message *message,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbim_device_reply_func_t function,

I will move the version into a modem property.

- Muhammad

