Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AD136E
	for <ofono@lists.linux.dev>; Fri, 14 Feb 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493968; cv=none; b=jOwfdMUQ1ED2guo7NmYzcMWKZ2dN+fAydZPbojsVhiRHnPClUrfeB4pcchfQawCsYmNT625h09eW2b4erG9dSw8j0tAJY1v9nAJI20N4qhYPeW7VpwDXaQa1mbKiWvNS/RICEG8tBpwATLwMPE8w1XDl2iBIlttPocU6TUBft9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493968; c=relaxed/simple;
	bh=7iafmAR6qEvw8gr5+TXhjCBaPXEhSft9e4Tcr6aH8nk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dAo/w5eeLDoP6Kq7t3macmjFz6j7eAMqHJMn/eqGSJ7CuAwfEzwPf9HQ1lcU/9n6k1+fhtXExjz7hbtWQe5N67RkMOyXf6eL+wUX3237+c8OhsWfEJoCm3Zr8V70goY2SSpmCMJKJcSK5Dm3bZ17IPZSBvpMI4RGCqq4SZxMI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=FyW0k7vf; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="FyW0k7vf"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 14701164952;
	Thu, 13 Feb 2025 19:46:06 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B94D5124FD2;
	Thu, 13 Feb 2025 19:46:05 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH 0/7] Add AT&T, T-Mobile, and Verizon MVNO IoT/M2M APNs
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <cover.1738805694.git.gerickson@nuovations.com>
Date: Thu, 13 Feb 2025 16:45:54 -0800
Cc: Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <014B2EA0-26CD-450B-96CC-0B4D78BE9A34@nuovations.com>
References: <cover.1738805694.git.gerickson@nuovations.com>
To: ofono@lists.linux.dev
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=IblEjnTxJuMp1zrxGkjSbxiIh+Ow05Kvsi/SOICUqXs=; b=FyW0k7vfZvqabg1umKuE3p7HhDhZ2C/3oTw4IDK9skD+oqMU/eK7OaBoAw8ISrzscI2LFkvsOq9ik1B9lfNvTyH7ILFRKjPjI1RBK32NI/aaloLF6EaRqOOvcwGAWILqmQZEo3mc3eQBz8kEPXSxu8yjCs5t7t0TkeJ73KdNUEI182Cp68tn8/BG2sfcVSnCCLYjlI7ICS8K55cJRk4vkX7QeIdKRjr9C96TxuatGbjHMLnQvgdULQzHTkM5suwTA2Vs8Ch8uCqZlsIj/B8n9RVjQGPdjxcQFZceJjj9KhHDbj09P42Ae/b20W99+fBK6ZJMIcFhYTmb78Qz+dhSjw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Feb 5, 2025, at 5:37=E2=80=AFPM, Grant Erickson =
<gerickson@nuovations.com> wrote:
> At least in North America / United States, there exist Cellular MVNOs
> (particularly in the IoT / M2M veritical) that neither use mobile
> virtual network operator (MVNO) service provider names (SPNs) nor use
> unique home network identifiers (HNIs) (that is, mobile country code
> (MCC) + mobile network code (MNC) pairs). Instead, they simply use the
> HNI of the parent operator.
>=20
> In addition, those MVNOs typically have two or three APN schemes:
>=20
>    1. A "public" APN that is broadly used by one or more MVNOs for
>       the parent operator that issues PUBLIC IP addresses and does
>       NOT route through the MVNOs or parent operator data center
>       infrastructure.
>=20
>    2. A "private" APN that may or may NOT be broadly used by one
>       or more MVNOs for the parent operator that issues PRIVATE IP
>       addresses and does route through the MVNOs or parent operator
>       data center infrastructure.
>=20
>    3. A "private" APN that is used only by the MVNO that issues
>       static or dynamic PRIVATE IP addresses, does route through the
>       MVNO data center infrastructure and, from there, via a VPN to
>       the customer services infrastructure.
>=20
>       These are sufficiently MVNO-specific where they do not or
>       should not play a role in a generic provisioning database.
>=20
> KORE Wireless is one such IoT / M2M MVNO that uses AT&T, T-Mobile, and
> Verizon as parent operators.
>=20
> This adds a MNVO-generic IoT / M2M APN of type (1) and (2) above that
> are used by KORE Wireless as well as by other MVNOs for the AT&T,
> T-Mobile, and Verizon parent operators.
>=20
> Grant Erickson (7):
>  data: Add AT&T MVNO IoT/M2M 'Public' APN.
>  data: Add AT&T MVNO IoT/M2M 'Private' APN.
>  data: Add T-Mobile MVNO IoT/M2M 'Public' APN.
>  data: Add T-Mobile MVNO IoT/M2M 'Private' APN.
>  data: Add Verizon MVNO IoT/M2M 'Private' APN.
>  data: Add Verizon MVNO IoT/M2M 'Public' APN tag for KORE Wireless.
>  data: Add Verizon MVNO IoT/M2M vzwims APN tags for KORE Wireless.
>=20
> data/provision.json | 52 ++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 49 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.45.0

This patch set can be ignored / abandoned; it has been superseded by =
subsequent patch sets.

Best,

Grant
--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

