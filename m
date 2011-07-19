Content-Type: multipart/mixed; boundary="===============6608176981039487463=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 1/3] Mobile broadband provider info plugin
Date: Tue, 19 Jul 2011 17:05:04 +0300
Message-ID: <4E258F10.6070903@intel.com>
In-Reply-To: <4E25886E.8000700@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6608176981039487463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On 07/19/2011 04:36 PM, Denis Kenzior wrote:
> To my understanding, with mobile-broadband-provider-info the best we can
> do is provision the internet context only.

Thanks for the clarification. I thought that for those few cases where mms =
or =

wap settings are already present in the database, we could provision them a=
s well.

> This is there to handle MVNOs.  Basically you might have a provider (A)
> that owns the network and a provider (B) that buys access to A's
> network.  Both can administer different service plans (and have
> different settings for APNs, etc).  In theory the MNC of provider B
> should be different from that of A, however some countries / networks
> are weird and have re-used provider's A MCC/MNC for subscribers of
> provider B.
>
> This is where the SPN comes in, since the MVNO is interested in
> displaying their name to the customer, the SPN is nearly always provided
> on the SIM.  In the case of the same MCC/MNC, the SPN can thus be used
> to distinguish between provider A's settings and provider B's settings.

Thanks a lot for the help, it's clear now.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki

--===============6608176981039487463==--

