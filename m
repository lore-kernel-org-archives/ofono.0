Content-Type: multipart/mixed; boundary="===============6304499296421599106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V3 2/4] voicecall: add ATD support for HFP emulator
Date: Sun, 05 Jun 2011 21:09:16 -0500
Message-ID: <4DEC36CC.1060306@gmail.com>
In-Reply-To: <4DEE2058.3000601@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6304499296421599106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

<snip>

>>> +
>>> +    if (vc->pending_em) {
>>> +        result.type =3D OFONO_ERROR_TYPE_FAILURE;
>>> +        goto send;
>>> +    }
>>
>> You might also want to check that the Dial is not happening via D-Bus or
>> STK, and vice-versa.
> =

> Voicecall_dial will check if there is already a pending outgoing call.
> I think this is sufficient to manage concurrent ATD between D-Bus, STK
> and emulator.
> =


No, it isn't.  voicecall_dial only checks for dialing / alerting calls.
 However, you have to remember that the call isn't created until the
dial callback returns or ofono_voicecall_notify is called with the newly
created call.  This can take some time (e.g. due to queuing on the
GAtChat object), and during this time new Dial requests have to be rejected.

D-Bus API implementation handles this by using vc->pending (and it is a
bug that it doesn't check vc->dial_req).   STK handles this by checking
vc->pending and the existence of dial_req object.

Once you introduce the emulator, there is no cross-checking between the
emulator and the existing ways.  Between emulators you handle this by
using vc->pending_em, but you should also be checking that a Dial hasn't
been scheduled via STK/D-Bus API.

Regards,
-Denis

--===============6304499296421599106==--

