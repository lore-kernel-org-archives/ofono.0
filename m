Content-Type: multipart/mixed; boundary="===============3804951488051812071=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: trying to understand context creation
Date: Tue, 21 Feb 2012 08:03:41 -0600
Message-ID: <4F43A43D.3020503@gmail.com>
In-Reply-To: <CAHiDW_GHn=WQeKbS8w2H_XrFCbGyMid1-=PazuUVx-M=nt+6TA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3804951488051812071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 02/21/2012 09:20 AM, Jussi Kukkonen wrote:
> Hi,
> I'm looking at how I'm creating and using internet contexts to make
> sure I'm not missing any problem cases, and I feel like I don't have
> much feedback on what is happening and what possibly scenarios I
> should be ready for. Dennis explained the ConnectionManager "life
> time" last week which helped a lot (thanks) but I'm still struggling.
> =

> I've listed some steps that may happen from user/GUI point of view and
> the questions I have (some are connman related but I think this is
> still the better list):
> =

> * Modem with ConnectionManager appears
> A ConnectionContext may have been created automatically or not. Under
> what  circumstances does this happen? E.g. If the mobile broadband db
> contains several plans for a MNC/MCC does ofono try them until one
> works or is the selection left to user? Are there checks to make sure
> the created context is valid for the network?

Actually this is really rather straight forward.
1. oFono obtains the IMSI from the Sim Card, this is a unique identifier
of the subscriber.
2. If the IMSI has not been seen before (e.g. a new never before sim
card is inserted) proceed to step 2a.
2a. oFono obtains MCC/MNC & SPN from the SIM file system, and asks any
provisioning plugins to provide context information.  The contract
between the provisioning plugin and oFono is that the information
provided must be unique.  E.g. if there are any conflicts, or multiple
matches for a given mcc/mnc/spn then provisioning should fail.
Successful provisioning results in a set of contexts being created
before ConnectionManager interface is registered.
2b. If provisioning fails or mcc/mnc information is not known (e.g.
inadequate modem driver support) then a single, default, empty context
is created.
3. If the IMSI has been seen before, then any contexts created
previously are loaded from the IMSI-keyed storage.  This includes the
unprovisioned 'default, empty context' if it hasn't been provisioned
previously.

So to sum up, from a UI point of view, you only need to care about
provisioning if the UI detects a single, empty context of type
'internet' with empty APN/username/password.

And no, there is absolutely no way to know whether a given context
settings are valid, but a good indication would be that a context
activation fails.

> =

> * If a ConnectionContext does not appear, UI/user may create one.
> using ConnectionManager.AddContext() and
> ConnectionContext.SetProperty().
> Are there checks at this point to ensure that the created context is
> valid and should work? If not, is there anythign I can do to check
> context validity?

Not really

> =

> * Connman exposes a cellular service
> What are the conditions for this to happen? If connman exposes a
> service, should that "Just work" (with normal caveats about internet
> connections) or does it appear for any context that has been created?

Connman only cares about internet contexts, and its services are
populated from the same ConnectionManager context list.  There are no
further filtering rules other than the context type.

> =

> * Finally, user can connect the cellular service exposed by connman
> If the connection with a cellular service fails, is there anything
> else than "Error=3Dconnect-failed" to work with? What are the potential

not at this time

> reasons for this -- is it just the normal issues with any network
> connection, or can e.g. broken APN settings be a reason for failure at
> this point?
> =


Yes, broken APN settings can and do cause connection failures.

> =

> In case background helps to understand it, this uncertainty came to be
> from two issues (possibly related ones):
> 1. a tester is telling me nothing happens when he selects his plan
> using dawati networks panel (ofono is 1.0 so automatic context
> creation does not work), in other words the service isn't appearing in
> connman. Now, I know how to start digging to the specific  problem in
> this case, but I'd like to make sure I'm handling all the relevant
> error cases... What are the possible points of failure in this? Is it
> just the method calls in ConnectionManager and ConnectionContext plus
> Connman Service.Error after trying to connect to the service?

If the service isn't appearing, then likely the context is not being
created properly...

> 2. I've been testing ofono 1.4 and it seems I can succesfully create a
> context with any values of APN/username/password and a connman service
> will appear. Is this supposed to happen? (Calling Connect() on this
> service will timeout and in the end set "Error=3Dconnect-failed", which
> is to be expected)
> =


Yes, this is supposed to happen.  It is rather unfortunate that the user
has to know this information, however at this time we have not heard /
seen any standard for provisioning context settings other than the
widely used approach of consulting an external database.  This approach
still requires user intervention a lot of times due to varying carrier
plans.

Regards,
-Denis

--===============3804951488051812071==--

