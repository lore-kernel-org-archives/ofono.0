Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CE1C84D9
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576584; cv=none; b=GmkXuFSIimE/8Qcuov59RpC48iEzt7jw/j0XkkBqRuvgpcNTlMAxuYD0bAUybaNGzrJPhvQTsr/IUcBut9wxIXrdtzRtXxIYOyG/uZrffOfOct1bEarW+qufryPPr5hP7+0iKcjKq+SA5W02CZc1nFvprhQwZ23I7Z8d4mpsEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576584; c=relaxed/simple;
	bh=I4Ki/Z6OxmOOoimq/t0jCgJWstWcgE+IGYAkWZTHhwU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ELqMTCmRVrzvE4FYMb6cTvn/N5f/MV0SESokI0BUGsdKImBpOYBkUsBRA63SeDO7VdXx31MbbIVwvGG6Ipp5vQ1+8948XK/JoLsIkb7kN8XeGEAz6YmxMmFIJIYs34d8bMrhwMHVtDLk0aEy84C1RklHdTfM+of+oO9YlVWC3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=n8DAFgK5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="n8DAFgK5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3018E164A14;
	Fri, 14 Feb 2025 18:43:01 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D6B42124FE9;
	Fri, 14 Feb 2025 18:43:00 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <0fc81066-67e8-4e8a-858d-e92784d72912@gmail.com>
Date: Fri, 14 Feb 2025 15:42:49 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <245C9F37-21E2-49CB-9953-E13146CCE602@nuovations.com>
References: <cover.1739553712.git.gerickson@nuovations.com>
 <35556cf3af8ce161ab6e178bdf4615ee94407bc6.1739553712.git.gerickson@nuovations.com>
 <0fc81066-67e8-4e8a-858d-e92784d72912@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=QWHHJINNE83AKTIaib0xh9+BowgV4wIvaOVPMSCnVlQ=; b=n8DAFgK5A9L7Jn4WqTnwXanndJ9xB4s+RAE6IQXtpOhxodzn73s2Xu9qeXdlEi0/fHS//M1gprxXGcsBVjkofm2TTWj5hzSKvjhK1HDRpz1Lk5Xw9PzIXzv51FcYknJMloHSNrXjUsWO3P7yv1fw4GsG4r9nw7SS5khd+wlUdUU4fyBDL0KksSmxcC7ZcI7ppPhG+BN15sNg5uXnuaZc+N0riSEGgjDEm2VQviNIXn8opPc/DM3/iyD20AYRib9OmAIxZetz8wxJQBfAJzdqzJNmJyOK+W62kcQKtC72ycTfz3RucihtsS6VVDuC/Kw/4pXblOzrRkRiD3NQ+rv5FQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 14, 2025, at 1:08=E2=80=AFPM, Denis Kenzior <denkenz@gmail.com> =
wrote:
>=20
>=20
> Hi Grant,
>=20
> On 2/14/25 11:22 AM, Grant Erickson wrote:
>> Determine if we need to rate-limit QMI services requests to a
>> transport-specific minimum request period. If so, return true so that
>> the queue can be retried again later.
>> Adds the following data members to 'qmi_transport':
>>   * Minimum request period
>>     - The minimum period, in microseconds, for back-to-back QMI
>>       service requests.
>>   * Last request time
>>     - Time, in microseconds, when the last QMI service request was
>>       sent.
>> to support the implementation.
>> ---
>>  drivers/qmimodem/qmi.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>=20
> The CI doesn't like this version either:
>=20
> Alpine (musl) gcc optimized
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Configure: PASS
> Build: FAIL
>    drivers/qmimodem/qmi.c: In function 'can_write_data':
>    drivers/qmimodem/qmi.c:701:50: error: 'now' may be used =
uninitialized [-Werror=3Dmaybe-uninitialized]
>      701 |                 transport->last_req_sent_time_us =3D now;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
>    drivers/qmimodem/qmi.c:669:18: note: 'now' was declared here
>      669 |         uint64_t now;
>          |                  ^~~
>    cc1: all warnings being treated as errors
>    make[1]: *** [Makefile:4090: drivers/qmimodem/qmi.o] Error 1
>    make[1]: Target 'all-am' not remade because of errors.
>    make: *** [Makefile:2405: all] Error 2
>=20
> Regards,
> -Denis

Denis,

Is there a place, in-tree, where the CI process and configuration are =
coded / documented? I=E2=80=99d like to be able to produce the same =
results which:

% ./bootstrap
% mkdir build-clang
% mkdir build-gcc
% cd build-clang
% CC=3Dclang ../configure -C
% make -j`nproc`
% cd ../build-gcc
% CC=3Dgcc ./configure -C
% make -j`nproc`

does not seem to replicate.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

