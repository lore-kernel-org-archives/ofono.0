Content-Type: multipart/mixed; boundary="===============0214254291259032670=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] ublox: TOBY L4 supports only router mode
Date: Thu, 14 Mar 2019 20:44:32 -0500
Message-ID: <a287e5fe-560d-3181-0732-04ab3ae4e9ce@gmail.com>
In-Reply-To: <20190314222843.9232-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0214254291259032670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/14/2019 05:28 PM, Jonas Bonn wrote:
> The TOBY L4 supports only "router mode" where the modem presents a
> network interface that one can run a DHCP client against.  Behind this
> interface, the modem takes care of routing packets via NAT by:
> =

> i)  selecting the relevant context based on destination IP
> ii) using the first activated context as the default route

Ah right, and this is where the multiple active context on the Toby L2 =

stuff came from.  This is a bit tricky to support since oFono expects =

some context types (such as MMS contexts, for example) to not be =

configured via DHCP.  And I'm not sure how MMS proxying would work either.

> =

> In order to have the connection manager, thus, do the right thing, the
> context only needs to report itself as being active and with the IP
> settings set to method "dhcp".  There's no need for the connection manager
> to know details like what IP address the context was assigned.
> =

> Tested with connman that does the right thing when it finds an active
> "dhcp" context.

Anyway, all 5 applied, thanks.

Regards,
-Denis

--===============0214254291259032670==--

