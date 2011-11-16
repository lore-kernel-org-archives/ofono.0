Content-Type: multipart/mixed; boundary="===============7077682014924485653=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCHv2 5/6] gatppp: Add IPv6 CP connect, disconnect callbacks
Date: Wed, 16 Nov 2011 16:05:39 +0200
Message-ID: <4EC3C333.8000905@intel.com>
In-Reply-To: <4EC1D595.9040202@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7077682014924485653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 11/15/2011 04:59 AM, Denis Kenzior wrote:
>> @@ -64,6 +64,7 @@ struct _GAtPPP {
>>   	struct pppcp_data *ipcp;
>>   	struct pppcp_data *ipv6cp;
>>   	struct ppp_net *net;
>> +	struct ppp_net *net6;
>
> Actually you can't do it this way.  There's only a single IP layer, so
> it is considered 'live' as soon as one of the NCPs (e.g. IPCP or IPv6CP)
> has been negotiated (e.g. went to 'up' state).

Thanks for the explanation of the semantics here.

Regarding the ppp_net, it might be possible to do just with one instance, =

enhancing struct ppp_net with guint8 proto field. The protocol that goes up =

first, creates the interface, the second one just adds relevant protocol =

configuration. Maybe, the reference counter, would be useful here then.

What would be the preferred approach here?

>> +	GAtPPPDisconnectFunc disconnect6_cb;
>> +	gpointer disconnect6_data;
>
> Why do you need this one?

I added it for consistency. But, true, it isn't needed, I will drop it.

>> @@ -454,7 +459,19 @@ void ppp_ipv6cp_up_notify(GAtPPP *ppp, const char *=
local, const char *peer)
>>   {
>>   	DBG(ppp, "local: %s, peer: %s", local, peer);
>>
>> +	ppp->net6 =3D ppp_net_new(ppp, -1);
>> +
>> +	if (ppp->net6 =3D=3D NULL) {
>> +		ppp->disconnect_reason =3D G_AT_PPP_REASON_NET_FAIL;
>> +		pppcp_signal_close(ppp->lcp);
>> +		return;
>> +	}
>> +
>>   	ppp_enter_phase(ppp, PPP_PHASE_LINK_UP);
>
> See my previous comments, entering of the LINK_UP phase can happen as
> soon as one of IPCP or IPV6CP has been negotiated, so this needs to be
> reworked a bit.  If it makes things easier, for now we can assume that
> if IPCP or IPV6CP goes down, then the other one should probably be shut
> down as well, if it exists.

OK, understood. Let me check this once again, I will try to address this.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============7077682014924485653==--

