Content-Type: multipart/mixed; boundary="===============7476977057805139207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MBIM IP configuration
Date: Mon, 24 Sep 2018 16:17:41 -0500
Message-ID: <d773975b-e323-19d8-083e-857b652db65a@gmail.com>
In-Reply-To: <CAKSBH7EYgTj-r2WLSZikV2Ez4uzkQn-Ew9N4Bvab2fuB1YzrzA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7476977057805139207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/24/2018 12:45 AM, Giacinto Cifelli wrote:
> Dear all,
> =

> I have stepped into a very slow networks, that takes almost 1 minute to =

> assign an IP address once the MBIM CONNECT DONE is returned.
> Under these conditions, the call to IP_CONFIGURATION returns all empty =

> values, and the driver sets the connection method to 'dhcp'.
> But this modem does not support DHCP, so is there a way out of this?
> Can the driver set the method to kind of 'waiting', and query =

> periodically, let's say every 500ms or every second?

You can try and have mbim_ip_configuration_cb retry the IP_CONFIGURATION =

command in this case after a timeout.  However, this seems to also be =

completely against the MBIM specification.  If the device signals that =

no IP configuration details are available, then DHCP is implied. =

However, most MBIM devices do not support DHCP anyway.  So this is bizarre.

The fact that you get IP details after a minute also implies that this =

has nothing to do with the network wanting DHCP done by the host (like =

you posit in your other email on the subject).

Regards,
-Denis

--===============7476977057805139207==--

