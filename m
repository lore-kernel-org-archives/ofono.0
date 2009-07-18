Content-Type: multipart/mixed; boundary="===============5430110343645970092=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Read EF-PNN,
 EF-OPL and override network names accordingly.
Date: Sat, 18 Jul 2009 00:40:43 -0500
Message-ID: <200907180040.44024.denkenz@gmail.com>
In-Reply-To: <fb249edb0907171636w58f8af6aud94bbea0b24c5192@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5430110343645970092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> 2009/7/14 Denis Kenzior <denkenz@gmail.com>:
> > Patch has been applied.  However, I've completely (juding by 40 or so
> > commits) refactored how SIM filesystem is handled in oFono so I might
> > have introduced some bugs.  Could you test to make sure it is working as
> > intended?
>
> Attaching some fixes for the new code, the test and a clean-up patch
> (feel free to drop parts).  Note all the recent commits broke
> bisectability badly.

Good catches.  All five have been applied and pushed.  Thanks.

>
> Wouldn't it be useful for the service provider name to be available as
> SimManager property?

I really don't see any practical uses for it by the UI.  Can you foresee =

anything that actually needs this?  Remember, it is easier to add apis late=
r =

than to modify or remove.

Regards,
-Denis

--===============5430110343645970092==--

