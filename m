Content-Type: multipart/mixed; boundary="===============2300504195028329773=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: How to handle pins?
Date: Fri, 23 Apr 2010 15:56:57 +0200
Message-ID: <20100423135657.GB11437@gumpy.localdomain>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD1E3BC9EE@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2300504195028329773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Thu, Apr 22, 2010 at 02:54:38AM +0200, Xu, Martin wrote:

> > modify connmand that way, that it shows the modem as device (with a
> > new property "PinRequired") even when the GPRS interface is not yet
> > available. Though I had to hackaround with the IMSI (which is used as
> > unique identifier for the dbus paths) is only available after the pin
> > has been entered. Maybe the serial number could be used instead of the
> > IMSI instead?
> I am afraid that IMSI is the best identifier, and serial number is implem=
ented by manufacturer, and sometime not unique.
> Anyway it is the issue we need to resolve. So I also copy it to oFono mai=
llist for comments. ;-)

Okay. Is there a proper way to identify a SIM when it is still locked?
I guess this can only be done by some guessworking. =


cheers,
daniel

--===============2300504195028329773==--

