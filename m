Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864F45038
	for <ofono@lists.linux.dev>; Sun, 19 May 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143566; cv=none; b=BlaC1SvJDTTW+AxqWeqvXaYFwC2IFfK7fx+wiocJFpWt05DarrDOqa5Jwl/GDf7DHvhNcrxMuDePdmGDcvSzEBVRNkAmfBputTlYDeLEiYCy00tvTaWxnGK5cnZA98uff4Dxa8nlkOr5sp31DiVNqf1WaifJlrCvFJ7l+1V2etM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143566; c=relaxed/simple;
	bh=oN4PwQ2UJG+uxWweGY4aHQhKszw4RXEXzJVOheD5LZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxUBbU7GZ0vaT/ofplD/BQkL6cXFkhtfd1xJ/9OVee0SP8ISeEwb0uer1sI6in4wedaDUdp32/eXW2e9b8MDeD6YOJSPBm339K08P9Y5xUMlGYLsoxwYzgDFccK7Jp7MwB4/tt9siVrduVyIl6Difw6DlC7wrbl2CFNxNvCLuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=TfPw44/E; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="TfPw44/E"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 8805C60853;
	Sun, 19 May 2024 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1716143210;
	bh=oN4PwQ2UJG+uxWweGY4aHQhKszw4RXEXzJVOheD5LZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfPw44/EwxW1bcf8FDkidr6uCrnE/cu9my6tdUoUaMxteOeG/7qOM4Qw1Z+yKbepZ
	 Zc7amikitV6cJx/LeiXTZxZA5rXkdlwTxjEvpAfHrztKwpkjIqdbZqMvNEKQ+t3jhH
	 M4s4ILCDGaTMhNV419wNaHBsRIYQ07V2bfTNOgDhFnhoLje+XbegLSY69wkai8fJ8o
	 vbzHJkskLvLgPmIY+SNmbDbyjtkxECxydvXaN9/y/zNSoqLeVLjk2nH1YaaeMLhvzf
	 N6FMpURrPWb/0pkZm78efGWAVvZoU6yiDu0CeTbFzZsbe16uVP0plZzOfKvodvT34s
	 LPxk3Xvw9sNqA==
Date: Sun, 19 May 2024 21:26:35 +0300
From: Tony Lindgren <tony@atomide.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: Adam Pigg <piggz1@gmail.com>, ofono@lists.linux.dev,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Merlijn Wajer <merlijn@wizzup.org>,
	Carl Philipp Klemm <philipp@uvos.xyz>
Subject: Re: RFC - Add AT interface to qmi device
Message-ID: <20240519182635.GF5156@atomide.com>
References: <2269874.vFx2qVVIhK@adam-laptop-hp>
 <42fea483-2770-45bc-9744-7063174b9ca7@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fea483-2770-45bc-9744-7063174b9ca7@gmail.com>

Hi,

* Denis Kenzior <denkenz@gmail.com> [700101 02:00]:
> Hi Adam,
> 
> On 4/30/24 4:49 PM, Adam Pigg wrote:
> > Hi
> > 
> > I would appreciate views on this patch I need for the Pinephone modem.  This
> > adds code to the gobi plugin and qmi_device to get a handle to the GAtChat Aux
> > interface.  The voicecall and sms drivers can then use this interface to
> > trigger call/sms notification.
> 
> From an architectural perspective this is unfortunate.  QMI atom drivers
> (drivers/qmimodem/*) should not know anything about AT command drivers
> (drivers/atmodem/*) or GAtChat and vice versa.  Doing so keeps dependencies
> to a minimum and allows oFono to be compiled without AT/ISI/RIL/MBIM support
> for example.
> 
> For modem drivers, I can see the need / usecase of driving both QMI and AT /
> whatever ports together simultaneously.  Such modem drivers would then
> depend on both QMI / AT / whatever support being available.
> 
> > 
> > This is done in addition to the QMI interface, because it seems that
> > _sometimes_ the modem does not always send the QMI notification, or it is
> > missed due to the phone being in a deep sleep state.  The AT interface is
> > always triggered.
> 
> Have you considered simply using AT commands for calls and SMS?

At least on Droid4 the ttyUSB AT interface is bit buggy.. But there may be
a generic way to trigger lost QMI events based on the USB AT interface
notifications.

What we accidentally discovered with the Maemo Droid4 modem patches was
that triggering a dummy QMI call on serial (muxed TS 27.010) notifications
would trigger the lost QMI notifications :)

So we have the call below in the out of tree patches to kick the USB QMI
modem based on the AT interface notifications:

int mot_qmi_trigger_events(struct ofono_modem *modem)
{
	struct motmdm_data *data = ofono_modem_get_data(modem);

	if (data->wms == NULL)
		return -ENODEV;

	return qmi_service_send(data->wms, QMI_WMS_GET_SMSC_ADDR, NULL,
						NULL, NULL, g_free);
};

Ivaylo mentioned a while back that the notifications also appear on the
ttyUSB AT interface, so maybe the same code would work for Pinephone and
Droid4. Not sure if Ivaylo already has some related patches.

Regards,

Tony
