Content-Type: multipart/mixed; boundary="===============4629727702321637765=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 17:05:11 +0200
Message-ID: <AANLkTinDO02k1GSRUzFr3WaJX+4wxkrf_dS7L9UY2a_F@mail.gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0E1A1@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4629727702321637765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 31 August 2010 15:59,  <Jeevaka.Badrappan@elektrobit.com> wrote:
>> If you need magic binary APIs that are only used by specific
> application or even purely for conformance testing, then you need to
> propose an interface for these. By default we will not make application
>> to any kind of conversation.
>
>> Every single nasty conversion that has to be done by every single
> application using such an interface is wrong. Complexity belongs into
> oFono and not the application. The idea of just pushing complex
>> tasks up into the application so that oFono doesn't have to deal with
> it is a really bad idea. Remember that one main goal of oFono is to make
> the usage of standard telephony functionality as easy as
>> possible when you are developing telephony applications.
>
>
> I'm not proposing any changes to the dbus interface and I completely
> understand that its a very bad idea to push the conversions to the
> application side. USAT conformance specification expects that the
> information sent by the application toolkit to be sent as it is to the
> network. Conformance test setup is such that if the data received at the
> network doesn't match with the data sent by the application toolkit then
> the conformance test case is considered to be a failure case.
>
> When a Send USSD proactive command is received, STK atom sends an
> internal request to the USSD atom to send the string along with the DCS
> supplied. So, for sending the USSD string and dcs received from the
> proactive command, support needs to be added to the USSD driver
> interface.
>
> What I meant was to provide a driver API which will take both the dcs
> and string as parameter. something like the following:

Yes, the driver api may need a change like this.  The current API was
created based on the fact that many modems don't understand anything
other than DCS =3D 15.  However with STK's "Send USSD" command, sending
the requested DCS as-is is probably our best bet.

There is a hope that most modems implement Send USSD in their firmware
so that ofono doesn't have to do anything (this is the case on the
Texas Instruments Calypso modem), do you have a modem that you know
does not handle Send USSD internally?  Of course it makes sense to
implement the fallback in ofono anyway.

Have you been working on implementation of this command? I'm asking to
avoid duplicating the effort.

Best regards

--===============4629727702321637765==--

