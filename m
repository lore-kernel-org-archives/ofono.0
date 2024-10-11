Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF020C470
	for <ofono@lists.linux.dev>; Fri, 11 Oct 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651355; cv=none; b=pwobzffOWIESZC6hilLCrCrs6/nMBGDQwsnzxGBU84OETLZcELE+87K86j2KyQ2V/LKOxtj5/L/HwE3tQoDEF4M/P6M7iWgHdrwHbnYPllP984WntapNq/PuTCiGekg/tp2Q6sOoig6oZGaF5GMkViSr2HJRPGxICyuTIk+F6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651355; c=relaxed/simple;
	bh=qrnlpJSC3KVh4FwVN0Pds+AX/lyfee1E+VPTyfVNLRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG8CY/nzqz8dXmOEBrwy6pcdpbRDu2Jn29LEUVmxebFe0NvBNM7KXZSYdctDei29xp860MX31V5lgS6s2p9BP0umks+oGlB2kBQ1TzrjvT54Tb6bFQppskMbn0TUHFncSPbXTv9BLdZHwpYVz7HIfEINotsLp1HTIq+uCNcS0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hlRPVmCV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hlRPVmCV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=QUvm/YSNVm9S9h7Lr8hzjNLQux+X9j4dIVE7vCUrO6g=; b=hlRPVm
	CVZht4939MFwctWmcS/YGDDyxeBD9WQP+HzbEdKnVbjyidH7aFrReKNZhK5+DNRr9xY38EFupJnmo
	HdBuLKWtu1aa6jY1TSIeyxlvL9rT09n2nvlK0TvzyqFm6jVfuzMTbbcUz77w098I8ORF+VSWayyq4
	HYNRqL8Gl1YVFqoHop834jQnAVAhJl89Ov7ds3qPLNPGpEinsKZeyEGOd6FNKILuevf0nBjw9UeKU
	MELeP4M//iOheZpPvKb6IKScPdsdfl2dxOmDm+lh+VxlVRTxpByhmcBxss8FH/6gTWNmM378soLN1
	tb/MV+iLy5d3rbL5gZ8JP3SMgDlw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1szFBN-000H49-IF; Fri, 11 Oct 2024 14:55:49 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1szFBM-0002vm-2m;
	Fri, 11 Oct 2024 14:55:48 +0200
Date: Fri, 11 Oct 2024 14:55:48 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: ofono@lists.linux.dev
Subject: Re: [PATCH 1/2] network: allow status' and notifications on eutran
 networks
Message-ID: <yrbu7vwtsbmjfokmqjxaaa72t5jy3ojrg4zfjmzrlbetsxgznj@pnrywn5fpuaw>
References: <20241008091104.1567517-1-sean@geanix.com>
 <80d58c8a-182e-4727-bf6b-4afd5e20f63e@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80d58c8a-182e-4727-bf6b-4afd5e20f63e@gmail.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27424/Fri Oct 11 10:30:09 2024)

Hi Denis,

On Wed, Oct 09, 2024 at 10:35:47AM +0100, Denis Kenzior wrote:
> Hi Sean,
> 
> On 10/8/24 4:11 AM, Sean Nyekjaer wrote:
> > SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
> > 6 registered for "SMS only", home network (applicable only when E-UTRAN)
> > 7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
> > +COPS supplies the <AcT> = EUTRAN
> 
> Do you know the distinction between registered/roaming and "SMS only"
> variants in practical terms?  Are data calls available on "SMS only"?
> Voicecalls?

To my limited knowledge; E-UTRAN(let us call it LTE) doesn't have voicecalls,
that why we have VoLTE.
With the SIMCom modem on LTE in NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN
mode we have data and legacy sms available.

