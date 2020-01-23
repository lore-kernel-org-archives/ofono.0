Content-Type: multipart/mixed; boundary="===============2376231622253778295=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Where are ofono dbus paths for RSRQ and RSRP?
Date: Thu, 23 Jan 2020 21:39:05 +1100
Message-ID: <CAA=hcWS6cXJO6V1NZQBwtXqvt_soQFDv9Q3ogLauPFBbKmgnjg@mail.gmail.com>
In-Reply-To: <965e959a-38bf-0451-fb33-869f29ad6108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2376231622253778295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 1/23/20, Denis Kenzior <denkenz@gmail.com> wrote:
> You can invoke the org.ofono.NetworkMonitor.GetServingCellInformation or
> GetNeighbouringCellsInformation methods and see if this particular value
> would be reported.

That indeed works well.

> If you're on uBlox hardware, then i think it only reports the Serving
> Cell info, not neighbor cells.

You are right, uBlox hardware only works for Serving Cell info, not
neighbor cells. Since the device is in stationary, all we need is the
Serving Cell info, not neighbor cells.

Thank you very much Denis, greatly appreciate it.

Kind regards,

- jh
--===============2376231622253778295==--

