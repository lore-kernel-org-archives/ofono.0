Content-Type: multipart/mixed; boundary="===============4080953917253216969=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] doc: detail PinRetries property
Date: Wed, 22 Dec 2010 18:40:48 -0600
Message-ID: <4D129A90.4000103@gmail.com>
In-Reply-To: <AANLkTi=7pveKexb8tpqJ2f3hWUFYdZvL9L+Tq1FFH9fF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4080953917253216969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 12/22/2010 12:54 PM, Lucas De Marchi wrote:
> Hi,
> =

> On Tue, Dec 21, 2010 at 5:48 AM, Sankar <gsankar.gs@gmail.com> wrote:
>>> +               byte PinRetries [readonly]
>>> +
>>> +                       Contains the retry counter for the current
>>> required
>>> +                       pin. This counter is tipically decremented
>>> whenever a
>>> +                       call to EnterPin() fails.
>>> +
>>> +                       E.g.: if PinRequired is equal "puk", this prope=
rty
>>> +                       contains the number of times EnterPin can be
>>> called
>>> +                       with a wrong puk.
>>
>> Does this property also mention how many retries are possible when the u=
ser
>> enters a wrong PUK for unblocking the sim pin.
> =

> Interesting, but it was not what I had in mint. If we want this
> behavior, we might have to return all the counters instead of only
> one. Then, what would be the user interface?
> =


This brings up an interesting point.  So here are the possible usecases:

The SIM is PIN locked and asks the user to enter a PIN.  The number of
tries remaining is shown to the user.  The pin is entered by using EnterPin.

The user has tried to use 'EnterPin' with the wrong code too many times
and the SIM PUK is now required.  The number of tries remaining should
be shown to the user.  The PUK and the new PIN is entered by using
ResetPin.  I believe the original question was about this case.

The user has entered the PIN correctly and the phone is initialized.  In
theory the PinRetries can be applicable here as well:

The user wants to unblock the PIN from being asked on the next sim
initialization.  He uses UnlockPin to do so.  The number of retries
remaining could be shown to the user.

The user wants to change his PIN from one to another.  He uses ChangePin
to do so.  The number of retries remaining could be shown to the user.

The user wants to make sure the PIN is asked on the next sim
initialization.  He uses LockPin to do so.  The number of retries
remaining should be could to the user.

The first two usecases are already nicely by your proposal, but the
others are not.  The question is, does anyone consider showing the
number of retries in the last three usecases important?

Regards,
-Denis

--===============4080953917253216969==--

