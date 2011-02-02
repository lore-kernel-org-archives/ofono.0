Content-Type: multipart/mixed; boundary="===============0920625077431456575=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Wed, 02 Feb 2011 22:55:58 +0000
Message-ID: <E9010BA84901F04DBE0FC93A424E0E45010962D1@008-AM1MPN1-035.mgdnok.nokia.com>
In-Reply-To: <1296665027.1520.332.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0920625077431456575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

On 02 Feb 2011, Marcel Holtmann wrote:
>> 	- This relates to another TODO -> persistant storage of RX-TPDUs
>> 	  for incomplete messages. If we've acked a TPDU to network,
>>  	  we must have stored it to persistant storage.
> =

> Where are we not doing this. We do store the fragments. If it is a
> complete message, we signal it directly.

my mistake. I got this impression from some recent discussion on
#ofono (related to the recent patches for TX spooling from Lucas =

De Marchi), and with that in mind, failed to look up what sms_assembly_add_=
fragment() =

really does in the end. I thought it was in-memory stuff only,
but oh no, commit 06ea6137a30944855ebafe0c8abfb2285eac74b5 =

added fragment spooling (already in 2009!), so forget this part.

>> - The history agent does not wait until the agent replies it has
>>   handled the message, but instead it calls agent_request_dispatch
>>   and then already returns to core (which acks the message to modem).
> =

> I know this actually. The missing piece is the storing to disk here to
> spool the SMS history and call history in case no agent is present.

Ok. I just didn't see any mention of disk/file spooling in this
patchset (nor in other existing plugins except the out-of-tree
smshistory) one, and was not sure whether it is proposed to have
spooling before or after the DBus hop.

But yes, if indeed your intention was specifically to add spooling
to the ofono-side plugin already, I agree that would work.

Although, the plugin needs to store to disk _always_, even if agent =

is available. Or wait until the Dbus method reply is received (which
I don't think is feasible). Otherwise following can happen:
 =

 - history_sms_received() called
 - agent available, MessageReceived() called not async so not
   waiting for reply
 - history_sms_received() returns to src/sms.c, TPUs cleared/acked
 -> zap, out of battery -> message potentially lost

This can be solved by spooling always.

>> I'd prefer to have something like:
>> http://people.freedesktop.org/~wjt/telepathy-spec-
>> import_stored_messages/spec/Connection_Interface_Stored_Messages.html
> =

> How is this any better? If all messages get send when the agents
> registers to oFono. And we can easily use D-Bus results to either
> delete messages from the spool or not. Since D-Bus is asynchronous
> and that will just work out fine.

Your plugin patch did not have/mention this functionality (message
goes to /dev/null if no agent is registered), but if this is
supposed to be there, then agreed, this'd work.
 =

So I think this comes down to how the history agent acknowledges
the messages over DBus. E.g. single DBus MessageReceived method =

with ok/nok response, or an explicit acknowledge method/signal (the
StoredMessages telepathy implements the latter approach).

The main functional difference is the possibility to have
multiple agents (as Mikhail noted), but this is perhaps something
to debate whether it is really needed or not.

Otherwise, what I'm still not sure about is whether it's sane to =

have possibly very long req-reply roundtrips, and e.g. multiple pending =

calls of e.g. MessageReceived waiting for reply. I know it _can_ be =

done, but is it a robust design and will it cause grey hairs to agent =

implementors.. (I know many dbus bindings have default timeouts of =

roughly ~30s for method calls -> dunno if this can cause havoc). I freely =

admit my dbus skills/experience is not sufficient, so feedback is =

welcome.

Based on my very informal poll, more people have voted for
explicit acks in Telepathy style, but not all, so good arguments
for/against are welcome.


--===============0920625077431456575==--

