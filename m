Content-Type: multipart/mixed; boundary="===============2415465508869619337=="
MIME-Version: 1.0
From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: Detecting if a modem has dialing support
Date: Mon, 22 Jul 2019 10:02:30 -0700
Message-ID: <CAJCx=gnv85otbA0hJGyV1QOducnP5uKA-wOVotBLj4RFUE37KQ@mail.gmail.com>
In-Reply-To: <72c6ecec-5814-c862-4322-cd3760d47a52@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2415465508869619337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 9:14 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Matt,
>
> > It is in the qmimodem driver, and not sure if any modem using that
> > driver is implementing
> > dialing support.
> >
>
> I believe there are some people using a QMI modems for voicecall
> testing.  Don't recall offhand if they're using a hacked firmware or
> just specific devices.  So there are devices that support this, but
> likely in very custom setups.
>
> I guess the detection logic in the qmimodem voicecall driver is not
> sufficient for knowing whether voicecall support is real or not.  I'm
> not a qmi expert, so not sure what else could be done here.
>
> Worst case, I suppose we can turn off voicecall for QMI by default, and
> those who need it can add a udev setting / config option / environment
> variable for controlling this when required.

For the record this is a Sierra Wireless module using a QMI modem.

- Matt

>
> Regards,
> -Denis

--===============2415465508869619337==--

