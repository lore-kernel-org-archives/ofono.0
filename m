Content-Type: multipart/mixed; boundary="===============9178850948705763518=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: trying to understand context creation
Date: Wed, 22 Feb 2012 03:19:25 -0600
Message-ID: <4F44B31D.2050501@gmail.com>
In-Reply-To: <CAHiDW_FfSoXvdsovuuyikOJswrF2AMLGksdAeQ_uUL==00wg5w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9178850948705763518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/22/2012 03:58 AM, Jussi Kukkonen wrote:
> On Tue, Feb 21, 2012 at 4:03 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Jussi,
> =

> Hi, thanks for clarification, it helps a lot.
> =

>> On 02/21/2012 09:20 AM, Jussi Kukkonen wrote:
>  [clip]
>>> * Modem with ConnectionManager appears
>>> A ConnectionContext may have been created automatically or not. Under
>>> what  circumstances does this happen? E.g. If the mobile broadband db
>>> contains several plans for a MNC/MCC does ofono try them until one
>>> works or is the selection left to user? Are there checks to make sure
>>> the created context is valid for the network?
>>
>> Actually this is really rather straight forward.
>> 1. oFono obtains the IMSI from the Sim Card, this is a unique identifier
>> of the subscriber.
>> 2. If the IMSI has not been seen before (e.g. a new never before sim
>> card is inserted) proceed to step 2a.
>> 2a. oFono obtains MCC/MNC & SPN from the SIM file system, and asks any
>> provisioning plugins to provide context information.  The contract
>> between the provisioning plugin and oFono is that the information
>> provided must be unique.  E.g. if there are any conflicts, or multiple
>> matches for a given mcc/mnc/spn then provisioning should fail.
>> Successful provisioning results in a set of contexts being created
>> before ConnectionManager interface is registered.
>> 2b. If provisioning fails or mcc/mnc information is not known (e.g.
>> inadequate modem driver support) then a single, default, empty context
>> is created.
>> 3. If the IMSI has been seen before, then any contexts created
>> previously are loaded from the IMSI-keyed storage.  This includes the
>> unprovisioned 'default, empty context' if it hasn't been provisioned
>> previously.
>> So to sum up, from a UI point of view, you only need to care about
>> provisioning if the UI detects a single, empty context of type
>> 'internet' with empty APN/username/password.
> =

> or if the user explicitly tells me he wants to mess the context up
> manually -- I will have to provide this possibility at all times if
> there's no way of knowing whether specific settings are considered
> valid by the network.

Yep, sounds good.

> =

>> And no, there is absolutely no way to know whether a given context
>> settings are valid, but a good indication would be that a context
>> activation fails.
> =

> Aha... would you consider it a good/bad idea if a configuration UI
> activated/deactivated the context after modifications to check for
> this? This could be useful to say "We couldn't connect to the network
> with these settings, would you like try another configuration?"
> =


I'm generally in favor of not over-complicating this, but instead
relying on the provisioning data as much as possible.  Look at iOS for a
good example, the user doesn't have any UI to edit context settings, it
is all provisioned using carrier profiles.  Granted, the provisioning
database in use is a little bit better than what
mobile-broadband-provider-info provides, so some way to manually enter
details would still be required in our case; however we should strive to
make this as rarely used as possible.

What you suggest is a good idea, but might be overkill...

Regards,
-Denis

--===============9178850948705763518==--

