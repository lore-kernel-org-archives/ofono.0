Content-Type: multipart/mixed; boundary="===============3997315940210272630=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: RE: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 15:25:51 +0300
Message-ID: <1284985551.12393.468.camel@tucson.research.nokia.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A519AF@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3997315940210272630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2010-09-20 at 13:09 +0200, ext Jeevaka.Badrappan(a)elektrobit.com
wrote:
> Class 2 Messages are stored in the SIM whereas Class 1 Messages are
> stored in the device storage which can be host storage or SIM storage.

Right now, oFono doesn't store class 2 messages at all, which is a good
thing. There is quite a trivial DoS attack possibility caused by the
limited storage capacity on the SIM card and the fact that oFono doesn't
provide access to that storage for clean up purposes.

And since exceeding capacity for class 2 messages effectively causes a
HOL block for class 1 messages, the whole thing is really broken by
design.

> When the storage is full, then the ME can inform the network that the
> memory capacity is full. This is to make sure network is not forwarding
> the messages to =

> ME. =

> =

> When the storage is available, then the ME can inform the network that
> it has space for receiving messages.

We could provide this in oFono using the message agent API, or possibly
also via the history API. That is, have the agent/plugin return an error
when it has exceeded its storage capacity, and then have a corresponding
addition the SMS driver API to communicate this to the network.

Of course, one can argue whether this feature really has some real world
relevance or is purely theoretical.

I wonder if it is a type approval requirement to support?

Cheers,
Aki


--===============3997315940210272630==--

