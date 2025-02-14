Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86260154C1D
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506940; cv=none; b=jFdJLxl+G43HMDnGlbgZkFuAQLsiEjSKn58ashz4CmcN4gHrs/sHRCfUVRxly7m1ObK5HczDQUHBB9P9NdU26wdzF5fcBbfkIgKurk7kCv7ly9J2dO1efAVGdjGAWHpfuW9VwCxlLECUmDUkoU8PEpzkYF3iLMrarZzPrYcBVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506940; c=relaxed/simple;
	bh=CZn6VjsGupF9ASn5k/8pdD18oZi5EJKyX2bO6qSBpTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c7WCVfntUIuFm98ALVECpfSl0oUvjOH63dVISv9QfUTGbO3G7JbNBiH9ATKTegDQGtLVioQWo0izkRBii9xKb4YRE+9CGsbr7t6pU3puvSu3OW8dZr3UPSuJkl1rKrmAX/Gqn7PxY6lMflocBlc37Gk0LlbnN3ZoMbdPA649Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Dhl45NKg; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Dhl45NKg"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 2D1B6164A75;
	Thu, 13 Feb 2025 23:22:15 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D4094125167;
	Thu, 13 Feb 2025 23:22:14 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2 4/7] qmi: Implement QMI service request rate limiting
 in 'can_write_data'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <5e8f1d1d-01d3-4577-b17d-c565e93f9e0d@gmail.com>
Date: Thu, 13 Feb 2025 20:22:03 -0800
Cc: ofono@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <500BF5FA-3998-40EA-BE10-EEB6955D8328@nuovations.com>
References: <cover.1739406657.git.gerickson@nuovations.com>
 <d2b56b2248111502169c4639329ad8f2fa5715dd.1739406657.git.gerickson@nuovations.com>
 <5e8f1d1d-01d3-4577-b17d-c565e93f9e0d@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=x1NP+c7GNK4k0X3TndIJnfn84etrscHEYn9gQmKddus=; b=Dhl45NKgqt6okHysXR43JsnYGw4YaaqPIBdZGNx8Zfg3p0GcheTVtvj8+BDWCCPPcSCYA/wT8AFHgtUumuXXtT1rBqZpgw6TO/QCmT24ZzA/NG58dNscGJdThuggI0YH4yaGaHffNau9gHWx/4iw1cQNKmehXa7LDxD73J6pmcnIeBcJfNPF9ixdIAadfT1GAnhd9xnEJEZpkjOU0Z2LG9vlq15ZklKW6xbf/nLZKx5R61N87d8DhGqA6mUv2BIfcsQF8pab9u6pljmof5PhjE8eWci5ElFTadnSvNolwumKYeuLU4TdU/2VnY2vpOONmHbJvc/xahCwwRQxzudegg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 12, 2025, at 6:07=E2=80=AFPM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 2/12/25 6:33 PM, Grant Erickson wrote:
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
>> @@ -653,8 +665,25 @@ static bool can_write_data(struct l_io *io, void =
*user_data)
>>  {
>>   struct qmi_transport *transport =3D user_data;
>>   struct qmi_request *req;
>> + const bool throttle_enabled =3D transport->min_req_period_us > 0;
>> + uint64_t now;
>> + uint64_t delta;
>>   int r;
>>  + /*
>> + * Determine if we need to rate-limit commands to a
>> + * transport-specific minimum request period. If so,
>> + * return true so that the queue can be retried again
>> + * later.
>> + */
>> + if (throttle_enabled && transport->last_req_sent_time_us !=3D 0) {
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
>=20
> Pretty sure this won't work and gcc will complain.

Surprisingly, GCC 8.2.0 didn=E2=80=99t squawk about it:

% ${SYSROOT}usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-gcc =
--version
arm-dey-linux-gnueabi-gcc (GCC) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is =
NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.

% ${SYSROOT}usr/bin/arm-dey-linux-gnueabi/arm-dey-linux-gnueabi-gcc
-DHAVE_CONFIG_H -I. -I${PROJECTROOT}third_party/ofono/repo -I./include =
-I./src
-I${PROJECTROOT}third_party/ofono/repo/src
-I${PROJECTROOT}third_party/ofono/repo/gdbus
-I${PROJECTROOT}third_party/ofono/repo/gisi
-I${PROJECTROOT}third_party/ofono/repo/gatchat
-I${PROJECTROOT}third_party/ofono/repo/gril =
--sysroot=3D${PROJECTROOT}rootfs
-isystem ${SYSROOT}usr/include
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/linux/linux-dey/include
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/dbus/usr/include/dbus-1.0
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/dbus/usr/lib/dbus-1.0/include
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/glib/usr/include/gio-unix-2.0
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/glib/usr/include/glib-2.0
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/glib/usr/lib/glib-2.0/include
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/ell/usr/include
=
-I${PROJECTROOT}results/${BUILDPRODUCT}/digi/dey/8.2.0/${BUILDCONFIG}/thir=
d_party/eudev/usr/include
-DOFONO_PLUGIN_BUILTIN -DPLUGINDIR=3D\""/usr/lib/ofono/plugins"\"
-DUNITDIR=3D\""./unit/"\" --sysroot=3D${PROJECTROOT}rootfs =
-mcpu=3Dcortex-a8
-mfloat-abi=3Dhard -mfpu=3Dneon -fno-omit-frame-pointer =
-fno-strict-aliasing
-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -MT drivers/qmimodem/qmi.o =
-MD -MP
-MF $depbase.Tpo -c -o drivers/qmimodem/qmi.o
${PROJECTROOT}third_party/ofono/repo/drivers/qmimodem/qmi.c && mv -f
$depbase.Tpo $depbase.Po

I=E2=80=99ve another evaluation branch with GCC 12.3.1. I=E2=80=99ll =
cross-check there.

>  Compilers are still not great at tying together multiple =
conditionals...  You might still be better off keeping this inside the =
if() you added above...

There are two separate actions to be taken:

1. Performing the rate limit check before the request is dequeued and =
sent.
2. Setting the last sent time after the request is dequeued and =
successfully sent.

So, there need to be two, separate conditional blocks for each.

> Also, don't you need last_req_sent_time_us to be initialized to be =
non-zero somehow?  Otherwise it is dumb luck that last_req_sent_time_us =
is set to anything the first time (probably garbage data)

I thought about zero-initializing it in =E2=80=98qmi_qmux_device_new=E2=80=
=99; however, diving into the implementation of =E2=80=98l_new=E2=80=99, =
it appears as though all memory is zeroed out, so the =
zero-initialization seemed redundant.

I=E2=80=99ll have a v3 shortly based on the feedback from GCC 12.3.1.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

