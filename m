Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CEEC4
	for <ofono@lists.linux.dev>; Thu, 13 Feb 2025 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405292; cv=none; b=AuXFGnvtLCvJVt6Ol1J0NPSuE2Jx+Q9Y3JusVivBIBAeTZIph0SaYDg6B41AoGZ/EAHW04Pwfgw352SNBBOm7sX0onguZsofuyOGam0qbM9JUXHHUZusbYecRP/QlwL0IzxhTIyxpbrhTyiu0sgFKJ+z0R2JQgg+UIIo1tuSz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405292; c=relaxed/simple;
	bh=kyO3yEKEOH3ygb2uQ6TVtZEgkSYwyKoKUH2HNLHlMb4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W7L5RYmBK55HI4yjjzZyFO2GbpaoFB/F7sGclZLywB2MR6k0StZjNojS83mboQL593U27uhTTqDBZx7v+A2NiOU8KxE/nCq9kDLXQX7UVZJT72nngjikQsMNa+3Re6UZwFKu3LibAnzeCniioFhHCiWbp5PArSWOLK+vl4yv1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=DfokSsBD; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="DfokSsBD"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E5E391648AC;
	Wed, 12 Feb 2025 19:08:09 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 96B3F125167;
	Wed, 12 Feb 2025 19:08:09 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 08/10] qmi: Implement QMI service request rate limiting in
 'can_write_data'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <382fba22-d60b-4f46-9897-7f674221dec0@gmail.com>
Date: Wed, 12 Feb 2025 16:07:58 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CE7F093-091F-411C-9026-DDD3EA63EA47@nuovations.com>
References: <cover.1739339173.git.gerickson@nuovations.com>
 <1cf82d1527078e71d7a64b4f8caa7c5adad680c7.1739339173.git.gerickson@nuovations.com>
 <382fba22-d60b-4f46-9897-7f674221dec0@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=ErSGpGHVUGtbiCNCVxExCGBMZ74mJ4zS3J7M2aTN0gg=; b=DfokSsBD2QpNHfbJTDPSvJfhUaU0wzq33fpZJTQWiw+kb1wj1LmqWriFAtUztr7WOdYMkmlJFonjIOKWh9vO+Ds3nk2btQxV+ksGXvg/UZVaD24HpssP8iOSrtu2aEBr3PJEN1+GIQ4ICNoEqU/zaxdZV1VWuW3PQx6bOA1LyTS4cSn/YxQYiKaB9VOOpUvpQhWS8zIl6+UwVnTW3os0KWVlwn3RsXdukAdkhUsuUci8zhAWYc5lVQc1y6jcKQAswPhUqDb3GGVZ0YrZ7gm1U5r6fWqorHMtyhG7rTUqrAIDM9li9KSFZ0j41EWTRz9S7uIYxXLqW2gNXDn7RyPcRw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 12, 2025, at 11:29=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/11/25 11:52 PM, Grant Erickson wrote:
>> Determine if we need to rate-limit QMI services requests to a
>> transport-specific minimum request period. If so, return true so that
>> the queue can be retried again later.
>> ---
>>  drivers/qmimodem/qmi.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>=20
> Patches 5, 6 and 8 should belong in the same commit.  Prefer to group =
new member definitions with their first use.

Noted. I=E2=80=99ll coalesce these in a v2 patch set.

>> diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
>> index 00086578da10..591129c252e3 100644
>> --- a/drivers/qmimodem/qmi.c
>> +++ b/drivers/qmimodem/qmi.c
>> @@ -665,8 +665,23 @@ static bool can_write_data(struct l_io *io, void =
*user_data)
>>  {
>>   struct qmi_transport *transport =3D user_data;
>>   struct qmi_request *req;
>> + const uint64_t now =3D l_time_now();
>> + uint64_t delta =3D 0;
>>   int r;
>>  + /*
>> + * Determine if we need to rate-limit commands to a
>> + * transport-specific minimum request period. If so,
>> + * return true so that the queue can be retried again
>> + * later.
>> + */
>> + if (transport->last_req_sent_time_us !=3D 0) {
>=20
> Shouldn't this check min_req_period_us first, before incurring =
l_time_now overhead?

I=E2=80=99d originally had this in a pre-submit draft. That=E2=80=99s a =
good optimization; noted for v2.

>> + delta =3D l_time_diff(now, transport->last_req_sent_time_us);
>> +
>> + if (delta < transport->min_req_period_us)
>> + return true;
>> + }
>> +
>=20
> Something like:
> if (throttling_enabled) {
> now =3D l_time_now();
> delta =3D l_time_diff(now, transport->last_req_sent_time_us);
>=20
> if (delta < min_req_period_us)
> return true;
> ^^^^ Note, that this is a poor approach since it just busy-loops the =
event-loop until the throttle time gate expires.  Much better would be =
to use some sort of timeout.

Noted. I=E2=80=99d debated a timeout / timer approach; however, it =
seemed much more complicated in terms of its impact on the send / =
dequeue path, so I went with this approach first to validate the =
concept.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

