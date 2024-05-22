Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799247C081
	for <ofono@lists.linux.dev>; Wed, 22 May 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364127; cv=none; b=QewxwxvXeVOJyZ1jumATlfFaUj0PtLITqCgY/Irs/+IiZ5wodaoIsr1A14OALk/qsnSkRt0U2CG7PEN//EHGv+zr3BCBksgBJSsPKRM3WpaVPCbyBG6HHos2tP10qmre8H+DnaV9JX7pyjW8CPW96m0K/9PgeuEk1fYxSQxmT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364127; c=relaxed/simple;
	bh=PKSdcz7KxF0SYNQoxbZuY7FYgEnVMUFxuOvNSQiIk1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUw9PxhqTmta8iWBHENH4t88N02GjX3rOcZ6E8q5WP8TBXrImUwCj9jZxohPNn46s4QBIu7Ix/GYHTt3ri38F+3FWPRvWm9OPL26eQK0+M8NDgLxtJG2HEWyGyYjILWwTlZGjxSGr70CgD6ouFT/a1P46Py2PrXW380woXzUhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=luwwjfn8; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="luwwjfn8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PKSdcz7KxF0SYNQoxbZuY7FYgEnVMUFxuOvNSQiIk1o=; b=luwwjfn8RNCLlOiHVddEP0XnVW
	LMXLmn3RTpMmHpB22LkM5dBIQtUXeexLPhXOewIYVod1ivbWUmL7yWlk677Tl30Fv1FIwxaqo5sMl
	M3rXjkypaP0OEDAZaDvK/YGJCcB6/krqRdLZn5OUW/2vlHdjKldBlL9DbLvgeicWMLnkBi4gKsiQM
	+PkQsqpH4QCAJ/hHNWJa95oElb/FBwDZWlv+TRCFSNdTtND5SeOyEguWbLqSoA3gWxBrG03LeUP8H
	kF7Wiz27ksVLgRF68BSv3IDobY3DTjqpS5IhfBYaXKpusD06Wi3CUrOvhquDiSw2iXXipHl1BxT5B
	7b25begA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1s9giA-0007c1-H9; Wed, 22 May 2024 09:48:34 +0200
Received: from [85.184.138.13] (helo=[192.168.8.223])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@geanix.com>)
	id 1s9giA-000Bp9-0Q;
	Wed, 22 May 2024 09:48:34 +0200
Message-ID: <1f043a8186d42fe4a65914e0c44f106ef4ccc41c.camel@geanix.com>
Subject: Re: [PATCH 08/10] udevng: register support for SIMCom A76XX USB
 serial modem
From: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Date: Wed, 22 May 2024 09:48:33 +0200
In-Reply-To: <20240430115234.180185-8-martin@geanix.com>
References: <20240430115234.180185-1-martin@geanix.com>
	 <20240430115234.180185-8-martin@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27282/Tue May 21 10:30:22 2024)

Hi,

On Tue, 2024-04-30 at 13:52 +0200, Martin Hundeb=C3=B8ll wrote:
> Register the 1e0e:9011 usb id as a specialization of the sim7100
> driver.

I'm seeking advice on an issue that I experience with this SIMCom
A7672E modem: Not closing the PPP session when powering down the modem
breaks a following attempt to go online.

When setting Powered to false on dbus, any active PPP session is
destroyed without terminating it. The modem then keeps the session
alive for 15 seconds, even after sending AT+CFUN=3D0 and AT+CFUN=3D1.

The active session on the modem somehow interferes powering up the
modem again, and activating the gprs context.

The issue can be worked around by setting Online to false before
setting Powered to false.

I've been in contact with SIMCom, and while they understand the issue,
they more or less tell me to just close the PPP session before sending
AT+CFUN=3D0 :( I'm still trying to make them fix the issue properly, but
I don't hold my breath...

Is there a way to make ofono send a proper PPP terminate request to the
modem when powering down?

// Martin
