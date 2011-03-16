Content-Type: multipart/mixed; boundary="===============5110182954399752932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Wed, 16 Mar 2011 10:54:26 -0500
Message-ID: <4D80DD32.6020400@gmail.com>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC2D1C1E@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5110182954399752932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 03/16/2011 05:45 AM, Mika.Liljeberg(a)nokia.com wrote:
> Hi Denis,
> =

>> So during OSTS Samuel, Marcel and I sat down and tried to =

>> figure out the
>> IPv6 stuff.  Based on this discussion and your implementation =

>> I pushed a
>> series of patches implementing IPv6 and dual-stack contexts.  I have
>> taken (and later re-worked) some of your patches so you get =

>> credit here
>> as well.
> =

> Thanks for pushing the patches. I notice that these are based on my initi=
al set of patches rather than the later ones. A few comments, since I had s=
ome reasons for the changes I did in later patches.
> =

> I notice that your version of the patches are not forming the IPv6 link-l=
ocal address and configuring it on the network interface. That's ok, as lon=
g as connman takes care of it, but it does mean that Ethernet interfaces, w=
hich always have a link-local address, will autoconfigure immediately while=
 point-to-point interfaces will only autoconfigure when connman sets the li=
nk-local address on them. We talked about this with Marcel and at the time =
concluded that it would make more sense to keep things consistent by having=
 oFono configure the link-local address on the point-to-point interfaces. I=
 had this implemented in my later patch sets.

Samuel felt strongly that this should be done by ConnMan.  There's still
some questions left around this area.  Namely whether we should prevent
auto-configuration or not, etc.

> =

> A few comments on the driver API:
> =

> 	void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
>                                                 const char *address,
>                                                 gboolean static_ip);
> =

> What's the expected behaviour if this is called with a valid IP address a=
nd static_ip =3D FALSE? I think you could just drop the boolean flag and as=
sume a statically configured address if this method is called by the driver=
, otherwise do DHCP.

Then this is a bug in the driver.  Dropping the boolean flag is
certainly doable and is probably a good idea.

> =

> 	void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *=
gc,
>                                                 const char **dns);
> =

> 	void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *=
gc,
>                                                 const char **dns);
> =

> I would propose to have just a single method for setting all DNS servers.
> =

> Having separate lists for IPv4 and IPv6 DNS servers made sense in my firs=
t patch set, because a dual context could be emulated with separate IPv4 an=
d IPv6 contexts and those DNS servers might have been behind different netw=
ork interfaces. However, now this just creates additional complexity for th=
e drivers. A dual context will get a list of DNS server addresses, which ma=
y contain IPv4 addresses, IPv6 addresses or both. Now the driver has to sor=
t them into two separate lists for IPv4 and IPv6. Note that you can make A =
and AAAA queries to any server, so there is no particular reason to separat=
e the lists based on address family.
> =


We waffled on this one, but it seemed better to keep it symmetric with
the way ConnMan API is setup for IPv6.  For AT modems that support
dual-stack, the IPv4 and IPv6 information is returned separately anyway,
so for the majority of the drivers separating the details is more efficient.

> 	void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context=
 *gc,
>                                                 unsigned char length);
> 	void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
>                                                 const char *gateway);
> =

> I'm not sure these are really needed, which is why I dropped these from s=
ubsequent patches. This information is not received from the cellular netwo=
rk as part of context activation signalling. On-link prefixes, routes and d=
efault gateways are received as part of the standard IPv6 stateless address=
 autoconfiguration when the interfaces is brought up. The only reason to ha=
ve these would if a specific modem with a virtual ethernet interface deviat=
es from the standard address configuration practises for some reasons.

At least the gateway is reported separately for IPv4 and IPv6.  Refer to
27.007 Section 10.1.23 "PDP Context Read Dynamic Parameters".

For IPv6 we decided to go with prefix length to keep symmetry with
connman, even though 27.007 reports a netmask.  Drivers will need to
convert between IPv6 netmask and prefix length, so this might have to be
addressed in the future.

However, you might be right and that 27.007 is not a good reflection of
reality.  This has happened before ;)

> =

> Current USB modem sticks don't seem to have IPv6 support, so I'd propose =
to just drop these and add an API later if it turns out to be necessary. If=
 USB sticks do this propertly, they'll just proxy router advertisements and=
 neighbor discovery messages over the virtual ethernet interface and any ad=
ditional address configuration settings won't be needed.
> =

> If you decide to keep these, prefix length should probably default to 64 =
and be always shown in the settings.
> =

>> These are highly experimental and have not received much =

>> testing (since
>> I don't really have any facilities to do so).  So please look =

>> and let me
>> know if something isn't working as intended.
> =

> I'm not able to test dual context but IPv6 seems to work with isimodem. I=
 did notice that the context settings allocated in assign_context() are lea=
ked if context activation fails. Easy enough to fix, though:
> =


Sounds good.  Good catch on the leak, should we put it into
pri_activate_callback error case right before release_context?  Either
way, please do me a favor and send a proper patch.

Regards,
-Denis

--===============5110182954399752932==--