> 
> > ---
> >   src/network.c | 58 +++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 47 insertions(+), 11 deletions(-)
> > 
> 
> CI complains:
> 
> Checkpatch Output
> =================
> 0001-network-allow-status-and-notifications-on-eutran-net.patch:9: WARNING:
> Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> 0001-network-allow-status-and-notifications-on-eutran-net.patch:36: ERROR:
> switch and case should be at the same indent
> 0001-network-allow-status-and-notifications-on-eutran-net.patch:63: ERROR:
> switch and case should be at the same indent
> 0001-network-allow-status-and-notifications-on-eutran-net.patch:92: ERROR:
> switch and case should be at the same indent
> 0001-network-allow-status-and-notifications-on-eutran-net.patch:114: ERROR:
> switch and case should be at the same indent
> total: 4 errors, 1 warnings, 100 lines checked
> 0002-gprs-allow-attached-updates-and-status-on-eutran-net.patch:9: WARNING:
> Prefer a maximum 75 chars per line (possible unwrapped commit description?)
> total: 0 errors, 1 warnings, 47 lines checkeda

Can I run checkpatch myself?

> 
> > diff --git a/src/network.c b/src/network.c
> > index 40626179..02853e23 100644
> > --- a/src/network.c
> > +++ b/src/network.c
> > @@ -376,7 +376,8 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
> >   		return name;
> >   	}
> > -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED)
> > +	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> > +		netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN)
> >   		home_or_spdi = TRUE;
> >   	else
> >   		home_or_spdi = sim_spdi_lookup(netreg->spdi,
> > @@ -1205,9 +1206,15 @@ static void current_operator_callback(const struct ofono_error *error,
> >   	 * in which case the operator information frequently comes in bogus.
> >   	 * We ignore it here
> >   	 */
> > -	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
> > -			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
> > -		current = NULL;
> > +	switch (netreg->status) {
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> > +			break;
> > +		default:
> > +			current = NULL;
> > +	}
> >   	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
> >   		DBG("Error during current operator");
> > @@ -1324,6 +1331,8 @@ static void notify_emulator_status(struct ofono_atom *atom, void *data)
> >   void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
> >   			int lac, int ci, int tech)
> >   {
> > +	ofono_bool_t netreg_status;
> > +
> >   	if (netreg == NULL)
> >   		return;
> > @@ -1351,8 +1360,18 @@ void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
> >   	if (netreg->technology != tech)
> >   		set_registration_technology(netreg, tech);
> > -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> > -		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
> > +	switch (netreg->status) {
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> > +			netreg_status = true;
> > +			break;
> > +		default:
> > +			netreg_status = false;
> > +	}
> > +
> > +	if (netreg_status) {
> >   		if (netreg->driver->current_operator != NULL)
> >   			netreg->driver->current_operator(netreg,
> >   					current_operator_callback, netreg);
> > @@ -1448,6 +1467,7 @@ static void init_registration_status(const struct ofono_error *error,
> >   					void *data)
> >   {
> >   	struct ofono_netreg *netreg = data;
> > +	ofono_bool_t netreg_status;
> 
> Simple bool is fine.  The plan is to remove ofono_bool_t entirely.

OK


> 
> >   	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
> >   		DBG("Error during registration status query");
> > @@ -1460,8 +1480,18 @@ static void init_registration_status(const struct ofono_error *error,
> >   	 * Bootstrap our signal strength value without waiting for the
> >   	 * stack to report it
> >   	 */
> > -	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
> > -		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
> > +	switch (netreg->status) {
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> > +			netreg_status = true;
> > +			break;
> > +		default:
> > +			netreg_status = false;
> > +	}
> > +
> > +	if (netreg_status) {
> >   		if (netreg->driver->strength != NULL)
> >   			netreg->driver->strength(netreg,
> >   					signal_strength_callback, netreg);
> > @@ -1516,9 +1546,15 @@ void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strength)
> >   	 * Theoretically we can get signal strength even when not registered
> >   	 * to any network.  However, what do we do with it in that case?
> >   	 */
> > -	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
> > -			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
> > -		return;
> > +	switch (netreg->status) {
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED:
> > +		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING:
> > +		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
> > +			break;
> > +		default:
> > +			return;
> > +	}
> 
> Might be nicer to do:
> 
> if (!L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
> 			NETWORK_REGISTRATION_STATUS_ROAMING,
> 			...))
> 	return;

Will do that for V2.

> 
> >   	DBG("strength %d", strength);
> 
> Regards,
> -Denis

/Sean
