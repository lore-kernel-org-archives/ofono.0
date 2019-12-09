Content-Type: multipart/mixed; boundary="===============6220951418002460509=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: How accuracy to get 4G LTE RSSI via connman dbus query?
Date: Mon, 09 Dec 2019 16:17:15 +0100
Message-ID: <21c06978-3efe-6cb6-9d4a-94cc2354ba18@norrbonn.se>
In-Reply-To: <CAA=hcWRuZf0kk+HOhWL5=hfspp6NgqL8cirvHCrj89Znx3u80w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6220951418002460509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/12/2019 07:50, JH wrote:
> Hi,
> =

> I get 4G LTE RSSI from dbus connman service, I usually got about -61 I =

> thought it was accurate. But today, we are doing a test to check 4G LTE =

> RSSI based on different antennas, when connected to a antenna, the RSSI =

> is about -61, when I did not connect to an antenna, the RSSI =3D -40 but =

> the 4G LTE connection lost:
> =

> kernel: qmi_wwan 1-1:1.3: nonzero urb status received: -71.

Here your modem has probably crashed, right?

> =

> Apparently that RSSI =3D -40 was wrong in the situation of without antenn=
a =

> connection. I tried to build qmicli, but I could not get it running. =

> googling Internet, people pointed out, it could not be run if the qmi is =

> running by other services (ofono is running qmi on /dev/cdc-wdm0).
> =

> # qmicli --nas-get-signal-strength --device=3D/dev/cdc-wdm0
> error: couldn't create client for the 'nas' service: CID allocation =

> failed in the CTL client: Transaction timed out

Just make sure ofono is stopped before running ofono.

# systemctl stop ofono

/Jonas

> =

> Appreciate tips how to get qmicli running.
> =

> Thank you.
> =

> Kind regards,
> =

> - jh
> =

> _______________________________________________
> connman mailing list -- connman(a)lists.01.org
> To unsubscribe send an email to connman-leave(a)lists.01.org
>=20
--===============6220951418002460509==--

