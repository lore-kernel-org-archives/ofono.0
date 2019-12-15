Content-Type: multipart/mixed; boundary="===============5850609088164391566=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Sun, 15 Dec 2019 22:14:40 +0000
Message-ID: <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
In-Reply-To: <20191205093200.x47npi5sxtcphr2o@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5850609088164391566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
>
> On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > possible, then that's not possible.
> >
> > I do not know if bluez developers are interested in having this code as
> > part of bluez project, specially when in bluez4 HFP profile was there
> > and in bluez5 was HFP code completely removed.
>
> Hello, could someone from bluez developers comment this Tanu's point?

I would have to say no, we are definitely not interested in yet
another daemon for AT parsing, we actually have too many of these
around, either in a form of Modem Manager, oFono, etc. That said one
simpler way to resolve all of this is to maintain a plugin to
bluetoothd that way HSP/HFP becomes native again, that can either be
maintained in the tree or out of the tree.

-- =

Luiz Augusto von Dentz
--===============5850609088164391566==--

