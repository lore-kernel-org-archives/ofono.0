Content-Type: multipart/mixed; boundary="===============5557940452629048569=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 10:00:22 -0500
Message-ID: <200909021000.23069.denkenz@gmail.com>
In-Reply-To: <a4e57c0e0909020430k5affae8ex85949269c4730a57@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5557940452629048569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ismo,

> This is a philosophical difference from the provisioning point of
> view. An operator will likely support multiple configured access
> points, and the provisioning program should know their purpose from
> the configuration file (internet/MMS/WAP/...). This metadata is not
> there in the Ofono context, meaning that the provisioning program
> needs to store somewhere else the mapping between Ofono context object
> paths and the neccessary metadata. This begs the question: why not
> store all connection data (APN, authentication data, other metadata)
> to this external store in the first place?

Actually this one is missing from the API proposal.  Marcel already wanted =
the =

context type (internet, mms, wap, etc) information.  I've updated the propo=
sed =

API in git.

As discussed previously, we want oFono to manage this data, since it can do =

this by using the IMSI.  So if you insert a different operator SIM your APN =

settings are magically updated for that operator.  =


> In my proposal the "Status" variable was a three-state variable,
> having the states "attached", "detached" and "suspended". "Suspended"
> was specified to mean that the GPRS was attached, but temporarily not
> available (for instance because of a 2G phone call or temporary loss
> of cellular connectivity). In the IRC discussion someone said that
> this property would not be part of Denis's API because the tri-state
> variables were bad and the "suspended" status was not supported by

So the general rule is that if a feature isn't explicitly allowed in 27.007=
, =

we do not support it.  There are exceptions to this of course.  27.007 only =

supports two states for context: activated and deactivated.

> spec 27.007. However, the problem is that Maemo 5 already has UI
> support for indicating that the connection is suspended, and that
> makes it harder to drop the feature. Could the "suspended" status enum
> still be left there, and just have the modems that don't support the
> feature to never go to "suspended" mode?

I'd rather not.

If this feature is really required, then some sort of heuristic can be =

applied.  (e.g. Powered on, Attached on, but context is deactivated most =

likely means temporary unavailability of resources)

>
> Still one difference to my proposal was the dropping of the TX and RX
> byte counts, and the explanation that those statistics would be
> handled by the upper layers by reading the values from the network
> interface. I mentioned the problem where the connection was terminated
> by the network and the network interface was brought down before the
> upper layer had a chance to read the values. After giving the matter
> some thought, I still feel that for this reason the modem driver would
> need to get the TX/RX data and send it to the upper levels, if at all
> possible. Since many operators charge by the amount of data
> transferred, not losing the TX/RX data is quite crucial. At least
> Nokia phones have a GPRS data counter feature, that is supposed to
> show the transferred data. This said, I know that not all modem
> drivers can get the data from a connection that has been terminated by
> the network, but that does not mean that the modem drivers that can
> get the data should just discard it.

This really belong in the kernel.  Only the kernel can reliably know when a =

network interface has been brought down and notify the interested applicati=
ons =

with the statistics.  Nokia hardware supports this explicitly, but many oth=
ers =

don't.  I don't want nasty kludges inside oFono to enable this.

>
> Btw, is the context API missing the PDP type (IPv4 or IPv6)?

I left this out explicitly since I've never seen anything besides "IP" bein=
g =

used.  But we can add this easily enough if there's need.

Regards,
-Denis

--===============5557940452629048569==--

