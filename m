Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079B2798E0
	for <ofono@lists.linux.dev>; Tue,  6 May 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530432; cv=none; b=D53g5UF2pvKIZ4OPFsO7vWtu7E+boaQqDACghnZSUBfkdbBhUr+RsbnyFFNzqrjSYnhH+jmCLKhX5MHn6rUB+U/8ydTIP0JLrxPkXz4Fk6FR9KOR/jcKyJVvhsp1zibutHYLpI9FFFIn1ph/ZeSSycEy1zU36yffIYO6p/H2EBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530432; c=relaxed/simple;
	bh=3mJouYyjvgr9l5EjT3fKt+q8mADMRK5GG0uxfeG+uFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BGi1+vBEDmFgIHTh6lMmcoaZwaJTAVcPwCAbhED7hx+J28lgya+3Qw/7ROem06CCPsTd+i+nsYNiOADmcPJ5qX88VcgmkWWl5LP4DaXVhuXmTShWfJcexY63aQCqLMFZVep1+7Zp3qGlz8nt6+femGr4qFK73KNsUFOs/a7TDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=W5QVqoZ9; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="W5QVqoZ9"
DKIM-Signature: a=rsa-sha256; b=W5QVqoZ9r96mN3LeDYBtNp043xc+BNGlkOVSKNuFyfyTgO0JqzPaqHiXa4WXaKN99I8BeUQO6EzzhTUg39YEdaxCk6AYkVEP5vkZ/BY+FwLIjO13zjBjjPbEfVeD7jqKCAbLmRtFJbFeLSWKJOMhSaUk5uFtqZ8FPU6LjrUULExwA9OoAdiN7sSkuBkqiYNiFmUKncqN9Ek1BIvFVcwj4V8UcdD68T341aAPTA7lKU/leEu26c1ztvqKQQbxaMWgzyukSavR8o/b8F3ZdbHqOJyOftDjL1ED3tGLJHIPSWjiqxuXfK/CdMgAoK2PgktjntUXjA8JYYYUs6yPzBqp4Q==; s=purelymail3; d=purelymail.com; v=1; bh=3mJouYyjvgr9l5EjT3fKt+q8mADMRK5GG0uxfeG+uFE=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1803401872;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 May 2025 11:20:25 +0000 (UTC)
Message-ID: <a12e6f1c-1c9c-49c2-a3cb-a78ecf4d38d7@mentallysanemainliners.org>
Date: Tue, 6 May 2025 16:20:20 +0500
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mbimmodem: sim: add support for querying ICCID
 This implements the required functions to query file info and read file info
 from the modem. Currently the other file IDs haven't been implemented, but
 they will be tackled later.
To: Denis Kenzior <denkenz@gmail.com>, ofono@lists.linux.dev
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
 <20250504191931.7078-7-thevancedgamer@mentallysanemainliners.org>
 <61998d0f-822a-4f4f-9b7e-46b400721a8e@gmail.com>
Content-Language: en-US
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
In-Reply-To: <61998d0f-822a-4f4f-9b7e-46b400721a8e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Denis,

On 5/5/25 21:29, Denis Kenzior wrote:
>> +static void mbim_read_file_transparent(struct ofono_sim *sim,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fileid,=C2=A0=C2=A0=C2=A0=
 int start, int length,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned char *path, un=
signed int path_len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_read_cb_t cb, void =
*user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct sim_data *sd =3D ofono_sim_get_data(sim);
>> +=C2=A0=C2=A0=C2=A0 unsigned char iccid[10];
>> +=C2=A0=C2=A0=C2=A0 int iccid_len, len =3D strlen(sd->imsi);
>> +
>> +=C2=A0=C2=A0=C2=A0 sim_encode_bcd_number(sd->iccid, iccid);
>> +=C2=A0=C2=A0=C2=A0 iccid_len =3D len / 2;
>
> Hmm, len is based on the IMSI, not iccid?=C2=A0 Also, the number will be=
=20
> truncated, not rounded up.=C2=A0 Do you mean something like:
>
> sim_encode_bcd_number(sd->iccid, iccid);
> iccid_len =3D (strlen(sd->iccid) + 1) / 2;
>
> ?

oFono's `sim_encode_bcd_number()` will encode the ICCID string into BCD,=20
which halves the length of the string. ICCID's are 20 bytes long, so=20
this just returns 10 for length. The QMI driver also does the same.

- Muhammad

