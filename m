Content-Type: multipart/mixed; boundary="===============3845361328629623202=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [Clarification Request]HFP Modem:Termination Of Held Call
Date: Thu, 18 Aug 2011 19:32:41 -0500
Message-ID: <4E4DAF29.5030309@gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B3335836215186E3911@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3845361328629623202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On 08/19/2011 01:30 AM, milan.satpathy(a)accenture.com wrote:
> Hi,
> =

>  =

> =

> It looks like with current Ofono implementation, the termination of a
> Held call (AT+CHLD=3D0) is not permitted (using =E2=80=9CHangup=E2=80=9D)=
, in case there
> is another call present. Is there any specific reason to prevent the
> termination of Held call, unless it is the only call available?
> =

>  =

> =

> Issue faced:
> =

> -There is one active and one held call.
> =

> -It is not possible to terminate the held call as long as the active
> call exists.
> =


The pre-conditions have been relaxed by commit cb21b7f4.

Regards,
-Denis

--===============3845361328629623202==--

