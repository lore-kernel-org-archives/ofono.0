Content-Type: multipart/mixed; boundary="===============5929278085346066118=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Wed, 31 Oct 2018 20:44:45 +0100
Message-ID: <CAKSBH7Hb2VFSgMQSRYY07uDAw5ngXCRgvi2B2WjaMF+q6vWsTw@mail.gmail.com>
In-Reply-To: <a8e95031-ad54-e727-c4d4-dea6440e9432@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5929278085346066118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 8:23 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Marcel,
>
> >
> > I think that MBIM (and even QMI) have AT passthrough options. So by all=
 means, the main transport suppose to be MBIM here. I always prefer if only=
 one hardware port is opened and there is no need to open more.
>
> I've seen QMI over MBIM some vendor extended service UIDs.  Not sure
> about AT over MBIM.  If someone knows more, feel free to educate me.
>
> Isn't AT over QMI also possible?  And in theory AT over QMI over MBIM, lo=
l.
>

AT over MBIM is possible, but we decided not to implement it.
The big advantage of MBIM is a ready-made driver on Windows and on
MM/ofono. Adding AT over it would mean reworking the driver, so no
more advantages.
Over QMI I don't know.
QMI over MBIM is also possible, but with the same disadvantage as AT over M=
BIM.

> Regards,
> -Denis

--===============5929278085346066118==--

