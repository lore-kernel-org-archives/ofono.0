Content-Type: multipart/mixed; boundary="===============0244081750585286773=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 10:11:56 -0600
Message-ID: <4D4AD3CC.5070206@gmail.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157B54B@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0244081750585286773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

>> I am not really getting what you are saying. oFono will reassembly the
>> message for you piece by piece. And we are making sure fragments are
>> stored reliably. However once the message is complete we give it to
>> history for further processing. Mainly to get it stored in the
>> database.
> =

> The part I don't get is, if you do store TPDUs reliably as you seem to be=
 required to do anyway, why not keep the assembled messages until the clien=
t tells you that it is no longer interested in them?
> This will remove a whole class of issues with history agent's availabilit=
y, reliability, and performance.

How exactly is this different from the history plugin storing the
message and letting client ack it?  You can implement that now with
history easily enough.

Not everyone has the same requirements here, you can have systems with a
well defined store that do not need to cross the system/session bus
boundary for instance.

>> If you can accept this extra risk factors in the architecture and
>> ensure
>> that everything is reliable that is fine with me. You do might have to
>> design your unique history plugin that interacts directly with TP-ring
>> then. And to that extend also has its own spool.
> =

> It does not have to, if we can implement StoredMessages in terms of oFono.
> If we could expunge messages from oFono spool explicitly rather than by s=
erving a method call roundtrip, it would be natural. In all, we need three =
things from the oFono SMS API:
> * a property listing the spooled messages;
> * a method to expunge some of the messages;
> * a signal notifying of a new message in the spool.
> =


As I mentioned before, you can do that now using history anyway.  But in
the general case I do not agree this belongs as an official API.  Who
guarantees acking of messages? How many messages to spool? When to throw
away messages?  All of these issues are outside the scope of oFono.

> And this obviates the need to have a history agent service, if I understo=
od correct that you actually don't care about enforcing reliable storage fo=
r call events on oFono side.
> =

>>> 2. You don't want multiple entities to observe events pertaining to
>> oFono communication history and be able to control spooling while not
>> being regulated by oFono.
>>> If this is a concern, I think it's outweighed by greater simplicity
>> and flexibility, and the idea that access policy should be defined
>> outside of the implementation.
>>
>> The example that I sent around here was clearly limited to one consumer
>> and one consumer only. And that on purpose. I think that every storage
>> entity. Being it commhistory alone, or Tracker alone or all together
>> with TP-ring, they need a special history plugin to serve the exact
>> purpose.
> =

> So a platform integrating oFono cannot choose to implement call and messa=
ge logging separately. It needs to supply the whole hog in one plugin, and =
filter out the events it is not interested in at this level.
>

Again, why do you say that? You can have N history plugins doing as much
or as little as you want.  You can have one for smshistory, one for call
history, etc.

Regards,
-Denis

--===============0244081750585286773==--

