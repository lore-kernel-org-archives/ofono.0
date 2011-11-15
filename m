Content-Type: multipart/mixed; boundary="===============0417757370961871815=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 5/6] gatppp: Add IPv6 CP connect, disconnect callbacks
Date: Tue, 15 Nov 2011 07:43:29 -0600
Message-ID: <4EC26C81.7010104@gmail.com>
In-Reply-To: <4EC3C333.8000905@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0417757370961871815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 11/16/2011 08:05 AM, Oleg Zhurakivskyy wrote:
> Hello Denis,
> =

> On 11/15/2011 04:59 AM, Denis Kenzior wrote:
>>> @@ -64,6 +64,7 @@ struct _GAtPPP {
>>>       struct pppcp_data *ipcp;
>>>       struct pppcp_data *ipv6cp;
>>>       struct ppp_net *net;
>>> +    struct ppp_net *net6;
>>
>> Actually you can't do it this way.  There's only a single IP layer, so
>> it is considered 'live' as soon as one of the NCPs (e.g. IPCP or IPv6CP)
>> has been negotiated (e.g. went to 'up' state).
> =

> Thanks for the explanation of the semantics here.
> =

> Regarding the ppp_net, it might be possible to do just with one
> instance, enhancing struct ppp_net with guint8 proto field. The protocol
> that goes up first, creates the interface, the second one just adds
> relevant protocol configuration. Maybe, the reference counter, would be
> useful here then.
> =

> What would be the preferred approach here?
> =


That sounds fine, basically we need a single TUN interface to handle
both IPv6 and IPv4 packets.  We can probably get by with simply checking
the state of each NCP inside ppp_drop_packet on the rx side.

On the tx side we most likely need to peek inside the IP packet to
figure out and set the protocol accordingly.

Regards,
-Denis

--===============0417757370961871815==--

