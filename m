Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB226772B
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554046; cv=none; b=MWtDn7p9sxtqzTSQUh9T5visLO3nWJ/UeMupGjhUaZCaZfKRyrE1MJjZpvd7krClJ+K+W50ZGBU4sWpBrtUsWGHQuTPOjV968g8o1dkTcz/GsPp59NEdw8BeIp86vE07lgVV/vgI08IufjWKG8BZEYaa7jOgErheNcyq1ebBC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554046; c=relaxed/simple;
	bh=TdM46v39GGQLsvqJW2ybfrF6nTtj6yypNrN/w/DJ+X4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HSOonMNtz/EZMJOlwXc6KO+vWNUYknOWBCyEHnrSNDJvECGhAznAGpaCbymETMt4cOi5lMEMC1nNVhGIgRkAwmA/OFTaXOiGFueIXizfuvMGZrstNVXuWorcTikVim8wvCgCWX73IPHmikgB9xcyThc7Pzj4tlJlTaMBXMdayhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=KlPfMU/V; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="KlPfMU/V"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 90641164953;
	Fri, 14 Feb 2025 12:27:23 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 43842124F0D;
	Fri, 14 Feb 2025 12:27:23 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v3 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <bee3deed-8285-4452-9c14-c40b60c06ade@gmail.com>
Date: Fri, 14 Feb 2025 09:27:12 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <468C8C98-64D5-43F0-87FD-F4B9CB63049D@nuovations.com>
References: <cover.1739509438.git.gerickson@nuovations.com>
 <31c04f926af6ddfe0e244c2d6b0999ee9442659a.1739509438.git.gerickson@nuovations.com>
 <bee3deed-8285-4452-9c14-c40b60c06ade@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=QfIHTAaBOj2LYgXDVcoD5erkLdloDERsPJ3QRS4bPgQ=; b=KlPfMU/VorFC4IynQVtouyyIfTIhGcG/QHzFq5g7/f5RHZbrEnPcPpg64gq8zIpvbSSqQUTCuVQTzEMPFkIgVV9BYFvoijaArc3+mS1OhMrhM1u8fWXlMfQSbS2K/Wg0k3qz60yff1BzQD7DG6PZYgSvmMVzWl5QJ48S8/FaK7yUVqKg6g1ApsIDcUVG6yUZPCLDLFvj2qqsLyuPhGmXrOgDHXPxrpQnsSEv5ycbAADA7TtSX9A5w4fFD4l7Nby74vjM+RmHbFH98grJUt7G6ZEObiswknHcsUoE+vjqgGZpNFi1oYX3pY1UbtB5rLT4Q0Z1twTenOpZLVqD49fi7Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 14, 2025, at 7:29=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
>=20
>=20
> Hi Grant,
>=20
> >   struct qmi_qmux_device {
>> @@ -653,8 +665,25 @@ static bool can_write_data(struct l_io *io, void =
*user_data)
>>  {
>>   struct qmi_transport *transport =3D user_data;
>>   struct qmi_request *req;
>> + const bool throttle_enabled =3D transport->min_req_period_us > 0;
>> + uint64_t now =3D 0;
>=20
> I think this is still wrong?  There's a reason why we have =
doc/coding-style.txt item M7.
>=20
>> + uint64_t delta;
>>   int r;
>>  + /*
>> + * Determine if we need to rate-limit commands to a
>> + * transport-specific minimum request period. If so,
>> + * return true so that the queue can be retried again
>> + * later.
>> + */
>> + if (throttle_enabled && transport->last_req_sent_time_us !=3D 0) {
>=20
> Consider the starting condition:
>=20
> - last_req_sent_time_us -> zero
> - throttle_enabled -> true
>=20
> We don't enter into this if(), 'now' is still zero.
>=20
>> + now =3D l_time_now();
>> + delta =3D l_time_diff(now, transport->last_req_sent_time_us);
>> +
>> + if (delta < transport->min_req_period_us)
>> + return true;
>> + }
>> +
>>   req =3D l_queue_pop_head(transport->req_queue);
>>   if (!req)
>>   return false;
>> @@ -665,6 +694,9 @@ static bool can_write_data(struct l_io *io, void =
*user_data)
>>   return false;
>>   }
>>  + if (throttle_enabled)
>> + transport->last_req_sent_time_us =3D now;
>> +
>=20
> throttle_enabled is true, we set last_req_sent_time_us to 0.  In =
effect your throttling doesn't work...?

Confirmed, thanks. v4 submitted.

I=E2=80=99ve noted that the default ofono warning flags do not highlight =
the potential conditional issue with =E2=80=99now=E2=80=99 on arm, =
aarch64, or x86_64 with gcc or clang. If I dial up warnings with -Wall =
-Wextra -Weverything, then I get the warning.

With that in mind, do you want =E2=80=99now=E2=80=99 to follow M7 with =
the default warning flag set or to not follow M7 but ensuring the =
warning is addressed using default initialization with a non-default set =
of warning flags?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

