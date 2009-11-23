Content-Type: multipart/mixed; boundary="===============4101141180769073480=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Mon, 23 Nov 2009 04:40:14 -0600
Message-ID: <200911230440.14929.denkenz@gmail.com>
In-Reply-To: <359c5480911220638u422e7c09scabfdeb175fd494f@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4101141180769073480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> Keep in mind I'm speaking about general developers and their interest,
> not about organizations, just pointing that *actually* FSO carries
> more interests on *some* areas.

Yes, I believe we completely agree on this point.   oFono's intention was =

never to be an entire application framework.  Our ambitions are only to cre=
ate =

the best flexible, customizable and easy to use telephony stack.

> May you elaborate about that? May not a close source project use oFono
> by calling it's DBus API?

Marcel explained some of this very well already.  But just to add: oFono ta=
kes =

nearly full control of the modem, so even if it is technically possible to =
go =

behind oFono's back and try to do something in a closed/proprietary way, it =

would not be very practical.  This is also something we will actively =

discourage.

> That's one of the reason FSO is modularized. Anyway resource
> management in a complex system has to be handled in a central way to
> take coherency between subsytems.
> Having a middleware doing that is really important, just a case about
> the correct way to suspend/resume a device should be not the interest
> of a high level software.
>

Sure, however alternatives exist.  For this reason oFono does not dictate a=
ny =

particular approach.  In oFono everything is setup as a plugin / driver, so =

customizing any part or making it integrate with your particular environmen=
t =

should be quite easy.

>
> Nice to hear that. Anyway do not missunderstand, our team is adopting
> oFono, we are just digging incoming issues with the nogsm part
> integration!!!
>

Sounds interesting.  Let me know if I can be of assistance :)

Regards,
-Denis

--===============4101141180769073480==--

