Content-Type: multipart/mixed; boundary="===============8879182748352546216=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Duplicated contexts...
Date: Wed, 07 Aug 2019 17:08:57 -0500
Message-ID: <d54d9b0c-d450-e021-881b-d05431588966@gmail.com>
In-Reply-To: <CAHB-PjmsKndU1317ZGxPDsR7asT-R3EY5rvOAD_Ou=VgYNVQ2A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8879182748352546216==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/7/19 4:44 PM, Richard R=C3=B6jfors wrote:
> Hi,
> =

> Just want to hear your=C2=A0thoughts of how to fix an issue I saw.
> =

> The modem was told to activate with COPS=3D0, that took time.
> And a context was activated ME PDN ACT, almost immediately when =

> registered (LTE).

Interesting.  How'd you get here?  From what I understand you somehow =

got from post_sim to post_online in record time such that the sim atom =

hasn't finished initializing?

Really, a connection manager should not Online the modem until the =

SubscriberIdentity has been pushed out via signal...

> =

> So gprs got notified that the CID was activated. But at that stage SIM =

> had not finished, it was queued after the COPS=3D0 and there is a long =

> sequence... So gprs had not read its provision contexts.
> So a new context was created.....

Yes, so in theory gprs atom doesn't even appear on D-Bus until the SPN =

is read from the SIM and the contexts are bootstrapped.  So in theory =

you can merge these somewhere during ofono_gprs_finish_register and the =

application won't know any difference

> =

> Later on provision contexts were read and a second context was added for =

> the same APN...
> =

> Ideas of how to fix this:
> 1. Delay creation of context until the GPRS atom is registered, but that =

> is racy in case the context gets activated (we have no check for =

> deactivation without a created context).

This could work if we added a list_contexts method or something...

> 2. Merge provision context into the created context when provisioning =

> happens and send proprtychanged.

You might not even need the PropertyChanged at all...

Regards,
-Denis

--===============8879182748352546216==--

