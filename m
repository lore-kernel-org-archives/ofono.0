Content-Type: multipart/mixed; boundary="===============1242981858492141214=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: RFC: IPv6 support
Date: Wed, 26 Jan 2011 18:22:45 +0200
Message-ID: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242981858492141214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here's an initial set of IPv6 patches for review. Please don't apply
anything yet, as these are not final. I've left in some shim code which
allows compilation with existing modem drivers. Also, I have not yet
tried to exterminate coding style issues.

I'd like feedback on the following issues:

1) connman API: A combined ipv4v6 context type has been added as well
as properties for IPv6 network configuration. The combined ipv4v6 context
falls back on separate IPv4 and IPv6 bearers under the hood, in case the
modem or the network does not support 3GPP rel 8.

IPv6 address configuration is minimal. Basically, only network interface na=
me,
IPv6 link-local address and DNS server addresses are exposed. IPv6 stateless
address autoconfiguration method should be used for interface configuration.
I'd like some feedback on modems that provide a virtual ethernet interface.
Will the above suffice?

2) driver API: The activate_primary_new() method will replace the
activate_primary() method in the final patches. The callback no longer
passes every address configuration setting as argument. Instead, I've
defined a set of ofono_gprs_context_set_xyz() methods to convey context
settings to the core. The reason is that most of the settings are
optional. E.g., with a combined IPv4v6 context we might actually end up
with IPv4 or IPv6 only, instead of both, so both sets of configuration
parameters are optional. Things like IP netmask and gateway for static
network configuration, P-CSCF address, DNS servers, QoS parameters,
are also optional, depending on driver and context type. This way, any
changes are less likely to break the driver interface.

3) implementation in general: Unfortunately, the core patch is fairly big
even though I tried to not change things unnecessarily. The combined ipv4v6
context type made it necessary to rearrange quite a few things. The
pri_context structure now owns one or more context drivers (aka bearers),
each of which has it's own set of IPv4 and IPv6 settings when active.

Currently, the isimodem driver has been updated to work with IPv6, so N900
over USB can be used for testing. Other modem drivers should work ok with
IPv4.

Br,

	MikaL

[RFC 1/5] gprs: Update documentation for IPv6
[RFC 2/5] gprs: driver interface changes for IPv6
[RFC 3/5] gprs: core support for IPv6
[RFC 4/5] test: modify test scripts for IPv6
[RFC 5/5] isimodem: IPv6 support

--===============1242981858492141214==--

