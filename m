Content-Type: multipart/mixed; boundary="===============3170927557137313636=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Wed, 16 Mar 2011 10:45:28 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D1C1E@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D7FE5D3.8060005@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3170927557137313636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> So during OSTS Samuel, Marcel and I sat down and tried to =

> figure out the
> IPv6 stuff.  Based on this discussion and your implementation =

> I pushed a
> series of patches implementing IPv6 and dual-stack contexts.  I have
> taken (and later re-worked) some of your patches so you get =

> credit here
> as well.

Thanks for pushing the patches. I notice that these are based on my initial=
 set of patches rather than the later ones. A few comments, since I had som=
e reasons for the changes I did in later patches.

I notice that your version of the patches are not forming the IPv6 link-loc=
al address and configuring it on the network interface. That's ok, as long =
as connman takes care of it, but it does mean that Ethernet interfaces, whi=
ch always have a link-local address, will autoconfigure immediately while p=
oint-to-point interfaces will only autoconfigure when connman sets the link=
-local address on them. We talked about this with Marcel and at the time co=
ncluded that it would make more sense to keep things consistent by having o=
Fono configure the link-local address on the point-to-point interfaces. I h=
ad this implemented in my later patch sets.

A few comments on the driver API:

	void ofono_gprs_context_set_ipv4_address(struct ofono_gprs_context *gc,
                                                const char *address,
                                                gboolean static_ip);

What's the expected behaviour if this is called with a valid IP address and=
 static_ip =3D FALSE? I think you could just drop the boolean flag and assu=
me a statically configured address if this method is called by the driver, =
otherwise do DHCP.

	void ofono_gprs_context_set_ipv4_dns_servers(struct ofono_gprs_context *gc,
                                                const char **dns);

	void ofono_gprs_context_set_ipv6_dns_servers(struct ofono_gprs_context *gc,
                                                const char **dns);

I would propose to have just a single method for setting all DNS servers.

Having separate lists for IPv4 and IPv6 DNS servers made sense in my first =
patch set, because a dual context could be emulated with separate IPv4 and =
IPv6 contexts and those DNS servers might have been behind different networ=
k interfaces. However, now this just creates additional complexity for the =
drivers. A dual context will get a list of DNS server addresses, which may =
contain IPv4 addresses, IPv6 addresses or both. Now the driver has to sort =
them into two separate lists for IPv4 and IPv6. Note that you can make A an=
d AAAA queries to any server, so there is no particular reason to separate =
the lists based on address family.

	void ofono_gprs_context_set_ipv6_prefix_length(struct ofono_gprs_context *=
gc,
                                                unsigned char length);
	void ofono_gprs_context_set_ipv6_gateway(struct ofono_gprs_context *gc,
                                                const char *gateway);

I'm not sure these are really needed, which is why I dropped these from sub=
sequent patches. This information is not received from the cellular network=
 as part of context activation signalling. On-link prefixes, routes and def=
ault gateways are received as part of the standard IPv6 stateless address a=
utoconfiguration when the interfaces is brought up. The only reason to have=
 these would if a specific modem with a virtual ethernet interface deviates=
 from the standard address configuration practises for some reasons.

Current USB modem sticks don't seem to have IPv6 support, so I'd propose to=
 just drop these and add an API later if it turns out to be necessary. If U=
SB sticks do this propertly, they'll just proxy router advertisements and n=
eighbor discovery messages over the virtual ethernet interface and any addi=
tional address configuration settings won't be needed.

If you decide to keep these, prefix length should probably default to 64 an=
d be always shown in the settings.

> These are highly experimental and have not received much =

> testing (since
> I don't really have any facilities to do so).  So please look =

> and let me
> know if something isn't working as intended.

I'm not able to test dual context but IPv6 seems to work with isimodem. I d=
id notice that the context settings allocated in assign_context() are leake=
d if context activation fails. Easy enough to fix, though:

iff --git a/src/gprs.c b/src/gprs.c
index 00f6d6d..068aaf3 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -322,11 +322,13 @@ static gboolean assign_context(struct pri_context *ct=
x)
        return FALSE;
 }
 =

+static void context_settings_free(struct context_settings *settings);
 static void release_context(struct pri_context *ctx)
 {
        if (ctx =3D=3D NULL || ctx->gprs =3D=3D NULL || ctx->context_driver=
 =3D=3D NULL)
                return;
 =

+       context_settings_free(ctx->context_driver->settings);
        gprs_cid_release(ctx->gprs, ctx->context.cid);
        ctx->context.cid =3D 0;
        ctx->context_driver->inuse =3D FALSE;

Regards,

	MikaL
=20
--===============3170927557137313636==--

