Content-Type: multipart/mixed; boundary="===============6262695976301508463=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 11:48:54 -0800
Message-ID: <1296848934.1520.400.camel@aeonflux>
In-Reply-To: <A459777776EB4841B844E1134E7928740157CA57@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6262695976301508463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> > > And the failure mode of the agent disconnecting is... to drop events
> > on the floor???
> > =

> > Who said that? D-Bus is an asynchronous message bus with a method call
> > and a method return message. Where do you see events being dropped?
> =

> When you receive a callback on NameOwnerChanged for the agent, the propos=
ed patch, AFAICS, just nullifies the agent data in the history structure. A=
ny history event handler called after that simply returns silently because =
the agent is not available.
> This is a lousy failure mode, and you'll need to improve it. Presumably, =
by spooling whole messages until there is an agent ready to receive them.

you do understand the concept of sending something as RFC, do you?

And I did clearly mentioned that the whole part of spooling call history
and message history when agent is not present is missing. That is a TODO
item and hence this was a RFC.

Regards

Marcel



--===============6262695976301508463==--

