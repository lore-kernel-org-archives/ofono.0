Content-Type: multipart/mixed; boundary="===============3765356699535265055=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Thu, 08 Nov 2012 08:15:17 -0600
Message-ID: <509BBE75.60308@gmail.com>
In-Reply-To: <op.wngea2yoyxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3765356699535265055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> Just one additional question here
>
> $ ./test/process-context-settings
> Configuring /telit2_0/context1
> Interface is ppp0
> IP address is 10.9.8.171
> Gateway is 0.0.0.0
> Nameserver is 10.168.38.53
> Nameserver is 10.168.38.53
> route: SIOCADDRT: File exists
>
>
> Where these settings (addresses) come from (dhcp?), and why there is no
> correct gateway? I'm also wondering if these commands are connecting
> through GPRS or through 3G if I have 3G modem.

There is no DHCP in GSM.  The settings are obtained via underlying =

network to mobile signaling.  How they are provided to the telephony =

stack varies.  In the case of PPP it is done via IPCP.  Some modems fake =

a DHCP server in their firmware, and some provide the settings via AT =

commands.

There is no gateway because the link is point-to-point, it isn't necessary.

For your question regarding GPRS vs 3G.  The commands used are the same. =

  The modem capability and network availability will determine the =

technology used.  Really the only difference will be the speed you =

connect at.  PPP is too slow for true 3G speeds.  This is why most modem =

manufacturers have switched to high-speed interfaces (e.g. faked =

ethernet) or other special extensions.

Regards,
-Denis

>
> best regards
> Jan
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============3765356699535265055==--

