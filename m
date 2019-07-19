Content-Type: multipart/mixed; boundary="===============7409916118457271224=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Detecting if a modem has dialing support
Date: Fri, 19 Jul 2019 10:32:47 -0500
Message-ID: <72c6ecec-5814-c862-4322-cd3760d47a52@gmail.com>
In-Reply-To: <CAJCx=gmZ8Fg07HAbfFxE+SgO52-pyTLZvG=_ZznSM6sTRDSu6w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7409916118457271224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

> It is in the qmimodem driver, and not sure if any modem using that
> driver is implementing
> dialing support.
> =


I believe there are some people using a QMI modems for voicecall =

testing.  Don't recall offhand if they're using a hacked firmware or =

just specific devices.  So there are devices that support this, but =

likely in very custom setups.

I guess the detection logic in the qmimodem voicecall driver is not =

sufficient for knowing whether voicecall support is real or not.  I'm =

not a qmi expert, so not sure what else could be done here.

Worst case, I suppose we can turn off voicecall for QMI by default, and =

those who need it can add a udev setting / config option / environment =

variable for controlling this when required.

Regards,
-Denis

--===============7409916118457271224==--

