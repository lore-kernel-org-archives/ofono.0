Content-Type: multipart/mixed; boundary="===============0990379805164991806=="
MIME-Version: 1.0
From: Ismo Puustinen <ismo@iki.fi>
Subject: Re: GPRS support for Ofono
Date: Wed, 02 Sep 2009 14:30:06 +0300
Message-ID: <a4e57c0e0909020430k5affae8ex85949269c4730a57@mail.gmail.com>
In-Reply-To: <200909011636.49020.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0990379805164991806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2009 at 12:36 AM, Denis Kenzior<denkenz@gmail.com> wrote:

> of this discussion.  I'd like all interested to comment.  What needs
> improvement? What is missing?  What should be removed?

Here are some comments. Some of the comments were already present in
the IRC discussion, but I'll repeat them here anyway. First of all,
the both Denis's proposal and mine look quite much the same -- the
basic objects are the GPRS manager and the PDP contexts, and they
offer quite the same functionality. Please correct me if I understood
some parts of Denis's proposal incorrectly. The big differences
between the API proposals are the creation and connecting of the
contexts and the handling of the attached/detached state. I'll try to
address the both issues below.

In this proposal the contexts PDP contexts are persistent on the
device, meaning that they stay there also when Ofono is shut down. The
idea is that the contexts are made to Ofono by the GPRS provisioning
programs or by the UI, and then ConnMan or another upper layer needs
just to activate the context to actually do the connection. In my
proposal I thought that the higher layer components would keep track
of the access points and call the Connect() method with the suitable
connection parameters.

This is a philosophical difference from the provisioning point of
view. An operator will likely support multiple configured access
points, and the provisioning program should know their purpose from
the configuration file (internet/MMS/WAP/...). This metadata is not
there in the Ofono context, meaning that the provisioning program
needs to store somewhere else the mapping between Ofono context object
paths and the neccessary metadata. This begs the question: why not
store all connection data (APN, authentication data, other metadata)
to this external store in the first place?

The attachment to the GPRS network in this proposal is bit vague. To
my understanding, to attach the GPRS you need to set "Powered"
property on and "RoamingAllowed" on. To detach you need to set the
"Powered" property off. Since attaching can take a long time (or
fail), does this mean that the attach errors are handled in the
"Powered" property setter callback?  Or what happens when (during
roaming) the "Powered" is already on and the user puts the
"RoamingAllowed" on -- where are the attach errors handled? I kind of
think that it might be a better idea to just expose the GPRS
registration status and the attach status, and let a higher level
component explicitly set the attach/detach with either a readwrite
property or Attach() and Detach() methods.

In my proposal the "Status" variable was a three-state variable,
having the states "attached", "detached" and "suspended". "Suspended"
was specified to mean that the GPRS was attached, but temporarily not
available (for instance because of a 2G phone call or temporary loss
of cellular connectivity). In the IRC discussion someone said that
this property would not be part of Denis's API because the tri-state
variables were bad and the "suspended" status was not supported by
spec 27.007. However, the problem is that Maemo 5 already has UI
support for indicating that the connection is suspended, and that
makes it harder to drop the feature. Could the "suspended" status enum
still be left there, and just have the modems that don't support the
feature to never go to "suspended" mode?

Still one difference to my proposal was the dropping of the TX and RX
byte counts, and the explanation that those statistics would be
handled by the upper layers by reading the values from the network
interface. I mentioned the problem where the connection was terminated
by the network and the network interface was brought down before the
upper layer had a chance to read the values. After giving the matter
some thought, I still feel that for this reason the modem driver would
need to get the TX/RX data and send it to the upper levels, if at all
possible. Since many operators charge by the amount of data
transferred, not losing the TX/RX data is quite crucial. At least
Nokia phones have a GPRS data counter feature, that is supposed to
show the transferred data. This said, I know that not all modem
drivers can get the data from a connection that has been terminated by
the network, but that does not mean that the modem drivers that can
get the data should just discard it.

Btw, is the context API missing the PDP type (IPv4 or IPv6)?

As I said, I think that the differences between this proposal and mine
are mostly philosophical -- should the context data be stored in Ofono
or in the upper layers of the stack? And should Ofono set the policies
(for instance the roaming case) or just act as a low-level interface
to the GPRS functionality?

By looking at Denis's proposal it is easy to see that my proposal
wasn't perfect either. ;-) At least the GPRS registration state and
possibly other properties need to be added to the D-Bus interface, and
the API also needs to be made more future-proof by thinking how the
network-initiated connections and the secondary contexts would be
made.

-- =

Ismo Puustinen <ismo@iki.fi>

--===============0990379805164991806==--

