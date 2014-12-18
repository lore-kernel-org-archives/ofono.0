Content-Type: multipart/mixed; boundary="===============4011132670162552487=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT commands timeout
Date: Thu, 18 Dec 2014 09:54:35 -0600
Message-ID: <5492F8BB.203@gmail.com>
In-Reply-To: <CAH4ZQwvHCQthM2tMJneKH=CjJ1=mQucXcLA43WE_ww66bAVnOw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4011132670162552487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 12/18/2014 09:23 AM, Enrico Sau wrote:
> Hi everyone,
>
> Is there any way to set a timeout on AT commands send?
> I'm experiencing some problems because in some situation my modem does
> not answer to some AT command and I don't want for that to block my
> application.

GAtChat does not support AT command timeouts.  We chose not to implement =

this since there's no way to handle timeouts gracefully.

>
> The best solution would be to have a timeout parameter on at command
> send to avoid this kind of problems.
>

Sounds like you have some deeper modem integration issues to take care =

of.  AT command timeouts are generally not the answer based on our =

experience.

Regards,
-Denis


--===============4011132670162552487==--

