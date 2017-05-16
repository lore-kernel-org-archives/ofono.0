Content-Type: multipart/mixed; boundary="===============7754809972443012854=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v2 1/3] gemalto: Prepare new interface for hardware
 monitoring
Date: Tue, 16 May 2017 13:14:18 -0500
Message-ID: <00576b94-ce9d-7930-a8d4-2418083a8b8e@gmail.com>
In-Reply-To: <1494923922-8874-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7754809972443012854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/16/2017 03:38 AM, Vincent Cesson wrote:
> Gemalto modems have hardware related commands, allowing to monitor voltage
> and temperature. These parameters will be accessible on DBus interface:
> org.ofono.HardwareMonitor.
>
>  - Create the DBus method table with one entry: GetStatistics. This method
> would return temperature and voltage values.
>  - Create a dedicated structure to handle the DBus methods.
>  - Create enable/disable functions to handle DBus interface registration.
> ---
>  plugins/gemalto.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============7754809972443012854==--

