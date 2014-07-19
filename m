Content-Type: multipart/mixed; boundary="===============2567865599047027965=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Controlling GPRS connections through Ofono in the presence of
 Connman
Date: Fri, 18 Jul 2014 21:04:57 -0500
Message-ID: <53C9D249.1080502@gmail.com>
In-Reply-To: <CAEM=xjg0_ejkSPuOP+fNmaOFtD8w7y-JtYopJn8+abK_RM1GzA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2567865599047027965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederik,

Just a gentle reminder not to top post on this mailing list.

>
> Will the "ConnectionContext.Active" property not only indicate the Ofono
> side is done? I was under the understanding that Connman still has to
> assign the IP and modify the routing table before I can open a socket
> for comms? Is this something I need to check against a Connman property? =

> =


If you are using ConnMan, then yes you would have to monitor the
relevant ConnMan properties.  oFono lets the network management daemon
deal with the IP assignment.  Of course you can always write your own
network management handling code specifically for your use case...

Regards,
-Denis

--===============2567865599047027965==--

