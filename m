Content-Type: multipart/mixed; boundary="===============5998798414231012570=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: trying to understand context creation
Date: Wed, 22 Feb 2012 11:58:07 +0200
Message-ID: <CAHiDW_FfSoXvdsovuuyikOJswrF2AMLGksdAeQ_uUL==00wg5w@mail.gmail.com>
In-Reply-To: <4F43A43D.3020503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5998798414231012570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2012 at 4:03 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Jussi,

Hi, thanks for clarification, it helps a lot.

> On 02/21/2012 09:20 AM, Jussi Kukkonen wrote:
 [clip]
>> * Modem with ConnectionManager appears
>> A ConnectionContext may have been created automatically or not. Under
>> what =C2=A0circumstances does this happen? E.g. If the mobile broadband =
db
>> contains several plans for a MNC/MCC does ofono try them until one
>> works or is the selection left to user? Are there checks to make sure
>> the created context is valid for the network?
>
> Actually this is really rather straight forward.
> 1. oFono obtains the IMSI from the Sim Card, this is a unique identifier
> of the subscriber.
> 2. If the IMSI has not been seen before (e.g. a new never before sim
> card is inserted) proceed to step 2a.
> 2a. oFono obtains MCC/MNC & SPN from the SIM file system, and asks any
> provisioning plugins to provide context information. =C2=A0The contract
> between the provisioning plugin and oFono is that the information
> provided must be unique. =C2=A0E.g. if there are any conflicts, or multip=
le
> matches for a given mcc/mnc/spn then provisioning should fail.
> Successful provisioning results in a set of contexts being created
> before ConnectionManager interface is registered.
> 2b. If provisioning fails or mcc/mnc information is not known (e.g.
> inadequate modem driver support) then a single, default, empty context
> is created.
> 3. If the IMSI has been seen before, then any contexts created
> previously are loaded from the IMSI-keyed storage. =C2=A0This includes the
> unprovisioned 'default, empty context' if it hasn't been provisioned
> previously.
> So to sum up, from a UI point of view, you only need to care about
> provisioning if the UI detects a single, empty context of type
> 'internet' with empty APN/username/password.

or if the user explicitly tells me he wants to mess the context up
manually -- I will have to provide this possibility at all times if
there's no way of knowing whether specific settings are considered
valid by the network.

> And no, there is absolutely no way to know whether a given context
> settings are valid, but a good indication would be that a context
> activation fails.

Aha... would you consider it a good/bad idea if a configuration UI
activated/deactivated the context after modifications to check for
this? This could be useful to say "We couldn't connect to the network
with these settings, would you like try another configuration?"

 - Jussi

--===============5998798414231012570==--

