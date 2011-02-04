Content-Type: multipart/mixed; boundary="===============4608639723864799524=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 11:05:40 -0600
Message-ID: <4D4C31E4.1060008@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157C82C@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4608639723864799524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

> I totally agree. But it means that you have code in oFono to reliably sto=
re an ordered collection of stuff in a filesystem. I wouldn't like MeeGo de=
velopers to maintain very similar code in a different component, just for A=
PI adaptation reasons.

No we do not.  We have code to reliably store tpdus, fragments not
re-assembled messages.  It is not ordered or anything else you make it
out to be.  Why don't you actually read the sms_assembly code and tell
me if it is usable for anything else.  The code for storing assembled
messages would be _completely_ different.

> D-Bus messages at initialization of a storage-capable client:
> =

> 1. client connects to the oFono signal NewMessage.
> 2a. client calls ListMessages.
> 2b. oFono returns spooled messages.
> =

> If there are any messages, two more are needed:
> =

> 3a. client calls ExpungeMessages.
> 3b. oFono returns.
> =

> When a new message is received:
> =

> 1. oFono emits a NewMessage signal.
> 2a. client calls ExpungeMessages.
> 2b. oFono returns.
> =

> Now if we implement a history plugin to serve this API, there will be all=
 of the above plus the history plugin registration and event storage roundt=
rips.

You are proving Marcel's point here, the Agent has about 1/2 as many
round trips as your proposal.

1. client calls RegisterAgent()
2. For each new message the agent's HandleMessage() method is called
3. Client calls UnregisterAgent or oFono calls Release()

Regards,
-Denis

--===============4608639723864799524==--

