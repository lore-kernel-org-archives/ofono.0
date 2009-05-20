Content-Type: multipart/mixed; boundary="===============4262316667124302662=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Media Control
Date: Tue, 19 May 2009 19:18:22 -0500
Message-ID: <200905191918.22630.denkenz@gmail.com>
In-Reply-To: <8f9d9e260905191534h36631167nbf834da9b4334f13@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4262316667124302662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vince,

On Tuesday 19 May 2009 17:34:28 Vince Corning wrote:
> Denis,
>
> Access to AT Commands to merge or fork the GSM audio stream and access to
> commands to open microphone and/or speakers would be very helpful.  AT

Agreed, however, this will most likely be required only for certain platfor=
ms =

at the driver level rather than a high-level API exposed by oFono.  For pro=
per =

high-level access you will have to use another framework.  For instance, in =

Moblin what you want will be accomplished with the help of AudioManager:
http://moblin.org/community/blogs/zbt/2009/audio-manager-overview

> command access to set up sensors and request copy of sensor data would al=
so
> be helpful.

Again, I don't disagree.  But oFono does not aim to provide a proper high-
level API for this.  It belongs to framework(s) dedicated specifically to =

sensors & GPS information.  Where makes sense and can be generalized (e.g. =
GPS =

information) oFono will provide integration points for such frameworks.

Regards,
-Denis

--===============4262316667124302662==--

