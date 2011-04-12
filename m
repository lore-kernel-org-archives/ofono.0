Content-Type: multipart/mixed; boundary="===============0958669029649674141=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 12/20] packet: add context type default
Date: Tue, 12 Apr 2011 04:49:07 +0200
Message-ID: <1302576547.2572.235.camel@aeonflux>
In-Reply-To: <4DA35940.40300@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0958669029649674141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > OFONO_PACKET_CONTEXT_TYPE_DEFAULT is added to
> > ofono_packet_context_type and conversion functions
> > are updated for the same.
> > ---
> >  include/packet-context.h |    1 +
> >  src/packet.c             |    7 +++++++
> >  2 files changed, 8 insertions(+), 0 deletions(-)
> > =

> > diff --git a/include/packet-context.h b/include/packet-context.h
> > index 44fd69f..02a5c42 100644
> > --- a/include/packet-context.h
> > +++ b/include/packet-context.h
> > @@ -47,6 +47,7 @@ enum ofono_packet_context_type {
> >  	OFONO_PACKET_CONTEXT_TYPE_MMS,
> >  	OFONO_PACKET_CONTEXT_TYPE_WAP,
> >  	OFONO_PACKET_CONTEXT_TYPE_IMS,
> > +	OFONO_PACKET_CONTEXT_TYPE_DEFAULT,
> >  };
> >  =

> =

> My understanding was that whether an EPS bearer is 'default' has no
> bearing on what context type (e.g. ims, internet, mms) it actually is.
> I remember there was a conversation on how a 'default' context is
> chosen, but I already forgot most of it.

in the end we concluded that the only way to figure out the context type
is by comparing the APN name. And hopefully we have that one configured
and can simply string match it. If we do not, then the whole system will
fall apart.

> To me it makes no sense that a default context is going to be anything
> other than internet or ims.  The fact that it is a 'default' context
> doesn't really help the upper layers in any way.  Especially ConnMan
> needs to know whether this context can be used for internet access or not.

The concept of default context is as broken as trying to introduce a
special CID 0 meaning. Both do not work. We need to know what type of
context we have.

The real problem that I see here is that there is no clear definition on
what the default context connects to. I think this is the biggest
limitation of 3GPP right now. They should have just said that the
default context always connects to the private IP network of the
carrier. And that will be then the IMS, MMS etc. or some sort of context
that is clearly private to the carrier. And that the Internet context
always needs to be established by host.

Especially for the cases of roaming we need to have the default context
connecting to an operator internal network. Otherwise any kind of
billing will get really complicated. Since on one hand you wanna be
reachable while roaming, but maybe not pay for data roaming. Not to talk
about emergency call handling while roaming.

Lets have a look at the one network that deploys LTE for the public
these days. I did not find an official Verizon page about their APN
names and functions, but this will do:

http://www.4ginfo.com/index.php/verizon-uml290-mac-configuration-warning-a-=
fix.html

CID 1, Type IPV6,   APN vzwims
CID 3, Type IPV4V6, APN vzwinternet
CID 4, Type IPv4V6, APN vzwapp

And if you trust other sources, then CID 2 is this:

CID 2, Type IPV4V6, APN vzwadmin

This does not answer which APN gets activated as default, but I would
assume the network returns vzwims. If someone is on Verizon and has LTE
capable hardware, it would be nice if they try this.

And if you wanna have any legacy software working with LTE data dongle
as before, if would make a lot of sense to not end up having two
Internet contexts activated. I am just saying ;)

Regards

Marcel



--===============0958669029649674141==--

