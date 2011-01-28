Content-Type: multipart/mixed; boundary="===============0508016116219154565=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] voicecallmanager-api: call related SS signals (proposal)
Date: Fri, 28 Jan 2011 12:19:12 -0600
Message-ID: <4D4308A0.4090805@gmail.com>
In-Reply-To: <4D42F937.3040307@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0508016116219154565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andras,

On 01/28/2011 11:13 AM, Andras Domokos wrote:
> Hi Denis,
> =

> On 01/27/2011 06:01 PM, ext Denis Kenzior wrote:
>> Hi Andras,
>>
>>> This  becomes a problem when there are multiple calls since it is not
>>> possible to determine to which call instance the indication is referring
>>> to.
>>> This raises the question where/how to show this type of properties?
>> Have you seen the thread from Pekka's previous attempt to define such
>> APIs?  Its been a while now but should be in the archives.
> =

> It seems, we might have a bit work to do here.
> =

> The first thing is to settle on  the APIs for handling the voice call SS
> notifications, I am thinking about the DBus level API and the oFono
> internal API.
> =

> Currently the SSI notifications are handled in the call barring code, a
> better place for handling those notifications would be under the voice
> call atom.
> =

> Some of the SSI/SSU notifications should be presented as DBus signals
> on the VoiceCallManager interface, others converted to voice call
> properties, visible on the VoiceCall interface. I compiled a list of
> properties/signals based on the possible SSI/SSU notification. The list
> is not complete, but can be expanded any time later, based on practical
> needs.
> =

> Here is the mapping between the properties/signals and SS notification
> codes I considered essential to start with:
> =

> VoiceCall properties:
> Forwarded (bool):: +CSSI: 2, +CSSU: 0
> RemoteHold (bool):: +CSSU: 2, +CSSU: 3
> Multiparty (bool): +CSSU: 4
> =

> VoiceCallManager signals:
> UnconditionalForwardingInEffect: +CSSI: 0
> ConditionalForwardingInEffect: +CSSI: 1
> OutgoingBarringInEffect: +CSSI: 5
> IncomingBarringInEffect: +CSSI: 6
> =

> In the case of the VoiceCall properties, it is assumed that call instance
> number (call id) is available either implicitly, or explicitly provided
> by the
> modem driver. Some of the SSN functions needs to be changed to
> add call id to the function parameters list, so that modems supporting
> the "call id" feature can deliver this information.
> For cases when it's impossible to unambiguously determine the call id
> for the SS notifications, the notification will be either discarded, or a
> VoiceCallManager DBus could be emitted in connection with the
> notification (+CSSU: 2, +CSSU: 3, +CSSU: 4 cases).

Emitting a signal or setting a property depending on the circumstances
is not a good idea.  You either do one or the other.

> =

> I see no any need for the SSN atom, and my proposal is to remove it
> completely.
> =


If you read the earlier discussion you'll note that Pekka already
proposed this.  I'm fine with this approach, removing ssn atom is just fine.

Regards,
-Denis


--===============0508016116219154565==--

