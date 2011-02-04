Content-Type: multipart/mixed; boundary="===============3586396334421617461=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Fri, 04 Feb 2011 19:33:48 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157CA57@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <1296846099.1520.394.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3586396334421617461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Marcel Holtmann
> Sent: Friday, February 04, 2011 9:02 PM
> To: ofono(a)ofono.org
> Subject: RE: [RFC 2/2] doc: Add description for history agent interface
> =

> > And the failure mode of the agent disconnecting is... to drop events
> on the floor???
> =

> Who said that? D-Bus is an asynchronous message bus with a method call
> and a method return message. Where do you see events being dropped?

When you receive a callback on NameOwnerChanged for the agent, the proposed=
 patch, AFAICS, just nullifies the agent data in the history structure. Any=
 history event handler called after that simply returns silently because th=
e agent is not available.
This is a lousy failure mode, and you'll need to improve it. Presumably, by=
 spooling whole messages until there is an agent ready to receive them.

Best regards,
  Mikhail

--===============3586396334421617461==--

